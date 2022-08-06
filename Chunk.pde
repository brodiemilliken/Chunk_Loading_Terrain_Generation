class Chunk{
  
  /*
   * Adjustables
   */   
  float noiseMult = 0.0005; //Noise level of terrain  
  float amp = 1500; //Height amplitude of terrain
  int w = 1000; //Chunk width in pixels
  int scale = 100; //Sub chunks size in pixels
  /*
   * 
   */  
   
  float centerX;
  float centerY;

  boolean show;
  boolean loaded;
  
  float[][] heights;
  
  public Chunk(){
    heights = new float[w/scale + 1][w/scale + 1];
  }
  
  void setPositions(float x, float y){
    centerX = x;
    centerY = y;
  }
  
  void load(){
    loaded = true;  
    setHeights();
    show = true;
  }
  
  void setHeights(){
    for (int r = 0; r < heights.length; r++){
      for (int c = 0; c < heights.length; c++){
        float row = centerY - (r - heights.length / 2.0) * scale;
        float column = centerX - (c - heights.length / 2.0) * scale;
        heights[c][r] = (float)noise.eval(column * noiseMult, row * noiseMult);
      }
    }    
  }
  
  void show(){
    noStroke();
    for (int r = 0; r < heights.length - 1; r++){
      beginShape(TRIANGLE_STRIP);
      for (int c = 0; c < heights.length; c++){
        fill(colorPicker(heights[c][r] * amp));
        vertex(centerX - (c - heights.length / 2.0) * scale, centerY - (r - heights.length / 2.0) * scale, heights[c][r] * amp);
        vertex(centerX - (c - heights.length / 2.0) * scale, centerY - ((r + 1) - heights.length / 2.0) * scale, heights[c][r+1] * amp);
      }
      endShape();
    }
    this.show = false;
  }
  
  color colorPicker(float z) {
    int oceanBottom = -100;
    int sand_grass = 300;
    int grass_stone = 300;
    int stone_snow = 300;
    color c = color(#FFFFFF);
    
    //Water
    if (z < oceanBottom) c = color(#003C5F);
    else if (z < 3*oceanBottom/4) c = color(#115779);
    else if (z < 2*oceanBottom/4) c = color(#227292);
    else if (z < 1*oceanBottom/4) c = color(#338DAB);
    else if (z < 0) c = color(#44A7C4);
    
    //Sand - Grass
    else if (z < sand_grass/5) c = color(#EFDD6F);
    else if (z < 2*sand_grass/5) c = color(#C1C960);
    else if (z < 3*sand_grass/5) c = color(#92B550);
    else if (z < 4*sand_grass/5) c = color(#63A141);
    else if (z < sand_grass) c = color(#348C31);
    
    //Grass - snow
    else if (z < sand_grass + grass_stone/5) c = color(#3F8C3D);
    else if (z < sand_grass + 2*grass_stone/5) c = color(#498C48);
    else if (z < sand_grass + 3*grass_stone/5) c = color(#5E8C5F);
    else if (z < sand_grass + 4*grass_stone/5) c = color(#738C76);
    else if (z < sand_grass + grass_stone) c = color(#888C8D);
    
    //Stone - snow
    else if (z < sand_grass + grass_stone + stone_snow/4) c = color(#979A9B);
    else if (z < sand_grass + grass_stone + 2*stone_snow/4) c = color(#A6A8A9);
    else if (z < sand_grass + grass_stone + 3*stone_snow/4) c = color(#C4C3C4);
    else if (z < sand_grass + grass_stone + stone_snow) c = color(#E2DFDF);
    else if (z > sand_grass + grass_stone + stone_snow) c = color(#FFFAFA);
    
    return c;
  }
  
  
}
