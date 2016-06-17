/*
TODO: add deforming to springs stretched to far
*/

public final int HEIGHT = 900;
public final int WIDTH  = 1280;
public boolean toggleDepthTest = true;
public boolean clothHeld = false;
public boolean midPointOn = true;

long lastTime;

Camera camera = new Camera();

Cloth cloth;
Jello jello;

ArrayList<Spring>   springs   = new ArrayList<Spring>();
ArrayList<Particle> particles = new ArrayList<Particle>();

PImage cTexture;
PImage jTexture;


Vector wind    = new Vector(0,0,0);
Vector gravity = new Vector(0,0,-1);


void setup()
{ size(WIDTH,HEIGHT,P3D); // Use P3D Renderer
  cTexture  = loadImage("f2.png");
  jTexture = loadImage("jello.jpg");

  lastTime = millis();
}


public void stage0()
{
  cloth = null;
  jello = null;
  wind = new Vector();
  springs   = new ArrayList<Spring>();
  particles = new ArrayList<Particle>();
}

public void stage1()
{
  cloth = null;
  jello = null;
  springs   = new ArrayList<Spring>();
  particles = new ArrayList<Particle>();

  
  cloth = new Cloth(20,20,10);
  particles.addAll(cloth.getParticles());
}

public void stage2()
{
  stage0();
  
  jello = new Jello(5,10,5,50);
  particles.addAll(jello.getParticles());
}

public void stage3()
{
  stage0();
  jello = new Jello(5,5,5,50);
  
  particles.addAll(jello.getParticles());
}
 
public void stage4()
{
  Vector w = new Vector(1,1,0);
  for(Particle p : particles)
    p.vel.add(w);
}

public void stage5() // swap integrators
{
  midPointOn = false;
  for(Particle p: particles) p.integrator = fEuler;
}

public void stage6() // swap integrators
{
  midPointOn = true;
  for(Particle p: particles) p.integrator = midPoint;
}


