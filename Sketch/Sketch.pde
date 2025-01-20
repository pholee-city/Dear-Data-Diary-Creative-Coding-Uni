PFont font;
PImage line;
boolean isAnimating = false;
String string = "Click me to play an animation!";

Cloud[] clouds; //Initialise array of clouds

void setup() {
  size(1024, 700);
  
  // Text font
  font = createFont("Margarine-Regular.ttf", 20);
  textFont(font);
  
  // Load the images
  line = loadImage("Line.png");
  cloud1 = loadImage("Cloud1.png");
  cloud2 = loadImage("Cloud2.png");
  eye1 = loadImage("Eye1.png");
  eye2 = loadImage("Eye2.png");
  sun = loadImage("Sun.png");
  moon = loadImage("Moon.png");
  sprite = loadImage("Sprite.png");
  speechBubble = loadImage("Speech bubble.png");
  train1 = loadImage("Train1.png");
  train2 = loadImage("Train2.png");

  // Initialize the clouds
  int numClouds = int(random(1, 7)); //Randomises number of clouds each time the program is run between 1 and 7
  clouds = new Cloud[numClouds]; //Creates array of clouds
  
  //Loops through array appending cloud1 and cloud2 at random
  for (int i=0; i<numClouds; i++) {
    float num = random(0, 1);
    if (num < 0.5) {
      clouds[i] = new Cloud(cloud1);
    } else {
      clouds[i] = new Cloud(cloud2);
    }
  }
}

//If different items on screen clicked, make things happen
void mousePressed() {
  //Sprite plays animation
  if (mouseX > 50 && mouseX < spriteWidth && mouseY > 500 && mouseY < height-35) {
    isAnimating = !isAnimating;
    string = "Click me to return to the launch page.";
  }
  //Menu1 shows schedule
  //Menu2 shows schedule
  //Menu3 shows schedule
  //Speed up animation
  //Slow down animation
  //Pause animation
}

//Create menu background
void drawGradientRect(float x, float y, float w, float h, color c1, color c2) {
  noFill();
  for (int i = 0; i < w; i++) {
    // Interpolate between c1 and c2
    float lerpFactor = map(i, 0, w, 0, 1);
    color interColor = lerpColor(c1, c2, lerpFactor);
    stroke(interColor);
    line(x + i, y, x + i, y + h);
  }
}

void draw() {
  background(207,226,243);
  
  for (Cloud cloud : clouds) {
    cloud.display();
    cloud.move();
  }
  
  //Title
  textSize(65);
  text("A week in my life", 50, 115);
  fill(0, 0, 0);
  image(line, 40, 140, 495, 10);
  
  //Menu item 1.1
  textSize(20);
  text("Sunset/ Sunrise times", 60, 200);
  fill(0, 0, 0);
  //If menu item is hovered over, make interactable
  boolean menu11IsHovered = mouseX > 50 && mouseX < 300 && mouseY > 170 && mouseY < 215;
  if (menu11IsHovered) {
    drawGradientRect(50, 170, 260, 45, color(255, 255, 255, 200), color(255, 255, 255, 0));
    text("Sunset/ Sunrise times", 60, 200);
    fill(0, 0, 0);
  }
  
  //Menu item 1.2
  textSize(20);   
  text("Sleep Schedule", 60, 245);
  fill(0, 0, 0);  
  //If menu item is hovered over, make interactable
  boolean menu12IsHovered = mouseX > 50 && mouseX < 300 && mouseY > 215 && mouseY < 260;
  if (menu12IsHovered) {
    drawGradientRect(50, 215, 260, 45, color(255, 255, 255, 200), color(255, 255, 255, 0));
    text("Sleep Schedule", 60, 245);
    fill(0, 0, 0);
  }
  
  //Menu item 1.3
  textSize(20);
  text("Travel", 60, 290);
  fill(0, 0, 0);  
  //If menu item is hovered over, make interactable
  boolean menu13IsHovered = mouseX > 50 && mouseX < 300 && mouseY > 260 && mouseY < 305;
  if (menu13IsHovered) {
    drawGradientRect(50, 260, 260, 45, color(255, 255, 255, 200), color(255, 255, 255, 0));    
    text("Travel", 60, 290);
    fill(0, 0, 0);
  }
  
  interactiveButton();
  drawEye();
  
  //Play animation when sprite clicked
  if (isAnimating) {
    
    drawSky();
    
    for (Cloud cloud : clouds) {
      cloud.display();
      cloud.move();
    }
    
    //Title
    textSize(65);
    text("Options", 50, 115);
    fill(0, 0, 0);
    image(line, 42, 140, 250, 10);
  
    interactiveButton();
    drawEye();
    
  }
}
