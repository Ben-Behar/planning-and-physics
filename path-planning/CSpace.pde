public class CSpace
{
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>(); // obstacles relative to the parent agent considering it's shape
  
  
  public boolean validNode(Vector v)
  {
    for(Obstacle o : this.obstacles)
      if(o.contains(v))
        return false;
    return true;
  }
  
  public boolean validEdge(Line l)
  {
    for(Obstacle o : this.obstacles)
    {
      if(o.collision(l))
      {
        //stroke(255,0,0); // red means collision detected
        //l.draw();
        return false;
      }
    }
    return true;
  }
  
  
  public Vector randomNode()
  {
    Vector tmp = new Vector(random(-20,20),random(-20,20),0);
    while(!validNode(tmp))
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
