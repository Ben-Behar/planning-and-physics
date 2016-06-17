
void drawBounds()
{
  strokeWeight(0.1);
  noFill();
  rect(-20,-20,40,40);
}



public void setFrameTitle()
{
  frame.setTitle("Fps: " + int(frameRate) +
                 " | Agents: " + agents.size() +
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


