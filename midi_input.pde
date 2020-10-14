boolean debug1 = true;
boolean debug2 = true;
boolean debug3 = true;
boolean debug4 = true;

void noteOn(int channel, int pitch, int velocity) {
    //main buttons
    if (channel == 0 && pitch > 35) {
        if (loopClear == 0) {
            midiVals[channel][pitch].add(timer.loopLocation, float(velocity)/127.0);
        }
        else {
            midiVals[channel][pitch].clear();
        }

    }
    //tap tempo
    else if (channel == 0 && pitch == 35) {
        timer.tap();
    }
    //loop clear
    else if (channel == 0 && pitch == 34) {
        loopClear = 1;
    }
    //color shift
    else if (channel == 0 && pitch == 33) {
        palette.shift();
    }
    if (pitch == 48) {
        println("noiseDemo");
        noiseDemo_setup();
        visual = 0;
    }
    if (pitch == 52) {

    }
    if (pitch == 56) {

    }
    else if (channel == 4) {
        if (pitch >= 32 && pitch <= 40) {
            palette.targetPalette(pitch-32);
        }
        if (pitch ==47) {
            palette.shift();
        }
        if (pitch == 51) {
            debug1 = !debug1;
        }
        if (pitch == 55) {
            debug2 = !debug2;
        }
        if (pitch == 59) {
            debug3 = !debug3;
        }
        if (pitch == 63) {
            debug4 = !debug4;
        }
    }

}

void noteOff(int channel, int pitch, int velocity) {
    if (channel == 0 && pitch == 34) {
        loopClear = 0;
    }
}

void controllerChange(ControlChange change) {
  // Receive a change.channel, number, value
    float new_val = map(change.value, 0, 127, controllerVals[change.channel][change.number].min, controllerVals[change.channel][change.number].max);
    controllerVals[change.channel][change.number].target(new_val);
}
