public class Particle
{
  Vector pos = new Vector();
  Vector vel = new Vector();
  Vector acc = new Vector();

  color fill = color(155,155,155);
  
  
  float bounce   = .5;
  float friction = .99;
  float radius = 100;
  
  int life = 500;
  
  public Particle(){}
  
  public void update(float time_step)
  { // FORWARD EULER
    life--;
    Vector newPos = pos.plus(vel.multiply(time_step));
    if(newPos.value[2] < radius) // if hits ground (z = 0)
    {
      vel.value[2] *= - bounce;     // change velocity to positive and scaled based on particle bounciness
      newPos.value[2] = radius;     // nudge the particle out of the way
      vel = vel.multiply(friction); // slow the velocity due to imperfect collision
    }
    else
      vel = vel.plus(acc.multiply(time_step));
    pos = newPos;
  }
  
  public void draw()
  {
    fill(fill);
    pushMatrix();
    translate(pos.value[0],pos.value[1],pos.value[2]);
    noStroke();
    sphere(radius);
    popMatrix();
    
  }
}
