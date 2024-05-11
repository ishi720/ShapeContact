class BlockSquare extends Block {
  PVector vs1, vs2, vs3, vs4;

  BlockSquare(int px, int py, int bs) {
    super(px, py, bs);
    vs1=new PVector(vp.x-bsize, vp.y-bsize);
    vs2=new PVector(vp.x+bsize, vp.y-bsize);
    vs3=new PVector(vp.x-bsize, vp.y+bsize);
    vs4=new PVector(vp.x+bsize, vp.y+bsize);
  }

  void update() {
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

  boolean isColliding(Block b) {
    if (b instanceof BlockPoint) {
      return colSP((BlockPoint)b);
    } else if (b instanceof BlockCircle) {
      return colSC((BlockCircle)b);
    } else if (b instanceof BlockSquare) {
      return colSS((BlockSquare)b);
    } else if (b instanceof BlockTriangle) {
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

    if (isColliding) {
      fill(0, 0, 0);
    } else {
      fill(0, 255, 0);
    }
    rect(vp.x-bsize, vp.y-bsize, 2*bsize, 2*bsize);
  }
}
