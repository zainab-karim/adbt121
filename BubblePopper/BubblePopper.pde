import processing.sound.*;              //import the library that does the sound
SoundFile pop, backgroundM, wrong, end; //imported the sounds used    

float x, y, radius;                     //declaring the variables
int sizeR;     
int score = 0;
boolean gameRunning = false;
boolean gameOver = false;
boolean clicked = true;
boolean musicStarted = false;
PFont Font1;
PImage img;
countDown sw;

void setup()
{
  background(#69AAB9);                     //setting background colour

  size(600, 470);  
  pop = new SoundFile(this, "pop.wav");
  backgroundM = new SoundFile(this, "backgroundM.mp3");
  end = new SoundFile(this, "end.mp3");
  wrong = new SoundFile(this, "wrong.mp3");

  img = loadImage("menuPic.png");         //setting background picture

  Font1 = createFont("DINAlternate-Bold", 30); //setting a font

  radius = random (10, 200);              //sets a random radius
  x= random(width - 2*radius)+radius;
  y= random(height - 2*radius)+radius;
  sizeR = int (random(20, 50));           //sets a random size of ellipse

  sw = new countDown();
}

void game()
{
  background(#69AAB9);
  if (clicked == true); 
  {
    fill(255);
    ellipse (x, y, sizeR, sizeR);         //a random ellipse will be displayed
  }
  int rem= 30-sw.sec();
  fill(0);
  textSize(18);
  text(rem, 50, 75);
  text("Seconds:", 50, 50);               //remaining seconds will be dispayed
  text ("Score:", 500, 50);               //the score will be displayed
  text (score, 500, 80);


  if (rem == 0 )                          //if the score = 0...
  {
    gameRunning = false;
    gameOver = true;
    clicked = false;

    backgroundM.stop();
    end.play();                           //a sound will play

    background(#69AAB9);
    noFill();
    strokeWeight(10);
    rect( 0, 0, 600, 470);
    textSize (40);
    fill(0);
    text ("Game Over", 200, 200);       //the game over sign will display
    text ("Score: ", 200, 300);         //the final score will be displayed
    text (score, 330, 300);


    sw.stop();                          //the program will stop
  }
}

void draw()
{
  if (gameRunning == true) {    
    background(#69AAB9);
    game();                            //the game will start
  } else if (gameRunning == false && gameOver == false ) {   
    menu();                            //at the start of the game the menu will be displayed
  }
}

void menu()   
{
  background(#69AAB9);

  if (musicStarted == false)
  {
    backgroundM.amp(0.1);
    backgroundM.play();
    println("backgroundM");
    musicStarted = true;
  }

  image (img, 0, 0);
  fill(255, 60);
  rect (40, 80, 500, 300);
  strokeWeight(1.5);
  textSize(25);
  textFont(Font1);
  fill(0);
  text("MENU", 60, 150);              //a menu is created
  textSize(20);
  text("Press the mouse to press as many\n circles as you can in under 30 seconds", 60, 200);
  text("Press the enter key to start...", 60, 300);
} 

void keyPressed() {
  if (key == ENTER) {                //if enter is pressed...
    gameRunning = true;          
    sw.start();                      //the game will start
  }
}

void mouseClicked() {
  boolean valueY = mouseY < y + sizeR;
  boolean valueX = mouseX < x+ sizeR;
  boolean valueYdown = mouseY > y - sizeR;
  boolean valueXright = mouseX > x- sizeR;
  boolean inCircle = valueY && valueX && valueYdown && valueXright;

  if (clicked == true && gameRunning == true);  //if the mouse presses the ellipse...
  {                      
    if (inCircle) {
      println("hit");
      pop.play();                 //a sound will be played
      println("pop.play");
      score++;                    //score will go up by 1
      fill (0);
      text (score, 500, 80);      //score will be diplayed
      radius = random(10, 100);
      x = random(width - 2*radius)+radius;      //another ellipse will be made
      y = random(height - 2*radius)+radius;
      sizeR = int (random(20, 50));           //sets a random size of ellipse
      ellipse(x, y, sizeR, sizeR);

    } if (clicked == true && gameRunning == true && !inCircle) {
      println("miss");    
      wrong.play();               //a sound will be played
      println("wrong.play");
    }
  }
}  
