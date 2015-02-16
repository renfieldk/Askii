class Tree {
  PVector pos;
  final String me = "#";

  Tree() {
    pos = new PVector();
    setRandPos();
  }

  void setRandPos() {
    pos.set( random(width * 2), height + random(height * 2), 0);
  }

  void display() {
    if (mode == SKIING) {
      pos.add(trans);
    }
    if (pos.y < 0) {
      setRandPos();
    }
    drawText(me, pos);
  }
}

