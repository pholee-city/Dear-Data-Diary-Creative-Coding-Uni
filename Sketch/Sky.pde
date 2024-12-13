PImage sun, moon;

float solarDuration = 86400; //Seconds in 24 hours
float solarElapsed = 0; //Time elapsed each cycle

//Set colours for each period of the day (array of colours[top,bottom])
color[] daySky = {color(142, 191, 255), color(220, 240, 255)};
color[] sunsetSky = {color(106, 35, 101), color(225, 125, 95)};
color[] nightSky = {color(0, 0, 9), color(24, 44, 85)};
color[] sunriseSky = {color(236, 154, 202), color(236, 155, 48)};

color currentSky;

void drawSky() {
  solarElapsed = (millis() % solarDuration) / solarDuration; //Calculate the current time in the solar cycle (0 to 1)
  
  color[] grad_from, grad_to; //Define periods of the day and smoothly transition between states
  
  //Transition between periods of day based on position in solar cycle
  //Day 0-0.25
  //Sunset 0.25-0.5
  //Night 0.5-0.75
  //Sunrise 0.75-1.0
  if (solarElapsed < 0.25) {
    grad_from = sunriseSky;
    grad_to = daySky;
  }
  else if (solarElapsed < 0.5) {
    grad_from = daySky;
    grad_to = sunsetSky;
  }
  else if (solarElapsed < 0.75) {
    grad_from = sunsetSky;
    grad_to = nightSky;
  }
  else {
    grad_from = nightSky;
    grad_to = sunriseSky;
  }
  
  //Interpolate top and bottom sky colors for smooth transition
  float phaseProgress = (solarElapsed % 0.25) / 0.25; // Normalize phase progress (0 to 1)
  
  color grad_col_top = lerpColor(grad_from[0], grad_to[0], phaseProgress);
  color grad_col_bottom = lerpColor(grad_from[1], grad_to[1], phaseProgress);
  
  //Draw gradient background
  for (int y = 0; y < height; y++) {
    float interp_param = map(y, 0, height, 0, 1);
    currentSky = lerpColor(grad_col_top, grad_col_bottom, interp_param);
    stroke(currentSky);
    line(0, y, width, y);
  }
  
  filter(POSTERIZE, 100); //filter
  
  celestialBodies();
}

void celestialBodies() {
  //Orbital parameters
  float centerX = width / 2; //Centre of orbit
  float centerY = height / 1.75; //Max height of orbit
  float posX = width / 1.7; // Horizontal radius determining position of celestial body
  float posY = height / 2.75; // Vertical radius determining position of celestial body
  
  //Calculate orbital position using solarElapsed
  float angle = TWO_PI * solarElapsed; //Angle of orbit about centre points in radians (0 to 2π)
  
  //Sun's position
  float sunX = centerX - posX * cos(angle); 
  float sunY = centerY - posY * sin(angle);
  
  //Moon's position directly out of phase with sun
  float moonX = centerX - posX * cos(angle + PI);
  float moonY = centerY - posY * sin(angle + PI);
  
  //Draw sun with rotation
  if (solarElapsed < 0.5) {
    imageMode(CENTER);
    pushMatrix();
    translate(sunX, sunY); // Move origin to the sun's position
    rotate(angle); // Rotate the sun image based on the angle
    image(sun, 0, 0, 200, 200); // Draw the sun at the new origin
    popMatrix();
  }
  
  //Draw moon
  if (solarElapsed >= 0.5) {
    imageMode(CENTER);
    image(moon, moonX, moonY, 130, 130);
  }
}
