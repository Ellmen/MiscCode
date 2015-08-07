PrintWriter output;
//color black = color(0, 0, 0);
float Spos [] = new float [3];
float xpos;
float ypos;
float x;
float y;
int iteration;
int max_iteration = 150;
int i;
float num,num1,num2;
int counter = 0;
float xtemp;
int side = 0;
int up = 0;

void setup() {
  size(800, 800);
  //noLoop();
}
void draw() {
 num = slider(100,0,"red");
 num1 = slider(250,1,"green");
 num2 = slider(400,2,"blue");
 textSize(32);
 //text("Drag sliders to view image",80,100);
 if(mousePressed){
 
  loadPixels();
  counter++;
  if(counter > 15)
    counter = 0;
  if(counter == 0){
 

  for (int w = 0; w < (width); w++) {
    for (int h = 0; h<height;h++) {
      i = width*h+w;
      xpos = ((float)w/ (float)width)*3.0-2.25;
      ypos = ((float)h/ (float)height)*3.0-1.5;
      x = 0.0;
      y = 0.0;
      iteration = 0;
      boolean white = false;
      while (iteration < max_iteration) {
        iteration++;
        xtemp = x*x - y*y + xpos;
        y = 2*x*y + ypos;
        x = xtemp;
        if(!white){
          //pixels[i] = color(iteration*(random(10)),iteration*(random(20)),iteration*(random(2)));
          pixels[i] = color(iteration*num/20,iteration*num1/20,iteration*num2/20);  
      }
        if (y*y+x*x>=20) {
          white = true;
          break;
        }
        if(iteration>100){
          pixels[i] = color(0,0,0);
          white = true;
          break;
        }
      }
      
    }
  }
  }
  updatePixels();
 
  //num = slider (100,0,"color");
  //print("done");
  //saveFrame("mandy.png");
 }
}

float slider(int SP2,int d, String Name){
  textSize(12);
  rectMode(CENTER);
   fill(200);
    rect(SP2, height*0.85,110,90);
       if (mousePressed && mouseX >SP2 - 45 && mouseX <SP2+45 && mouseY > height*0.85-15 && mouseY <  height*0.85+15){
           fill(200); 
           rect(SP2, height*0.85,110,90);
         Spos[d] = (mouseX-(SP2)+45);
       }
       fill(200);
        rect(SP2, height*0.85,90,10);
        fill(100);
       rect(SP2+Spos[d]-45, height*0.85,5,15);//SLIDERS
       text(Name,SP2-30,height*0.85-15);
         return Spos[d];
}