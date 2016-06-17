void stage(int stageNum, int agentNum)
{
  // reset everything
  obstacles   = new ArrayList<Obstacle>();
  nodes       = new ArrayList<Vector>();
  edges       = new ArrayList<Line>();
  currentPath = null;
  
  if(stageNum == 0 );
  else if(stageNum == 1)
  {
    startPos = new Vector(-9, -9, 0);
    goalPos  = new Vector( 9, 9, 0);
    obstacles.add(new Circle(new Vector(0,0,0), 2));
  }
  else if(stageNum == 2)
  {
    startPos = new Vector(-9, -9, 0);
    goalPos  = new Vector( 9, 9, 0);
    obstacles.add(new Rectangle(new Vector(0, 0, 0), 2, 30));
  }
  else if(stageNum == 3)
  {
    startPos = new Vector(-9, -9, 0);
    goalPos  = new Vector( 9, 9, 0);
  
    obstacles.add(new Circle(new Vector(0, 0, 0), 3));
    obstacles.add(new Circle(new Vector(0, 5, 0), 2));
    obstacles.add(new Circle(new Vector(0, 10, 0), 3));
    obstacles.add(new Circle(new Vector(0, 15, 0), 2));
    obstacles.add(new Circle(new Vector(5, 0, 0), 2))  ;
    obstacles.add(new Circle(new Vector(10, 0, 0), 2))  ;
    obstacles.add(new Circle(new Vector(15, 0, 0), 2))  ;
    obstacles.add(new Circle(new Vector(20, 0, 0), 2))  ;

  }
  else if(stageNum == 4)
  {
    startPos = new Vector(-18, -18, 0);
    goalPos  = new Vector( 9, 9, 0);
    
    obstacles.add( rectO(2.5, 0, 35, 1));
    obstacles.add( rectO(-10, -5, 20, 1));
    obstacles.add( rectO(-15, -15, 1, 10));
    obstacles.add( rectO(15, -5 , 10, .5));
    obstacles.add( circO(1, -12, 5));
   obstacles.add( rectO(10, -10 , 10, .5)); 
    obstacles.add( rectO(-2.5, 5, 35, 1));
    obstacles.add( rectO(5, 15, 20, 1));
    obstacles.add( rectO(15, 10, 1, 11));
  
    obstacles.add( circO(-12, 12, 1));
    obstacles.add( circO(-15, 10, 2));
    obstacles.add( circO(-1, 12, 3));
  }
  
  
  if(agentNum == 0)
    agent = new PointAgent( startPos, .01, null);
  else if(agentNum == 1)
    agent = new CircleAgent(.5, startPos, .01, null);
  else if(agentNum == 2)
    agent = new RectAgent(.5,1.5,startPos, .01, null); 


  agent.createCSpace(obstacles);
  nodes.add(startPos);
  nodes.add(goalPos);
}


