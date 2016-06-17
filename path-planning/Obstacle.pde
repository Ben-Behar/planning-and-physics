public abstract class Obstacle
{
  Vector pos = null;
  public boolean collision(Line l)
  {
    return collision(l.a, l.b);
  }
  public abstract boolean collision(Vector lineStart, Vector lineEnd);  
  public abstract void draw();
  public abstract boolean contains(Vector v);
}

public class Circle extends Obstacle
{
  float radius = 1;
  public Circle(Vector p, float radius)
  {
    this.pos = p;
    this.radius = radius;
  }
  
  // intesectin of line p -> v to circle 
  // project p -> CirclePos on to p - v, to find the point closest to the circle
  // if this point is within the circle there is a collision
  public boolean collision(Vector p, Vector v)
  { 
    if(this.contains(p))  return true; // starting point was inside the circle
    if(this.contains(v))  return true; //   ending point was inside the circle 
        
    Vector pc = this.pos.minus(p);   // vector from p to circle center
    Vector pv = v.minus(p);          // vector from p along line
    Vector pi = pc.projectionOn(pv); // vector from p to closest point on line to circle center
    Vector i = pi.plus(p);           // position of closest encounter with circle
    Line   l = new Line(p,v);        
    //stroke(0,255,255); line(i,this.pos).draw(); stroke(255,255,0); i.draw();
    
    if(!this.contains(i) )      return false; // point isn't within the circle...
    if(!l.insideBoundingBox(i)) return false; // point isn't on the line segment...
    return true;
  }
  
  public boolean contains(Vector v)
  {
    return v.minus(this.pos).mag() < this.radius;
  }
  
  public void draw()
  {
    ellipse(pos.value[0], pos.value[1], radius*2, radius*2);
  }
}

public class Rectangle extends Obstacle
{
  float w;
  float h;
  public Rectangle(Vector p,  float w, float h)
  {
    this.pos = p;
    this.w = w;
    this.h = h;
  }
  
  
  public boolean collision(Vector p, Vector v)
  { 
    if(this.contains(p))  return true; // starting point was inside the circle
    if(this.contains(v))  return true; //   ending point was inside the circle

    Line l = new Line(p,v); 
   
    Vector[] vs =  this.counterClockwiseVectors();
    
    return line(vs[0],vs[1]).intersect(l)
      ||   line(vs[1],vs[2]).intersect(l)
      ||   line(vs[2],vs[3]).intersect(l)
      ||   line(vs[3],vs[0]).intersect(l);
  }
  
  public boolean contains(Vector v)
  {
    Vector[] vs =  this.counterClockwiseVectors();
    return
      line(vs[0],vs[1]).side(v) == line(vs[1],vs[2]).side(v) && 
      line(vs[1],vs[2]).side(v) == line(vs[2],vs[3]).side(v) &&
      line(vs[2],vs[3]).side(v) == line(vs[3],vs[0]).side(v)  ;
    
  }
  
  public Vector[] counterClockwiseVectors()
  {
    Vector [] tmp = new Vector[4];
    tmp[0] = this.pos.plus(new Vector(-0.5*w, 0.5*h,0));
    tmp[1] = this.pos.plus(new Vector(-0.5*w,-0.5*h,0));
    tmp[2] = this.pos.plus(new Vector( 0.5*w,-0.5*h,0));
    tmp[3] = this.pos.plus(new Vector( 0.5*w, 0.5*h,0));
    return tmp;
  }
  
  public void draw()
  {
    rect(pos.value[0]-(w/2), pos.value[1]-(h/2), w, h);
  }


}
