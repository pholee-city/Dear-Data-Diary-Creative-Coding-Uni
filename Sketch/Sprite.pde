PImage sprite, speechBubble;

float spriteWidth = 200; //Image width
float spriteHeight = 200; //Image height
float spriteX = 130; //Image Xpos
float spriteY = 700 - spriteHeight/1.5;

void interactiveButton() {
  image(sprite, spriteX, spriteY, spriteWidth, spriteHeight);
  
  // Check if sprite is hovered over
  boolean isHovered = mouseX > 50 && mouseX < spriteWidth && mouseY > 500 && mouseY < height-50;
  
  // If hovered, display speech bubble
  if (isHovered) {
    image(speechBubble, spriteX+150, spriteY-50, spriteWidth, spriteHeight);
  }
}
