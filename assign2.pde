PImage bg,soil,life,groundhog,soldier,cabbage,title,gameover;
PImage startNormal,startHovered,restartNormal,restartHovered;
PImage groundhogRight,groundhogDown,groundhogLeft;

float soldierX,soldierY;
float cabbageX,cabbageY;
float groundhogX,groundhogY,groundhogSpeed;
float lifeX,lifeY;
int lifeNumber;

final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_OVER=2;
final int GAME_WIN=3;
int gameState=GAME_START;


boolean upPressed=false;
boolean downPressed=false;
boolean rightPressed=false;
boolean leftPressed=false;

void setup() {
  size(640, 480, P2D);
  frameRate(60);

  //loadImage
  bg=loadImage("img/bg.jpg");
  soil=loadImage("img/soil.png");
  life=loadImage("img/life.png");
  groundhog=loadImage("img/groundhogIdle.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");
  title=loadImage("img/title.jpg");
  gameover=loadImage("img/gameover.jpg");
  groundhogRight=loadImage("img/groundhogRight.png");
  groundhogDown=loadImage("img/groundhogDown.png");
  groundhogLeft=loadImage("img/groundhogLeft.png");
  
  //soldierPosition
  soldierX=floor(random(0,560));
  soldierY=160+80*floor(random(0,4));
  
  //cabbagePosition
  cabbageX=80*floor(random(0,8));
  cabbageY=160+80*floor(random(0,4));
  
  //groundhog
  groundhogX =320;
  groundhogY =80;
  groundhogSpeed =80;

  
  //life
  lifeX=10;
  lifeY=10;
  lifeNumber=2;  
}

void draw() {
  //gameState
  switch(gameState){
  case GAME_START:
    image(title,0,0);
    if(mouseX>248 && mouseX<248+144 && mouseY>360 
       && mouseY<360+60){
      image(startHovered,248,360);
      if(mousePressed){
        gameState = GAME_RUN;
      }
    }else{
      image(startNormal,248,360);
    }
    break;
    
  //GAME_RUN
  case GAME_RUN: 
  

    
    //bg.soil.life
    background(bg);
    image(soil,0,160);
    
    //sun
    stroke(255,255,0);
    strokeWeight(5);
    fill(253,184,19);
    ellipse(590,50,120,120);
    
    //grass
    noStroke();
    fill(124,204,25);
    rect(0,145,640,15);

    //cabbage&groundhog&soldier
    image(cabbage,cabbageX,cabbageY);    
    image(groundhog,groundhogX,groundhogY);
    image(soldier,soldierX,soldierY);
    soldierX+=3;
    if (soldierX>width){
        soldierX=-80;
    }
    
    //groundhogEatCabbage
    if(groundhogX==cabbageX  &&  groundhogY==cabbageY){
      cabbageX=-100;
      cabbageY=-100;
      lifeNumber++;
    }
      if(lifeNumber==3){
        image(life,lifeX,lifeY);
        image(life,lifeX+70,lifeY);
        image(life,lifeX+140,lifeY);
      }
      if (lifeNumber==2){
        image(life,lifeX,lifeY);
        image(life,lifeX+70,lifeY);
      }
      if(lifeNumber==1){
        image(life,lifeX,lifeY);      
      }
        
    //groundhogTouchSolider
    if(groundhogX<soldierX+80 && groundhogX+80>soldierX 
        && groundhogY<soldierY+80 && groundhogY+80>soldierY){
          groundhogX=320;
          groundhogY=80;
          lifeNumber--;
        }
      if(lifeNumber==2){
        image(life,lifeX,lifeY);
        image(life,lifeX+70,lifeY);
      }
      if (lifeNumber==1){ 
        image(life,lifeX,lifeY);      
      }
      if(lifeNumber==0){
        gameState = GAME_OVER;
      } 
    break;
    
   case GAME_OVER:
    image(gameover,0,0);
       groundhogX =-300;
       groundhogY =-300;
    if(mouseX>248 && mouseX<248+144 && mouseY>360 
       && mouseY<360+60){
      image(restartHovered,248,360);
      if(mousePressed){
        gameState = GAME_RUN;
        groundhogX =320;
        groundhogY =80;
        lifeNumber=2;
        cabbageX=80*floor(random(0,8));
        cabbageY=160+80*floor(random(0,4));
      }
    }else{
      image(restartNormal,248,360);

    }
    break;
  }
}
void keyPressed(){
  if(key ==CODED){
  switch(keyCode){
    case DOWN:
    image(groundhogDown,groundhogX,groundhogY);
    groundhogY+=groundhogSpeed;
    if(groundhogY+80>height){
       groundhogY=height-80;
    }
    break;
    case RIGHT:
    image(groundhogRight,groundhogX,groundhogY); 

    groundhogX+=groundhogSpeed;
    if(groundhogX+80>width){
       groundhogX=width-80;
    }
    break;
    case LEFT:
    image(groundhogLeft,groundhogX,groundhogY);
    groundhogX-=groundhogSpeed;
    if(groundhogX<=0){
       groundhogX=0; 
    }
    break;   
    }   
  }
} 
  void keyReleased(){
  switch(keyCode){
    case UP:
    upPressed = false;
    break;
    case DOWN:
    downPressed = false;
    break;
    case RIGHT:
    rightPressed = false;
    break;
    case LEFT:
    leftPressed = false;
    break;
  }
}
