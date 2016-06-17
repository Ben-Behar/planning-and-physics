public class Camera
{
  Vector pos   = new Vector(-2000,0,200);
  float pitch = 0;
  float yaw = 0;

  public void update()
  {//println("ROTATION: " +  rotX + "  " + rotY);
    yaw    %= 2*PI;
    pitch  %= 2*PI;
    //rotX %= 2*PI;
  
    // stack:
    // 1 translate
    // 2 rotate X -> Y
    camera(0,0,0,    1,0,0,    0,0,-1);
          rotateZ(yaw);
      rotateY(pitch);
    translate(-pos.value[0], -pos.value[1], -pos.value[2]);
  }
}
