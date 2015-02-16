static final int SKIING = 1;
static final int CRASHED= 2;
static final int READY  = 3;
PVector top;
int start, stop, count;
int mode;
Skier skier;
Tree[] trees;
color bgc;
int treeCount = 50;
PVector trans;
ArrayList<Fence> fences;

void setup() {
  // size(displayWidth, displayHeight);
  size(480, 640);
  frameRate(15);

  bgc = color(255);
  
  top = new PVector( width/2, textAscent());
  start = 0;
  stop = 0;
  count = 0;
  mode = READY;

  // to keep the skier in the center
  // use this to translate everything
  trans = new PVector();  

  // ski border
  // twice the width of the screen
  fences = new ArrayList<Fence>();
  int h = 0;
  while (h < height) {
    PVector pos = new PVector(-width, h);
    fences.add( new Fence(pos) );
    pos = new PVector(width * 2, h);
    fences.add( new Fence(pos) );
    h += textAscent();
  }

  // dont hit these!
  // make this an ArrayList and keep adding trees as time goes by...
  trees = new Tree[treeCount];
  for (int i=0; i<trees.length; i++) {
    trees[i] = new Tree();
  }

  // skiier in the center
  // make start higher up screen and go towards bottom of screen as time goes by?
  PVector c = new PVector(width/2, height/2);
  skier = new Skier(c);
}

void draw() {
  background(bgc); // clear screen for redraw update

  // draw fences & check for crashes
  for (Fence f : fences) {
    f.display(); 
    if ( skier.crashCheck(f.pos) ) {
      mode = CRASHED;
      bgc = color(255, 0, 0);
    }
  }

  // draw trees & check for crashes
  for (Tree t : trees) {
    t.display();
    if ( skier.crashCheck(t.pos) ) {
      mode = CRASHED;
      bgc = color(255, 0, 0);
    }
  }  

  switch (mode) {
  case READY: // starting screen
    String str = "Tap left or right side of screen to turn.\nTap anywhere to start.";
    PVector loc = new PVector(width/2, height/4);
    drawText(str, loc );
    count = 0;
    start = 0;
    stop  = 0;
    break;
  case SKIING: // we movin
    skier.turn(mouseX);
    skier.move();
    count = frameCount - start;
    break;
  }

  drawText("Count: " + count + " Speed: " + skier.acc.y + " Drift: " + skier.acc.x, top);
  skier.display();
}

void mouseClicked() {
  if (mode == READY) {
    mode = SKIING;
    start = frameCount;
  } else if (mode == CRASHED) {
    mode = READY;
    stop = frameCount;
    setup();
  }
}


void drawText(String t, PVector pos, color c) {
  pushStyle();
  textSize(12);
  fill(c);
  float w = textWidth(t);
  float h = textDescent();
  text(t, pos.x - w/2, pos.y + h);
  popStyle();
}


void drawText(String t, PVector pos) {
  drawText(t, pos, color(0));
}

