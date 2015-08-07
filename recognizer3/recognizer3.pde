import static java.nio.file.StandardCopyOption.*;
import java.nio.file.*;
import javax.swing.*;
import java.awt.*;
import java.awt.image.WritableRaster;
import java.awt.image.BufferedImage;
import java.io.*;
import javax.imageio.*;

int wid = 1;
int hig = 1;
int wid2 = 1;
int hig2 = 1;
int sx = 10;
int sy = 10;
int h = 360;
int b = 100;
int s = 100;
ArrayList<Box> objects = new ArrayList<Box>();
Boolean [][] matrix = new Boolean [1][1];
PImage img;
BufferedImage bimg;
color orange = color(255, 106, 0);
color red = color(255, 0, 42);
color blue = color(31, 123, 255);
color yellow = color(255, 255, 0);
color purple = color(255, 0, 255);
color green = color(0, 255, 0);
color color1 = color(200, 255, 0);
color color2 = color(255, 216, 0);
color pix;
color pix2;
Box b1;
int err = 20;
int [] values = new int [9];
float [] times = new float [10];
File dir = new File("./Pictures");
String[] list = dir.list();
File f1; 


void setup() {
  noLoop();
  list = new String[1];
  list[0] = "DSC00464.JPG";
  times[8] = millis();

  for (int q = 0; q < list.length; q++) {
    times[0] = millis();
    colorMode(HSB, h, s, b);
    f1 = new File("./Pictures/"+list[q]);
    try {
      //times[0] = millis();
      bimg = ImageIO.read(f1);
      //img = new PImage(bimg);
    } 
    catch (Exception e) {
    }
    //img = loadImage("./Pictures/"+list[q]);

    times[1] = millis();
    println("time to load image: "+(times[1] - times[0]));
    //img.resize(600, 600);
    //wid = int(img.width/ 10)*10;
    //hig = int(img.height/ 10)*10;
    wid = bimg.getWidth();
    hig = bimg.getHeight();
    objects = new ArrayList<Box>();
    matrix = new Boolean [wid/sx][hig/sx];
    size(wid, hig);
    for (int x = 0; x < wid/sx; x += 1) {
      for (int y = 0; y < hig/sx; y += 1) {
        matrix[x][y] = false;
      }
    }
    times[2] = millis();
    //image(img, 0, 0);
    loadPixels();//Color Collector -----------------------------------------------------------------------
    times[3] = millis();
    println("image drawing time: "+(times[3] - times[2]));
    times[4] = millis();
    for (int y = 1; y < hig - 3; y+= sy) {
      for (int x = 1; x < wid - 3; x+= sx) {
        loc = x + y*wid;
        //pix = pixels[loc];
        pix = bimg.getRGB(x, y);
        for (int z = -1; z < 2; z++) {
          for (int e = -1; e < 2; e++) {
            values[(z+1)*3 + e+1] = (int)hue(bimg.getRGB(x+e, y+z));
            //values[z*3 + e] = (int)hue(pixels[loc+y+z*wid]);
            //matrix[z][e] = (int)max(r1,b1,g1);
          }
        }
        if ((inColor(pix, green, 50, 50, 50) || inColor(pix, yellow, 20, 70, 70) || inColor(pix, red, 30, 60, 60) || isWhite(pix))) {//*****
          matrix[x/sx][y/sx] = true;
          //println("hello");
        }
      }
    }
    times[5] = millis();
    println("Wanted Pixel Collection: "+(times[5] - times[4]));
    //Object builder ------------------------------------------------------------------------------------
    times[6] = millis();
    for (int y = 0; y < hig -5; y+= sy) {
      for (int x = 0; x < wid - 5; x+= sx) {
        pix = bimg.getRGB(x, y);
        b1 = new Box(x/sx, y/sy, 1, 1, pix);
        if (matrix[x/sx][y/sy]) {
          b1 = buildShape(matrix, b1, 1);
          if (b1.dimx + b1.dimy > 4 && b1.posx > 5 && b1.posy > 5 && (b1.posx+b1.dimx)*sx < bimg.getWidth() - 10 && (b1.posy+b1.dimy)*sy < bimg.getHeight() - 10){
            objects.add(b1);
          }
          for (int z = b1.posx*sx; z < (b1.posx+b1.dimx)*sx; z++) {
            for (int w = b1.posy*sy; w < (b1.posy+b1.dimy)*sy; w++) {
              matrix[z/sx][w/sx] = false;
            }
          }
        }
      }
    }
    times[7] = millis();
    println("object building time: "+(times[7] - times[6]));
    drawImage(bimg);
    //textSize(32);
    for (int x = 0; x < objects.size (); x++) {
      objects.get(x).make();
      //println((avgBrightness(bimg, objects.get(x))+avgHue(bimg, objects.get(x)))+" "+objects.get(x).posx*sx+" "+objects.get(x).posy*sy);
    }

    //println(objects.get(1).posy);
    if (objects.size() > 0) {
      println(list[q]);
      //f1.renameTo(new File ("./Objects/"+list[q]));
    }
  }
  times[9] = millis();
  println("Total time taken: "+(times[9] - times[8]));

  dir = new File("./Objects");
  list = dir.list();

  //size(1000,600);
}

int loc = 0;
int counter = 0;
//Reset image selector, noLoop and all file search and save file
void draw() {
  //  println(mouseX+" "+mouseY);
  //  println(objects.get(1).posx*sx+" "+objects.get(1).posy*sy);
  //  println(avgHue(bimg,objects.get(1)));

//      background(255);
//      textSize(16);
//      textAlign(CENTER);
//      text("Press enter to confirm Target",850,100);
//      text("Press BACKSPACE to unidentify Target",850,300);
//      text("Press h to identify as 3D",850,500);
//      if(counter < list.length){
//        
//      img = loadImage("./Objects/"+list[counter]);//Setup & Loading ------------------------------------------------------------------
//      img.resize(700,700);
//      
//      image(img,0,0);
//      }
//      else{
//        fill(0);
//        rect(0,0,700,600);
//      }
}

void keyPressed() {
  if (counter < list.length) {
    f1 = new File ("./Objects/"+list[counter]);
  }
  if (key == '\n') {
    counter+=1;
    redraw();
  }
  if (key == 'q') {
    if (counter < list.length) {
      f1.renameTo(new File ("./QRs/"+list[counter]));
    }
    counter+=1;
    redraw();
  }
  if (key == '\b') {
    if (counter < list.length) {
      f1.renameTo(new File ("./Pictures/"+list[counter]));
    }
    counter+=1;
    redraw();
  }
  if (key == 'h') {
    if (counter < list.length) {
      f1.renameTo(new File ("./3D/"+list[counter]));
    }
    counter+=1;
    redraw();
  }
}
float avgHue(BufferedImage imgz, Box box) {
  color Tcol;
  float sum = 0;
  int siz = 0;
  ArrayList<Integer> hues = new ArrayList<Integer>();
  for (int x = box.posx*sx; x < (box.posx+box.dimx)*sx; x+= sx) {
    for (int y = box.posy*sy; y < (box.posy+box.dimy)*sy; y+= sy) {
       Tcol = bimg.getRGB(x, y);
       if (inColor(Tcol, box.boxcolor, 50, 10, 10)) {
            hues.add((int)hue(Tcol));
            point(x,y);
       }
      
    }
  }
  
  int [] Chues = listConversion(hues);
  return stdev(Chues);
}

float avgBrightness(BufferedImage imgz, Box box) {
  color Tcol;
  float sum = 0;
  int siz = 0;
  ArrayList<Integer> bris = new ArrayList<Integer>();
  for (int x = box.posx*sx; x < (box.posx+box.dimx)*sx; x++) {
    for (int y = box.posy*sy; y < (box.posy+box.dimy)*sy; y++) {
       Tcol = bimg.getRGB(x, y);
       if (inColor(Tcol, box.boxcolor, 50, 10, 10)) {
            bris.add((int)brightness(Tcol));
            point(x,y);
       }
      
    }
  }
  
  int [] Cbris = listConversion(bris);
  return stdev(Cbris);
}

int[] listConversion(ArrayList<Integer> Olist)
{
  int [] Nlist = new int [Olist.size()];
  for (int x = 0; x < Olist.size (); x++) {
    Nlist[x] = (int)Olist.get(x);
  }
  return Nlist;
}

Boolean [][] submatrix(Boolean[][] matrix, int posx, int posy, int dimx, int dimy) {
  Boolean [][] newmatrix = new Boolean[dimx][dimy];
  for (int x = 0; x < dimx; x++) {
    for (int y = 0; y < dimy; y++) {
      newmatrix[x][y] = matrix[posx + x][posy + y];
    }
  }
  return newmatrix;
}
void drawImage(BufferedImage img1) {
  PImage img2 = createImage(img1.getWidth(), img1.getHeight(), ARGB);
  int loc = 0;
  for (int x = 0; x < img1.getWidth (); x++) {
    for (int y = 0; y < img1.getHeight (); y++) {
      loc = x + y*img1.getWidth();
      img2.pixels[loc] = img1.getRGB(x, y);
    }
  }
  img2.resize(600,600);
  image(img2, 0, 0);
}
float stdev(int [] list) {
  float sum = 0;
  int size = 0;
  for (int x = 0; x < list.length; x++) {
    if (list[x] != -1) {
      sum += list[x];
      size++;
    }
  }
  float mean = sum/size;
  float sum2 = 0;
  for (int x = 0; x < list.length; x++) {
    if (list[x] != -1) {
      sum2 += sq(list[x] - mean);
    }
  }
  //println(sum2);
  //println(mean);
  return sqrt(sum2/size);
}

boolean inColor(color given, color col, float error, float bri, float sat) {
  if (brightness(given) > bri & saturation(given) > sat) {
    if (abs(hue(given) - hue(col)) % (h-error) < error) {
      return true;
    } else {
      return false;
    }
  }
  return false;
}

boolean isWhite(color given) {
  if (saturation(given) < 10 && brightness(given) > 80) {
    return true;
  } else {
    return false;
  }
}

class Box {
  int posx = 0;
  int posy = 0;
  int dimx = 0;
  int dimy = 0;
  color boxcolor;
  Box(int Tposx, int Tposy, int Tdimx, int Tdimy, color Tboxcolor) {
    boxcolor = Tboxcolor;
    posx = Tposx;
    posy = Tposy;
    dimx = Tdimx;
    dimy = Tdimy;
  }

  void make() {
    fill(255, 0, 0, 0);
    stroke(boxcolor);
    for (int x = 0; x < 2; x++) {
      rect(posx*sx-x, posy*sy-x, dimx*sx+2*x, dimy*sy+2*x);
    }
  }
}

Box buildShape(Boolean [][] Matrix, Box B, int count) {
  Boolean up = false;
  Boolean down = false;
  Boolean side = false;
  Boolean Lside = false;
  Boolean colored = false;
  if (B.posx*sx + B.dimx*sx < width - 5) {
    if (BooleanCount(submatrix(Matrix, B.posx, B.posy, B.dimx, B.dimy)) < BooleanCount(submatrix(Matrix, B.posx, B.posy, B.dimx+1, B.dimy))) {
      B.dimx = B.dimx + 1;
      side = true;
    }
  }
  if (B.posy*sy + B.dimy*sy < height - 5 ) {
    if (BooleanCount(submatrix(Matrix, B.posx, B.posy, B.dimx, B.dimy)) < BooleanCount(submatrix(Matrix, B.posx, B.posy, B.dimx, B.dimy+1))) {
      B.dimy = B.dimy + 1;
      up = true;
    }
  }
  if (B.posx*sx > 1) {
    if (BooleanCount(submatrix(Matrix, B.posx, B.posy, B.dimx, B.dimy)) < BooleanCount(submatrix(Matrix, B.posx-1, B.posy, B.dimx+1, B.dimy))) {
      B.posx = B.posx - 1;
      B.dimx = B.dimx + 1;
      Lside = true;
    }
  }
  if (B.posy*sy > 1) {
    if (BooleanCount(submatrix(Matrix, B.posx, B.posy, B.dimx, B.dimy)) < BooleanCount(submatrix(Matrix, B.posx, B.posy-1, B.dimx, B.dimy+1))) {
      B.posy = B.posy - 1;
      B.dimy = B.dimy + 1;
      down = true;
    }
  }
  count = 1;
  if (up || side || down || Lside) {
    return buildShape(Matrix, B, count);
  } else {
    return B;
  }
}

int BooleanCount(Boolean [][] Matrix) {
  int count = 0;
  for (int y = 0; y < Matrix[0].length; y++) {
    for (int x = 0; x < Matrix.length; x++) {
      if (Matrix[x][y]) {
        count++;
      }
    }
  }
  return count;
}

Boolean notColor(color col, color col2, color given, int bri, int sat) {
  if (saturation(given) < sat) {
    return false;
  } else if (hue(given) > col && hue(given) < col2) {
    if (brightness(given) < bri) {
      return false;
    } else {
      return true;
    }
  } else if (brightness(given) < bri) {
    return false;
  } else {
    return true;
  }
}

