void drawInput(PGraphics mpg) {
  mpg.beginDraw();
  mpg.rectMode(CENTER);

  for (int i = 0; i < INPUT.length / 4; i += 4) {
    float x = map(INPUT[i+0], 0, 256, 0, mpg.width);
    float y = map(INPUT[i+1], 0, 256, 0, mpg.height);
    float w = map(INPUT[i+2], 0, 256, mpg.width/20, mpg.width/4);
    float h = map(INPUT[i+3], 0, 256, mpg.height/20, mpg.height/4);

    //mpg.stroke(0, 0, 200, 32);
    //mpg.fill(0, 0, 200, 16);
    mpg.stroke(0, 32);
    mpg.fill(0, 16);
    mpg.rect(x, y, w, h);
    mpg.rect(mpg.width - x, mpg.height - y, w, h);

    //mpg.stroke(200, 0, 0, 32);
    //mpg.fill(200, 0, 0, 16);
    mpg.stroke(0, 32);
    mpg.fill(0, 16);
    mpg.rect(mpg.width - x, y, w, h);
    mpg.rect(x, mpg.height - y, w, h);
  }
  mpg.endDraw();
}

void drawBorders(PGraphics mpg, int bwidth) {
  mpg.beginDraw();
  mpg.rectMode(CORNER);
  mpg.stroke(255);
  mpg.fill(255);
  mpg.rect(0, 0, mpg.width, bwidth);
  mpg.rect(0, mpg.height - bwidth, mpg.width, bwidth);
  mpg.rect(0, 0, bwidth, mpg.height);
  mpg.rect(mpg.width - bwidth, 0, bwidth, mpg.height);

  mpg.noFill();
  mpg.stroke(10);
  mpg.strokeWeight(1);
  mpg.rect(1, 1, mpg.width - 2, mpg.height - 2);
  mpg.endDraw();
}
