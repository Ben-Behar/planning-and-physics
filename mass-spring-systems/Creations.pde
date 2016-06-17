
public class Cloth
{
   public Particle[][] cloth;
   
   float spacing = 10;
   float damping =  .5;
   float strength = .8;
   
   
   Spring closeSpring = new Spring(null,null);
   Spring farSpring   = new Spring(null,null);
   Spring diagSpring  = new Spring(null,null);
   
   public Cloth(int w, int h, int spacing)
   {
     this.spacing = spacing;
     this.cloth = new Particle[w][h];
     
     
     closeSpring.restLength = spacing;
     closeSpring.k          = strength;
     closeSpring.damping    = damping;
     
     diagSpring.restLength  = sqrt(2.0) * spacing; // use sqrt 2f
     diagSpring.k           = strength*1.4;
     diagSpring.damping     = damping;
     
     farSpring.restLength   = 2 * spacing ;
     farSpring.k            = strength *1;
     farSpring.damping      = damping;

     
     for(int i = 0 ; i < cloth.length; i++) // left right
       for(int j = 0 ; j < cloth[i].length; j++) // up down
       {
         cloth[i][j] = new Particle()
         {};
         cloth[i][j].pos = new Vector(i*spacing,j*spacing,500);
         cloth[i][j].vel = new Vector(0,0,0);
         cloth[i][j].acc = new Vector(0,0,-1);
         cloth[i][j].bounce   = .01;
         cloth[i][j].friction = .99;
         cloth[i][j].radius   = 10;      
         cloth[i][j].damping  = .99995;
         
       }
       
     for(int i = 0 ; i < cloth.length; i++) // left right
        for(int j = 0 ; j < cloth[i].length; j++) // up down
        {
          if( (i+1) < cloth.length)                            newSpring(cloth[i][j], cloth[i+1][j],  closeSpring); // right
          if( (j+1) < cloth[i].length)                         newSpring(cloth[i][j], cloth[i][j+1],  closeSpring); // down
          
          if( (i-1) >= 0 && (j+1) < cloth[i].length)           newSpring(cloth[i][j], cloth[i-1][j+1], diagSpring); // down left
          if( (i+1) < cloth.length && (j+1) < cloth[i].length) newSpring(cloth[i][j], cloth[i+1][j+1], diagSpring); // down right
          
          if( (i+2) < cloth.length)                            newSpring(cloth[i][j], cloth[i+2][j],    farSpring); // double right
          if( (j+2) < cloth[i].length)                         newSpring(cloth[i][j], cloth[i][j+2],    farSpring); // double down
        }
   }

  private Vector dragForTriangle(Particle p1, Particle p2, Particle p3)
  { // - .5 * density * constant * mag(avgVelocity)^2 * area * unitNormal
    //Vector wind = new Vector(0,0,0);
    
    Vector vel  = p1.vel.plus(p2.vel).plus(p3.vel).multiply(1.0/3.0).minus(wind); // compute avg velocity - wind
    Vector norm = p2.pos.minus(p1.pos).cross(p3.pos.minus(p1.pos)); // get cross of two sides of triangle
    
    float pc = 0.001;
    
    Vector van = norm.multiply( vel.mag() * vel.dot(norm) / (2.0 * norm.mag()));
    
    return van.multiply(-.5 *pc);
  }

  public void applyDrag()
  {
    for(int i = 0 ; i < cloth.length-1; i++) // left right
      for(int j = 0 ; j < cloth[i].length-1; j++) // up down
      {
       // upper triangle
        Vector aero = dragForTriangle(cloth[i][j], cloth[i+1][j], cloth[i+1][j+1]);
        cloth[i][j].acc.add(aero);
        cloth[i+1][j].acc.add(aero);
        cloth[i+1][j+1].acc.add(aero);
       // lower triangle
        aero = dragForTriangle(cloth[i][j], cloth[i][j+1], cloth[i+1][j+1]);
        cloth[i][j].acc.add(aero);
        cloth[i][j+1].acc.add(aero);
        cloth[i+1][j+1].acc.add(aero);
      }  
  }

  public ArrayList<Particle> getParticles()
  {
     ArrayList<Particle> tmp = new ArrayList<Particle>();
     for(int i = 0 ; i < cloth.length; i++) // left right
       for(int j = 0 ; j < cloth[i].length; j++) // up down
         tmp.add(cloth[i][j]);
     return tmp;        
  }

  public void draw()
  {
    noStroke();
    for(int i = 0 ; i < cloth.length-1; i++) // left right
      for(int j = 0 ; j < cloth[i].length-1; j++) // up down
      {
       beginShape();
        texture(cTexture);
        vertex(cloth[i][j].pos,       0, 0  );
        vertex(cloth[i+1][j].pos,   255, 0  );
        vertex(cloth[i+1][j+1].pos, 255, 255);
       endShape();
       
       beginShape();
        texture(cTexture);
        vertex(cloth[i][j].pos,       0,   0);
        vertex(cloth[i][j+1].pos,     0, 255);
        vertex(cloth[i+1][j+1].pos, 255, 255);
       endShape();
      }     
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

public class Jello
{
   public Particle[][][] structure;
   
   float spacing = 10;
   float strength = 1;
   float damping = 0.5;
   float deform  = 0.3;
   Spring closeSpring = new Spring(null,null);
   Spring farSpring   = new Spring(null,null);
   Spring diagSpring  = new Spring(null,null);
   
   public Jello(int w, int h, int d, int spacing)
   {
     this.spacing = spacing;
     this.structure = new Particle[w][h][d];

     closeSpring.restLength = spacing;
     closeSpring.k          = strength;
     closeSpring.damping    = damping;
     closeSpring.deform     = deform;
     
     diagSpring.restLength  = sqrt(2.0) * spacing; // use sqrt 2f
     diagSpring.k           = strength*1.4;
     diagSpring.damping     = damping;
     diagSpring.deform      = deform;
     
     farSpring.restLength   = sqrt(3.0) * spacing;
     farSpring.k            = strength *1.7;
     farSpring.damping      = damping;
     farSpring.deform       = deform;
     
     
     
     
     for(int i = 0 ; i < structure.length; i++) // left right
       for(int j = 0 ; j < structure[i].length; j++) // up down
         for(int k = 0 ; k < structure[i][j].length; k++) //in out
         {
           structure[i][j][k] = new Particle()
           {};
           structure[i][j][k].pos = new Vector(i*spacing,j*spacing,300+(k*spacing));
           structure[i][j][k].vel = new Vector(0,0,0);
           structure[i][j][k].acc = new Vector(0,0,-1);
           structure[i][j][k].bounce   = .01;
           structure[i][j][k].friction = .99;
           structure[i][j][k].radius   = 0;      
         }
       
     for(int i = 0 ; i < structure.length; i++) // left right
       for(int j = 0 ; j < structure[i].length; j++) // up down
         for(int k = 0 ; k < structure[i][j].length; k++) //in out
          {
           // one step away straight
            if(valid(i+1 , j, k))     newSpring(structure[i][j][k], structure[i+1][j][k],  closeSpring);
            if(valid(i , j+1, k))     newSpring(structure[i][j][k], structure[i][j+1][k],  closeSpring);
            if(valid(i , j, k+1))     newSpring(structure[i][j][k], structure[i][j][k+1],  closeSpring);
           // diags
            if(valid(i+1 , j+1, k))   newSpring(structure[i][j][k], structure[i+1][j+1][k],  diagSpring);
            if(valid(i , j+1, k+1))   newSpring(structure[i][j][k], structure[i][j+1][k+1],  diagSpring);
            if(valid(i+1 , j, k+1))   newSpring(structure[i][j][k], structure[i+1][j][k+1],  diagSpring);
           // diags backward
            if(valid(i-1 , j+1, k))   newSpring(structure[i][j][k], structure[i-1][j+1][k],  diagSpring);
            if(valid(i , j-1, k+1))   newSpring(structure[i][j][k], structure[i][j-1][k+1],  diagSpring);
            if(valid(i+1 , j, k-1))   newSpring(structure[i][j][k], structure[i+1][j][k-1],  diagSpring);
           // center cross
            if(valid(i+1 , j+1, k+1)) newSpring(structure[i][j][k], structure[i+1][j+1][k+1],  farSpring);
            if(valid(i+1 , j+1, k-1)) newSpring(structure[i][j][k], structure[i+1][j+1][k-1],  farSpring);
            if(valid(i-1 , j+1, k+1)) newSpring(structure[i][j][k], structure[i-1][j+1][k+1],  farSpring);
            if(valid(i-1 , j+1, k-1)) newSpring(structure[i][j][k], structure[i-1][j+1][k-1],  farSpring);
          }
   }
   
   public boolean valid(int i , int j, int k)
   {
     return (0<=i && i<structure.length) && (0<=j && j<structure[i].length) && (0<=k && k<structure[i][j].length);
   }

  public ArrayList<Particle> getParticles()
  {
     ArrayList<Particle> tmp = new ArrayList<Particle>();
     for(int i = 0 ; i < structure.length; i++) // left right
       for(int j = 0 ; j < structure[i].length; j++) // up down
         for(int k = 0 ; k < structure[i][j].length; k++) //in out
           tmp.add(structure[i][j][k]);
     return tmp;        
  }

  public void draw()
  {
    noStroke();
    for(int i = 0 ; i < structure.length-1; i++) // left right
      for(int j = 0 ; j < structure[i].length-1; j++) // up down
      {
        int lim = structure[i][j].length-1;
        square(structure[i][j][0],structure[i+1][j][0],structure[i+1][j+1][0],structure[i][j+1][0]);
        square(structure[i][j][lim],structure[i+1][j][lim],structure[i+1][j+1][lim],structure[i][j+1][lim]);
      } 
    for(int i = 0 ; i < structure.length-1; i++) // left right
      for(int k = 0 ; k < structure[i][0].length-1; k++) // up down
      {
        int lim = structure[i].length-1;
        square(structure[i][0][k],structure[i+1][0][k],structure[i+1][0][k+1],structure[i][0][k+1]);
        square(structure[i][lim][k],structure[i+1][lim][k],structure[i+1][lim][k+1],structure[i][lim][k+1]);
      }
    for(int j = 0 ; j < structure[0].length-1; j++) // left right
      for(int k = 0 ; k < structure[0][j].length-1; k++) // up down
      {
       int lim = structure.length-1;
        square(structure[0][j][k],structure[0][j+1][k],structure[0][j+1][k+1],structure[0][j][k+1]);
        square(structure[lim][j][k],structure[lim][j+1][k],structure[lim][j+1][k+1],structure[lim][j][k+1]);
      } 
  }
  
  private void square(Particle p1, Particle p2, Particle p3, Particle p4)
  {
     beginShape();
        texture(jTexture);
        vertex(p1.pos,       0, 0  );
        vertex(p2.pos,   512, 0  );
        vertex(p3.pos, 512, 512);
       endShape();
       
       beginShape();
        texture(jTexture);
        vertex(p1.pos,       0,   0);
        vertex(p4.pos,     0, 512);
        vertex(p3.pos, 512, 512);
       endShape();
  }
}






