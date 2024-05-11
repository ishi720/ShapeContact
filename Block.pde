class Block {
  int bsize;//形のサイズ
  PVector vp;//位置
  boolean iscol=false;

  Block(int px, int py, int bs) {
    vp=new PVector(px, py);
    bsize=bs;
  }

  // ブロック位置の更新
  // constrain()を使用して、ブロックが画面内に留まるように制限
  void update() {
    vp.x = constrain(mouseX, 0, width);
    vp.y = constrain(mouseY, 0, height);
  }

  void show() {
  }

  boolean col(Block b) {//当たり判定
    return false;
  }
}
