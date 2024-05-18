/**
 * ブロッククラスを継承した三角形クラス
 */
class BlockTriangle extends Block {
  PVector vt1, vt2, vt3;//三角の頂点

  /**
   * 三角形を生成
   * @param x x座標
   * @param y y座標
   * @param size サイズ
   */
  BlockTriangle(int x, int y, int size) {
    super(x, y, size);
    updateVertices();
  }

  /**
   * ブロックの位置を更新
   */
  void update() {
    super.update();
    updateVertices();
  }

  /**
   * 三角形の頂点を更新
   */
  private void updateVertices() {
    vt1 = new PVector(this.point.x, this.point.y - this.size);
    vt2 = new PVector(this.point.x - this.size, this.point.y + this.size);
    vt3 = new PVector(this.point.x + this.size, this.point.y + this.size);
  }

  /**
   * 他ブロックとの当たり判定を行う
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  boolean isColliding(Block b) {
    if (b instanceof BlockPoint) {
      return colTP((BlockPoint)b);
    } else if (b instanceof BlockCircle) {
      return colTC((BlockCircle)b);
    } else if (b instanceof BlockSquare) {
      return colTS((BlockSquare)b);
    } else if (b instanceof BlockTriangle) {
      return colTT((BlockTriangle)b);
    } else {
      return false;
    }
  }

  /**
   * ベクトル間の角度の合計を計算して内外判定を行う
   * @param vectors 判定対象のベクトル
   * @return 内側の場合はtrue、それ以外の場合はfalse
   */
  private boolean checkAngleSum(PVector... vectors) {
    float angleSum = 0;
    for (int i = 0; i < vectors.length; i++) {
      angleSum += PVector.angleBetween(vectors[i], vectors[(i + 1) % vectors.length]);
    }
    return abs(angleSum - PI * 2) < 0.1;
  }

  /**
   * 三角形と点の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colTP(BlockPoint b) {
    return checkAngleSum(PVector.sub(vt1, b.point), PVector.sub(vt2, b.point), PVector.sub(vt3, b.point));
  }

  /**
   * 三角形と三角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colTT(BlockTriangle b) {
    return checkAngleSum(PVector.sub(vt1, b.vt1), PVector.sub(vt2, b.vt1), PVector.sub(vt3, b.vt1)) ||
           checkAngleSum(PVector.sub(vt1, b.vt2), PVector.sub(vt2, b.vt2), PVector.sub(vt3, b.vt2)) ||
           checkAngleSum(PVector.sub(vt1, b.vt3), PVector.sub(vt2, b.vt3), PVector.sub(vt3, b.vt3));
  }

  /**
   * 三角形と四角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colTS(BlockSquare b) {
    return checkAngleSum(PVector.sub(vt1, b.vs1), PVector.sub(vt2, b.vs1), PVector.sub(vt3, b.vs1)) ||
           checkAngleSum(PVector.sub(vt1, b.vs2), PVector.sub(vt2, b.vs2), PVector.sub(vt3, b.vs2)) ||
           checkAngleSum(PVector.sub(vt1, b.vs3), PVector.sub(vt2, b.vs3), PVector.sub(vt3, b.vs3)) ||
           checkAngleSum(PVector.sub(vt1, b.vs4), PVector.sub(vt2, b.vs4), PVector.sub(vt3, b.vs4));
  }

  /**
   * 三角形と円の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colTC(BlockCircle b) {
    PVector lA, lB, lC;
    PVector l1, l2, l3;

    lA = new PVector(b.point.x - vt1.x, b.point.y - vt1.y);
    lB = new PVector(b.point.x - vt2.x, b.point.y - vt2.y);
    lC = new PVector(b.point.x - vt3.x, b.point.y - vt3.y);

    l1 = new PVector(vt1.x - vt2.x, vt1.y - vt2.y);
    l2 = new PVector(vt2.x - vt3.x, vt2.y - vt3.y);
    l3 = new PVector(vt3.x - vt1.x, vt3.y - vt1.y);

    if (( ((b.point.dist(vt1)*sin(PVector.angleBetween(lA, l1))) <=this.size)
      && (b.point.x>=vt2.x-this.size) && (b.point.x<=vt1.x+this.size)
      && (b.point.y>=vt1.y-this.size) && (b.point.y<=vt2.y+this.size)
      || ((b.point.dist(vt2)*sin(PVector.angleBetween(lB, l2))) <=this.size)
      && (b.point.x>=vt2.x-this.size) && (b.point.x<=vt3.x+this.size)
      && (b.point.y>=vt2.y-this.size) && (b.point.y<=vt3.y+this.size)
      || ((b.point.dist(vt3)*sin(PVector.angleBetween(lC, l3))) <=this.size)
      && (b.point.x>=vt1.x-this.size) && (b.point.x<=vt3.x+this.size)
      && (b.point.y>=vt1.y-this.size) && (b.point.y<=vt3.y+this.size)
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
      fill(0, 0, 255);
    }
    triangle(this.point.x, this.point.y - this.size, this.point.x - this.size, this.point.y + this.size, this.point.x + this.size, this.point.y + this.size);
  }
}
