class Dither {
  PGraphics pg;
  PImage src;
  PImage p; 
  
  // Bayer matrix
  int[][] matrix = {   
    {
      1, 9, 3, 11
    }
    , 
    {
      13, 5, 15, 7
    }
    , 
    {
      4, 12, 2, 10
    }
    , 
    {
      16, 8, 14, 6
    }
  };
  float mratio = 1.0 / 17;
  float mfactor = 255.0 / 5;
  
  Dither() {
    pg = createGraphics(196, 14);
    
    //src = loadImage("medusa.jpg");
    //res = createImage(src.width, src.height, RGB);
  }
  
  Dither(String s) {
    p = loadImage(s);
    pg = createGraphics(p.width, p.height);
    
    //src = loadImage("medusa.jpg");
    //res = createImage(src.width, src.height, RGB);
  }
  
  void feed(PImage p) {
    src = p;
  }
  
  void setCanvas(int x, int y) {
    pg = createGraphics(x, y);
  }
  
  
  
  PGraphics floyd_steinberg() {
    pg.noSmooth();
    pg.beginDraw();
    //pg.background(0);
    //pg.noStroke();
    
    int s = 1;
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        color oldpixel = src.get(x, y);
        color newpixel = findClosestColor(oldpixel);
        float quant_error = brightness(oldpixel) - brightness(newpixel);
        pg.set(x, y, newpixel);
  
        pg.set(x+s, y, color(brightness(src.get(x+s, y)) + 7.0/16 * quant_error) );
        pg.set(x-s, y+s, color(brightness(src.get(x-s, y+s)) + 3.0/16 * quant_error) );
        pg.set(x, y+s, color(brightness(src.get(x, y+s)) + 5.0/16 * quant_error) );
        pg.set(x+s, y+s, color(brightness(src.get(x+s, y+s)) + 1.0/16 * quant_error));
  
        
        pg.stroke(newpixel);      
        pg.point(x,y);
        
      }
    }
    pg.endDraw();
    
    return pg;
  }
  
  PGraphics bayer() {
    int s = 1;
    pg.noSmooth();
    pg.beginDraw();

    // Scan image
    for (int x = 0; x < src.width; x+=s) {
      for (int y = 0; y < src.height; y+=s) {
        // Calculate pixel
        color oldpixel = src.get(x, y);
        color value = color( brightness(oldpixel) + (mratio*matrix[x%4][y%4] * mfactor));
        color newpixel = findClosestColor(value);
        
        pg.set(x, y, newpixel);
  
  
        // Draw
        pg.stroke(newpixel);   
        pg.point(x, y);
      }
    }
    pg.endDraw();
    return pg;
  }
  
  color findClosestColor(color c) {
    color r;
    if (brightness(c) < 128) {
      r = color(0);
    } else {
      r = color(255);
    }
    return r;
  }

}
