Block [] pb;
BlockPoint p;
int mark=0;//マーク

void setup() {
  size(800, 800);//画面のサイズ
  frameRate(50);//フレームレート

  pb=new Block[6];
  pb[0] = new BlockCircle(200, 300, 30);
  pb[1] = new BlockCircle(200, 600, 30);
  pb[2] = new BlockSquare(400, 300, 30);
  pb[3] = new BlockSquare(400, 600, 30);
  pb[4] = new BlockTriangle(600, 300, 30);
  pb[5] = new BlockTriangle(600, 600, 30);

  p=new BlockPoint(mouseX, mouseY, 1);
}

void draw() {
  background(255);
  noStroke();

  //マウスポインタの更新
  p.update();

  //当たっていない時の判定
  for (int i=0;i<=5;i++) {
    pb[i].iscol=false;
  }
  //当たっている時の判定
  for (int i=0;i<=5;i++) {
    for (int j=0;j<=5;j++) {
      if (i != j) {
        if (pb[i].col(pb[j])==true) {
          pb[i].iscol=true;
          pb[j].iscol=true;
        }
      }
    }
  }
  //形の表示
  for (int i=0;i<=5;i++) {  
    pb[i].show();
  }
}
//形をマークする
void mousePressed() {
  for (int i=0;i<=5;i++) {  
    if (pb[i].col(p) == true) {
      mark=i+1;
    }
  }
}
//マークしている形を動かす
void mouseDragged() {
  for (int i=0;i<=5;i++) {
    if (mark==i+1) {
      pb[i].update();
    }
  }
}
//マークを空にする
void mouseReleased() {
  mark=0;
}
class Block {
  int bsize;//形のサイズ
  PVector vp;//位置
  boolean iscol=false;
  
  Block(int px, int py, int bs) {
    vp=new PVector(px, py);
    bsize=bs;
  }

  void update() {
    vp.x=mouseX;
    vp.y=mouseY;

    if (vp.y<0) {
      vp.y=0;
    }//上の限界
    if (vp.y>height) {
      vp.y=height;
    }//下の限界
    if (vp.x<0) {
      vp.x=0;
    }//左の限界
    if (vp.x>width) {
      vp.x=width;
    }//右の限界
  }

  void show() {
  }

  boolean col(Block b) {//当たり判定
    return false;
  }
}
class BlockCircle extends Block {

  BlockCircle(int px, int py, int bs) {
    super(px, py, bs);
  }

  boolean col(Block b) {
    if (b instanceof BlockPoint) {
      return colCP((BlockPoint)b);
    }
    else if (b instanceof BlockCircle) {
      return colCC((BlockCircle)b);
    }
    else if (b instanceof BlockSquare) {
      return colCS((BlockSquare)b);
    }
    else if (b instanceof BlockTriangle) {
      return colCT((BlockTriangle)b);
    }
    return false;
  }

  //点
  boolean colCP(BlockPoint b) {
    PVector p;
    p=new PVector(b.vp.x, b.vp.y);

    if (vp.dist(p)<=bsize) {
      return true;
    }
    return false;
  }

  //円
  boolean colCC(BlockCircle b) {
    if (vp.dist(b.vp)<=bsize+b.bsize) {
      return true;
    }
    return false;
  }

  //四角
  boolean colCS(BlockSquare b) {
    PVector vs1, vs2, vs3, vs4;

    vs1=new PVector(b.vp.x-bsize, b.vp.y-bsize);
    vs2=new PVector(b.vp.x+bsize, b.vp.y-bsize);
    vs3=new PVector(b.vp.x-bsize, b.vp.y+bsize);
    vs4=new PVector(b.vp.x+bsize, b.vp.y+bsize);

    if ((vp.dist(vs1)<=bsize)
      ||(vp.dist(vs2)<=bsize)
      ||(vp.dist(vs3)<=bsize)
      ||(vp.dist(vs4)<=bsize)) {
      return true;
    }
    return false;
  }

  //三角
  boolean colCT(BlockTriangle b) {
    PVector vt1, vt2, vt3;

    vt1=new PVector(b.vp.x, b.vp.y-bsize);
    vt2=new PVector(b.vp.x-bsize, b.vp.y+bsize);
    vt3=new PVector(b.vp.x+bsize, b.vp.y+bsize);

    if ((vp.dist(vt1)<=bsize)
      ||(vp.dist(vt2)<=bsize)
      ||(vp.dist(vt3)<=bsize)) {
      return true;
    }
    return false;
  }

  void show() {
    if(iscol==false){
    fill(255, 0, 0);
    }
    else{
      fill(0, 0, 0);
    }
    
    ellipse(vp.x, vp.y, bsize*2, bsize*2);
  }
}
class BlockPoint extends Block {

  BlockPoint(int px, int py, int bs) {
    super(px, py, bs);
  }
}
class BlockSquare extends Block {
  PVector vs1, vs2, vs3, vs4;

  BlockSquare(int px, int py, int bs) {
    super(px, py, bs);
    vs1=new PVector(vp.x-bsize, vp.y-bsize);
    vs2=new PVector(vp.x+bsize, vp.y-bsize);
    vs3=new PVector(vp.x-bsize, vp.y+bsize);
    vs4=new PVector(vp.x+bsize, vp.y+bsize);
  }
  
   void update(){
     super.update();
    vs1.x=vp.x-bsize;
    vs1.y=vp.y-bsize;
    vs2.x=vp.x+bsize;
    vs2.y=vp.y-bsize;
    vs3.x=vp.x-bsize;
    vs3.y=vp.y+bsize;
    vs4.x=vp.x+bsize;
    vs4.y=vp.y+bsize;
  }
  
  boolean col(Block b){
  if(b instanceof BlockPoint){
    return colSP((BlockPoint)b);
  }
  else if(b instanceof BlockCircle){
    return colSC((BlockCircle)b);
  }
  else if(b instanceof BlockSquare){
    return colSS((BlockSquare)b);
  }
  else if(b instanceof BlockTriangle){
    return colST((BlockTriangle)b);
  }
  return false;
}
  
  //点
  boolean colSP(BlockPoint b) {
    if (vs1.x<=b.vp.x && vs4.x>=b.vp.x && vs1.y<=b.vp.y && vs4.y>=b.vp.y) {
      return true;
    }
    return false;
  }

  //四角
  boolean colSS(BlockSquare b) {
    if ((vp.x-bsize>=b.vs1.x && vp.x-bsize<=b.vs4.x && vp.y-bsize>=b.vs1.y && vp.y-bsize<=b.vs4.y)
      ||(vp.x+bsize>=b.vs1.x && vp.x+bsize<=b.vs4.x && vp.y-bsize>=b.vs1.y && vp.y-bsize<=b.vs4.y)
      ||(vp.x-bsize>=b.vs1.x && vp.x-bsize<=b.vs4.x && vp.y+bsize>=b.vs1.y && vp.y+bsize<=b.vs4.y)
      ||(vp.x+bsize>=b.vs1.x && vp.x+bsize<=b.vs4.x && vp.y+bsize>=b.vs1.y && vp.y+bsize<=b.vs4.y)) {     
      return true;
    }
    return false;
  }

  //三角
  boolean colST(BlockTriangle b) {
    if ((b.vt1.x>=vs1.x && b.vt1.y>=vs1.y && b.vt1.x<=vs4.x && b.vt1.y<=vs4.y)
      ||(b.vt2.x>=vs1.x && b.vt2.y>=vs1.y && b.vt2.x<=vs4.x && b.vt2.y<=vs4.y)
      ||(b.vt3.x>=vs1.x && b.vt3.y>=vs1.y && b.vt3.x<=vs4.x && b.vt3.y<=vs4.y)) {
      return true;
    }
    return false;
  }

  //円
  boolean colSC(BlockCircle b) {
    PVector LA, LB, LC, LD;//四角の隅
    PVector L1, L2, L3, L4;//四角の辺
    
    LA=new PVector(b.vp.x-vs1.x, b.vp.y-vs1.y);
    LB=new PVector(b.vp.x-vs2.x, b.vp.y-vs2.y);
    LC=new PVector(b.vp.x-vs3.x, b.vp.y-vs3.y);
    LD=new PVector(b.vp.x-vs4.x, b.vp.y-vs4.y);
    L1=new PVector(vs1.x-vs2.x, vs1.y-vs2.y);
    L2=new PVector(vs2.x-vs4.x, vs2.y-vs4.y);
    L3=new PVector(vs4.x-vs3.x, vs4.y-vs3.y);
    L4=new PVector(vs3.x-vs1.x, vs3.y-vs1.y);

    if (( ((b.vp.dist(vs1)*sin(PVector.angleBetween(LA, L1))) <=bsize)
      && (b.vp.x>=vs1.x-bsize) && (b.vp.x<=vs2.x+bsize)
      && (b.vp.y>=vs1.y-bsize) && (b.vp.y<=vs2.y+bsize)
      ||((b.vp.dist(vs2)*sin(PVector.angleBetween(LB, L2))) <=bsize)
      && (b.vp.x>=vs2.x-bsize) && (b.vp.x<=vs4.x+bsize)
      && (b.vp.y>=vs2.y-bsize) && (b.vp.y<=vs4.y+bsize)
      ||((b.vp.dist(vs3)*sin(PVector.angleBetween(LC, L3))) <=bsize)
      && (b.vp.x>=vs3.x-bsize) && (b.vp.x<=vs4.x+bsize)
      && (b.vp.y>=vs3.y-bsize) && (b.vp.y<=vs4.y+bsize)
      ||((b.vp.dist(vs1)*sin(PVector.angleBetween(LA, L4))) <=bsize)
      && (b.vp.x>=vs1.x-bsize) && (b.vp.x<=vs3.x+bsize)
      && (b.vp.y>=vs1.y-bsize) && (b.vp.y<=vs3.y+bsize)
      )) {
      return true;
    }
    return false;
  }
  
  void show() {
    
    if(iscol==false){
    fill(0, 255, 0);
    }
    else{
    fill(0, 0, 0);
    }
    rect(vp.x-bsize, vp.y-bsize, 2*bsize, 2*bsize);
  }
}
class BlockTriangle extends Block {
  PVector vt1, vt2, vt3;//三角の頂点

  BlockTriangle(int px, int py, int bs) {
    super(px, py, bs);
    vt1=new PVector(vp.x, vp.y-bsize);
    vt2=new PVector(vp.x-bsize, vp.y+bsize);
    vt3=new PVector(vp.x+bsize, vp.y+bsize);
  } 
  void update() {
    super.update();
    vt1.x=vp.x;
    vt1.y=vp.y-bsize;
    vt2.x=vp.x-bsize;
    vt2.y=vp.y+bsize;
    vt3.x=vp.x+bsize;
    vt3.y=vp.y+bsize;
  }
   
  boolean col(Block b){
  if(b instanceof BlockPoint){
    return colTP((BlockPoint)b);
  }
  else if(b instanceof BlockCircle){
    return colTC((BlockCircle)b);
  }
  else if(b instanceof BlockSquare){
    return colTS((BlockSquare)b);
  }
  else if(b instanceof BlockTriangle){
    return colTT((BlockTriangle)b);
  }
  return false;
}

  //点
  boolean colTP(BlockPoint b) {
    PVector ma0 = PVector.sub(vt1, b.vp);
    PVector mb0 = PVector.sub(vt2, b.vp);
    PVector mc0 = PVector.sub(vt3, b.vp);

    // 各頂点へのベクトル間の角度を調べて合計  
    float angleSum0 = PVector.angleBetween(ma0, mb0) + PVector.angleBetween(mb0, mc0) + PVector.angleBetween(mc0, ma0);

    // およそ(誤差を考慮して)360度ならば内側、それ以外は外側
    if ((abs(angleSum0 - PI * 2) < 0.1)){
      return true;
    }
    return false;
  }

  //三角
  boolean colTT(BlockTriangle b) {
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
      || (abs(angleSum2 - PI * 2) < 0.1))
      return true;
    return false;
  }

  //四角
  boolean colTS(BlockSquare b) {
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
    }
    return false;
  }


  //円
  boolean colTC(BlockCircle b) {
    PVector lA, lB, lC;
    PVector l1, l2, l3;

    lA=new PVector(b.vp.x-vt1.x, b.vp.y-vt1.y);
    lB=new PVector(b.vp.x-vt2.x, b.vp.y-vt2.y);
    lC=new PVector(b.vp.x-vt3.x, b.vp.y-vt3.y);

    l1=new PVector(vt1.x-vt2.x, vt1.y-vt2.y);
    l2=new PVector(vt2.x-vt3.x, vt2.y-vt3.y);
    l3=new PVector(vt3.x-vt1.x, vt3.y-vt1.y);

    if (( ((b.vp.dist(vt1)*sin(PVector.angleBetween(lA, l1))) <=bsize)
      && (b.vp.x>=vt2.x-bsize) && (b.vp.x<=vt1.x+bsize)
      && (b.vp.y>=vt1.y-bsize) && (b.vp.y<=vt2.y+bsize)
      || ((b.vp.dist(vt2)*sin(PVector.angleBetween(lB, l2))) <=bsize)
      && (b.vp.x>=vt2.x-bsize) && (b.vp.x<=vt3.x+bsize)
      && (b.vp.y>=vt2.y-bsize) && (b.vp.y<=vt3.y+bsize)
      || ((b.vp.dist(vt3)*sin(PVector.angleBetween(lC, l3))) <=bsize)
      && (b.vp.x>=vt1.x-bsize) && (b.vp.x<=vt3.x+bsize)
      && (b.vp.y>=vt1.y-bsize) && (b.vp.y<=vt3.y+bsize)
      )) {
      return true;
    }
    return false;
  }

  void show() {
    if(iscol==false){
    fill(0, 0, 255);
    }
    else{
    fill(0,0,0);
    }
    triangle(vp.x, vp.y-bsize, vp.x-bsize, vp.y+bsize, vp.x+bsize, vp.y+bsize);
  }
}

