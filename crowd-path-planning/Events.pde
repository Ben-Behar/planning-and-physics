void keyPressed()
{
  float dp = 10;
  float dr =  PI/100;

   println(keyCode);
  if (keyCode == 10)    for(Agent a : agents) a.path = prm.getPath(new Vector(9,9,0), a.pos); // enter // provides agent with path
  if (keyCode == 32)    prm.step(); // space
  
  if (keyCode == 192)   toggleLines  = !toggleLines;  // ~
  if (keyCode == 9)     toggleCSpace = !toggleCSpace; // tab
  
  
  if (keyCode == 49)    stage(stageNum = 1, agentNum);  // 1
  if (keyCode == 50)    stage(stageNum = 2, agentNum);  // 2
  if (keyCode == 51)    stage(stageNum = 3, agentNum);  // 3
  if (keyCode == 52)    stage(stageNum = 4, agentNum);  // 4
  

  if (keyCode == 81)    stage(stageNum, agentNum = 0 );  // q
  if (keyCode == 87)    stage(stageNum, agentNum = 1);   // w  
  if (keyCode == 69)    stage(stageNum, agentNum = 2);   // e
  if (keyCode == 82)    stage(stageNum, agentNum = 3);   // r
  
  time = millis();

  
}
  
