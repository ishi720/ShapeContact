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

  boolean col(Block b) {
    if (b instanceof BlockPoint) {
      return colTP((BlockPoint)b);
    } else if (b instanceof BlockCircle) {
      return colTC((BlockCircle)b);
    } else if (b instanceof BlockSquare) {
      return colTS((BlockSquare)b);
    } else if (b instanceof BlockTriangle) {
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
    if ((abs(angleSum0 - PI * 2) < 0.1)) {
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
    if (iscol==false) {
      fill(0, 0, 255);
    } else {
      fill(0, 0, 0);
    }
    triangle(vp.x, vp.y-bsize, vp.x-bsize, vp.y+bsize, vp.x+bsize, vp.y+bsize);
  }
}