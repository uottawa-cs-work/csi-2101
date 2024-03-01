// Author: Raman Gupta
// Student Number: 300290648

public class Pair implements Comparable<Pair> {
  private String key;
  private Double value;

  /**
   * @param key String
   * @param value Double
   */
  public Pair(String key, Double value) {
    this.key = key;
    this.value = value;
  }

  // Accessors and mutators
  public String getKey() {
    return this.key;
  }

  public Double getValue() {
    return this.value;
  }

  public void setKey(String key) {
    this.key = key;
  }

  public void setValue(Double value) {
    this.value = value;
  }

  /**
   * @param other The other Pair object to compare against
   * @return A negative number if the implicit object has a smaller value 0 if the implicit object
   *     has an equal value A positive number if the implicit object has a greater value
   */
  public int compareTo(Pair other) {
    return this.value.compareTo(other.value);
  }

  public String toString() {
    return String.format("[%s, %f]", this.key, this.value);
  }
}
