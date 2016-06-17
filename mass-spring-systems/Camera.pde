public class Camera
{
  Vector pos   = new Vector(-500,500,300);
  float  pitch = 0;
  float  yaw   = .2*PI;

  public void update()
  {//println("ROTATION: " +  rotX + "  " + rotY);
    yaw    %= 2*PI;
    pitch  %= 2*PI;
    camera(0,0,0,    1,0,0,    0,0,-1);
    rotateY(pitch);
    rotateZ(yaw);
    rotateY(pitch);
    translate(-pos.value[0], -pos.value[1], -pos.value[2]);
  }
}
