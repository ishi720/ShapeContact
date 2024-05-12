/**
 * ブロッククラス
 */
class Block {
  int size; // 形のサイズ
  PVector point; // 位置
  boolean isColliding = false; // 衝突フラグ

  /**
   * ブロックを生成
   * @param x ブロックのx座標
   * @param y ブロックのy座標
   * @param size ブロックの形のサイズ
   */
  Block(int x, int y, int size) {
    this.point = new PVector(x, y);
    this.size = size;
  }

  /**
   * ブロックの位置を更新
   * constrain()を使用して、ブロックが画面内に留まるように制御
   */
  void update() {
    this.point.x = constrain(mouseX, 0, width);
    this.point.y = constrain(mouseY, 0, height);
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
