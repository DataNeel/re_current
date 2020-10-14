import java.util.Random;

PShader color_shader;

Random generator1;
Random generator2;


int visual;

//midibus
import themidibus.*;
MidiBus myBus;

//syphon
import codeanticode.syphon.*;
SyphonServer server;
PGraphics canvas;
PGraphics canvas1;
PGraphics canvas2;

//knobs
Param[][] controllerVals = new Param[9][128];
Param param1;
Param param2;
Param param3;
Param param4;
Param param5;
Param param6;
Param param7;
Param param8;
Param param9;
Param param10;
Param param11;
Param param12;
Param param13;
Param param14;
Param param15;
Param param16;

//misc variables
float noise_position;
float time2;

//time stuff
TapTempo timer = new TapTempo();
float loopCounter = 0;

//pads
int loopClear = 0;
int loopLength = 8;
Loop[][] midiVals = new Loop[9][128];
Loop loop1;
Loop loop2;
Loop loop3;
Loop loop4;








PShader shader;


float impulse(float k, float x) {
  float h = k * x;
  return h*exp(1-h);
}


void setup() {
    size(1280, 720, P2D);
    visual = 0;
    canvas = createGraphics(1280, 720, P2D);
    canvas1 = createGraphics(1280, 720, P2D);
    canvas2 = createGraphics(1280, 720, P2D);

    generator1 = new Random();
    generator2 = new Random();
    color_shader = loadShader("colors.frag");
    noiseDemo_shader = loadShader("noiseDemo.frag");
    shader = color_shader;


    canvas.noStroke();
    canvas1.noStroke();
    canvas2.noStroke();
    myBus = new MidiBus(this, "Intech Studio: Grid", -1);
    server = new SyphonServer(this,"Processing Syphon");

    palette = new Palette(palettes,0);
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 128; j++) {
            midiVals[i][j] = new Loop(loopLength);
            controllerVals[i][j] = new Param(0,0,1);
        }
    }
    loop1 = midiVals[0][44];
    loop2 = midiVals[0][45];
    loop3 = midiVals[0][46];
    loop4 = midiVals[0][47];

    param1 = controllerVals[0][48];
    param2 = controllerVals[0][52];
    param3 = controllerVals[0][56];
    param4 = controllerVals[0][60];

    param5 = controllerVals[0][49];
    param6 = controllerVals[0][53];
    param7 = controllerVals[0][57];
    param8 = controllerVals[0][61];

    param9 = controllerVals[0][50];
    param10 = controllerVals[0][54];
    param11= controllerVals[0][58];
    param12 = controllerVals[0][62];

    param13 = controllerVals[0][51];
    param14 = controllerVals[0][55];
    param15 = controllerVals[0][59];
    param16 = controllerVals[0][63];



    param2.set(.3);
    param9.set(.5);
    param5.set(0.);


    param13.set(.5);
    param14.set(.5);
    param15.set(.5);
    param16.set(.5);



}


void draw() {
    canvas.shader(shader);
    float[][] colors = palette.getRGB();
    shader.set("u_resolution", float(width), float(height));
    shader.set("u_time", timer.T);
    shader.set("u_c0", colors[0][0],colors[0][1],colors[0][2]);
    shader.set("u_c1", colors[1][0],colors[1][1],colors[1][2]);
    shader.set("u_c2", colors[2][0],colors[2][1],colors[2][2]);
    shader.set("u_c3", colors[3][0],colors[3][1],colors[3][2]);



    canvas.beginDraw();

    if (visual == 0) {
        noiseDemo_draw();
    }

    canvas.endDraw();
    image(canvas,0,0);
    server.sendImage(canvas);
    timer.update();
    text(timer.loopLocation * 4 + 1, 10, 30);
    text(frameRate,20,50);
    noise_position += map(param7.updateGet(),0,1,0,.01);
    time2 += map(param4.updateGet(),0,1,0,0.15);
}
