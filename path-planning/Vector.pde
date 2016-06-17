public class Vector
{
  public static final int DIM = 3;
  float[] value = new float[DIM];
  
  public Vector() {}
  public Vector(Vector v)
  {
    this.value[0] = v.value[0];
    this.value[1] = v.value[1];
    this.value[2] = v.value[2];
  }
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
  
  public float mag()
  {
    return sqrt( this.value[0]*this.value[0] + this.value[1]*this.value[1] + this.value[2]*this.value[2]);
  }
  
  
  public Vector plus(Vector that)
  {
    float[] tmp = new float[DIM];
    for(int i =0 ; i < DIM; i++)
      tmp[i] = this.value[i] + that.value[i];
    return new Vector(tmp);
  }
  
  public void add(Vector that)
  {
    this.value[0] = this.value[0] + that.value[0];
    this.value[1] = this.value[1] + that.value[1];
    this.value[2] = this.value[2] + that.value[2]; 
  }
  
  public Vector multiply(Vector that)
  {
      float[] tmp = new float[DIM];
      for(int i = 0 ; i < DIM; i++)
        tmp[i] = this.value[i] * that.value[i];
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
  
  public float dot(Vector that)
  {
    float tmp = 0;
    for(int i =0 ; i < DIM; i++)
      tmp += this.value[i] * that.value[i];
    return tmp;
  }
  
  public Vector cross(Vector that)
  {
    return new Vector(
      this.value[1]*that.value[2] - this.value[2]*that.value[1],
      this.value[2]*that.value[0] - this.value[0]*that.value[2],
      this.value[0]*that.value[1] - this.value[1]*that.value[0]);
  }
  
  public Vector projectionOn(Vector that)
  {
    float  mag      = that.mag();
    Vector unitThat = that.multiply(1 / mag); 
   
    return unitThat.multiply(this.dot(unitThat));
  }
  
  public Vector toUnit()
  {
    return this.multiply(1/this.mag());
  
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
  
  public boolean isValid()
  {
    return !(Float.isNaN(value[0]) || Float.isNaN(value[1]) || Float.isNaN(value[2]));
  }
  
  public boolean isZero()
  {
    return (this.value[0] == 0) && (this.value[1] == 0) && (this.value[2] == 0);
  }

  public String toString()
  {
    return "Vector" + DIM + ": <" + value[0] + ", " + value[1] + ", " + value[2] + ">";
  }
  
  public void draw()
  {
    float x = this.value[0]; 
    float y = this.value[1];
    float i = 0.2;
    noFill();
    strokeWeight(.01);
    line(x-i,y-i,x+i,y+i);
    line(x-i,y+i,x+i,y-i);
  
  }
}
