// Author: Raman Gupta
// Student Number: 300290648

/** Represent an RGB pixel */
public class Pixel {
  private int red;
  private int green;
  private int blue;

  /**
   * Constructs a pixel object
   *
   * @param red The red channel value of the color
   * @param green The green channel value of the color
   * @param blue The blue channel value of the color
   */
  public Pixel(int red, int green, int blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }

  /**
   * @return Returns an array of the RGB values
   */
  public int[] getRGB() {
    return new int[] {red, green, blue};
  }
}
