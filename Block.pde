class Block {
  int bsize;//形のサイズ
  PVector vp;//位置
  boolean iscol=false;
  
  Block(int px, int py, int bs) {
    vp=new PVector(px, py);
    bsize=bs;
  }

  void update() {
    vp.x=mouseX;
    vp.y=mouseY;

    if (vp.y<0) {
      vp.y=0;
    }//上の限界
    if (vp.y>height) {
      vp.y=height;
    }//下の限界
    if (vp.x<0) {
      vp.x=0;
    }//左の限界
    if (vp.x>width) {
      vp.x=width;
    }//右の限界
  }

  void show() {
  }

  boolean col(Block b) {//当たり判定
    return false;
  }
}
