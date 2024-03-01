// Author: Raman Gupta
// Student Number: 300290648

import java.io.File;

public class Utils {
  // Prevents instantiation
  private Utils() {}

  public static boolean dirExists(String path) {
    File dir = new File(path);

    return dir.isDirectory() && dir.exists();
  }

  public static boolean fileExists(String path) {
    File file = new File(path);

    return file.isFile() && file.exists();
  }
}
