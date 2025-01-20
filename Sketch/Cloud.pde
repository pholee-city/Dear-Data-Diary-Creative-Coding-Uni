PImage cloud1, cloud2;

class Cloud {
  PImage cloud; //Imports asset
  float x, y, speed; //Intial x, y and speed given to cloud

  //Constructor called to create new cloud
  Cloud(PImage img) {
    this.cloud = img;
    
    //Initialises state of cloud with random values
    x = random(1275, 3000);
    y = random(50, 200);
    
    //Checks if image name is cloud1 or cloud2 and adjusts speed accordingly
    if (cloud == cloud1) {
      speed = 0.75*(solarDuration/86400);
    } else {
      speed = 0.5*(solarDuration/86400);
    }
  }

  void display() {
    image(cloud, x, y, 250, 250);
  }
  
   void move() {
    x -= speed; //Move the cloud horizontally
    if (x < -300) {
      x = width + 300; //Reset to the right side if it goes offscreen
    }
  }
}
