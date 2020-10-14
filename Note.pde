class Note {
    float time;
    Param velocity;
    Note previous;

    Note(float time, float velocity) {
        this.time = time;
        this.velocity = new Param(0,0,10);
        this.velocity.target(velocity);
    }

    void dim() {
        this.velocity.target(0);
    }


    float updateGet() {
        return this.velocity.updateGet();
    }

    float get() {
        return this.velocity.get();
    }

}
