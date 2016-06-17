
void drawBounds()
{
  strokeWeight(0.1);
  noFill();
  rect(-20,-20,40,40);
}


void drawStart()
{
  float x = startPos.value[0]; 
  float y = startPos.value[1];
  float i = 0.3;
  fill(255,255,0);
  stroke(255,255,0);
  strokeWeight(.02);
  ellipse(x,y, i*2 , i*2);
  point(x,y);

}


void drawGoal()
{
  float x = goalPos.value[0]; 
  float y = goalPos.value[1];
  float i = 0.2;
  noFill();
  strokeWeight(.05);
  ellipse(x,y, i*2 , i*2);
  goalPos.draw();
}

public void setFrameTitle()
{
  frame.setTitle("Fps: " + int(frameRate) +
                 " | Nodes: " + nodes.size() +
                 " | Edges: " + edges.size() +
                 " | Agent: " + (agentNum == 1 ? "Circle" : (agentNum == 2 ? "Rectangle" : "Point")) + 
                 " | Frame: " + frameCount);
}


public Line line(Vector p, Vector v)
{
  return new Line(p,v);
}

public Rectangle rectO(float x, float y, float w, float h)
{
  return new Rectangle(new Vector(x,y,0),w,h);
}

public Circle circO(float x, float y, float r)
{
  return new Circle(new Vector(x,y,0), r);

}



