float[] set;
String text;
float offset = 0;
int i1, i2;
boolean run = true;
int time = 0;
void setup() {
  size(800, 600);
  frameRate(60);
  set = new float[int(0.99*width)];
  offset = 0.01*width/2;
  for (int i = 0; i < set.length; i++) set[i] = map(i, 0, set.length - 1, height/50, 9*height/10);
  disorder(set);
  i1 = set.length/2 - 1;
  i2 = set.length - 1;
}

void draw() {
  background(0);
  textSize(20);
  if (run) {
    if (i1 >= 0) {
      heapify(set, i1, set.length - 1);
      i1--;
      text = "Time: " + (millis() - time) + " ms";
      text(text, 20, 20);
    } else if (i2 > 0) {
      swap(set, 0, i2);
      heapify(set, 0, i2);
      i2--;
      text = "Time: " + (millis() - time) + " ms";
      text(text, 20, 20);
    } else {
      run = false;
      time = millis() - time;
    }
  } else {
    fill(255);
    text = "Time: " + time + " ms";
    text("finished!\n" + text, 20, 20);
  }

  stroke(255);
  for (int i = 0; i < set.length; i++) line(i + offset, height, i + offset, height-set[i]);
}

void heapify(float[] arr, int start, int end) {
  int max_p = start, left = 2*start+1, right = 2*start+2;
  if (left < end && arr[left] > arr[max_p]) max_p = left;
  if (right < end && arr[right] > arr[max_p]) max_p = right;
  if (max_p != start) {
    swap(arr, max_p, start);
    heapify(arr, max_p, end);
  }
}

void swap(float[] arr, int a, int b) {
  if (a != b) {
    arr[a] += arr[b];
    arr[b] = arr[a] - arr[b];
    arr[a] = arr[a] - arr[b];
  }
}

void disorder(float[] arr) {
  for (int i = 0; i < set.length; i++) {
    int x = round(random(set.length - 1));
    if (i != x) swap(arr, i, x);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    disorder(set);
    i1 = set.length/2 - 1;
    i2 = set.length - 1;
    time = millis();
    run = true;
  }
}
