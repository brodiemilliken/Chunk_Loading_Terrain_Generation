class Chunk{
  
  /*
   * Adjustables
   */   
  float noiseMult = 0.0003; //Noise level of terrain  
  float amp = 2000; //Height amplitude of terrain
  int w = 500; //Chunk width in pixels
  int scale = 25; //Sub chunks size in pixels
  /*
   * 
   */  
      
  float centerX;
  float centerY;

  boolean show;
  boolean loaded;
  
  float oceanBottom = -amp/2;
  float sand_grass = 100;
  float grass_stone = amp/4;
  float stone_snow = amp/4;
  
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
        heights[c][r] = (float)(noise.eval(column * noiseMult, row * noiseMult) * amp/2 + pow(noise(row * noiseMult, column * noiseMult),2) * amp - amp/4);
      }
    }    
  }
  
  void show(){
    noStroke();
    push();
    translate(centerX - (heights.length / 2.0) * scale, centerY - (heights.length / 2.0) * scale);
    
    for (int r = 0; r < heights.length - 1; r++){
      beginShape(TRIANGLE_STRIP);
      for (int c = 0; c < heights.length; c++){

        fill(colorPicker(heights[c][r]));       
        vertex(-c * scale, -r * scale, max(heights[c][r],0));
        
        fill(colorPicker(heights[c][r+1]));       
        vertex(-c * scale, -(r + 1) * scale, max(heights[c][r+1],0) );
      }
      endShape();
    }
    this.show = false;
    pop();
  }
  
  color colorPicker(float z) {

    color c = color(#FFFFFF);
    
    //Water
    if (z < oceanBottom) c = color(#003C5F);
    else if (z < 4*oceanBottom/5) c = color(#115779);
    else if (z < 3*oceanBottom/5) c = color(#227292);
    else if (z < 2*oceanBottom/5) c = color(#338DAB);
    else if (z < oceanBottom/5) c = color(#44A7C4);
    
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
