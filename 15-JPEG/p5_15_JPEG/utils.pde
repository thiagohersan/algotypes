void drawInputFrames(PGraphics mpg) {
  mpg.beginDraw();

  mpg.rectMode(CENTER);
  mpg.stroke(0, 32);
  mpg.fill(0, 0, 200, 16);
  mpg.fill(0, 16);
  for (int i = 0; i < SIZE_INPUT_FRAMES; i += 4) {
    float x = map(INPUT_FRAMES[i+0], 0, 256, 0, mpg.width);
    float y = map(INPUT_FRAMES[i+1], 0, 256, 0, mpg.height);
    float w = map(INPUT_FRAMES[i+2], 0, 256, mpg.width/20, mpg.width/4);
    float h = map(INPUT_FRAMES[i+3], 0, 256, mpg.height/20, mpg.height/4);
    mpg.rect(x, y, w, h);
  }
  mpg.endDraw();
}

void drawOutput(PGraphics mpg) {
  mpg.beginDraw();
  mpg.rectMode(CENTER);
  mpg.strokeWeight(0.0);

  int[][] mjpeg = mJFIF.jpeg();
  int[][] mluminance = mJFIF.luminance();

  float w = float(mpg.width) / mJFIF.luminance[0].length;
  float h = float(mpg.height) / mJFIF.luminance.length;

  float minDiff = (mjpeg[0][0] - mluminance[0][0]);
  float maxDiff = (mjpeg[0][0] - mluminance[0][0]);

  for (int y = 0; y < mjpeg.length; y++) {
    for (int x = 0; x < mjpeg[y].length; x++) {
      float thisDiff = mjpeg[y][x] - mluminance[y][x];
      if (thisDiff > maxDiff) maxDiff = thisDiff;
      if (thisDiff < minDiff) minDiff = thisDiff;
    }
  }

  for (int y = 0; y < mjpeg.length; y++) {
    for (int x = 0; x < mjpeg[y].length; x++) {
      int red = (int)map((mjpeg[y][x] - mluminance[y][x]), minDiff, maxDiff, 0, 255);
      mpg.fill(red, 0, 0, (mjpeg[y][x] - mluminance[y][x]));
      mpg.stroke(red, 0, 0, (mjpeg[y][x] - mluminance[y][x]));
      mpg.rect(w*x, h*y, w, h);
    }
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
