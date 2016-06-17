public class CSpace
{
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>(); // obstacles relative to the parent agent considering it's shape
  
  public CSpace(Agent a, ArrayList<Obstacle> obstacles)
  {
    for(Obstacle o : obstacles)
    {
      if( o instanceof Circle)
      { // if circle against circles just make the circle obstacles bigger
        Circle cO = (Circle) o;
        this.obstacles.add(new Circle(o.pos, cO.radius + a.radius));
      }
      else if(o instanceof Rectangle)
      { // do a bit of magic if it's circle on rectangle
        Rectangle rO = (Rectangle) o;
        for(Vector v : rO.counterClockwiseVectors()) // for each corner of Rectangle
          this.obstacles.add(new Circle(v, a.radius)); // put a circle on it
        this.obstacles.add(new Rectangle( rO.pos.plus(new Vector( .5*rO.w, 0, 0)) , 2*a.radius, rO.h)); // right
        this.obstacles.add(new Rectangle( rO.pos.plus(new Vector(-.5*rO.w, 0, 0)) , 2*a.radius, rO.h)); // left
        this.obstacles.add(new Rectangle( rO.pos.plus(new Vector( 0, .5*rO.h, 0)) , rO.w, 2*a.radius)); // down
        this.obstacles.add(new Rectangle( rO.pos.plus(new Vector( 0,-.5*rO.h, 0)) , rO.w, 2*a.radius)); // up
        this.obstacles.add(o);
      }
      else 
        throw new Error(" Obstacle type unknown to CircleAgent in createCSpace");
    }// cspace is generated
  
  }
  
  public boolean valid(Vector v)
  {
    for(Obstacle o : this.obstacles) if(o.contains(v)) return false;
    return true;
  }
  
  public boolean valid(Line l)
  {
    for(Obstacle o : this.obstacles) if(o.collision(l)) return false;
    return true;
  }
  
  
  public Vector randomNode()
  {
    Vector tmp = new Vector(random(-20,20),random(-20,20),0);
    while(!valid(tmp))
      tmp = new Vector(random(-20,20),random(-20,20),0);
    return tmp; 
  }

  public void draw()
  {
    noFill();
    stroke(255,10,10);
    strokeWeight(.1);
    for(Obstacle o : this.obstacles) o.draw();
  }
  
}
