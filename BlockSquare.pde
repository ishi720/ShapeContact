/**
 * ブロッククラスを継承した四角形クラス
 */
class BlockSquare extends Block {
  PVector vs1, vs2, vs3, vs4;
  /**
   * 四角形を生成
   * @param x x座標
   * @param y y座標
   * @param size サイズ
   */
  BlockSquare(int x, int y, int size) {
    super(x, y, size);
    vs1 = new PVector(this.point.x - this.size, this.point.y - this.size);
    vs2 = new PVector(this.point.x + this.size, this.point.y - this.size);
    vs3 = new PVector(this.point.x - this.size, this.point.y + this.size);
    vs4 = new PVector(this.point.x + this.size, this.point.y + this.size);
  }

  /**
   * ブロックの位置を更新
   */
  void update() {
    super.update();
    vs1.x = this.point.x - this.size;
    vs1.y = this.point.y - this.size;
    vs2.x = this.point.x + this.size;
    vs2.y = this.point.y - this.size;
    vs3.x = this.point.x - this.size;
    vs3.y = this.point.y + this.size;
    vs4.x = this.point.x + this.size;
    vs4.y = this.point.y + this.size;
  }

  /**
   * 他ブロックとの当たり判定を行う
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  boolean isColliding(Block b) {
    if (b instanceof BlockPoint) {
      return colSP((BlockPoint)b);
    } else if (b instanceof BlockCircle) {
      return colSC((BlockCircle)b);
    } else if (b instanceof BlockSquare) {
      return colSS((BlockSquare)b);
    } else if (b instanceof BlockTriangle) {
      return colST((BlockTriangle)b);
    } else {
      return false;
    }
  }

  /**
   * 四角形と点の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colSP(BlockPoint b) {
    if (vs1.x <= b.point.x && vs4.x >= b.point.x && vs1.y <= b.point.y && vs4.y >= b.point.y) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 四角形と四角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colSS(BlockSquare b) {
    if ((this.point.x-this.size>=b.vs1.x && this.point.x-this.size<=b.vs4.x && this.point.y-this.size>=b.vs1.y && this.point.y-this.size<=b.vs4.y)
      ||(this.point.x+this.size>=b.vs1.x && this.point.x+this.size<=b.vs4.x && this.point.y-this.size>=b.vs1.y && this.point.y-this.size<=b.vs4.y)
      ||(this.point.x-this.size>=b.vs1.x && this.point.x-this.size<=b.vs4.x && this.point.y+this.size>=b.vs1.y && this.point.y+this.size<=b.vs4.y)
      ||(this.point.x+this.size>=b.vs1.x && this.point.x+this.size<=b.vs4.x && this.point.y+this.size>=b.vs1.y && this.point.y+this.size<=b.vs4.y)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 四角形と三角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colST(BlockTriangle b) {
    if ((b.vt1.x>=vs1.x && b.vt1.y>=vs1.y && b.vt1.x<=vs4.x && b.vt1.y<=vs4.y)
      ||(b.vt2.x>=vs1.x && b.vt2.y>=vs1.y && b.vt2.x<=vs4.x && b.vt2.y<=vs4.y)
      ||(b.vt3.x>=vs1.x && b.vt3.y>=vs1.y && b.vt3.x<=vs4.x && b.vt3.y<=vs4.y)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 四角形と円の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colSC(BlockCircle b) {
    PVector LA, LB, LC, LD;//四角の隅
    PVector L1, L2, L3, L4;//四角の辺

    LA = new PVector(b.point.x-vs1.x, b.point.y-vs1.y);
    LB = new PVector(b.point.x-vs2.x, b.point.y-vs2.y);
    LC = new PVector(b.point.x-vs3.x, b.point.y-vs3.y);
    LD = new PVector(b.point.x-vs4.x, b.point.y-vs4.y);
    L1 = new PVector(vs1.x-vs2.x, vs1.y-vs2.y);
    L2 = new PVector(vs2.x-vs4.x, vs2.y-vs4.y);
    L3 = new PVector(vs4.x-vs3.x, vs4.y-vs3.y);
    L4 = new PVector(vs3.x-vs1.x, vs3.y-vs1.y);

    if (( ((b.point.dist(vs1)*sin(PVector.angleBetween(LA, L1))) <=this.size)
      && (b.point.x>=vs1.x-this.size) && (b.point.x<=vs2.x+this.size)
      && (b.point.y>=vs1.y-this.size) && (b.point.y<=vs2.y+this.size)
      ||((b.point.dist(vs2)*sin(PVector.angleBetween(LB, L2))) <=this.size)
      && (b.point.x>=vs2.x-this.size) && (b.point.x<=vs4.x+this.size)
      && (b.point.y>=vs2.y-this.size) && (b.point.y<=vs4.y+this.size)
      ||((b.point.dist(vs3)*sin(PVector.angleBetween(LC, L3))) <=this.size)
      && (b.point.x>=vs3.x-this.size) && (b.point.x<=vs4.x+this.size)
      && (b.point.y>=vs3.y-this.size) && (b.point.y<=vs4.y+this.size)
      ||((b.point.dist(vs1)*sin(PVector.angleBetween(LA, L4))) <=this.size)
      && (b.point.x>=vs1.x-this.size) && (b.point.x<=vs3.x+this.size)
      && (b.point.y>=vs1.y-this.size) && (b.point.y<=vs3.y+this.size)
      )) {
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
      fill(0, 255, 0);
    }
    rect(this.point.x - this.size, this.point.y - this.size, 2 * this.size, 2 * this.size);
  }
}
