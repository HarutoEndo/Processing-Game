void legStrength(){   //脚力,重力強化関数
  if(8<legStrength && legStrength<20){
    
    if (keyPressed && key == CODED) {
      
      if (keyCode == UP) {
        
        legStrength++;              //脚力強化
        playerGravity+=0.01875/2;   //重力強化
        
      } 
      else if (keyCode == DOWN) {
        
        legStrength--;              //脚力強化
        playerGravity-=0.01875/2;   //重力強化
      }
      
    }
    
  }
  else if(legStrength==8){
    
    if (keyPressed && key == CODED) {
      
      if (keyCode == UP) {
        
        legStrength++;
        playerGravity+=0.01875/2;
        
      } 
      
    }
    
  }
  else if(legStrength==20){
    
    if (keyPressed && key == CODED) { 
      
      if (keyCode == DOWN) {
        
        legStrength--;
        playerGravity-=0.01875/2;
        
      }
      
    }
    
  }
  
}
