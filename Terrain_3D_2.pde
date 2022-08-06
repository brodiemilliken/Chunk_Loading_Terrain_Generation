
  /*
   * Controls:
   * W,A,S,D - Move Around
   * Left, Right Arrows - Turn
   * Up, Down Arrows - Move up or down
   * Scroll wheel - Zoom in or out
   *
   * Adjustables availible in the Chunk
   * and Player classes for additional
   * changes
   */  

Terrain terrain;
Player player;
OpenSimplexNoise noise;
float zoom = 300;

void setup(){
  fullScreen(P3D);
  noise = new OpenSimplexNoise();
  terrain = new Terrain(1000); //Map width in chunks
  player = new Player(0,0);
  perspective(PI/2, float(width)/float(height), 
            1, 100000);
}

void draw(){
  background(0);
  println(frameRate);
  
  terrain.loadNewChunks();
  
  camera(player.pos.x + zoom * cos(player.viewAngle), player.pos.y + zoom * sin(player.viewAngle), player.pos.z + zoom / 2 + 50,
    player.pos.x, player.pos.y, player.pos.z + 60,
    cos(player.viewAngle), sin(player.viewAngle), 0);
    
  player.move();
  player.show();
  
}

void keyPressed(){
  if (key == 'a') player.left = true;
  if (key == 'd') player.right = true;
  if (key == 'w') player.up = true;
  if (key == 's') player.down = true;
  if (keyCode == RIGHT) player.turnRight = true;
  if (keyCode == LEFT) player.turnLeft = true;
  if (keyCode == UP) player.goUp = true;
  if (keyCode == DOWN) player.goDown = true;
}

void keyReleased(){
  if (key == 'a') player.left = false;
  if (key == 'd') player.right = false;
  if (key == 'w') player.up = false;
  if (key == 's') player.down = false;
  if (keyCode == RIGHT) player.turnRight = false;
  if (keyCode == LEFT) player.turnLeft = false;
  if (keyCode == UP) player.goUp = false;
  if (keyCode == DOWN) player.goDown = false;
}

void mouseWheel(MouseEvent event){
  zoom += event.getCount() * 10;
}
