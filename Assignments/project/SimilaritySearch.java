// Author: Raman Gupta
// Student Number: 300290648

import java.io.File;
import java.util.PriorityQueue;

public class SimilaritySearch {
  private static void validateArgs(String[] args) {
    // Ensure correct number of parameters
    if (args.length != 2) {
      System.out.println(
          "Error: Usage java SimilaritySearch <queryImage path> <datasetDirectoryPath>.");
      System.exit(1);
    }

    String queryImagePath = "./queryImages/" + args[0];
    String datasetDirectoryPath = "./" + args[1];

    // Ensure all files & directories exist
    if (!Utils.fileExists(queryImagePath)) {
      System.out.println("Error: Query image not found.");
      System.exit(1);
    }

    if (!Utils.dirExists(datasetDirectoryPath)) {
      System.out.println("Error: Image dataset directory not found.");
      System.exit(1);
    }
  }

  private static void printPQ(PriorityQueue<Pair> queue, int i) {
    if (queue.isEmpty()) {
      return;
    }

    Pair elem = queue.poll();
    printPQ(queue, i - 1);

    String filename = "#" + i + ": " + elem.getKey();
    double similarity = elem.getValue();

    System.out.printf("%-18s | %-18f\n", filename, similarity);
  }

  private static void printKSimilarImages(PriorityQueue<Pair> images) {
    System.out.printf("%-18s | %-18s\n", "File", "Similarity");
    System.out.println("-".repeat(18) + "-|" + "-".repeat(12));
    printPQ(images, 5);
  }

  public static void main(String[] args) {
    validateArgs(args);

    String queryImagePath = "./queryImages/" + args[0];
    String datasetDirectoryPath = "./" + args[1];

    File datasetDirectory = new File(datasetDirectoryPath);
    File[] files = datasetDirectory.listFiles();

    int DEPTH = 3;
    ColorImage queryImage = new ColorImage(queryImagePath);
    queryImage.reduceColors(DEPTH);

    ColorHistogram queryHistogram = new ColorHistogram(DEPTH);
    queryHistogram.setImage(queryImage);

    PriorityQueue<Pair> kSimilarImages = new PriorityQueue<>();

    for (File file : files) {
      String filename = file.getName();

      // Filter for txt files
      if (!file.isFile() || !filename.endsWith(".txt")) continue;

      String datasetHistogramFilePath = datasetDirectoryPath + "/" + filename;
      ColorHistogram datasetHistogram = new ColorHistogram(datasetHistogramFilePath);

      double intersection = queryHistogram.compare(datasetHistogram);
      Pair currFile = new Pair(filename, intersection);

      int queueSize = kSimilarImages.size();

      if (queueSize < 5) kSimilarImages.offer(currFile);
      else if (queueSize == 5 && kSimilarImages.peek().getValue() < intersection) {
        kSimilarImages.poll();
        kSimilarImages.offer(currFile);
      }
    }

    printKSimilarImages(kSimilarImages);
  }
}
