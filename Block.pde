/**
 * ブロッククラス
 */
class Block {
  int size; // 形のサイズ
  PVector vp; // 位置
  boolean isColliding = false; // 衝突フラグ

  /**
   * ブロックを生成
   * @param px ブロックのx座標
   * @param py ブロックのy座標
   * @param size ブロックの形のサイズ
   */
  Block(int px, int py, int size) {
    vp = new PVector(px, py);
    this.size = size;
  }

  /**
   * ブロックの位置を更新
   * constrain()を使用して、ブロックが画面内に留まるように制御
   */
  void update() {
    vp.x = constrain(mouseX, 0, width);
    vp.y = constrain(mouseY, 0, height);
  }

  /**
   * ブロックを表示
   */
  void show() {
  }

  /**
   * 他ブロックとの当たり判定を行う
   * @param b 判定対象のブロック
   * @return 当たっている場合はtrue、それ以外の場合はfalse
   */
  boolean isColliding(Block b) {
    return false;
  }
}
