public class Path
{
  Path parent;
  Vector v;
  float dist = Float.POSITIVE_INFINITY;

  public Path(Path p, Vector v)
  {
    this.parent = p;
    this.v = v;
    if(p == null)
      this.dist = 0;
    else
      this.dist = this.v.minus(p.v).mag();
  }
  
  public Path(Path p, Vector v, float d)
  {
    this.parent = p;
    this.v = v; 
    this.dist = d;
  }
  
  public void draw()
  {
    stroke(170,170,0);
    this.v.draw();
    if(this.parent == null) return;
    
    line(this.v, parent.v).draw(.2);
    parent.draw();
  
  }
  
  public float totalDistance()
  {
    if(this.parent == null)
      return this.dist;
    else
      return this.dist + this.parent.totalDistance();
  
  }
  
}
