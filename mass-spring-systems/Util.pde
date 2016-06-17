public void line(Vector v1, Vector v2)
{

  line(v1.value[0],v1.value[1],v1.value[2],
       v2.value[0],v2.value[1],v2.value[2]);
     
}

public void vertex(Vector v, float t1, float t2)
{
  vertex(v.value[0],v.value[1],v.value[2], t1, t2);
}

public void attachSpring(Particle p1 , Particle p2, Spring s)
{
  //s.clone();

}

public void connect(Particle p1, Particle p2)
{
  Spring s = new Spring(p1,p2);
  springs.add(s);

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
  strokeWeight(1);
  stroke(255,255,255);
  fill(255,255,255);
  rect(0, 0, 1000, 1000, 1);
  rect(-1000, -1000, 1000, 1000, 1);
  stroke(100,100,100);
  fill(100,100,100);
  rect(-1000, 0, 1000, 1000, 1);
  rect(0, -1000, 1000, 1000, 1);

}

