// Author: Raman Gupta
// Student Number: 300290648
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class ColorHistogram {
  int depth;
  int numBins;
  ColorImage image;
  double[] histogram;

  /**
   * Constructor
   *
   * @param d The depth of the image
   */
  public ColorHistogram(int d) {
    this.depth = d;
    this.numBins = (int) Math.pow(2, this.depth * 3);
  }

  /**
   * Constructor
   *
   * @param filePath The filename that holds the histogram data
   */
  public ColorHistogram(String filePath) {
    try {
      if (!Utils.fileExists(filePath)) {
        System.out.println("Error: File not found.");
        return;
      }
      FileReader in = new FileReader(filePath);
      BufferedReader reader = new BufferedReader(in);

      parseHistogramFile(reader);
      reader.close();
    } catch (IOException error) {
      error.printStackTrace();
    }
  }

  /**
   * @param reader The reader for the file to parse
   */
  private void parseHistogramFile(BufferedReader reader) throws IOException {
    this.numBins = Integer.parseInt(reader.readLine());

    // Use log change of base formula since no native log base 2 in java
    this.depth = (int) (Math.log(numBins) / Math.log(2) / 3);

    String[] strRGBValues = reader.readLine().split(" ");
    double[] histogram = new double[numBins];

    for (int i = 0; i < numBins; i++) {
      histogram[i] = Double.parseDouble(strRGBValues[i]);
    }

    this.histogram = histogram;
  }

  /** Computes the normalized histogram of the given image */
  private void computeHistogram() {
    int width = this.image.getWidth();
    int height = this.image.getHeight();

    double[] histogram = new double[this.numBins];
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int[] rgb = image.getPixel(i, j);
        int index = (rgb[0] << (2 * this.depth)) + (rgb[1] << this.depth) + rgb[2];

        if (index >= numBins) {
          System.out.println("Error: Ensure histogram depth is the same as the image depth");
          System.exit(1);
        }

        histogram[index] += 1;
      }
    }

    this.histogram = histogram;
  }

  /** Normalizes a histogram */
  private double[] normalizeHistogram() {
    double sum = 0;
    double[] temp = new double[numBins];
    for (int i = 0; i < this.numBins; i++) {
      sum += histogram[i];
    }

    for (int i = 0; i < this.numBins; i++) {
      temp[i] = histogram[i] / sum;
    }

    return temp;
  }

  /**
   * Determines the intersections between two histograms
   *
   * @param hist The histogram to find the intersection with
   * @return The similarity value
   */
  public double compare(ColorHistogram hist) {
    double[] intersection = new double[this.histogram.length];
    double[] other = hist.getHistogram();

    for (int i = 0; i < this.numBins; i++) {
      intersection[i] = Math.min(getHistogram()[i], other[i]);
    }

    double sum = 0;
    for (int i = 0; i < this.numBins; i++) {
      sum += intersection[i];
    }

    return sum;
  }

  /**
   * @return The histogram in string format
   */
  private String histogramToString() {
    StringBuilder out = new StringBuilder();

    for (int i = 0; i < this.numBins; i++) {
      out.append((int) this.histogram[i]);

      if (i < this.numBins - 1) {
        out.append(" ");
      }
    }
    return out.toString();
  }

  /**
   * Writes the histogram to a file
   *
   * @param filename The name of the output file
   */
  public void save(String filename) {
    try {
      FileWriter out = new FileWriter(filename);
      BufferedWriter writer = new BufferedWriter(out);
      writer.write(numBins + "\n");
      writer.write(histogramToString() + " ");
      writer.close();
    } catch (Exception error) {
      error.printStackTrace();
    }
  }

  /**
   * Sets image attribute and computes the histogram for given image
   *
   * @param image The image used for histogram
   */
  public void setImage(ColorImage image) {
    this.image = image;
    computeHistogram();
  }

  /**
   * @return The histogram for the set image
   */
  public double[] getHistogram() {
    return normalizeHistogram();
  }
}
