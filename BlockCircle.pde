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
