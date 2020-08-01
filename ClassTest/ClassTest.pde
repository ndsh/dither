Dither d;
PImage p;

void setup() {
  size(1322, 864);
  surface.setLocation(0,0);
  
  p = loadImage("sample.jpg");
  d = new Dither();
  d.setCanvas(1322, 864);
  d.feed(p);
}

void draw() {
  
  image(d.floyd_steinberg(), 0, 0);
}
