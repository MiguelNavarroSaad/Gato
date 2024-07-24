int delta = 10;
int lado;
float diametro = 100;
boolean cambia = true;
PVector pos[][];
int estado[][];
float mX, mY;

PGraphics uno, dos;

void setup() {
  size(500, 500);
  background(255, 255, 255);
  frameRate(10);
  lado = width/4-2*delta;
  uno = createGraphics(lado, lado);
  dos = createGraphics(lado, lado);
  gato();
  cruz();
  circulo();
  pos = new PVector[4][4];
  for (int i = 0; i <= 3; i++)
    for (int j = 0; j <= 3; j++)
      pos[i][j] = new PVector((2*j+1)*width/8+delta, (2*i+1)*height/8+delta);
  estado = new int[3][3];
  for (int i = 0; i <= 2; i++)
    for (int j = 0; j <= 2; j++)
      estado[i][j] = 0;
}

void draw() {
  mX = mouseX;
  mY = mouseY;
  if (mousePressed) {
    for (int i = 0; i < 3; i++)
      for (int j = 0; j < 3; j++)
        if (mX > pos[i][j].x && mX < pos[i][j+1].x &&
            mY > pos[i][j].y && mY < pos[i+1][j].y)
          if (estado[i][j] == 0) {
            cambia = !cambia;
            estado[i][j] = (cambia)?1:2;
            image((cambia)?uno:dos, pos[i][j].x, pos[i][j].y);
          }
  }
  fin();
}

void fin() {
  for (int i = 0; i < 3; i++)
    if (estado[i][0] != 0 && estado[i][0] == estado[i][1]
                          && estado[i][1] == estado[i][2]) {
      stroke(255, 0, 0);
      line(pos[i][0].x, pos[i][0].y+(pos[i+1][0].y-pos[i][0].y)/2-delta,
           pos[i][3].x, pos[i][0].y+(pos[i+1][3].y-pos[i][3].y)/2-delta);
      noLoop();
    }
  for (int i = 0; i < 3; i++)
    if (estado[0][i] != 0 && estado[0][i] == estado[1][i]
                          && estado[1][i] == estado[2][i]) {
      stroke(255, 0, 0);
      line(pos[0][i].x+(pos[0][i+1].x-pos[0][i].x)/2-delta, pos[0][i].y, 
           pos[0][i].x+(pos[3][i+1].x-pos[3][i].x)/2-delta, pos[3][i].y);
      noLoop();
    }
    if (estado[0][0] != 0 && estado[0][0] == estado[1][1]
                          && estado[1][1] == estado[2][2]) {
      stroke(255, 0, 0);
      line(pos[0][0].x-delta, pos[0][0].y-delta, pos[3][3].x-delta, pos[3][3].y-delta);
      noLoop();
    }
    if (estado[0][2] != 0 && estado[0][2] == estado[1][1]
                          && estado[1][1] == estado[2][0]) {
      stroke(255, 0, 0);
      line(pos[0][3].x-delta, pos[0][3].y-delta, pos[3][0].x-delta, pos[3][0].y-delta);
      noLoop();
    }
}

void gato() {
  stroke(0);
  strokeWeight(2*delta);
  line(3*width/8, height/8, 3*width/8, 7*height/8);
  line(5*width/8, height/8, 5*width/8, 7*height/8);
  line(width/8, 3*height/8, 7*width/8, 3*height/8);
  line(width/8, 5*height/8, 7*width/8, 5*height/8);
}

void cruz() {
  uno.beginDraw();
  uno.background(255, 255, 255);
  uno.stroke(0, 0, 0);
  uno.strokeWeight(diametro/4);
  uno.line(diametro/4, diametro/4, lado-diametro/4, lado-diametro/4);
  uno.line(lado-diametro/4, diametro/4, diametro/4, lado-diametro/4);
  uno.endDraw();
}

void circulo() {
  dos.beginDraw();
  dos.background(255, 255, 255);
  dos.noStroke();
  dos.fill(0, 0, 0);
  dos.circle(lado/2, lado/2, lado-diametro/4);
  dos.fill(255, 255, 255);
  dos.circle(lado/2, lado/2, 3*(lado-diametro/4)/4);
  dos.endDraw();
}

void triangulo() {
  uno.beginDraw();
  uno.noStroke();
  uno.fill(220, 220, 0);
  uno.beginShape();
    uno.vertex(-lado, 0);
    uno.vertex(lado, 0);
    uno.vertex(0, lado);
    uno.vertex(-lado, 0);
  uno.endShape();
  uno.endDraw();
}
