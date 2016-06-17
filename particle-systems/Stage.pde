
public void stage1()
{
  particles.add(ball());
  
}

public void stage2()
{
  spawners.add(spout());
}


public void stage3()
{
  spawners.add(fire());
}


public void stage4()
{
  particles.add(firework());
}

public void stage5()
{
  float w = 50;
  Vector wisp = new Vector(random(-w,w),random(-w,w),0);
  for(int i = 0 ; i < 2; i ++)
  {
    Particle p = new SmokeParticle();
    p.pos = wisp.plus(new Vector(random(-20,20),random(-20,20),400 + random(20)));
    p.vel = new Vector(random(-.2,.2),random(-.2,.2),3);
    p.acc = new Vector(0,0,-.002);
    p.life = 1000;
    p.radius = 50;
    p.fill = color(80,80,100);
   
  
    
    particles.add(p);
  }
  
  
  
}
