PImage sun, moon;

float solarDuration = 20000;//86400; //Seconds in 24 hours
float solarElapsed = 0; //Time elapsed each cycle

//Set colours for each period of the day (array of colours[top,bottom])
color[] daySky = {color(142, 191, 255), color(220, 240, 255)};
color[] sunsetSky = {color(106, 35, 101), color(225, 125, 95)};
color[] nightSky = {color(0, 0, 9), color(24, 44, 85)};
color[] sunriseSky = {color(236, 154, 202), color(236, 155, 48)};

color currentSky;

//Dates for the range (November 11 to November 17)
int startDay = 11;
int endDay = 17;

//Display date
void displayDate(int currentDay) {
    textSize(15);
    text("November " + currentDay, 60, 175);
    fill(0, 0, 0);
}

//Display time
void displayTime(String timeString) {
    textSize(15);
    text(timeString, 60, 200);
    fill(0, 0, 0);
}

void drawSky() {
  solarElapsed = (millis() % solarDuration) / solarDuration; //Calculate the current time in the solar cycle (0 to 1)
  
  //Map the solarElapsed value (0 to 1) to a specific date in the range
  int currentDay = int(map(solarElapsed, 0, 1, startDay, endDay));

  //Offset time by 12 hours
  float offsetSolarElapsed = solarElapsed + 0.5;
  //Wraps around within range 0 to 1
  if (offsetSolarElapsed >= 1) {
    offsetSolarElapsed -= 1;
  }

  //Map solarElapsed to hours, minutes, and seconds
  int hours = int(map(solarElapsed, 0, 1, 0, 24));  //Map to hours (0 to 23)
  int minutes = int(map(solarElapsed, 0, 1, 0, 60)); //Map to minutes (0 to 59)
  int seconds = int(map(solarElapsed, 0, 1, 0, 60)); //Map to seconds (0 to 59)

  //Format time as HH:MM:SS (24-hour format)
  String timeString = nf(hours, 2) + ":" + nf(minutes, 2) + ":" + nf(seconds, 2);
  
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
  float phaseProgress = (solarElapsed % 0.25) / 0.25; //Normalize phase progress (0 to 1)
  
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
  
  displayDate(currentDay);
  displayTime(timeString);
}

void celestialBodies() {
  //Orbital parameters
  float centerX = 500; //Centre of orbit
  float centerY = 550; //Height of orbit (where it starts)
  float posX = 700; //Horizontal radius determining position of celestial body
  float posY = 450; //Vertical radius determining position of celestial body
  
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
    pushMatrix();
    translate(sunX, sunY); //Move origin to the sun's position
    rotate(angle); //Rotate the sun image based on the angle
    image(sun, 0, 0, 200, 200); //Draw the sun at the new origin
    popMatrix();
  }
  
  //Draw moon
  if (solarElapsed >= 0.5) {
    pushMatrix();
    translate(moonX, moonY); //Move origin to the moon's position
    image(moon, 0, 0, 130, 130);
    popMatrix();
  }
}
