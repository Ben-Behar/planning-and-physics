void mouseWheel(MouseEvent event) // ZOOM IN/OUT
{
 // float scale =  1.0 + event.getCount() / 10.0;
  //camera.dist = camera.dist*(scale);
  //camera.update();
}

void keyPressed()
{
  float dp = 10;
  float dr =  PI/100;
  Vector v = new Vector();
  println(keyCode);
  if (keyCode == 37)    camera.yaw += dr; // left
  if (keyCode == 38)    camera.pitch += dr;  // up
  if (keyCode == 39)    camera.yaw -= dr;  // right
  if (keyCode == 40)    camera.pitch -= dr;  // down
  if (keyCode == 87)    camera.pos.value[0] += dp;//w
  if (keyCode == 65)    camera.pos.value[1] -= dp;//a
  if (keyCode == 83)    camera.pos.value[0] -= dp;//s
  if (keyCode == 68)    camera.pos.value[1] += dp;//d
  if (keyCode == 81)    camera.pos.value[2] -= dp;//q
  if (keyCode == 69)    camera.pos.value[2] += dp;//e
  
  if (keyCode == 49)    stage1();  // 1
  if (keyCode == 50)    stage2();  // 2
  if (keyCode == 51)    stage3();  // 3
  if (keyCode == 52)    stage4();  // 4
  if (keyCode == 53)    stage5();  // 5
  
  if (keyCode == 192)
  {
    if(toggleDepthTest)
      hint(DISABLE_DEPTH_TEST);
    else
    {
      System.out.println("enable");
      hint(ENABLE_DEPTH_TEST);
    }
    toggleDepthTest = !toggleDepthTest;
  }
  
  if (keyCode == 32)
  {
    particles.clear();
    spawners.clear();
  }
  
  
  camera.update();
} 


void mousePressed()
{
  println("Mouse Pressed!");
}


