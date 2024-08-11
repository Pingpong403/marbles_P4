class CollisionHelper {
  LinkedList<Marble> objects;
  
  public CollisionHelper(LinkedList<Marble> objects) {
    this.objects = objects;
  }
  
  public void run() {
    int[] indices = findIndices();
    updateMarbles(indices);
  }
  
  public LinkedList<Marble> getMarbles() {
    return objects;
  }
  
  private int[] findIndices() {
    // we will use these to avoid duplicates and to return to the user
    LinkedList<Integer> foundIndices = new LinkedList<>();
    for (int i = 0; i < objects.size(); i++) {
      if (!foundIndices.contains(i)) {
        float r1 = objects.get(i).getRadius();
        for (int j = i + 1; j < objects.size(); j++) {
          if (!foundIndices.contains(j)) {
            float r2 = objects.get(j).getRadius();
            double distance = objects.get(i).compareDistance(objects.get(j));
            if (distance < r1 + r2) {
              foundIndices.add(i);
              foundIndices.add(j);
            }
          }
        }
      }
    }
    int[] returnArray = new int[foundIndices.size()];
    int temp_i = 0;
    for (Integer i : foundIndices) {
      returnArray[temp_i] = i.intValue();
      temp_i++;
    }
    return returnArray;
  }
  
  private void updateMarbles(int[] indices) {
    for (int i = 0; i < indices.length; i += 2) {
      // Find angle
      double angle = Math.atan2(objects.get(indices[i + 1]).getPosY() - objects.get(indices[i]).getPosY(), objects.get(indices[i + 1]).getPosX() - objects.get(indices[i]).getPosX());
      
      // Find resulting velocities
      double v1 = objects.get(indices[i + 1]).getTotalVel();
      double v2 = objects.get(indices[i]).getTotalVel();
      
      // Apply velocities at the given angle
      float bounciness_1 = objects.get(indices[i]).getBounciness();
      float bounciness_2 = objects.get(indices[i + 1]).getBounciness();
      objects.get(indices[i]).addVelX((float)(Math.cos(angle + Math.PI) * v1 * bounciness_1));
      objects.get(indices[i]).addVelY((float)(Math.sin(angle + Math.PI) * v1 * bounciness_1));
      objects.get(indices[i + 1]).addVelX((float)(Math.cos(angle) * v2 * bounciness_2));
      objects.get(indices[i + 1]).addVelY((float)(Math.sin(angle) * v2 * bounciness_2));
      
      // Nudge marbles until they don't overlap
      double r1 = objects.get(indices[i]).getRadius();
      double r2 = objects.get(indices[i + 1]).getRadius();
      while (objects.get(indices[i]).compareDistance(objects.get(indices[i + 1])) < r1 + r2) {
        objects.get(indices[i]).nudge(angle + Math.PI);
        objects.get(indices[i + 1]).nudge(angle);
      }
    }
  }
}
