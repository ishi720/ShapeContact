/**
 * ブロッククラスを継承した円クラス
 */
class BlockCircle extends Block {

  BlockCircle(int px, int py, int bs) {
    super(px, py, bs);
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
    }
    return false;
  }

  //点
  boolean colCP(BlockPoint b) {
    PVector p;
    p = new PVector(b.vp.x, b.vp.y);

    if (vp.dist(p) <= this.size) {
      return true;
    }
    return false;
  }

  //円
  boolean colCC(BlockCircle b) {
    if (vp.dist(b.vp) <= this.size + b.size) {
      return true;
    }
    return false;
  }

  //四角
  boolean colCS(BlockSquare b) {
    PVector vs1, vs2, vs3, vs4;

    vs1 = new PVector(b.vp.x-this.size, b.vp.y-this.size);
    vs2 = new PVector(b.vp.x+this.size, b.vp.y-this.size);
    vs3 = new PVector(b.vp.x-this.size, b.vp.y+this.size);
    vs4 = new PVector(b.vp.x+this.size, b.vp.y+this.size);

    if ((vp.dist(vs1)<=this.size)
      ||(vp.dist(vs2)<=this.size)
      ||(vp.dist(vs3)<=this.size)
      ||(vp.dist(vs4)<=this.size)) {
      return true;
    }
    return false;
  }

  //三角
  boolean colCT(BlockTriangle b) {
    PVector vt1, vt2, vt3;

    vt1 = new PVector(b.vp.x, b.vp.y - this.size);
    vt2 = new PVector(b.vp.x - this.size, b.vp.y + this.size);
    vt3 = new PVector(b.vp.x + this.size, b.vp.y + this.size);

    if ((vp.dist(vt1)<=this.size)
      ||(vp.dist(vt2)<=this.size)
      ||(vp.dist(vt3)<=this.size)) {
      return true;
    }
    return false;
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
    ellipse(vp.x, vp.y, this.size*2, this.size*2);
  }
}
