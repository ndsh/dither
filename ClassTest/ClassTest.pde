Dither d;
PImage p;

void setup() {
  size(800, 800);
  surface.setLocation(0,0);
  
  p = loadImage("medusa.jpg");
  d = new Dither();
  d.setCanvas(400, 400);
  d.feed(p);
}

void draw() {
  background(255);
  image(d.floyd_steinberg(), 0, 0);
  image(d.bayer(), 0, 400);
  image(d.atkinson(), 400, 0);
  image(d.rand(), 400, 400);
}
