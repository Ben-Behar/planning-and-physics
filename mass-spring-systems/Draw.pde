void draw()
{ long timeStep = - lastTime + (lastTime = millis());
  //LIGHTS
  background(0,0,0);
  ambientLight(100,100,100);
  pointLight(200,200,200,0,0,1000);
  //CAMERA
  camera.update();
  //ACTION
  
    
  drawCoordSys(100);
  drawGround();
  
  for(Particle p : particles) p.acc = new Vector(gravity); // reset all accelerations
  if(cloth != null) cloth.applyDrag();
  for(Spring   s : springs  ) s.update(); // calculate acc due to springs
  
  int steps = 20;
  for(int i = 0; i < steps ; i++)
    for(Particle p : particles)
      p.update((float)timeStep/(100*steps)); 
  

  //for(Spring s : springs)    s.draw();
  //for(Particle p: particles) p.draw();  
  if(cloth != null) cloth.draw();
  if(jello != null) jello.draw();
  
    
  
  frame.setTitle("Fps: " + int(frameRate) +
              " | Particles: " + 0 +
              " | DepthTest: " + toggleDepthTest +
              " | Frame: " + frameCount + 
              " | Integrator: " + (midPointOn ? "Midpoint" : "Forward Euler"));
}
