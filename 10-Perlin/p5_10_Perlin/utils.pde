void drawInput(PGraphics mpg) {
  mpg.beginDraw();

  mpg.rectMode(CENTER);
  mpg.stroke(0, 32);
  mpg.fill(0, 0, 200, 16);
  mpg.fill(0, 16);
  for (int i = 0; i < INPUT.length; i += 4) {
    float x = map(INPUT[i+0], 0, 256, 0, mpg.width);
    float y = map(INPUT[i+1], 0, 256, 0, mpg.height);
    float w = map(INPUT[i+2], 0, 256, mpg.width/20, mpg.width/4);
    float h = map(INPUT[i+3], 0, 256, mpg.height/20, mpg.height/4);
    mpg.rect(x, y, w, h);
  }
  mpg.endDraw();
}

void drawOutput(PGraphics mpg) {
  int PWIDTH = OUT_SCALE * 3;
  float NOISE_SCALE = 1.0 / (OUT_SCALE * 128f);

  mpg.beginDraw();
  mpg.rectMode(CENTER);

  for (float x = 0; x < mpg.width + PWIDTH; x += PWIDTH) {
    for (float y = 0; y < mpg.height + PWIDTH; y += PWIDTH) {
      int c = int(255f * mPerlin.noise(x * NOISE_SCALE, y * NOISE_SCALE));

      mpg.stroke(255, 0, 0, c);
      mpg.strokeWeight(OUT_SCALE / 2);
      mpg.fill(255, 0, 0, c / 2);

      mpg.rect(x, y,
        1.5*(PWIDTH + OUT_SCALE)*mPerlin.noise(x * NOISE_SCALE, y * NOISE_SCALE, PI),
        1.5*(PWIDTH + OUT_SCALE)*mPerlin.noise(x * NOISE_SCALE, y * NOISE_SCALE, TWO_PI));
    }
  }
  mpg.endDraw();
}

void saveOutput(String filename) {
  float NOISE_SCALE = 1.0 / (OUT_SCALE * 8f);
  byte[] out = new byte[INPUT.length];
  for (int i = 0; i < out.length; i += 1) {
    out[i] = (byte)((int)(255f * mPerlin.noise(i * NOISE_SCALE)) & 0xff);
  }
  saveBytes(filename, out);
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

  mpg.noStroke();
  mpg.textFont(mFont);
  mpg.textSize(OUT_SCALE * FONT_SIZE);
  mpg.rectMode(CENTER);
  mpg.textAlign(CENTER, CENTER);
  mpg.fill(255);
  mpg.rect(mpg.width/2, bwidth, 1.111 * mpg.textWidth(Card.number), 2 * OUT_SCALE * FONT_SIZE);
  mpg.fill(0);
  mpg.text(Card.number, mpg.width/2, OUT_SCALE * FONT_SIZE / 2);

  mpg.fill(255);
  mpg.rect(mpg.width/2, mpg.height - bwidth, 1.111 * mpg.textWidth(Card.name), 2 * OUT_SCALE * FONT_SIZE);
  mpg.fill(0);
  mpg.text(Card.name, mpg.width/2, mpg.height - OUT_SCALE * 32);

  mpg.rectMode(CORNER);
  mpg.noFill();
  mpg.stroke(10);
  mpg.strokeWeight(1);
  mpg.rect(1, 1, mpg.width - 2, mpg.height - 2);
  mpg.endDraw();
}
