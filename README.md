[![](https://img.shields.io/badge/using-Processing-brightgreen.svg?style=flat-square&color=000000)](http://processing.org/)

# dither
## What is dither?
>Dither is an intentionally applied form of noise used to randomize quantization error, preventing large-scale patterns such as color banding in images. Dither is routinely used in processing of both digital audio and video data, and is often one of the last stages of mastering audio to a CD.

>A common use of dither is converting a greyscale image to black and white, such that the density of black dots in the new image approximates the average grey level in the original. 

Source: [Dither. From Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Dither)

## Dithering Class for Processing
This free and simple to use class helps you to integrate a dithering filter into your project in no time.
Copy either the contents of DitherClass.pde into a new tab or simply the whole DitherClass.pde file into your Processing project.

Currently there are four modes available:
* **Floyd–Steinberg** dithering is an image dithering algorithm first published in 1976 by Robert W. Floyd and Louis Steinberg. It is commonly used by image manipulation software, for example when an image is converted into GIF format that is restricted to a maximum of 256 colors. 
* Ordered (Bayer) dithering
* **Atkinson dithering** was developed by Apple programmer Bill Atkinson, and resembles Jarvis dithering and Sierra dithering, but it's faster. Another difference is that it doesn't diffuse the entire quantization error, but only three quarters. It tends to preserve detail well, but very light and dark areas may appear blown out.
* **Random dithering** was the first attempt (at least as early as 1951) to remedy the drawbacks of thresholding. Each pixel value is compared against a random threshold, resulting in a staticky image. Although this method doesn't generate patterned artifacts, the noise tends to swamp the detail of the image. It is analogous to the practice of mezzotinting.[16]

**Simple Example**
```
Dither d;
Dither d2;
PImage p;

void setup() {
  size(800, 800);
  surface.setLocation(0,0);
  colorMode(HSB, 360, 100, 100);
  p = loadImage("medusa.jpg");
  d = new Dither();
  d2 = new Dither("sample.jpg");
  d.setCanvas(400, 400);
  d.feed(p);
  
  // example of how to set the modes differently via d2 object
  d2.setMode("RANDOM");
  d2.setMode(3);
  
}

void draw() {
  background(255);
  
  image(d.floyd_steinberg(), 0, 0);
  image(d.bayer(), 0, 400);
  image(d.atkinson(), 400, 0);
  image(d.rand(), 400, 400);
  
  // get random outputs
  d2.setMode((int)random(4));
  // ask the dither object just for the calculated dither image instead of going to a mode directly
  image(d2.dither(), 200, 200);
}
```

## Class and method calls
| Class           | Parameters   | Description                                                                                  |
|-----------------|--------------|----------------------------------------------------------------------------------------------|
| Dither          | empty        | Creates a new dither object with some standard dimensions. I used this for my flipdots :)    |
| Dither          | String s     | Loads an image from your data folder and takes the dimensions to create the PGraphics buffer |
| Dither          | int w, int h | Creates the dither objects with dimensions w and h                                           |

| Method           | Return    | Parameters   | Description                                                                                                         |
|------------------|-----------|--------------|---------------------------------------------------------------------------------------------------------------------|
| setCanvas        | void      | int w, int h | Creates a new PGraphics buffer with dimensions w and h. The dithering will be applied to the contents of the Buffer |
| setMode          | void      | int m        | Sets the internal mode. Allowed input: 0, 1, 2, 3 => floyd, bayer, atkinson, random                                 |
| setMode          | void      | String s     | Set the mode. Input: "FLOYD", "BAYER", "ATKINSON", "RANDOM"                                                         |
| feed             | void      | PImage       | Set the internal source of the class (such as an PImage that you load or the current frame of a Movie object)       |
| dither           | PGraphics | empty        | Returns the current internal source with the setMode parameters                                                     |
| dither           | PGraphics | int m        | Returns the current internal source. Input: 0,1,2,3                                                                 |
| floyd_steinberg  | PGraphics | empty        | Returns the current internal source with Floyd-Steinberg dithering                                                  |
| bayer            | PGraphics | empty        | Returns the current internal source with Ordered (Bayer) dithering                                                  |
| atkinson         | PGraphics | empty        | Returns the current internal source with Atkinson dithering                                                         |
| random           | PGraphics | empty        | Returns the current internal source with random dithering                                                           |
| findClosestColor | color     | color c      | Threshold function that computates the closest color. Currently hardcoded to do brightness calculations only.       |

## Version + Changes
All image sources will be cast into RGB color space. This will still work with Processing sketches, that are explicitly working with HSB colorMode!