public class Spawner
{
  Vector pos = new Vector(0, 0, 100);
  Vector sVel = new Vector(2,2,10);
  float radius = 20;
  float vErr = .1;
  float rErr = .5;
  // TODO: implement a clone able particle that can be reused as part of the spawner
  
  public Spawner() {}

  public void update()
  {
    for (int i = 0 ; i < 10; i++)
    {
      TexturedParticle p1 = new TexturedParticle();
      particles.add(p1);
      //float r     = random(0, radius);
      //float angle = random(0, 2*PI);
      p1.bounce = .2;
      p1.friction = .9;
      p1.fill = color(50,50,255);
      p1.radius = radius;
      //p1.vel = new Vector( radius*cos(angle),radius*sin(angle),random(19,20));
      p1.pos = pos.plus( new Vector( random(-10,10), random(-10,10), random(-10,10) ));
      p1.vel = sVel.plus(
          new Vector( random(-rErr,rErr), random(-rErr,rErr), random(-rErr,rErr) )
        ).multiply(random(1.0-vErr,1.0+vErr));      
      p1.acc = new Vector(0,0,-1); // just for gravity
    }
  }
}



public class FireSpawner extends Spawner
{
  public FireSpawner(){}
  
  
  public void update()
  {
    float w = .6;
    Vector wisp = new Vector(random(-w,w),random(-w,w),0); // accounts for wispiness of fire (I would call it the twisting of the air but there is a more technical term)
    for(int i = 0 ; i < 15 ; i++)
    {
      Particle p = new TexturedParticle();
      p.fill = color(255,0,0);
      p.life = 53;
      p.radius = 20;

      float angle = random(0,2*PI);
      float radius = random(10,50);

      p.acc = new Vector(0,0,.1);
      p.pos = new Vector( radius*cos(angle),radius*sin(angle),random(0,10));
      p.vel = p.pos.multiply(.05).plus(wisp);
      p.acc = p.pos.multiply(-.0015);
      
      p.acc.value[2] = .1;
      p.pos.value[2] = random(0,5);
      particles.add(p);
    }
  }




}
