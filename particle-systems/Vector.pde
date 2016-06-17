public class Vector
{
  public static final int DIM = 3;
  float[] value = new float[DIM];
  
  public Vector() {}
  public Vector(float x, float y, float z)
  {
    this.value[0] = x;
    this.value[1] = y;
    this.value[2] = z;
  }
  
  public Vector(float[] value)
  {
    for(int i = 0 ; i < DIM; i++)
      this.value[i] = value[i];
  }
  
  
  public Vector plus(Vector that)
  {
    float[] tmp = new float[DIM];
    for(int i =0 ; i < DIM; i++)
      tmp[i] = this.value[i] + that.value[i];
    return new Vector(tmp);
  }
  
  public Vector multiply(float number)
  {
      float[] tmp = new float[DIM];
      for(int i = 0 ; i < DIM; i++)
        tmp[i] = this.value[i] * number;
      return new Vector(tmp);    
  }
  
  public Vector minus(Vector that)
  {
    float[] tmp = new float[DIM];
    for(int i =0 ; i < DIM; i++)
      tmp[i] = this.value[i] - that.value[i];
    return new Vector(tmp);
  }
  
///// helper methods

  public float x()
  {
    return value[0];
  }
  public float y()
  {
    return value[1];
  }
  public float z()
  {
    return value[2];
  }

  public String toString()
  {
    return "Vector" + DIM + ": <" + value[0] + ", " + value[1] + ", " + value[2] + ">";
  }
}
