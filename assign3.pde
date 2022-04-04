final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal,
  restartHovered, life, stone1, stone2, gh, ghRight, ghLeft, ghDown,
  soldier, cabbage, bg;

PImage []soil;
int nbrSoil = 6;
float soilStart = 160;
float soilSize = 80;

float stone1X=0, stone1Y=0, stone2X=0, stone2Y=0, stone3X=0,
  stone3Y=0, stone4X=0, stone4Y=0, stone5X=0, stone5Y=0, stone6X=0, stone6Y=0,
  stone7X=0, stone7Y=0;

float sdX=0, sdY=0, sdW=80 ;

final int cabbageW=80;
float cabbageX, cabbageY;

float test=0;
float ghX, ghY, ghRightX, ghRightY, ghLeftX, ghLeftY, ghDownX, ghDownY;
float ghSpeed = 80;
float ghW = 80;
float moveScript = 0;
int Time;
final int GH_IDLE = 0;
final int GH_LEFT = 1;
final int GH_RIGHT = 2;
final int GH_UP = 3;
final int GH_DOWN = 4;
int ghState = GH_IDLE;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;


float lifeSize = 50;
float lifeGap = 20;
float nbrlife = 2;
float lifemax = 5;
// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;













void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  gh = loadImage("img/groundhogIdle.png");
  ghRight = loadImage("img/groundhogRight.png");
  ghLeft = loadImage("img/groundhogLeft.png");
  ghDown = loadImage("img/groundhogDown.png");
  soil = new PImage[nbrSoil];
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");


  //soldier
  sdY = floor(random(2, 6))*80;

  //cabbage
  cabbageX = floor(random(1, 8))*80;
  cabbageY = floor(random(2, 6))*80;

  //groundhog
  ghX=width/2.0;
  ghY=80;
}


void draw() {
  /* ------ Debug Function ------
   
   Please DO NOT edit the code here.
   It's for reviewing other requirements when you fail to complete the camera moving requirement.
   
   */
  if (debugMode) {
    pushMatrix();
    translate(0, cameraOffsetY);
  }
  /* ------ End of Debug Function ------ */

  switch (gameState) {

  case GAME_START: // Start Screen
    image(title, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
        gameState = GAME_RUN;
        mousePressed = false;
      }
    } else {

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;



  case GAME_RUN: // In-Game

    // Background
    image(bg, 0, 0);

    // Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 120, 120);

    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT+moveScript, width, GRASS_HEIGHT);

    // Soil
    for (int i=0; i<nbrSoil; i++) {
      soil[i]=loadImage("img/soil"+i+".png");
      for (int x=0; x<width; x+=soilSize) {
        for (int y=0; y<soilSize*4; y+=soilSize) {
          image(soil[i], x, y+soilStart+320*i+moveScript);
        }
      }
    }

    //Stone1~8
    for (int i=0; i<8; i++) {
      stone1X = soilSize*i;
      stone1Y = soilStart+soilSize*i;
      image(stone1, stone1X, stone1Y+moveScript);
    }
    //Stone9~16
    for (int x = 0; x<width; x+=80) {
      for (int y = 0; y<soilStart+soilSize*16; y+=80) {
        if (x==80||x==160||x==400||x==480) {
          if (y+soilStart==800||y+soilStart==1040||
            y+soilStart==1120||y+soilStart==1360) {
            image(stone1, x, y+soilStart+moveScript);
          }
        }
      }
    }
    for (int x = 0; x<width; x+=80) {
      for (int y = 0; y<soilStart+soilSize*16; y+=80) {
        if (x==0||x==240||x==320||x==560) {
          if (y+soilStart==880||y+soilStart==960||
            y+soilStart==1200||y+soilStart==1280) {
            image(stone1, x, y+soilStart+moveScript);
          }
        }
      }
    }
    //Stone17~24
    for (int i=0; i<7; i+=3) {
      for (int j=0; j<7; j+=3) {
        stone2X = soilSize*i+soilSize;
        stone2Y = soilStart+soilSize*(16+j);
        image(stone1, stone2X, stone2Y+moveScript);
      }
    }
    for (int i=0; i<7; i+=3) {
      for (int j=0; j<7; j+=3) {
        stone3X = soilSize*i;
        stone3Y = soilStart+soilSize*(17+j);
        image(stone1, stone3X, stone3Y+moveScript);
      }
    }
    for (int i=0; i<7; i+=3) {
      for (int j=0; j<7; j+=3) {
        stone4X = soilSize*i+soilSize*2;
        stone4Y = soilStart+soilSize*(18+j);
        image(stone1, stone4X, stone4Y+moveScript);
      }
    }

    for (int i=0; i<7; i+=3) {
      for (int j=0; j<7; j+=3) {
        stone5X = soilSize*i+soilSize*2;
        stone5Y = soilStart+soilSize*(16+j);
        image(stone1, stone5X, stone5Y+moveScript);
        image(stone2, stone5X, stone5Y+moveScript);
      }
    }
    for (int i=0; i<7; i+=3) {
      for (int j=0; j<7; j+=3) {
        stone6X = soilSize*i+soilSize;
        stone6Y = soilStart+soilSize*(17+j);
        image(stone1, stone6X, stone6Y+moveScript);
        image(stone2, stone6X, stone6Y+moveScript);
      }
    }
    for (int i=0; i<7; i+=3) {
      for (int j=0; j<7; j+=3) {
        stone7X = soilSize*i;
        stone7Y = soilStart+soilSize*(18+j);
        image(stone1, stone7X, stone7Y+moveScript);
        image(stone2, stone7X, stone7Y+moveScript);
      }
    }

    //cabbage
    image(cabbage, cabbageX, cabbageY+moveScript);

    //soldier
    image(soldier, sdX, sdY+moveScript);
    sdX +=3; //soldierSpeed
    if (sdX>=640) {
      sdX=-40;
    }

    // Health UI
    for (int i=0; i<nbrlife; i++) {
      image(life, 10+i*(lifeSize+lifeGap), 10);
       }

    //Play
    if (ghX<sdX+sdW && ghX+ghW>sdX && ghY+ghW>sdY+.3+moveScript && ghY<sdY+sdW-.3+moveScript) {
      ghState=GH_IDLE;
      Time=0;
      ghX = width / 2.0 ;
      ghY = 80;
      nbrlife--;
      moveScript=0;
      test=0;
    }
    if (ghX<cabbageX+cabbageW && ghX+ghW>cabbageX
      && ghY+ghW>cabbageY+.3+moveScript && ghY<cabbageY+cabbageW-.3+moveScript
      && playerHealth<=5 && playerHealth>=0) {
      cabbageX=-100;
      cabbageY=-100;
      if(nbrlife<lifemax){
        nbrlife++;
      }
    }
    if (nbrlife<=0) {
      gameState = GAME_OVER;
    }

    // Player
    if (Time<15) {
      Time++;
      switch(ghState) {
      case GH_LEFT:
        ghX-=ghSpeed/15.0;
        break;
      case GH_RIGHT:
        ghX+=ghSpeed/15.0;
        break;
      case GH_DOWN:
        if (test>=300&&test<=360) {
          ghY+=ghSpeed/15.0;
          moveScript=-1600;
        } else if (test>=360) {
          test-=15;
        } else {
          ghY=80;
          moveScript+=-80/15.0;
        }
        break;
      case GH_UP:
        if (test<=0) {
          test++;
          ghY=80;
          moveScript=0;
        } else if (test>=300&&test<=360) {
          ghY-=ghSpeed/15.0;
          moveScript=-1600;
        } else {
          ghY=80;
          moveScript+=80/15.0;
        }
        break;
      }
    } else {
      ghState=GH_IDLE;
    }

    switch(ghState) {
    case GH_IDLE:
      image(gh, ghX, ghY);
      break;
    case GH_LEFT:
      image(ghLeft, ghX, ghY);
      break;
    case GH_RIGHT:
      image(ghRight, ghX, ghY);
      break;
    case GH_UP:
      image(ghDown, ghX, ghY);
      test--;
      break;
    case GH_DOWN:
      image(ghDown, ghX, ghY);
      test++;
      break;
    }


    //Groundhog_limit
    if (ghX+ghW>=width) {
      ghX=width-ghW;
    }
    if (ghX<=0) {
      ghX=0;
    }
    if (ghY+ghW>=height) {
      ghY=height-ghW;
    }
    if (ghY<=80) {
      ghY=80;
    }


    break;

  case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);

    if (START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if (mousePressed) {
          ghState=GH_IDLE;
        Time=0;
        ghX = width / 2.0 ;
        ghY = 80;
        nbrlife=2;
        moveScript=0;
        test=0;
        gameState = GAME_RUN;
        mousePressed = false;
        
        // Remember to initialize the game here!
      
      }
    } else {

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
  if (debugMode) {
    popMatrix();
  }
}

void keyPressed() {
  // Add your moving input code here
  if (ghState == GH_IDLE ) {
    Time=0;
    switch(keyCode) {
    case UP:
      ghState=GH_UP;
      break;
    case DOWN:
      ghState=GH_DOWN;
      break;
    case RIGHT:
      ghState=GH_RIGHT;
      break;
    case LEFT:
      ghState=GH_LEFT;
      break;
    }
  }








  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w':
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's':
    debugMode = true;
    cameraOffsetY -= 25;
    break;

  case 'a':
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd':
    if (playerHealth < 5) playerHealth ++;
    break;
  }
}

void keyReleased() {
}
