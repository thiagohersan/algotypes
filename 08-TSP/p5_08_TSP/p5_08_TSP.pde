// Based on:
// https://en.wikipedia.org/wiki/Nearest_neighbour_algorithm
// https://en.wikipedia.org/wiki/Travelling_salesman_problem#Heuristic_and_approximation_algorithms
// https://en.wikipedia.org/wiki/Simulated_annealing

// input
static final int INPUT_SIZE = 1024;
int[] INPUT = new int[INPUT_SIZE];

void initInput() {
  for (int i=0; i < INPUT_SIZE; i++) {
    INPUT[i] = int(0xff * noise(i, frameCount));
  }
}

Graph mGraph;


void setup() {
  size(469, 804);
  noLoop();
  noiseSeed(0);
}

void draw() {
  initInput();
  mGraph = new Graph(INPUT);

  background(255);

  println(mGraph.greedy());
  println(" " + mGraph.anneal());
}
