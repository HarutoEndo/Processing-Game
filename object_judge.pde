boolean isOverlap(float x1, float y1, int w1, int h1, float x2, float y2, int w2, int h2) {    //画像同士の重なりを判定する関数
  return x1 < x2+w2 && x2 < x1+w1 && y1 < y2+h2 && y2 < y1+h1;
}

void bananas_judge() {  //バナナに関する関数

  for (int i=0; i<10; i++) {

    if (!(isOverlap(goriX, goriY, 150, 100, banana1X[i], banana1Y[i], 70, 70)) && banana1Judge[i]==1) {  //ゴリラと重なっていない+バナナ自身がもつ値が１1のとき
      image(banana1, banana1X[i], banana1Y[i]);  //画像を表示
    } 
    else if(banana1Judge[i]==1) {  //始めてゴリラと衝突した時
      banana1Judge[i]=0;  //バナナ自身が持つ値を0にする。
      bananaScore+=15;  //スコアを15獲得
    }

    if (frameCount%1000==100*i) {  //1000フレームに一回、自身の持つ値を1に戻す
      banana1Judge[i]=1;
    }
  }  


  for (int i=0; i<3; i++) {

    if (!(isOverlap(goriX, goriY, 150, 100, banana3X[i], banana3Y[i], 70, 70)) && banana3Judge[i]==1) {
      image(banana3, banana3X[i], banana3Y[i]);
    } 
    else if(banana3Judge[i]==1) {
      banana3Judge[i]=0;
      bananaScore+=50;  //3バナナはスコアを50獲得
    }

    if (frameCount%3000==1000*i) {
      banana3Judge[i]=1;
    }
  } 

  return;
}


void spikeBall_judge() {  //障害物に関する関数



  if ((frameCount-frames)%500==0 && appearance_count<=19) {  //500フレームに1回、画面に表示できる障害物の数を増やす

    appearance_count++;
    
  }

  for (int k=0; k<appearance_count; k++) {  //画面に表示できる障害物の数回for文を実行
 
      if (preBall_frameCount[k]!=0 && (frameCount-frames)-preBall_frameCount[k]>=300) {  //偽障害物が表示されているなら、表示された300フレーム後に
        image(spikeBall, spikeBallX[k], spikeBallY[k]);                                  //障害物を出す
        if(isOverlap(goriX, goriY, 150, 100, spikeBallX[k], spikeBallY[k], 120, 120)){   //もし障害物とゴリラの画像が重なったら
          ScSwitch=3;  //ゲームオーバーページに切り替え
        }
      } 
      else {  //偽障害物が表示されていないなら
        image(preBall, spikeBallX[k], spikeBallY[k]); //偽障害物を表示
        if(preBall_frameCount[k]==0){  //まだ「偽障害物が表示されたフレーム数を保存する配列」に何も代入されてないなら
          preBall_frameCount[k]=frameCount-frames; //偽障害物が表示された時のフレーム数を記録
        }
      }
    }
  


}
