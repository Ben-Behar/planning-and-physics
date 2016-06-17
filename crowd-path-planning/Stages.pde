void stage(int stageNum, int agentNum)
{
  // reset everything
  agents      = new ArrayList<Agent>();
  obstacles   = new ArrayList<Obstacle>();

 
  if(stageNum == 0 );
  else if(stageNum == 1)
  {
    // step 1 add obstacles
    obstacles.add(new Circle( vec(0,0), 2));
  }
  else if(stageNum == 2)
  {
    // step 1 add obstacles
    obstacles.add(new Circle( vec(0,0), 8));
    //step 2 add agents
  }
  else if(stageNum == 3)
  {
    for(int i = -20; i < 8;i++)
    {
      obstacles.add(new Circle( vec(-5,i), 2));
    }
        for(int i = -8; i < 19;i++)
    {
      obstacles.add(new Circle( vec(5,i), 2));
    }
  }
  else if(stageNum == 4)
  {
    for(int i = -20; i < 8;i++)
    {
      obstacles.add(new Circle( vec(-5,i), 1));
    }
    
    for(int j = -3; j < 2 ; j += 2)
      for(int i = -18; i < 8;i+=4)
        obstacles.add(new Circle( vec(j,i), .5));
      
    
    
    
    for(int i = -8; i < 19;i++)
    {
      obstacles.add(new Circle( vec(6,i), 2));
    }

  }
  
  if(agentNum == 0)
  {
    agents.add(new Agent( .5, vec(-8,-8), .01, null));
  }
  else if(agentNum == 1)
  {
    agents.add(new Agent( .5, vec(-8,-8), .01, null));
    agents.add(new Agent( .5, vec(-9,-9), .01, null));
  }
  else if(agentNum == 2)
  {
    for(int i = 0; i < 10; i ++)
    {
      agents.add(new Agent(.5, vec(-9,-i), .01, null));
    }
  
  }
  else if(agentNum == 3)
  {
    for(int i = 0; i < 4; i ++)
    for(int j = 0; j < 4; j ++)
    {
      agents.add(new Agent(.5, vec(-9-j,-8-i), .01, null));
    }
  
  }
  // step 3: generate a CSpace based on the agent size
  prm = new PRM(new CSpace(agents.get(0),obstacles),100); // all agents are the same size and shape so just use the first one as a template

  
}

public Vector vec( int x , int y) { return new Vector(x,y,0); }
