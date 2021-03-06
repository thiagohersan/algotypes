//
//

void initInput() {
  byte in[] = loadBytes(sketchPath("../../Packets/in/" + INPUT_FILENAME));
  INPUT = new int[in.length];
  for (int i = 0; i < INPUT.length; i++) {
    INPUT[i] = in[i] & 0xff;
  }
}

static class Card {
  static final public String number = "";
  static final public String name = "";
  static final public String filename = OUTPUT.name() + "_" + (BLEED_WIDTH ? "WIDE_" : "") + "0xXX_Back";
}

void setup() {
  size(840, 840);
  mSetup();
  BLEED_HEIGHT = BLEED_WIDTH;
  if (BLEED_HEIGHT) OUTPUT_GRAPHICS_DIMENSIONS = OUTPUT_DIMENSIONS.copy().sub(0, 0, 0);
}

void draw() {
  mDraw();
}
