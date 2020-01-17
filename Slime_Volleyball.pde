import fisica.*;

color blue   = color(29, 178, 242);
color brown  = color(166,120,24);
color green  = color(74,163,57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);

//keyboard booleans
boolean wkey, akey, skey, dkey;

//fisica
FBox lground, lwall, rground, rwall, net;
FCircle lplayer, rplayer, ball;
FWorld world;

//Physics
boolean leftCanJump, rightCanJump;

void setup() {
  size(800, 600);
  
  //init world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 980);

  lground = new FBox(400, 100);
  lground.setFillColor(blue);
  lground.setNoStroke();
  lground.setPosition(200, 550);
  lground.setStatic(true);
  lground.setFriction(0);
  world.add(lground);
  
  rground = new FBox(400, 100);
  rground.setFillColor(red);
  rground.setNoStroke();
  rground.setPosition(600, 550);
  rground.setStatic(true);
  rground.setFriction(0);
  world.add(rground);
  
  net = new FBox(20, 100);
  net.setFill(255);
  net.setNoStroke();
  net.setPosition(400, 450);
  net.setStatic(true);
  world.add(net);
  
  lplayer = new FCircle(100);
  lplayer.setFillColor(red);
  lplayer.setNoStroke();
  lplayer.setPosition(200, 400);
  world.add(lplayer);
  
  rplayer = new FCircle(100);
  rplayer.setFillColor(blue);
  rplayer.setNoStroke();
  rplayer.setPosition(600, 400);
  world.add(rplayer);
}

void draw() {
  background(0);
  
  leftCanJump = false;
  ArrayList<FContact> contacts = lplayer.getContacts();
  
  int i = 0;
  while (i < contacts.size()) {
    FContact c = contacts.get(i);
    if (c.contains(lground)) leftCanJump = true;
    i++;
  }
  
  if (wkey && leftCanJump) lplayer.addImpulse(0,-5000);
  if (akey) lplayer.addImpulse(-100,0);
  if (skey) ;
  if (dkey) lplayer.addImpulse(100,0);
  
  world.step();  //get box2D to calculate all the forces and new positions
  world.draw();  //ask box2D to convert this world to processing screen coordinates and draw
}

void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'd' || key == 'D') dkey = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'd' || key == 'D') dkey = false;
}
