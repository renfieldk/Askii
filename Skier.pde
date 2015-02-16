class Skier {
  float acx = 0.1;
  float acy = 0.05;
  ArrayList<Trail> trails;
  final int trailCount = 10;
  float L, R, S;
  PVector direction;

  PVector pos, acc;
  String sk;

  Skier(PVector pv) {
    pos = new PVector();
    acc = new PVector();
    pos.set(pv); 
    sk = "||";

    trails = new ArrayList<Trail>();

    L = width/3; // from left to 1/3 right
    S = L*2; // from 1/3 right to 2/3 right
    R = width; // from 2/3 right to right

    direction = new PVector(0, 0);
    direction.rotate(HALF_PI); // straight down
  }

  boolean crashCheck(PVector p) {
    return abs(pos.dist(p)) < textWidth(sk)/2 ? true : false;
  }

  /* make this so that the longer you turn to one side, the harder you turn
   divide the screen into 3rds:
   left, straight, right
   */
  void turn(int mx) {    
    if (mx <= L) {
      sk = "//";
      acc.add(-acx, 0, 0);
      if (acc.x < 0) { // facing direction turning so speed up
        acc.add(0, acy * acx, 0);
      } else { // counter-turning so slow down
        acc.add(0, -acy * acx, 0);
      }
    } else if (mx <= S) {
      sk ="||";
      acc.add(0, acy, 0); // speeding up
    } else if (mx <= R) {
      sk = "\\"+"\\";
      acc.add(acx, acy, 0);
      if (acc.x > 0) { // facing direction turning so speed up
        acc.add(0, acy * acx, 0);
      } else { // counter-turning so slow down
        acc.add(0, -acy * acx, 0);
      }
    }
  }

  void move() {
    if (mode == SKIING) {
      pos.add(acc);
    } else { // reset acceleration to zero
      acc.set(0, 0);
    }

    trails.add(new Trail(pos, sk));
    trans = new PVector(width/2-pos.x, height/2-pos.y);
    pos.add(trans);
  }

  void display() {
    drawText(sk, pos);
    for (Trail tr : trails) {
      tr.display();
    }
    
    // show vector
    pushStyle();
    stroke(0,255,0);
    PVector center = new PVector(0,0);
    PVector end = PVector.add(center, acc);
    end.mult(10);
    line(width/2, height/2, width/2 + end.x, height/2 + end.y);
    popStyle();
  }
}

