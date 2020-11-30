// based on:
// https://www.youtube.com/watch?v=dKIf6mQUfnY
// http://www.scholarpedia.org/article/Viterbi_algorithm

void initInput() {
  byte in[] = loadBytes(INPUT_FILEPATH);
  INPUT = new int[in.length];
  for (int i = 0; i < INPUT.length; i++) {
    INPUT[i] = in[i] & 0xff;
  }
}

static class Card {
  static final public String number = "0x12";
  static final public String name = "Viterbi Encoding";
  static final public String filename = OUTPUT.name() + "_" + number + "_" + name.replace(" ", "_");
}

FSM mFSM;

void setup() {
  size(804, 804);
  mSetup();
  mFSM = new FSM(INPUT);
}

void draw() {
  mDraw();
}
