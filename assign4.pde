/*game 4*/
PImage bg1,bg2,enemy,fighter,hp,treasure,start1,start2,end1,end2;
PImage[] flame=new PImage[5];
float Hp=197;
float tSpeed=5;
float hpx;//hpx=floor(random(197));
float hpSpace=Hp/5;
float fx=550,fy=240;
float tx=random(41,601),ty=random(41,441);
int bgx1=641,bgx2=0;
int spacing=10;
int j=0;
float enemyWidth=61;
float enemyHeight=61;
float[] ex=new float[5];
float[] ey=new float[5];
float[] ey1=new float[5];
float[] ey2=new float[5];
float flameX;
float eStartY;
float eStartX=-5*(spacing+enemyWidth);
int state;
int stateGame;
final int GAME_START=0;
final int GAME_RUN=1;
final int GAME_LOSE=2;
final int RUN1=0;
final int RUN2=1;
final int RUN3=2;
boolean upPressed,downPressed,rightPressed,leftPressed=false;

void setup()
{
  size(640,480);
  hpx=hpSpace;
  state=GAME_START;
  stateGame=RUN1;
  eStartY=random(0,height-enemyHeight);
  start1=loadImage("img/start1.png");
  start2=loadImage("img/start2.png");
  bg1=loadImage("img/bg1.png");
  bg2=loadImage("img/bg2.png");
  treasure=loadImage("img/treasure.png");
  fighter=loadImage("img/fighter.png");
  enemy=loadImage("img/enemy.png");
  hp=loadImage("img/hp.png");  
  end1=loadImage("img/end1.png");
  end2=loadImage("img/end2.png");
  for(int i=0;i<5;i++)
  {
    flame[i]=loadImage("img/flame"+(i+1)+".png");
  }
  for(int i=0;i<5;i++)
  {
      ex[i]=eStartX+(enemyWidth+spacing)*i;
  }
  for(int i=0;i<5;i++)
  {
    ey[i]=eStartY;
  }
}
void draw()
{
  switch(state)
  {
    //------------------------------
    case GAME_START:
    {
          hpx=hpSpace;
          stateGame=RUN1;
          eStartY=random(0,height-enemyHeight);
          for(int i=0;i<5;i++)
          {
            ex[i]=eStartX+(enemyWidth+spacing)*i;
          }
            for(int i=0;i<5;i++)
          {
            ey[i]=eStartY;
          }
          image(start2,0,0);  
          if(mouseX>207&&mouseX<454) //x:207-454,y:378-413
          {
              if(mouseY>378&&mouseY<413)
              {
                  image(start1,0,0);
                  if(mousePressed)
                    state=GAME_RUN;
              }
          }
          break;
    }
    //------------------------------
    case GAME_RUN:
    {
         //bg
        image(bg1,bgx1-640,0);
        bgx1+=3;
        bgx1%=1280;
        image(bg2,bgx2-640,0);
        bgx2+=3;
        bgx2%=1280;
        //treasure
        image(treasure,tx,ty);
        if((fx-tx)<41&&(tx-fx)<51)
        {
          if((fy-ty)<41&&(ty-fy)<51)
          {
            tx=random(41,601);
            ty=random(41,441);
            hpx+=hpSpace;
            if(hpx>=Hp)
              hpx=Hp;
          }
        }
        //fighter
        if(upPressed)
          fy-=tSpeed;
        if(downPressed)
          fy+=tSpeed;
        if(rightPressed)
          fx+=tSpeed;
        if(leftPressed)
          fx-=tSpeed;
        
        if(fx<0)
          fx=0;
        if(fx>590)
          fx=590;
        if(fy<0)
          fy=0;
        if(fy>429)
          fy=429;
        //hp
        if(hpx<=0)
          state=GAME_LOSE;
        image(fighter,fx,fy);
        //enemy
        switch(stateGame)
        {
          case RUN1:
            for(int i=0;i<5;i++)
            {
              //hit
              if(fx-ex[i]<61&&ex[i]-fx<51)
              {
                 if(fy-ey[i]<61&&ey[i]-fy<51)
                 {
                   flameX=ex[i];
                   ex[i]=width;
                   hpx-=hpSpace;
                   //flame
                   if(frameCount%(60/10)==0)
                   {
                      image(flame[j],flameX,ey[i]);
                      j++;
                      if(j==5)
                        j=0;
                   }
                 }
              }
              image(enemy,ex[i],ey[i]);
            }
            //move
            for(int i=0;i<5;i++)
            {
              ex[i]+=2;
              ey[i]=eStartY;
            }
            //move out
            if(ex[0]>width&&ex[1]>width&&ex[2]>width&&ex[3]>width&&ex[4]>width)
            {
              eStartX=-5*(spacing+enemyWidth);
              eStartY=random(140,height-enemyHeight); 
              for(int i=0;i<5;i++)
              {
                 ex[i]=eStartX+(enemyWidth+spacing)*i;
                 ey[i]=eStartY-30*i;
              }
              stateGame=RUN2;
            }
            break;
           case RUN2:
             for(int i=0;i<5;i++)
            {
              if(fx-ex[i]<61&&ex[i]-fx<51)
              {
                 if(fy-ey[i]<61&&ey[i]-fy<51)
                 {
                   ex[i]=width;
                   hpx-=hpSpace;
                 }
              }
              image(enemy,ex[i],ey[i]);
            }
            for(int i=0;i<5;i++)
            {
              ex[i]+=2;
            }
            if(ex[0]>width&&ex[1]>width&&ex[2]>width&&ex[3]>width&&ex[4]>width)
            {
              eStartX=-5*enemyWidth;
              eStartY=random(0,175);
              for(int i=0;i<5;i++)
              {
                  ex[i]=eStartX+enemyWidth*i;
                  if(i<=2)
                  {
                    ey1[i]=eStartY+(2+i)*enemyHeight;
                    ey2[i]=eStartY+(2-i)*enemyHeight;
                  }
                  if(i>2)
                  {
                    ey1[i]=eStartY+(i/2)*enemyHeight;
                    ey2[i]=eStartY+(6-i)*enemyHeight;
                  }
               }
              stateGame=RUN3;
            }
            break;
            case RUN3:
                for(int i=0;i<5;i++)
                {                  
                  if(fx-ex[i]<61&&ex[i]-fx<51)
                  {
                     if(fy-ey1[i]<61&&ey1[i]-fy<51)
                     {
                         ey1[i]=height;
                         hpx-=hpSpace;
                     }
                  }
                  if(fx-ex[i]<61&&ex[i]-fx<51)
                  {
                     if(fy-ey2[i]<61&&ey2[i]-fy<51)
                     {
                         ey2[i]=height;
                         hpx-=hpSpace;
                     }
                  }
                  image(enemy,ex[i],ey1[i]);
                  image(enemy,ex[i],ey2[i]);
                }
                for(int i=0;i<5;i++)
               {
                  ex[i]+=2;
               }
               if(ex[0]>width||(ey1[0]>height&&ey1[1]>height&&ey1[2]>height&&ey1[3]>height&&ey1[4]>height&&
               ey2[0]>height&&ey2[1]>height&&ey2[2]>height&&ey2[3]>height&&ey2[4]>height))
               {
                 eStartX=-5*(spacing+enemyWidth);
                 eStartY=random(0,height-enemyHeight); 
                 for(int i=0;i<5;i++)
                 {
                      ex[i]=eStartX+(enemyWidth+spacing)*i;
                      eStartY=random(0,height-enemyHeight);
                 }
                 stateGame=RUN1;
               }
               break;
        }
        //rect
        fill(255,0,0);
        rect(41,23,hpx,20);
        //hp
        image(hp,30,20);
        break;
      }
    //---------------
    case GAME_LOSE:
      image(end2,0,0);
      if(mouseX>205&&mouseX<438)
      {
        if(mouseY>307&&mouseY<349)
        {
          image(end2,0,0);
          if(mousePressed)
            state=GAME_START;
        }
      }
      break;
  } 
}


void keyPressed()
{
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP:
        upPressed=true;
        break;
      case DOWN:
        downPressed=true;
        break;
      case RIGHT:
        rightPressed=true;
        break;
      case LEFT:
        leftPressed=true;
         break;
    }
  }
}
void keyReleased()
{
  if(key==CODED)
  {
    switch(keyCode)
    {
      case UP:
        upPressed=false;
        break;
      case DOWN:
        downPressed=false;
        break;
      case RIGHT:
        rightPressed=false;
        break;
      case LEFT:
        leftPressed=false;
         break;
    }
  }
}
