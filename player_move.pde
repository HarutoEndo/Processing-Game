void playerMove(){
  
  goriX += xSpeed;
  goriY += ySpeed;
  
  //gorilla画像切り替え
  if(xSpeed>0){
    image(gorilla_right, int(goriX), int(goriY));
  }
  else{
    image(gorilla_left, int(goriX), int(goriY));
  }
  
  //左右動作
  if (keyPressed && key == CODED) {
    
    if (keyCode == LEFT) {
      xSpeed = -3;
      } 
    else if (keyCode == RIGHT) {
      xSpeed = 3;
    }
    
  }
  
  if(goriX > width - 150) {
    goriX = width - 150;
  } 
  else if (goriX < 0) {
    goriX = 0;
  }

  //ジャンプ処理
  if(goriY < height*5/6) { //空中にいる間y速度増加
    ySpeed += playerGravity;
  } 
  else { //地面に着いたら-ｙ速度0
    ySpeed = 0;
    goriY = height*5/6;
  }
  
}


void keyPressed() {
  
  //ジャンプトリガー
  if(key == ' ' && goriY == height*5/6) {
    
    ySpeed = - legStrength;
    
  }  
    
}
