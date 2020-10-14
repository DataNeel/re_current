class Param{
    //the current value and range of potential values
    float value;
    float min;
    float max;

    //variables used for targeting
    float targetValue;
    float targetSetTime;
    float targetTime;
    float previousValue;
    float movement_time = .5;

    Param(float value, float min, float max) {
        this.value = value;
        this.min = min;
        this.max = max;
        this.targetValue = value;
        this.targetTime = timer.T;
        this.targetSetTime = timer.T;
    }

    void reset(float value, float min, float max) {
        this.value = value;
        this.min = min;
        this.max = max;
        this.targetValue = value;
        this.targetTime = timer.T;
        this.targetSetTime = timer.T;
    }

    void set(float value) {
        this.value = value;
        this.targetValue = value;
        this.targetTime = timer.T;
    }

    void target(float targetValue) {
        //calculates how big of a change we're making as a percentage of the full range
        float targetDiffPct = abs(targetValue - this.value)/abs(this.max-this.min);

        this.targetValue = targetValue;
        this.targetSetTime = timer.T;
        this.targetTime = timer.T + (.5 + .5*targetDiffPct)*PI * this.movement_time;
        this.previousValue = this.value;
    }

    void update() {
        if (this.targetTime >= timer.T) {
            float timePCT = (timer.T-this.targetSetTime)/(this.targetTime-this.targetSetTime);
            this.value = lerp(this.previousValue, this.targetValue, timePCT);
        }
        else {
            this.value = this.targetValue;
        }
    }

    float get() {
        return this.value;
    }

    float updateGet() {
        if (this.value != this.targetValue) {
            this.update();
        }
        return this.value;
    }
}
