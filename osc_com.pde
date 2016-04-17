///////////LIBRARIES////////////
import oscP5.*;
import netP5.*;

///////////VARIABLES TO SET////////////
OscP5 oscP5;
NetAddress tankLoc;//TANK location
NetAddress gauntletLoc;//GAUNTLET location

boolean handsHolding = false;
float[] gauntletIMU = new float[10];
int gauntletIMUx, gauntletIMUy, gauntletIMUz;
//////////////FUNCTIONS////////////////
void setupOSC() {
  oscP5 = new OscP5(this, 8000);
  tankLoc = new NetAddress("169.254.1.1", 9000);
  gauntletLoc = new NetAddress("169.254.1.2", 9000);

  //sets up holding hands switch on gauntlet
  OscMessage myMessage = new OscMessage("/gauntlet/inputs/mode/digital/8"); //address pattern
  oscP5.send(myMessage, gauntletLoc);
  myMessage = new OscMessage("/gauntlet/inputs/digital/down/8"); //address pattern
  oscP5.send(myMessage, gauntletLoc);
}
//////////////////RECEIVING PROX SENSOR DATA///////////////////////////////
void oscEvent(OscMessage theOscMessage) {
  String addrPattern = theOscMessage.addrPattern();
  //println(addrPattern);
  if (addrPattern.equals("/tank/inputs/analogue")) {
    int proxVal = int(100*(theOscMessage.get(2).floatValue())); //
    println("prox: "+proxVal);
  }

  //handsholding switch: 1 hands holding starts, 0 hands holding ends! 
  if (addrPattern.equals("/gauntlet/inputs/digital")) {
    if (int(theOscMessage.get(7).intValue()) == 1) {
      handsHolding = true;
    } else {
      handsHolding = false;
    }
  }
  //println(handsHolding);//FOR DEBUG

if (addrPattern.equals("/gauntlet/imu")) {
    for (int i = 0; i < gauntletIMU.length; i ++) {
      gauntletIMU[i] = theOscMessage.get(i).floatValue();
    }
    gauntletIMUx = int(gauntletIMU[3]*100);
    gauntletIMUy = int(gauntletIMU[4]*100);
    gauntletIMUz = int(gauntletIMU[5]*100);
   // println("gauntletIMU: "+ gauntletIMUx +", "+ gauntletIMUy +", "+ gauntletIMUz);
  }
} 
//////////////////SENDING NEOPIXEL/EL WIRE COMMANDS////////////////////////////////

void gauntletShow() {
  OscMessage myMessage = new OscMessage("/gauntlet/outputs/rgb/1"); //address pattern
  myMessage.add(gauntletBlob); //puts blob into message
  //println(" myMessage: "+myMessage); //FOR DEBUG
  oscP5.send(myMessage, gauntletLoc);//sends blob over
}

void tankShow() {
  OscMessage myMessage = new OscMessage("/tank/outputs/rgb/11"); //address pattern
  myMessage.add(tankBlob); //puts blob into message
  //println(" myMessage: "+myMessage); //FOR DEBUG
  oscP5.send(myMessage, tankLoc);//sends blob over
}

//OH WHAT A FUCKING MESS
void ELOff() {
  OscMessage myMessage = new OscMessage("/tank/outputs/digital/2"); //address pattern
  myMessage.add(0); 
  println(" myMessage ON: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(100);
  myMessage = new OscMessage("/tank/outputs/digital/2"); //address pattern
  myMessage.add(1);   
  println(" myMessage OFF: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(10);
}

void ELOn() {
  OscMessage myMessage = new OscMessage("/tank/outputs/digital/2"); //address pattern
  myMessage.add(0); 
  println(" myMessage ON: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(500);
  myMessage = new OscMessage("/tank/outputs/digital/2"); //address pattern
  myMessage.add(1);   
  println(" myMessage OFF: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(10);
  myMessage = new OscMessage("/tank/outputs/digital/1"); //address pattern
  myMessage.add(1);   
  println(" myMessage OFF: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(30);
  myMessage = new OscMessage("/tank/outputs/digital/1"); //address pattern
  myMessage.add(0); 
  println(" myMessage ON: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(10);
  myMessage = new OscMessage("/tank/outputs/digital/1"); //address pattern
  myMessage.add(1);   
  println(" myMessage OFF: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(30);
  myMessage = new OscMessage("/tank/outputs/digital/1"); //address pattern
  myMessage.add(0); 
  println(" myMessage ON: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob over
  delay(10);
  myMessage = new OscMessage("/tank/outputs/digital/1"); //address pattern
  myMessage.add(1);   
  println(" myMessage OFF: "+myMessage);
  oscP5.send(myMessage, tankLoc);//sends blob ove
  delay(5000);
}