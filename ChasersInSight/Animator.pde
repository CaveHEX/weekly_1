class Animator {

  PVector pos;
  String path;
  int nbFrame;
  int frame = 0;
  int speed;
  PImage img[];

  Animator(PVector _pos, String _path, int _nbFrame, int _speed) {
    pos = _pos.copy();
    path = _path;
    nbFrame = _nbFrame;
    speed = _speed;
    img = new PImage[nbFrame];
    this.load();
  }

  void load() {
    for (int i = 0; i < nbFrame; i++) {
      String actualSprite = path + nf(i, 3) + ".png";
      img[i] = loadImage(actualSprite);
    }
  }

  void setScale(float _scale) {
    for (int i = 0; i < nbFrame; i++) {
      img[i].resize(int(img[i].width * _scale), int(img[i].height * _scale));
    }
  }

  void run() {
    image(img[frame%nbFrame], pos.x, pos.y);
    if (frameCount%speed == 0) {
      frame++;
    }
  }
}
