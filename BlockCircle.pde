/**
 * ブロッククラスを継承した円クラス
 */
class BlockCircle extends Block {

  /**
   * 円を生成
   * @param x x座標
   * @param y y座標
   * @param size サイズ
   */
  BlockCircle(int x, int y, int size) {
    super(x, y, size);
  }

  boolean isColliding(Block b) {
    if (b instanceof BlockPoint) {
      return colCP((BlockPoint)b);
    } else if (b instanceof BlockCircle) {
      return colCC((BlockCircle)b);
    } else if (b instanceof BlockSquare) {
      return colCS((BlockSquare)b);
    } else if (b instanceof BlockTriangle) {
      return colCT((BlockTriangle)b);
    } else {
      return false;
    }
  }

  //点
  private boolean colCP(BlockPoint b) {
    return this.point.dist(b.point) <= this.size;
  }

  //円
  private boolean colCC(BlockCircle b) {
    return this.point.dist(b.point) <= this.size + b.size;
  }

  //四角
  private boolean colCS(BlockSquare b) {
    PVector vs1, vs2, vs3, vs4;

    vs1 = new PVector(b.point.x-this.size, b.point.y-this.size);
    vs2 = new PVector(b.point.x+this.size, b.point.y-this.size);
    vs3 = new PVector(b.point.x-this.size, b.point.y+this.size);
    vs4 = new PVector(b.point.x+this.size, b.point.y+this.size);

    if ((this.point.dist(vs1)<=this.size)
      ||(this.point.dist(vs2)<=this.size)
      ||(this.point.dist(vs3)<=this.size)
      ||(this.point.dist(vs4)<=this.size)) {
      return true;
    } else {
      return false;
    }
  }

  //三角
  private boolean colCT(BlockTriangle b) {
    PVector vt1, vt2, vt3;

    vt1 = new PVector(b.point.x, b.point.y - this.size);
    vt2 = new PVector(b.point.x - this.size, b.point.y + this.size);
    vt3 = new PVector(b.point.x + this.size, b.point.y + this.size);

    if ((this.point.dist(vt1)<=this.size)
      ||(this.point.dist(vt2)<=this.size)
      ||(this.point.dist(vt3)<=this.size)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * ブロックを表示
   */
  void show() {
    if (isColliding) {
      fill(0, 0, 0);
    } else {
      fill(255, 0, 0);
    }
    ellipse(this.point.x, this.point.y, this.size * 2, this.size * 2);
  }
}
