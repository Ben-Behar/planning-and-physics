public class Spring
{
  Particle p1 = null;
  Particle p2 = null;
  float restLength = 50;
  float k          = .01;
  float damping    = .0001;
  float deform     = 1.5;
  public Spring( Particle p1, Particle p2)
  {
    this.p1 = p1;
    this.p2 = p2;
  }
  
  
  
  public void update()
  {
    Vector dif = p2.pos.minus(p1.pos);
    float mag  = dif.mag();
    if(mag == 0)         println("WARNING: V.mag() WAS 0 - Dividing by zero error");
    if(Float.isNaN(mag)) println("WARNING: V.mag() WAS NAN - A General Problem");
    
    Vector direction = dif.multiply(1/mag); // unit vector
  
    // stroke(0,255,0); line(p1.pos, p1.pos.plus(direction.multiply(restLength)));// shows ideal resting length
    //stroke(255,255,255);
    if(abs(mag - restLength) > restLength * this.deform)
      this.restLength = mag;
    
    
    Vector vk = direction.multiply( k* (mag - restLength) ); // Hooke's Law
    
    Vector v1 = direction.multiply(direction.dot(p1.vel)); // v1
    Vector v2 = direction.multiply(direction.dot(p2.vel)); // v2
    Vector vd = v2.minus(v1);

    // assume mass of each particle is 1
    p1.acc.add( vk.multiply( .5).plus(vd.multiply( damping)) ); // add 1/2 to p1 
    p2.acc.add( vk.multiply(-.5).plus(vd.multiply(-damping)) ); // add -.5 to p2
  }
  
  public void draw()
  {
    stroke(0,255,0);
    line(p1.pos,p2.pos);
  }


  public Spring copy()
  {
    Spring c = new Spring(this.p1,this.p2);
    c.restLength = this.restLength;
    c.k          = this.k;
    c.damping    = this.damping;
    c.deform     = this.deform;
    return c;
  }  


}



public void newSpring(Particle p1, Particle p2, Spring s)
{
   s = s.copy();
   s.p1 = p1;
   s.p2 = p2;
   springs.add(s);
   
}
