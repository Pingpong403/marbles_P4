class Marble
{
  // Constant values
  private Random rand = new Random();
  
  // Physics
  float bounciness = 0.5;
  float friction = 0.9;
  
  // Appearance
  private float radius = 50;
  
  // Changing values
  
  // Physics
  private float posX;
  private float posY;
  private float velX = rand.nextInt(-20, 20);
  private float velY = rand.nextInt(-20, 0);
  
  // Appearance
  private Color mColor;
  private String index;
  
  public Marble(float posX, float posY, Color mColor, String index)
  {
    this.posX = posX;
    this.posY = posY;
    this.mColor = mColor;
    this.index = index;
  }
  
  public void paintIndex() {
    stroke(0, 0, 0);
    textSize(50);
    text(index, posX - 10, posY + 10);
  }
  
  public String getIndex() {
    return index;
  }
  
  public void drawMarble() {
    noStroke();
    fill(mColor.getR(), mColor.getG(), mColor.getB(), mColor.getA());
    ellipse(posX, posY, radius * 2, radius * 2);
  }
  
  public float getBounciness() {
    return bounciness;
  }
  
  public float getFriction() {
    return friction;
  }
  
  public float getRadius() {
    return radius;
  }
  
  public float getPosX() {
    return posX;
  }
  
  public float getPosY() {
    return posY;
  }
  
  public void setPosX(float newPosX) {
    posX = newPosX;
  }
  
  public void setPosY(float newPosY) {
    posY = newPosY;
  }
  
  public void addX(float addend) {
    posX += addend;
  }
  
  public void addY(float addend) {
    posY += addend;
  }
  
  public void updatePos() {
    posX += velX;
    posY += velY;
  }
  
  public void nudge(double angle) {
    // Nudges the objects a pixel in the given direction
    posX += Math.cos(angle);
    posY += Math.sin(angle);
  }
  
  public double compareDistance(Marble m2) {
    return Math.sqrt(Math.pow(this.posX - m2.getPosX(), 2) + Math.pow(this.posY - m2.getPosY(), 2));
  }
  
  public float getVelX() {
    return velX;
  }
  
  public float getVelY() {
    return velY;
  }
  
  public float getTotalVel() {
    return (float)Math.sqrt(Math.pow(velX, 2) + Math.pow(velY, 2));
  }
  
  public void setVelX(float vel) {
    velX = vel;
  }
  
  public void setVelY(float vel) {
    velY = vel;
  }
  
  public void addVelX(float amt) {
    velX += amt;
  }
  
  public void addVelY(float amt) {
    velY += amt;
  }
  
  public void reverseVelX() {
    velX *= -1;
  }
  
  public void reverseVelY() {
    velY *= -1;
  }
  
  public void lossX(float loss) {
    velX *= loss;
  }
  
  public void lossY(float loss) {
    velY *= loss;
  }
  
  public void updateColor(Color c) {
    mColor = c;
  }
  
  public void resetColor() {
    mColor = new Color(20, 50, 200, 150);
  }
}
