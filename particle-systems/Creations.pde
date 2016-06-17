
public Particle ball()
{
  Particle p1 = new Particle();
  particles.add(p1);
  p1.pos = new Vector(0,0,1000);
  p1.vel = new Vector(1,1,0);
  p1.acc = new Vector(0,0,-.5); // just for gravity
  
  p1.fill = color(155,155,155);
  p1.bounce   = .6;
  p1.friction = .99;
  p1.radius = 100;
  
  return p1;
}




public Spawner spout()
{
   Spawner s = new Spawner();
   s.sVel = new Vector(10,10,10);
   
   
   return s;

}

public Spawner fire()
{
  return new FireSpawner();

}

public Particle firework()
{
    Particle p = new FireWork();
    p.pos = new Vector(random(-100,100),random(-100,100),50);
    p.vel = new Vector(random(-1,1),random(-1,1),4);
    p.acc = new Vector(0,0,-.02);
    p.life = 100;
    p.radius = 10;
    return p;

}







void drawCoordSys(float size) // RED = x ; GREEN = y ; BLUE = z 
{
  strokeWeight(1);
  stroke(255, 0, 0);
  line(0,0,0,size,0,0);
  stroke(0, 255, 0);
  line(0,0,0,0,size,0);
  stroke(0, 0, 255);
  line(0,0,0,0,0,size);
}

void drawGround()
{
  strokeWeight(0);
  stroke(255,255,255);
  fill(255,255,255);
  rect(0, 0, 1000, 1000, 1);
  rect(-1000, -1000, 1000, 1000, 1);
  stroke(100,100,100);
  fill(100,100,100);
  rect(-1000, 0, 1000, 1000, 1);
  rect(0, -1000, 1000, 1000, 1);

}
