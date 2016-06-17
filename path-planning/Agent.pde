public abstract class Agent
{
  Vector pos;
  Vector vel;
  float speed;
  Path path;
  CSpace cSpace = new CSpace();
  public abstract void createCSpace(ArrayList<Obstacle> relativeObstacles);
  public abstract void draw();
  
  public void tryPath()
  {
    if(this.path == null)
    {
      this.vel  = new Vector();//println("nothing to do!");
      return;
    }
    
    Vector intent = path.v.minus(this.pos);
    float mag = intent.mag();
    if(mag > speed)
    {
      Vector nV = intent.multiply(this.speed/mag);
      float cos = this.vel.toUnit().dot(nV.toUnit()); 
      if(cos < -.9 ) advancePath(); // if the cos of the angle between them is to large, indicates oscilation
      else this.vel = nV;
    }
    else advancePath(); // agent is close enough to get to goal in next step
  }
  
  private void advancePath()
  {
    this.vel = new Vector(); // stop the agent
    this.pos = this.path.v;  // make sure the agent is at the current paths destination
    this.path = this.path.parent; // grab the remaining path
  }
}


public class PointAgent extends Agent
{
  public PointAgent(Vector pos, float speed, Path path)
  {
    this.pos = pos;
    this.speed = speed;
    this.path = path;
  }

  public void createCSpace(ArrayList<Obstacle> os)
  {
    this.cSpace = new CSpace();
    this.cSpace.obstacles.addAll(os);
  }


  public void draw()
  {
    float x = this.pos.value[0]; 
    float y = this.pos.value[1];
    float i = 0.5;
    noFill();
    stroke(100,100,255);
    strokeWeight(.1);
    ellipse(x,y, i*2 , i*2);
    strokeWeight(.2);
    point(x,y);
    if(this.path != null) line(this.pos, path.v).draw(); // draw line to current goal
  }
}



public class CircleAgent extends Agent
{
  float radius;
  
  public CircleAgent(float radius,Vector pos, float speed, Path path)
  {
    this.radius = radius;
    this.pos = pos;
    this.speed = speed;
    this.path = path;
  }

  public void createCSpace(ArrayList<Obstacle> os)
  {
    this.cSpace = new CSpace();
    for(Obstacle o : os)
    {
      if( o instanceof Circle)
      { // if circle against circles just make the circle obstacles bigger
        Circle cO = (Circle) o;
        this.cSpace.obstacles.add(new Circle(o.pos, cO.radius + this.radius));
      }
      else if(o instanceof Rectangle)
      { // do a bit of magic if it's circle on rectangle
        Rectangle rO = (Rectangle) o;
        for(Vector v : rO.counterClockwiseVectors()) // for each corner of Rectangle
          this.cSpace.obstacles.add(new Circle(v, this.radius)); // put a circle on it
        this.cSpace.obstacles.add(new Rectangle( rO.pos.plus(new Vector( .5*rO.w, 0, 0)) , 2*this.radius, rO.h)); // right
        this.cSpace.obstacles.add(new Rectangle( rO.pos.plus(new Vector(-.5*rO.w, 0, 0)) , 2*this.radius, rO.h)); // left
        this.cSpace.obstacles.add(new Rectangle( rO.pos.plus(new Vector( 0, .5*rO.h, 0)) , rO.w, 2*this.radius)); // down
        this.cSpace.obstacles.add(new Rectangle( rO.pos.plus(new Vector( 0,-.5*rO.h, 0)) , rO.w, 2*this.radius)); // up
        this.cSpace.obstacles.add(o);
      }
      else 
        throw new Error(" Obstacle type unknown to CircleAgent in createCSpace");
    }
  }


  public void draw()
  {
    fill(100,100,255);
    stroke(100,100,255);
    strokeWeight(.1);
    ellipse(pos.value[0], pos.value[1], radius*2, radius*2);
    if(this.path != null) line(this.pos, path.v).draw(); // draw line to current goal  
  }
}



public class RectAgent extends Agent
{
  float w;
  float h;
  
  public RectAgent(float w,float h,Vector pos, float speed, Path path)
  {
    this.w = w;
    this.h = h;
    this.pos = pos;
    this.speed = speed;
    this.path = path;
  }

  public void createCSpace(ArrayList<Obstacle> os)
  {
    this.cSpace = new CSpace();
    for(Obstacle o : os)
    {
      if( o instanceof Circle)
      { //
        Circle cO = (Circle) o;
        this.cSpace.obstacles.add(new Rectangle( cO.pos.plus(new Vector( cO.radius, 0, 0)) , this.w, this.h)); // right
        this.cSpace.obstacles.add(new Rectangle( cO.pos.plus(new Vector(-cO.radius, 0, 0)) , this.w, this.h)); // left
        this.cSpace.obstacles.add(new Rectangle( cO.pos.plus(new Vector( 0, cO.radius, 0)) , this.w, this.h)); // down
        this.cSpace.obstacles.add(new Rectangle( cO.pos.plus(new Vector( 0,-cO.radius, 0)) , this.w, this.h)); // up
        
        this.cSpace.obstacles.add(new Circle( cO.pos.plus(new Vector( .5*this.w,  .5*this.h, 0)) , cO.radius)); // dl
        this.cSpace.obstacles.add(new Circle( cO.pos.plus(new Vector( .5*this.w, -.5*this.h, 0)) , cO.radius)); // ul
        this.cSpace.obstacles.add(new Circle( cO.pos.plus(new Vector(-.5*this.w,  .5*this.h, 0)) , cO.radius)); // dr
        this.cSpace.obstacles.add(new Circle( cO.pos.plus(new Vector(-.5*this.w, -.5*this.h, 0)) , cO.radius)); // ur
        
      }
      else if(o instanceof Rectangle)
      { //  if rect on rect add both widths and heights to get new rect
        Rectangle rO = (Rectangle) o;
        this.cSpace.obstacles.add(new Rectangle( rO.pos, rO.w + this.w, rO.h + this.h ));
      }
      else 
        throw new Error(" Obstacle type unknown to CircleAgent in createCSpace");
    }
  }


  public void draw()
  {
    fill(100,100,255);
    stroke(100,100,255);
    strokeWeight(.1);
    rect(pos.value[0]-(w/2), pos.value[1]-(h/2), w, h);
    if(this.path != null) line(this.pos, path.v).draw(); // draw line to current goal  
  }
}


