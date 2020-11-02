import java.util.Random;

Random rand = new Random();

int w = 800;
int h = 800;
int cellsize = 5;

boolean[][] cells = new boolean[h/cellsize][w/cellsize];

color white = #FFFFFF;
color black = #000000;

void setup() {
  size(800,800);
  generateCells();
  frameRate(30);

}

void generateCells() {
  for(int i = 0; i < cells.length; i++) {
    for(int j = 0; j < cells[0].length; j++) {
      cells[i][j] = rand.nextBoolean();
    }
  }
}

void draw() {
  for(int i = 0; i < cells.length; i++) {
    for(int j = 0; j < cells[0].length; j++) {
      if(cells[i][j]) {
        fill(white);
      } else {
        fill(black);
      }
      rect(j*cellsize, i*cellsize, (j+1) * cellsize, (i+1) * cellsize);
    }
  }
  cellStep();
}

void keyPressed() {
  cellStep();
}

void cellStep() {
  boolean[][] newCells = new boolean[cells.length][cells[0].length];
  for(int y = 0; y < cells.length; y++) {
    for(int x = 0; x < cells[0].length; x++) {
      newCells[y][x] = stayAlive(x,y);
    }
  }
  cells = newCells;
}

boolean stayAlive(int xpos, int ypos) {
  int aliveNeighbors = 0;
  //bottom
  if(cells[(ypos+1)%80][xpos]) {
    aliveNeighbors++;
  }
  //right
  if(cells[ypos][(xpos+1)%80]) {
    aliveNeighbors++;
  }
  //bottom-right
  if(cells[(ypos+1)%80][(xpos+1)%80]) {
    aliveNeighbors++;
  }
  //top
  if(cells[(((ypos-1)%80)+80)%80][xpos]) {
    aliveNeighbors++;
  }
  //left
  if(cells[ypos][(((xpos-1)%80)+80)%80]) {
    aliveNeighbors++;
  }
  //top-right
  if(cells[(((ypos-1)%80)+80)%80][(xpos+1)%80]) {
    aliveNeighbors++;
  }
  //top-left
  if(cells[(((ypos-1)%80)+80)%80][(((xpos-1)%80)+80)%80]) {
    aliveNeighbors++;
  }
  //bottom-left
  if(cells[(ypos+1)%80][(((xpos-1)%80)+80)%80]) {
    aliveNeighbors++;
  }

  if(cells[ypos][xpos]) {
    if(aliveNeighbors == 2 || aliveNeighbors == 3) {
      return true;
    } else {
      return false;
    }
  } else {
    if(aliveNeighbors == 3) {
      return true;
    } else {
      return false;
    }
  }
}
