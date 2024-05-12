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
    vt1 = new PVector(this.point.x, this.point.y - this.size);
    vt2 = new PVector(this.point.x - this.size, this.point.y + this.size);
    vt3 = new PVector(this.point.x + this.size, this.point.y + this.size);
  }

  /**
   * ブロックの位置を更新
   */
  void update() {
    super.update();
    vt1.x = this.point.x;
    vt1.y = this.point.y - this.size;
    vt2.x = this.point.x - this.size;
    vt2.y = this.point.y + this.size;
    vt3.x = this.point.x + this.size;
    vt3.y = this.point.y + this.size;
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
   * 三角形と点の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colTP(BlockPoint b) {
    PVector ma0 = PVector.sub(vt1, b.point);
    PVector mb0 = PVector.sub(vt2, b.point);
    PVector mc0 = PVector.sub(vt3, b.point);

    // 各頂点へのベクトル間の角度を調べて合計
    float angleSum0 = PVector.angleBetween(ma0, mb0) + PVector.angleBetween(mb0, mc0) + PVector.angleBetween(mc0, ma0);

    // およそ(誤差を考慮して)360度ならば内側、それ以外は外側
    if ((abs(angleSum0 - PI * 2) < 0.1)) {
      return true;
    } else {
      return false;
    }
  }

  //三角
  private boolean colTT(BlockTriangle b) {
    PVector ma0 = PVector.sub(vt1, b.vt1);
    PVector mb0 = PVector.sub(vt2, b.vt1);
    PVector mc0 = PVector.sub(vt3, b.vt1);

    PVector ma1 = PVector.sub(vt1, b.vt2);
    PVector mb1 = PVector.sub(vt2, b.vt2);
    PVector mc1 = PVector.sub(vt3, b.vt2);

    PVector ma2 = PVector.sub(vt1, b.vt3);
    PVector mb2 = PVector.sub(vt2, b.vt3);
    PVector mc2 = PVector.sub(vt3, b.vt3);


    // 各頂点へのベクトル間の角度を調べて合計
    float angleSum0 = PVector.angleBetween(ma0, mb0) + PVector.angleBetween(mb0, mc0) + PVector.angleBetween(mc0, ma0);
    float angleSum1 = PVector.angleBetween(ma1, mb1) + PVector.angleBetween(mb1, mc1) + PVector.angleBetween(mc1, ma1);
    float angleSum2 = PVector.angleBetween(ma2, mb2) + PVector.angleBetween(mb2, mc2) + PVector.angleBetween(mc2, ma2);

    // およそ(誤差を考慮して)360度ならば内側、それ以外は外側
    if ((abs(angleSum0 - PI * 2) < 0.1)
      || (abs(angleSum1 - PI * 2) < 0.1)
      || (abs(angleSum2 - PI * 2) < 0.1)) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * 三角形と四角形の当たり判定
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  private boolean colTS(BlockSquare b) {
    PVector ma0 = PVector.sub(vt1, b.vs1);
    PVector mb0 = PVector.sub(vt2, b.vs1);
    PVector mc0 = PVector.sub(vt3, b.vs1);

    PVector ma1 = PVector.sub(vt1, b.vs2);
    PVector mb1 = PVector.sub(vt2, b.vs2);
    PVector mc1 = PVector.sub(vt3, b.vs2);

    PVector ma2 = PVector.sub(vt1, b.vs3);
    PVector mb2 = PVector.sub(vt2, b.vs3);
    PVector mc2 = PVector.sub(vt3, b.vs3);

    PVector ma3 = PVector.sub(vt1, b.vs4);
    PVector mb3 = PVector.sub(vt2, b.vs4);
    PVector mc3 = PVector.sub(vt3, b.vs4);

    // 各頂点へのベクトル間の角度を調べて合計
    float angleSum0 = PVector.angleBetween(ma0, mb0) + PVector.angleBetween(mb0, mc0) + PVector.angleBetween(mc0, ma0);
    float angleSum1 = PVector.angleBetween(ma1, mb1) + PVector.angleBetween(mb1, mc1) + PVector.angleBetween(mc1, ma1);
    float angleSum2 = PVector.angleBetween(ma2, mb2) + PVector.angleBetween(mb2, mc2) + PVector.angleBetween(mc2, ma2);
    float angleSum3 = PVector.angleBetween(ma3, mb3) + PVector.angleBetween(mb3, mc3) + PVector.angleBetween(mc3, ma3);

    // およそ(誤差を考慮して)360度ならば内側、それ以外は外側
    if ((abs(angleSum0 - PI * 2) < 0.1)
      || (abs(angleSum1 - PI * 2) < 0.1)
      || (abs(angleSum2 - PI * 2) < 0.1)
      || (abs(angleSum3 - PI * 2) < 0.1)) {
      return true;
    } else {
      return false;
    }
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
