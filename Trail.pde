class Trail {
  PVector pos;
  String str;

  Trail(PVector p, String m) {
    pos = new PVector();
    pos.set(p);
    setMuki(m);
  }

  void setMuki(String m) {
    str = m;
  }

  void display() {
    color c = color( pos.dist(skier.pos) ); // fade out
    if (mode == SKIING) {
      pos.add(trans);
    }
    drawText(str, pos, c);
  }
}

