public final int HEIGHT = 900;
public final int WIDTH  = 1280;
Camera camera = new Camera();
ArrayList<Particle> particles = new ArrayList<Particle>();
ArrayList<Spawner>  spawners  = new ArrayList<Spawner>();

boolean toggleDepthTest = true;



Vector gravity = new Vector(0,0,-1);


int lastTime = millis();
PImage texture;


float[] d1 = {1,1,-1};
float[] d2 = {100,100,100};
Vector v1 = new Vector(d1);
Vector v2 = new Vector(d2);


void setup()
{ size(WIDTH,HEIGHT,P3D); // Use P3D Renderer
  texture = loadImage("fireball.png");
  texture.mask(loadImage("fireball.png")); // this selects a black and white mask to display the image through 
  

}


void draw()
{ camera.update();
  background(0,0,0);
  ambientLight(100, 100, 100);
  directionalLight(200, 200, 200, 0, 0, -1);
  
  strokeWeight(10);
  
  int time     = millis();
  int timeStep = time - lastTime;
  
  drawGround();
  drawCoordSys(50);
  
  
  for(Spawner s : spawners)
    s.update();

  for(int i = 0 ; i < particles.size(); i++)
  {
    Particle p = particles.get(i);
    p.update(timeStep/10.0);
    if (p.life > 0)
      p.draw();
    else
    {
      particles.remove(i);
      i--;
    }
  }
 
  frame.setTitle("Fps: " + int(frameRate) + " | Particles: " + particles.size() + " | DepthTest: " + toggleDepthTest);
  lastTime = time;

}






/*  THINGS THAT WERE INCLUDED THAT ARE WORTH MERIT:

 15 Ball Bouncing
 15 Spout of 'Water'
 15 Fire
 15 Fireworks
 
 
 
 5 User Controlled Camera
 5 3D implementation
 5 Realtime Rendering (if particles < 2000)
 
 5 Textured Sprites       (Enable/Disable depth test to see issues (key '~'))
 5 Trails on Particles
 5 Translucent Particles  ( This is what 'tint()' does)
 
 
 
 Additional:
 
 loss of energy due to friction
 loss of energy due to 'bounciness'
 
 
 
 














*/
