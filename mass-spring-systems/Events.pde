void keyPressed()
{
  float dp = 10;
  float dr =  PI/100;

  println(keyCode);
  if (keyCode == 37)    camera.yaw   += dr; // left
  if (keyCode == 38)    camera.pitch += dr;  // up
  if (keyCode == 39)    camera.yaw   -= dr;  // right
  if (keyCode == 40)    camera.pitch -= dr;  // down
  if (keyCode == 87)    camera.pos.value[0] += dp;//w
  if (keyCode == 65)    camera.pos.value[1] -= dp;//a
  if (keyCode == 83)    camera.pos.value[0] -= dp;//s
  if (keyCode == 68)    camera.pos.value[1] += dp;//d
  if (keyCode == 81)    camera.pos.value[2] -= dp;//q
  if (keyCode == 69)    camera.pos.value[2] += dp;//e
  
  if (keyCode == 32)    stage0(); // space
  if (keyCode == 49)    stage1();  // 1
  if (keyCode == 50)    stage2();  // 2
  if (keyCode == 51)    stage3();  // 3
  if (keyCode == 52)    stage4();  // 4
  if (keyCode == 53)    stage5();  // 3
  if (keyCode == 54)    stage6();  // 4
  
  if (keyCode == 73)    wind.add(new Vector(0,-.1,0));
  if (keyCode == 74)    wind.add(new Vector(-.1,0,0));
  if (keyCode == 75)    wind.add(new Vector(0,-.1,0));
  if (keyCode == 76)    wind.add(new Vector(.1,0,0));
  if (keyCode == 85)    wind.add(new Vector(0,0,.1));
  if (keyCode == 79)    wind.add(new Vector(0,0,-.1));
  
  
  if (keyCode == 192)
  {
    if(toggleDepthTest) hint(DISABLE_DEPTH_TEST);
    else                hint(ENABLE_DEPTH_TEST);
    toggleDepthTest = !toggleDepthTest;
  }
  
  
  
  
  
  camera.update();
} 

