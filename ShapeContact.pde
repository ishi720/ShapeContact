Block [] pb;
BlockPoint p;
int mark = 0;//マーク

void setup() {
  size(800, 800);//画面のサイズ
  frameRate(50);//フレームレート

  pb = new Block[6];
  pb[0] = new BlockCircle(200, 300, 30);
  pb[1] = new BlockCircle(200, 600, 30);
  pb[2] = new BlockSquare(400, 300, 30);
  pb[3] = new BlockSquare(400, 600, 30);
  pb[4] = new BlockTriangle(600, 300, 30);
  pb[5] = new BlockTriangle(600, 600, 30);

  p = new BlockPoint(mouseX, mouseY, 1);
}

void draw() {
  background(255);
  noStroke();

  //マウスポインタの更新
  p.update();

  //当たっていない時の判定
  for (int i = 0; i<pb.length; i++) {
    pb[i].iscol = false;
  }
  //当たっている時の判定
  for (int i = 0; i < pb.length; i++) {
    for (int j = 0; j < pb.length; j++) {
      if (i != j) {
        if (pb[i].col(pb[j]) == true) {
          pb[i].iscol = true;
          pb[j].iscol = true;
        }
      }
    }
  }
  //形の表示
  for (int i = 0; i < pb.length; i++) {
    pb[i].show();
  }
}
//形をマークする
void mousePressed() {
  for (int i = 0; i < pb.length; i++) {
    if (pb[i].col(p) == true) {
      mark=i+1;
    }
  }
}
//マークしている形を動かす
void mouseDragged() {
  for (int i = 0; i < pb.length; i++) {
    if (mark == i+1) {
      pb[i].update();
    }
  }
}
//マークを空にする
void mouseReleased() {
  mark = 0;
}
