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

  /**
   * 他ブロックとの当たり判定を行う
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
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

  /**
   * 円と点の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colCP(BlockPoint b) {
    return this.point.dist(b.point) <= this.size;
  }

  /**
   * 円と円の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colCC(BlockCircle b) {
    return this.point.dist(b.point) <= this.size + b.size;
  }

  /**
   * 円と四角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colCS(BlockSquare b) {
    PVector vs1, vs2, vs3, vs4;

    vs1 = new PVector(b.point.x - this.size, b.point.y - this.size);
    vs2 = new PVector(b.point.x + this.size, b.point.y - this.size);
    vs3 = new PVector(b.point.x - this.size, b.point.y + this.size);
    vs4 = new PVector(b.point.x + this.size, b.point.y + this.size);

    if (
      (this.point.dist(vs1) <= this.size) ||
      (this.point.dist(vs2) <= this.size) ||
      (this.point.dist(vs3) <= this.size) ||
      (this.point.dist(vs4) <= this.size)
    ) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 円と三角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colCT(BlockTriangle b) {
    PVector vt1, vt2, vt3;

    vt1 = new PVector(b.point.x, b.point.y - this.size);
    vt2 = new PVector(b.point.x - this.size, b.point.y + this.size);
    vt3 = new PVector(b.point.x + this.size, b.point.y + this.size);

    if (
      (this.point.dist(vt1) <= this.size) ||
      (this.point.dist(vt2) <= this.size) ||
      (this.point.dist(vt3) <= this.size)
    ) {
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
