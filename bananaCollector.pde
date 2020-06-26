float goriX = 10, goriY = height*5/6; //gorilla座標
float xSpeed = 0, ySpeed = 0; //速度
float playerGravity = 0.15;   //重力
int legStrength = 8;  //脚力
int bananaScore = 0;  //Score
int frames;  //メインゲームが始まった時のframeCountを記録
float stX=random(1000),stY=random(900),dstX=10,dstY=15; //スタート画面のバナナを動かす
float stX2=random(1000),stY2=random(900),dstX2=-10,dstY2=15; //スタート画面のバナナ(二個目)を動かす
PImage gorilla_right,haikei,gorilla_left,banana1,banana3,spikeBall,preBall,topback; //画像名

//bananaの判定と座標の入れ物
int banana1Judge[]=new int[10];
float banana1X[]=new float[10];
float banana1Y[]=new float[10];

int banana3Judge[]=new int[3];
float banana3X[]=new float[3];
float banana3Y[]=new float[3];

//障害物の座標の入れ物
int preBall_frameCount[]=new int[20];
float spikeBallX[]=new float[20];
float spikeBallY[]=new float[20];

int appearance_count=0; //障害物を画面に何個表示するか

int ScSwitch=0;  //場面切り替え変数


void setup(){
  
  
  frameRate(100);
  fullScreen();
  smooth();
  
  //画像読み込み+リサイズ
  gorilla_right = loadImage("gorilla_right.gif");
  gorilla_right.resize(150,100);
  gorilla_left = loadImage("gorilla_left.png");
  gorilla_left.resize(150,100);
  haikei = loadImage("jangle.jpg");
  haikei.resize(width,height);
  banana1 = loadImage("banana1.png");
  banana1.resize(70,70);
  banana3 = loadImage("banana3.png");
  banana3.resize(70,70);
  spikeBall = loadImage("spikeball.png");
  spikeBall.resize(120,120);
  preBall = loadImage("transparent.png");
  preBall.resize(120,120);
  topback = loadImage("topback.png");
  topback.resize(width,height);
  
  
  //banana1座標,表示判定
  for(int i=0;i<10;i++){
    
    banana1Judge[i]=1;
    banana1X[i]=random(0,width-70);
    banana1Y[i]=random(200,height-70-(height/6));
    
  }
  
  //banana3座標,表示判定
  for(int i=0;i<3;i++){
    
    banana3Judge[i]=1;
    banana3X[i]=random(0,width-70);
    banana3Y[i]=0;
    
  }
  
 
  //障害物の座標
  for(int i=0;i<20;i++){
    
    spikeBallX[i]=random(0,width-120);
    spikeBallY[i]=random(0,height-120-(height/6));
    
  }
  
  
  
  
}

void draw(){
  
  switch(ScSwitch){
  
  //スタート画面
  case 0:
  
  background(topback);
  
  //スタート画面の動くバナナ(二つ)実装
  stX+=dstX;
  stY+=dstY;
  stX2+=dstX2;
  stY2+=dstY2;
  image(banana3,stX,stY);
  image(banana3,stX2,stY2);
  if(stX<0 || stX>width-70){
    dstX=-dstX;
  }
  if(stY<0 || stY>height-70){
    dstY=-dstY;
  }
  if(stX2<0 || stX2>width-70){
    dstX2=-dstX2;
  }
  if(stY2<0 || stY2>height-70){
    dstY2=-dstY2;
  }
  
  //ボタン作成
  fill(0,255,0,150);
  rect(width-400,0,400,200);
  textSize(50);
  fill(255);
  text("INSTRUCTIONS",width-380,120);
  fill(0,255,255,150);
  rect(width-400,200,400,200);
  fill(255);
  text("PRACTICE",width-320,320);
  textSize(100);
  fill(255,0,0,150);
  text("START GAME",650,900);
  
  //説明ページに切り替え
  if(mousePressed && width-400<=mouseX && mouseX<=width && 0<=mouseY && mouseY<=200){
    ScSwitch=1;
  }
  //操作練習ページに切り替え
  else if(mousePressed && width-400<=mouseX && mouseX<=width && 200<=mouseY && mouseY<=400){
    ScSwitch=5;
  }
  //ゲームページに切り替え&&変数初期化
  else if(mousePressed && !(0<=mouseX && mouseX<=400 && 0<=mouseY && mouseY<=200)){
    ScSwitch=2;
    bananaScore=0;
    goriX=0;
    goriY=0;
    appearance_count=0;
    for(int i=0;i<10;i++){
    banana1Judge[i]=1;
    }
    for(int i=0;i<3;i++){
    banana3Judge[i]=1;
    }
    frames=frameCount;
  }
  
  break;
  
  
  //操作説明
  case 1:
  
  background(0,255,0);
  
  fill(255);
  textSize(70);
  text("←  →  :  Move",500,200);
  text("↑ :  LegStrengh,Gravity UP",500,400);
  text("↓ :  LegStrengh,Gravity DOWN",500,600);
  text("space : Jump",500,800);
  
  fill(255,0,0);
  rect(0,0,400,200);
  textSize(50);
  fill(255);
  text("BACK",120,120);
  //スタートページに戻る
  if(mousePressed && 0<=mouseX && mouseX<=400 && 0<=mouseY && mouseY<=200){
    ScSwitch=0;
  }
  
  break;
  
  
  //プレイ画面
  case 2:
    
  background(haikei);
  
  
  // プレイヤー動作
  playerMove();
  keyReleased();
  legStrength();
  
  //プレイヤーとオブジェクトのあたり判定
  bananas_judge();
  spikeBall_judge();
  
  //脚力、重力、スコアの表示
  fill(255,0,0);
  textSize(100);
  if(legStrength==20){
    text("max",150,200);
  }
  else{
    text(legStrength-7,150,200);
  }
  textSize(50);
  text("JumpLevel",100,100);
  
  if(legStrength<=12){
    text("Gravity - Low",width/2-300,100);
  }
  else if(legStrength<=16){
    text("Gravity - Middle",width/2-300,100);
  }
  else{
    text("Gravity - High",width/2-300,100);
  }
  
  text("bananaCount",1400,100);
  text(bananaScore,1500,200);
  
  
  break;
  
  //gameover
  case 3:
  
  background(0);
  fill(255,0,0,150);
  textSize(300);
  text("GAME OVER",100,600);
  textSize(60);
  text("Check Your Score by clicking",500,900);
  //リザルトページに切り替え
  if(mousePressed){
    ScSwitch=4;
  }
  
  break;
  
  
  //リザルト画面
  case 4:
  
  background(0);
  fill(255);
  textSize(150);
  text("Your Score",width/2-400,height/2-100);
  text(bananaScore,width/2-150,height/2+200);
  
  fill(255,0,0,150);
  rect(0,0,400,200);
  textSize(50);
  fill(255);
  text("RESTART",80,120);
  //スタートページに戻る
  if(mousePressed && 0<=mouseX && mouseX<=400 && 0<=mouseY && mouseY<=200){
    ScSwitch=0;
  }
  
  break;
  
  
  //練習モード(実際のゲームとは違い、障害物とスコア表示なし)
  case 5:
  
  background(haikei);
  
  
  fill(255,0,0);
  textSize(100);
  if(legStrength==20){
    text("max",550,200);
  }
  else{
    text(legStrength-7,550,200);
  }
  textSize(50);
  text("JumpLevel",500,100);
  
  if(legStrength<=12){
    text("Gravity - Low",width/2,100);
  }
  else if(legStrength<=16){
    text("Gravity - Middle",width/2,100);
  }
  else{
    text("Gravity - High",width/2,100);
  }
  // プレイヤー動作
  playerMove();
  keyReleased();
  legStrength();
  //プレイヤーとオブジェクトのあたり判定
  bananas_judge();
  
  textSize(220);
  fill(0,0,255,100);
  text("Practice Mode",270,600);
  
  fill(255,0,0,150);
  rect(0,0,400,200);
  textSize(50);
  fill(255);
  text("BACK",120,120);
  //スタートページに戻る
  if(mousePressed && 0<=mouseX && mouseX<=400 && 0<=mouseY && mouseY<=200){
    ScSwitch=0;
  }
  
  break;
  
  }
  
  
}
