
public final int HEIGHT = 900;
public final int WIDTH  = 1280;
public final float scale = 20; // how many pixels to meters

public final color white = color(255,255,255);


public boolean toggleLines  = false;
public boolean toggleCSpace = false;
public int     agentNum     = 0;
public int     stageNum     = 1;


public float time = millis();


public PRM prm = null;


public ArrayList<Agent>    agents    = new ArrayList<Agent>();
public ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();


void setup()
{ size(WIDTH,HEIGHT);
  stage(stageNum, agentNum);
}

void draw()
{
  float dt = millis() - time;
  time = millis();
  translate( WIDTH/2.0, HEIGHT/2.0);
  rotate(PI*1.5);
  scale(20);
  background(0,0,0);
 

  for(Agent a : agents) a.tryPath();
  for(Agent a : agents) doAlign(a,5);
  for(Agent a : agents) doCohesion(a,4);
  for(Agent a : agents) doRepel(a,2);
  for(Agent a : agents) avoidObstacles(a,4);
  for(Agent a : agents) capVelocity(a, .01);
  //for(Agent a : agents) treatCollisions(a);

  
  for(Agent a : agents) eulerStep(a, dt);
  
  for(Agent a : agents)
  {
    if(a.path  != null) a.path.draw();
    a.draw();
    
    
  }
  if(toggleCSpace) prm.cSpace.draw();
  if(toggleLines) for(Line l : prm.edges)   l.draw();
    
    
  fill(50,50,50)   ;  noStroke()         ; for(Obstacle o : obstacles) o.draw();
  fill(white);  stroke(white); drawBounds();

    

  setFrameTitle();
}


public void doRepel(Agent a, float dist)
{
  float rGrad = .01;
  float rDist = 0;
  
  for(Agent oa : agents)
    if(oa != a)
      if (oa.pos.minus(a.pos).mag() < dist)
      {
        float distance = a.pos.minus(oa.pos).mag();
        a.vel = a.vel.plus( a.pos.minus(oa.pos).multiply(rGrad/(distance*(distance+rDist)))  );
      }
}

public void doCohesion(Agent a, float dist)
{
  float force  = .0001 ;
  
  Vector sum = new Vector();
  int count = 0; 
  for(Agent oa : agents)
    if(oa != a)
      if (oa.pos.minus(a.pos).mag() < dist)
      { 
         sum = sum.plus(oa.pos);
         count++;
      }
  if(count > 0)
  {
    Vector f = sum.multiply(1.0/count).minus(a.pos);
    a.vel = a.vel.plus(f.multiply(force/(f.mag()*f.mag())));
    
  }
}

public void doAlign(Agent a, float dist)
{
  float force = .00001;
  
  Vector sum = new Vector();
  int count = 0;
  for(Agent oa : agents)
    if(oa != a && oa.pos.minus(a.pos).mag() < dist)
    {
      sum = sum.plus(oa.vel);
      count++;
    }
  if(count > 0 )
  {
    Vector avg = sum.multiply(1.0/count);
    Vector f   = avg.minus(a.vel);
    float mag = f.mag();
    if(mag > 0)
      a.vel = a.vel.plus(f.multiply(force/(mag*mag)));
  }
}
  
  
public void capVelocity(Agent a, float limit)
{
  float mag = a.vel.mag();
  if(mag > limit)
    a.vel = a.vel.multiply(1/mag).multiply(limit);
}

public void avoidObstacles(Agent a, float limit)
{
  float force = 0.001;
  for(Obstacle o : prm.cSpace.obstacles) // use the obstacles relative to the agents
  {
    Vector dist = a.pos.minus(o.pos);
    float mag = dist.mag();
    if(mag < limit+o.radius)
      a.vel = a.vel.plus( dist.multiply(1/mag).multiply(force/(mag-o.radius)) );
  }
}


public void eulerStep(Agent a, float dt)
{
  Vector newPos = a.pos.plus(a.vel.multiply(dt));  // Advance the agent with forward Euler
  if(prm.cSpace.valid(newPos))
    a.pos = newPos;
}


