class TapTempo {
    Loop frameLoop;
    float T = 0;
    float deltaT = 0.0005;
    float loopLocation = 0;
    long previousTime;
    long recentTime;

    TapTempo() {
        this.frameLoop = new Loop(2);
        this.previousTime = millis();
    }

    void tap() {
        if (this.frameLoop.totalNotes == 0) {
            this.frameLoop.add(millis(), 127.);

        }
        else if (this.frameLoop.latest.time < millis()-2000) {
            this.frameLoop = new Loop(2);
            this.frameLoop.add(millis(), 127.);

        }
        else {
            this.frameLoop.add(millis(), 127.);
            float[] times = this.frameLoop.times();
            float timeDiff = (times[0]-times[1]);
            this.deltaT = .125/timeDiff;

        }
    }

    void update() {
        this.previousTime = this.recentTime;
        this.recentTime = millis();
        this.T += (this.recentTime - this.previousTime) * this.deltaT;
        this.loopLocation = this.T%1.;
    }


}
