Block[] blocks;
BlockPoint point;
int selectedBlockIndex = 0; // 選択中のブロックのインデックス

void setup() {
    size(800, 800); // 画面のサイズ
    frameRate(50); // フレームレート

    blocks = new Block[6];
    blocks[0] = new BlockCircle(200, 300, 30);
    blocks[1] = new BlockCircle(200, 600, 30);
    blocks[2] = new BlockSquare(400, 300, 30);
    blocks[3] = new BlockSquare(400, 600, 30);
    blocks[4] = new BlockTriangle(600, 300, 30);
    blocks[5] = new BlockTriangle(600, 600, 30);

    point = new BlockPoint(mouseX, mouseY, 1);
}

void draw() {
    background(255);
    noStroke();

    //マウスポインタの更新
    point.update();

    //当たっていない時の判定
    for (int i = 0; i < blocks.length; i++) {
        blocks[i].isColliding = false;
    }
    //当たっている時の判定
    for (int i = 0; i < blocks.length; i++) {
        for (int j = 0; j < blocks.length; j++) {
            if (i != j) {
                if (blocks[i].isColliding(blocks[j])) {
                    blocks[i].isColliding = true;
                    blocks[j].isColliding = true;
                }
            }
        }
    }
    //形の表示
    for (int i = 0; i < blocks.length; i++) {
        blocks[i].show();
    }
}
//形をマークする
void mousePressed() {
    for (int i = 0; i < blocks.length; i++) {
        if (blocks[i].isColliding(point)) {
            selectedBlockIndex = i + 1;
        }
    }
}
//マークしている形を動かす
void mouseDragged() {
    for (int i = 0; i < blocks.length; i++) {
        if (selectedBlockIndex == i + 1) {
            blocks[i].update();
        }
    }
}
//マークを空にする
void mouseReleased() {
    selectedBlockIndex = 0;
}
