public class Line
{
  Vector a;
  Vector b;

  public Line(Vector start, Vector end)
  {
    this.a = start;
    this.b = end;
  }
  
  // does not check if the intersection lies on the segments
  public Vector intersectionWith(Line that)
  { // https://www.topcoder.com/community/data-science/data-science-tutorials/geometry-concepts-line-intersection-and-its-applications/
    // convert to Ax+By=C or standard form
    float a1 = this.b.value[1] - this.a.value[1];
    float b1 = this.a.value[0] - this.b.value[0];
    
    float c1 = a1*this.a.value[0] + b1*this.a.value[1];
    
    float a2 = that.b.value[1] - that.a.value[1];
    float b2 = that.a.value[0] - that.b.value[0];
    
    float c2 = a2*that.a.value[0] + b2*that.a.value[1];
    
    // |a1 b1|   |x|   |c1|
    // |a2 b2| * |y| = |c2|
    
    float d = a1 * b2 - a2 * b1;  // determinent of the left matrix
    if( d == 0 ) // determinent of zero means that the lines are parallel 
    {
      //println("parallel");
      return null; // techincally parallel lines are ok because it means being in contact with the wall but not crossing
    }
    else
    {
       float x = (b2*c1 - b1*c2)/d;
       float y = (a1*c2 - a2*c1)/d;
       Vector tmp = new Vector(x,y,0); 
       if( this.insideBoundingBox(tmp))// && that.insideBoundingBox(tmp)) // check if in bounds of line segments
         return tmp;
        else
         return null; 
    }
  }
  
  public boolean insideBoundingBox(Vector v) // is inside (not on boundary)bounding box given by the two vectors
  {
     float minX = min(this.a.value[0], this.b.value[0]);
     float maxX = max(this.a.value[0], this.b.value[0]);
     float minY = min(this.a.value[1], this.b.value[1]);
     float maxY = max(this.a.value[1], this.b.value[1]);
     
     if( v.value[0] <= minX || maxX <= v.value[0] )
       return false; 
     if( v.value[1] <= minY || maxY <= v.value[1] )
       return false;
     return true;
  }
  
  
  
  public boolean intersect(Line that) // ONLY IF BETWEEN THE TWO POINTS
  { // check that both points of that line are on opposite sides of this line
        
    if(this.side(that.a) == this.side(that.b)) return false; // both points on same side of this line -> no intersect
    if(that.side(this.a) == that.side(this.b)) return false; // both points on same side of that line -> no intersect
    
    return true;
  }
  
  
  public int side(Vector v)
  {
    Vector ab = this.b.minus(this.a); // vector along the line
    Vector av = v.minus(this.a);      // vector from base of line to v
    float res = ab.cross(av).value[2];// cross product z vector (torque)
    if( res == 0 )
      return 0;
    return (int)(res/abs(res));       // -1 if on right side and 1 if on left and 0 if on line
  }
  
  
  public Vector getOther(Vector v)
  {
    if(this.a == v)
      return this.b;
    else if(this.b == v)
      return this.a;
    else
      return null;
  }
  
  public float distance()
  {
    return this.toVector().mag(); 
  }
  
  public Vector toVector()
  {
    return this.b.minus(this.a);
  }
  
  public void draw()
  {
    strokeWeight(.01);
    line(this.a.value[0],this.a.value[1],this.b.value[0],this.b.value[1]);
  }
  
  public void draw(float size)
  {
    strokeWeight(size);
    line(this.a.value[0],this.a.value[1],this.b.value[0],this.b.value[1]);
  }

}


