public abstract class Particle
{
  Vector pos = new Vector();
  Vector vel = new Vector();
  Vector acc = new Vector();
  
  Integrator integrator = fEuler;


  color fill = color(155,155,155);
  
  
  float bounce   = .5;
  float friction = .8;
  float damping  = .9999;
  float radius = 100;

  
  public Particle()
  {
    this.integrator = midPoint;
    //System.out.println(integrator);
  }
  
  public void update(float time_step)
  {
    Vector newPos = integrator.nextPos(time_step,this);
    if(newPos.value[2] < radius) // if hits ground (z = 0)
    {
      vel.value[2]   *= - bounce;   // change velocity to positive and scaled based on particle bounciness
      newPos.value[2] = radius;     // nudge the particle out of the way
      vel = vel.multiply(friction); // slow the velocity due to imperfect collision
    }
    else
      vel = integrator.nextVel(time_step, this).multiply(damping);
    pos = newPos;
  }
  
  public void draw()
  {
    fill(fill);
    pushMatrix();
    translate(pos.value[0],pos.value[1],pos.value[2]);
    strokeWeight(3);
    point(0,0);
    popMatrix();
    
  }
  
  public String toString()
  {
    return "/" + pos + "\n|" + vel + "\n\\" + acc; 
  
  }
}
