import java.util.LinkedList;
import java.util.List;
import java.util.Arrays;
import java.util.Random;

// CONSTANTS
float GRAVITY = 4;

// Random
Random r = new Random();

// Marbles
int marbleCount = 0;
int startingMarbles = 5;
int maxMarbles = 10;
Color marbleColor = new Color(20, 50, 200, 150);

// Environment
boolean windActive = false;
boolean vortexActive = false;
boolean ceilingActive = false;

LinkedList<Marble> marbles = new LinkedList<Marble>();

void setup()
{
  size(1000, 700);
  Random rand = new Random();
  for (int i = 0; i < startingMarbles; i++) {
    marbles.add(new Marble(rand.nextInt(1000), rand.nextInt(700), marbleColor, ((Integer)i).toString()));
    marbleCount++;
  }
}

void draw()
{
  background(255, 255, 255);
  
  fill(200);
  textSize(20);
  text("click - scramble\na - add marble (" + marbleCount + "/" + maxMarbles + ")\nr - remove marble\nc - toggle ceiling\nw - toggle wind\nv - toggle gravity", 10, 20);
  
  for (Marble marble : marbles) {
    marble.drawMarble();
  }
  
  // Do gravity
  for (Marble marble : marbles) {
    marble.addVelY(GRAVITY);
  }
  
  // Do wind
  if (windActive) {
    for (Marble marble : marbles) {
      marble.addVelX(0.5);
      marble.addVelY(-2.6);
    }
  }
  
  // Do antigravity
  if (vortexActive) {
    for (Marble marble : marbles) {
      marble.addVelY(-GRAVITY);
    }
  }
  
  // Update positions
  for (Marble marble : marbles) {
    marble.updatePos();
  }
  
  // Do collisions
  
  // Floor (and ceiling)
  for (Marble marble : marbles) {
    if (marble.getPosY() + marble.getRadius() > 700) {
      marble.reverseVelY();
      marble.lossY(marble.getBounciness());
      marble.lossX((1 - marble.getFriction()) / 2 + marble.getFriction());
      marble.setPosY(700 - marble.getRadius());
    }
    if (marble.getPosY() - marble.getRadius() < 0 && ceilingActive) {
      marble.reverseVelY();
      marble.lossY(marble.getBounciness());
      marble.lossX((1 - marble.getFriction()) / 2 + marble.getFriction());
      marble.setPosY(marble.getRadius());
    }
  }
  
  // Walls
  for (Marble marble : marbles) {
    if (marble.getPosX() + marble.getRadius() > 1000) {
      marble.reverseVelX();
      marble.lossX(marble.getBounciness());
      marble.setPosX(1000 - marble.getRadius());
    }
    
    else if (marble.getPosX() - marble.getRadius() < 0) {
      marble.reverseVelX();
      marble.lossX(marble.getBounciness());
      marble.setPosX(marble.getRadius());
    }
  }
  
  // Other marbles
  CollisionHelper c = new CollisionHelper(marbles);
  c.run();
  marbles = c.getMarbles();
}

// Jumble up the marbles
void mouseClicked() {
  for (Marble marble : marbles) {
    if (vortexActive) {
      marble.addVelX(r.nextInt(-60, 60));
      marble.addVelY(r.nextInt(-50, -30));
    }
    else {
      marble.addVelX(r.nextInt(-100, 100));
    marble.addVelY(r.nextInt(-70, -50));
    }
  }
}

// Keypress events
void keyPressed() {
  // Add a new marble -> A
  if (marbleCount < maxMarbles && (key == 'a' || key == 'A')) {
    marbles.add(new Marble(mouseX, mouseY, marbleColor, ((Integer)(marbleCount)).toString()));
    marbleCount++;
  }
  // Remove the first marble -> R
  if (marbleCount > 0 && (key == 'r' || key == 'A')) {
    marbles.removeFirst();
    marbleCount--;
  }
  // Add wind -> W
  if (key == 'w' || key == 'W') {
    if (!windActive) {
      windActive = true;
    }
    else {
      windActive = false;
    }
  }
  // Antigravity -> V
  if (key == 'v' || key == 'V') {
    if (!vortexActive) {
      vortexActive = true;
    }
    else {
      vortexActive = false;
    }
  }
  // Add ceiling
  if (key == 'c' || key == 'C') {
    if (!ceilingActive) {
      ceilingActive = true;
    }
    else {
      ceilingActive = false;
    }
  }
  
  // SECRET
  if (key == 'm' || key == 'M') {
    maxMarbles++;
  }
  if (key == 'l' || key == 'L') {
    maxMarbles--;
  }
}
