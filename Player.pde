class Player{
  /*
   * Adjustables
   */ 
  float fov = PI/3; //Field of view
  float acc = 10; //Rate of acceleration
  float turnRate = PI/100; //Rate of turn
  int chunkRenderDistance = 50; //View Distance
  /*
   * 
   */ 
  
  
  PVector pos, vel;
  boolean left, right, up, down, turnRight, turnLeft, goUp, goDown;
  float viewAngle = 0;
  
  public Player(float x, float y){
    pos = new PVector(x,y,200);
    vel = new PVector(-1,0);
  }
  
  void show(){
    push();
    translate(pos.x,pos.y,pos.z);
    noStroke();
    fill(200);
    sphere(10);
    pop();
  }
  
  void move(){
    viewAngle %= TWO_PI;
    if (left) vel.add(cos(player.viewAngle - PI/2) * -acc, sin(player.viewAngle - PI/2) * -acc);
    if (right) vel.add(cos(player.viewAngle + PI/2) * -acc, sin(player.viewAngle + PI/2) * -acc);
    if (up) vel.add(cos(player.viewAngle) * -acc, sin(player.viewAngle) * -acc);
    if (down) vel.add(cos(player.viewAngle) * acc, sin(player.viewAngle) * acc);
    if (goUp) vel.add(0,0,acc);
    if (goDown) vel.add(0,0,-acc);
    if (turnRight) {
      viewAngle += turnRate;
      vel.rotate(turnRate);
    }
    if (turnLeft) {
      viewAngle -= turnRate;
      vel.rotate(-turnRate);
    }
      
    vel.mult(0.99);
    pos.add(vel);
  }
}
