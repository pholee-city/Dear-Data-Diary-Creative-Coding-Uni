PImage title;

Cloud[] clouds; //Initialise array of clouds

void setup() {
  size(1024, 700);
  
  // Load the images
  title = loadImage("Title.png");
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

void draw() {
  drawSky();
  
  interactiveButton();
  
  for (Cloud cloud : clouds) {
    cloud.display();
    cloud.move();
  }
  
  image(title, 430, 50, 750, 500);
 
  drawEye();
}
