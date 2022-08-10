class Terrain{
  
  Chunk[][] chunks;
  
  public Terrain(int w){
    chunks = new Chunk[w][w];
    
    for (int r = 0; r < chunks.length; r++){
      if (r % (chunks.length / 20.0) == 0) {
        println("Loading: " + round((float)r / chunks.length * 100) + "%");
      }
      for (int c = 0; c < chunks.length; c++){
        chunks[c][r] = new Chunk();
        int z = chunks[c][r].w;
        chunks[c][r].setPositions(((c - (chunks.length / 2.0)) * z + z/2), ((r - (chunks.length / 2.0)) * z) + z/2);
      }
    } 
  }
  
  void loadNewChunks(){
    float min = player.vel.heading() - player.fov/2 + PI;
    float max = min + player.fov; 
    if(min < 0){
      min += TWO_PI;
      max += TWO_PI;
    }
   
    int render = player.chunkRenderDistance / 2;
   
    int x = round((player.pos.x - chunks[0][0].w * 2 * cos(player.vel.heading()))/ chunks[0][0].w + (chunks.length / 2.0));
    int y = round((player.pos.y - chunks[0][0].w * 2 * sin(player.vel.heading())) / chunks[0][0].w + (chunks.length / 2.0));
    for (int i = -render; i < render; i++){
      for (int j = -render; j < render; j++){
        if (sqrt(i*i + j*j) < render) {
          float angle = -atan2(x - (x + i), y - (y + j)) + PI/2;
          if (angle < min) angle += TWO_PI;
          if (min < angle && angle < max) {
            try{
              if (!chunks[x + i][y + j].loaded){
                chunks[x + i][y + j].load(); 
              }
              chunks[x + i][y + j].show();
            } catch(IndexOutOfBoundsException e){}
          }
        }
      }
    }
  }
}
