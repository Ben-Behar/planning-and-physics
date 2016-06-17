public interface Integrator
{
  public Vector nextPos(float timeStep, Particle p);
  public Vector nextVel(float timeStep, Particle p);
}

Integrator fEuler = new Integrator()
{
  public Vector nextPos(float dt, Particle p)
  {
    Vector v = p.pos.plus(p.vel.multiply(dt));
    return v;
  }
  public Vector nextVel(float dt, Particle p)
  {
    return p.vel.plus(p.acc.multiply(dt));
  }
};


Integrator midPoint = new Integrator()
{
  public Vector nextPos(float timeStep, Particle p)
  { // x + v*t + a*t*t*.5
    Vector tmp = new Vector();
    tmp = tmp.plus(p.pos);
    tmp = tmp.plus(p.vel.multiply(timeStep));
    tmp = tmp.plus(p.acc.multiply(0.5*timeStep*timeStep));
    return tmp;   
  }
  
  public Vector nextVel(float dt, Particle p)
  {
    return p.vel.plus(p.acc.multiply(dt));
  }
};





public interface Function
{
  public Vector f();
}
