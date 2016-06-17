public class SphereParticle extends Particle
{
  public void draw()
  {
    fill(fill);
    pushMatrix();
    translate(pos.value[0],pos.value[1],pos.value[2]);
    noStroke();
    sphere(radius);
    popMatrix();
  }
}

public class DotParticle extends Particle
{
  public void draw()
  {
    stroke(fill);
    strokeWeight(5);
    pushMatrix();
    translate(pos.value[0],pos.value[1],pos.value[2]);
    point(0,0,0);
    popMatrix();
  }
}

public class TexturedParticle extends Particle
{
  public TexturedParticle()
  {
    this.bounce   = .01;
    this.friction = .99;
    this.radius = 5;
    this.life = 100;
  }
  
  public void draw()
  {
    noStroke();
    fill(fill);
    pushMatrix();
    translate(pos.value[0],pos.value[1],pos.value[2]); // place particle in the correct location
    rotateZ(-camera.yaw);      rotateY(-camera.pitch); //  rotate so that the texture is billboarded to the camera
    
    beginShape();
    
    texture(texture);
    tint(255, 100);    
    vertex(0,-radius, -radius, 0,             0);
    vertex(0, radius, -radius, texture.width, 0);
    vertex(0, radius,  radius, texture.width, texture.height);
    vertex(0,-radius,  radius, 0,             texture.height);
    
    endShape();
    popMatrix();
    
  }


}



public class FireWork extends SphereParticle
{
  
  public FireWork(){}
  
  public void update(float time_step)
  { // FORWARD EULER
    life--;
    Vector newPos = pos.plus(vel.multiply(time_step));
    if(newPos.value[2] < radius) // if hits ground (z = 0)
    {
      vel.value[2] *= - bounce;     // change velocity to positive and scaled based on particle bounciness
      newPos.value[2] = radius;     // nudge the particle out of the way
      vel = vel.multiply(friction); // slow the velocity due to imperfect collision
    }
    else
      vel = vel.plus(acc.multiply(time_step));
    
    if(this.life > 0)
    { // add a trail
      Particle p = new TexturedParticle();
      p.pos = pos;
      p.acc = new Vector();
      p.life = this.life + (int)random(50,100);
      particles.add(p);
      pos = newPos;
    }
    else
    {
      for(int i =0; i < 20 ; i ++)
      {
        Particle p = new TrailedParticle();
        p.radius = 5;
        p.fill = color(0,255,0);
        p.pos = pos;
        p.vel = this.vel.plus(new Vector(random(-1,1),random(-1,1),random(-1,1)));
        p.acc = new Vector(0,0,-0.01);
        p.life = this.life + (int)random(50,100);
        particles.add(p);
        pos = newPos;
      }
    }
  }

}

public class TrailedParticle extends DotParticle
{
  
  public void update(float time_step)
  { // FORWARD EULER
    life--;
    this.fill = color(0,life*4+10,0);
    Vector newPos = pos.plus(vel.multiply(time_step));
    if(newPos.value[2] < radius) // if hits ground (z = 0)
    {
      vel.value[2] *= - bounce;     // change velocity to positive and scaled based on particle bounciness
      newPos.value[2] = radius;     // nudge the particle out of the way
      vel = vel.multiply(friction); // slow the velocity due to imperfect collision
    }
    else
      vel = vel.plus(acc.multiply(time_step));
    
    // add a trail
    if (random(0,2) > 1)
    {
      Particle p = new TexturedParticle();
      p.fill = color(0,255,0);
      p.pos = pos;
      p.acc = new Vector();
      p.life = this.life + (int)random(0,50);
      particles.add(p);
    }
    pos = newPos;
  }
}



public class SmokeParticle extends TexturedParticle
{
  public void draw()
  {
    noStroke();
    fill(fill);
    pushMatrix();
    translate(pos.value[0],pos.value[1],pos.value[2]); // place particle in the correct location
    rotateZ(-camera.yaw);      rotateY(-camera.pitch); //  rotate so that the texture is billboarded to the camera
    
    beginShape();
    
    texture(texture);
    tint(255, min(100,life-100));
    float size = max(radius, radius + (1000 - life)/2 );
    vertex(0,-size, -size, 0,             0);
    vertex(0, size, -size, texture.width, 0);
    vertex(0, size,  size, texture.width, texture.height);
    vertex(0,-size,  size, 0,             texture.height);
    
    endShape();
    popMatrix();
    
  }

}


