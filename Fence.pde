class Fence {
  PVector pos;
   final String me = "!";

  Fence(PVector p) {
    pos = new PVector();
    pos.set(p);
  }
  
  void display() {
    if (mode == SKIING) {
      pos.add(trans);
    }
    if (pos.y < 0) {
     pos.set(pos.x, height,0);
    }
    drawText(me, pos);
  }
}
