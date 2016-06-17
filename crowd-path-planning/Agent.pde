public class Agent
{ // EACH agent has its own CSpace and PRM to guide it through the world
  Vector pos = new Vector();
  Vector vel = new Vector();
  float radius;
  float speed;
  Path path;
  Vector goal = new Vector(9,9,0);
  
  public void tryPath()
  {
    if(this.path == null)
    {
      this.vel  = new Vector();
      return;
    }
    Path p = path;
    while( p != null && prm.cSpace.valid(line(this.pos, p.v)) ) // this agent can see the next path goal
    {
      this.path = p;  
      p = this.path.parent;
    }
    
    Vector intent = path.v.minus(this.pos);
    float mag = intent.mag();
    if(mag > speed)
    {
      Vector nV = intent.multiply(this.speed/mag);
      
      if(mag < 0.2)
      {
        this.pos = path.v;
        advancePath();
      }
      else 
       this.vel = nV;
    }
    else advancePath(); // agent is close enough to get to goal in next step
  }
  
  private void advancePath()
  {
    this.vel = new Vector(); // stop the agent
    this.pos = this.path.v;  // make sure the agent is at the current paths destination
    this.path = this.path.parent; // grab the remaining path
  }

  
  
  public Agent(float radius,Vector pos, float speed, Path path)
  {
    this.radius = radius;
    this.pos    = pos;
    this.speed  = speed;
    this.path   = path;
  }

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
    fill(100,100,255);
    stroke(100,100,255);
    strokeWeight(.1);
    ellipse(pos.value[0], pos.value[1], radius*2, radius*2);
    stroke(170,170,0);
    if(this.path != null) line(this.pos, path.v).draw(); // draw line to current goal  
  }
}

