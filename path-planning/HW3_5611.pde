
public final int HEIGHT = 900;
public final int WIDTH  = 1280;
public final float scale = 20; // how many pixels to meters

public boolean toggleLines  = true;
public boolean toggleCSpace = false;
public int     agentNum     = 0;
public int     stageNum     = 1;

public float time = millis();

public Vector startPos = new Vector();
public Vector goalPos = new Vector();
public Agent agent;

public PRM prm = new PRM();
public Path currentPath = null;

public ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
public ArrayList<Vector>   nodes     = new ArrayList<Vector>();
public ArrayList<Line>     edges     = new ArrayList<Line>();

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
 
   
  stroke(255,255,255);
  for(Vector v : nodes) v.draw();
  if(toggleLines) for(Line l : edges)   l.draw();
  drawStart();
  drawGoal();
   
   
  agent.tryPath();
  agent.pos = agent.pos.plus(agent.vel.multiply(dt));  // Advance the agent with forward Euler
  
  if(currentPath != null) currentPath.draw();             
  if(agent.path  != null) agent.path.draw();
  agent.draw();
  
    
  fill(50,50,50);
  noStroke();
  for(Obstacle o : obstacles) o.draw();
    
  fill(255,255,255);
  stroke(255,255,255);
  drawBounds();

    
  if(toggleCSpace) agent.cSpace.draw();
  setFrameTitle();
}

