// Author: Raman Gupta
// Student Number: 300290648

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class ColorImage {
  private int height;
  private int width;
  private int depth;
  private Pixel[][] pixels;
  private static final int MAX_DEPTH = 8;

  /**
   * Constructor
   *
   * @param filePath The filename of the image file (jpg)
   */
  public ColorImage(String filePath) {
    try {
      if (!Utils.fileExists(filePath)) {
        System.out.println("Error: Image not found.");
        return;
      }

      BufferedImage image = ImageIO.read(new File(filePath));
      this.height = image.getHeight();
      this.width = image.getWidth();
      this.depth = image.getColorModel().getPixelSize() / 3;
      this.pixels = new Pixel[this.width][this.height];

      initializeImage(image);
    } catch (IOException error) {
      error.printStackTrace();
    }
  }

  /**
   * Stores all pixels in image in 2D array
   *
   * @param image The image to store in memory
   */
  private void initializeImage(BufferedImage image) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int pixel = image.getRGB(i, j);

        // Extract RGB components
        int red = (pixel >> MAX_DEPTH * 2) & 0xFF;
        int green = (pixel >> MAX_DEPTH) & 0xFF;
        int blue = pixel & 0xFF;

        this.pixels[i][j] = new Pixel(red, green, blue);
      }
    }
  }

  /**
   * @param i The y position of the pixel
   * @param j The x position of the pixel
   * @return The RGB values in an array
   */
  public int[] getPixel(int i, int j) {
    return pixels[i][j].getRGB();
  }

  /**
   * Reduce the color space (depth) of an image
   *
   * @param d The depth to reduce to
   */
  public void reduceColors(int d) {
    int SHIFT = MAX_DEPTH - d;
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int[] rgb = getPixel(i, j);

        int reducedRed = rgb[0] >> SHIFT;
        int reducedGreen = rgb[1] >> SHIFT;
        int reducedBlue = rgb[2] >> SHIFT;

        this.pixels[i][j] = new Pixel(reducedRed, reducedGreen, reducedBlue);
      }
    }

    this.depth = d;
  }

  /** Prints out each pixel of the image (for testing purposes) */
  public String toString() {
    StringBuilder out = new StringBuilder();
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int[] rgb = pixels[i][j].getRGB();
        out.append(String.format("[%d, %d, %d]\n", rgb[0], rgb[1], rgb[2]));
      }
    }

    return out.toString();
  }

  // Accessors & Mutators
  public Pixel[][] getPixels() {
    return pixels;
  }

  public int getHeight() {
    return height;
  }

  public void setHeight(int height) {
    this.height = height;
  }

  public int getWidth() {
    return width;
  }

  public void setWidth(int width) {
    this.width = width;
  }

  public int getDepth() {
    return depth;
  }

  public void setDepth(int depth) {
    this.depth = depth;
  }
}
