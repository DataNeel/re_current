
class Loop {
    Note latest;
    int noteCount =0;
    int totalNotes;

    Loop(int noteCount) {
        this.noteCount = noteCount;
        this.totalNotes = 0;
    }

    int loopNotes() {
        return min(this.noteCount, this.totalNotes);
    }
    float[] times() {
        if (totalNotes > 0) {
            int valuesLength = this.loopNotes();
            float[] values = new float[valuesLength];
            Note currentNote = this.latest;
            for (int i = 0; i < valuesLength; i++) {
                values[i] = currentNote.time;
                currentNote = currentNote.previous;
            }
            return values;
        } else {
            return new float[] {-1000};
        }
    }

    float[] velocities() {
        if (totalNotes > 0) {
            int valuesLength = this.loopNotes();
            float[] values = new float[valuesLength];
            Note currentNote = this.latest;
            for (int i = 0; i < valuesLength; i++) {
                values[i] = currentNote.updateGet();
                currentNote = currentNote.previous;
            }
            return values;
        } else {
            return new float[] {-1000};
        }
    }

    void add(float time, float velocity) {
        if (this.latest == null) {
            this.latest = new Note(time, velocity);
        }
        else {
            Note old_latest = this.latest;
            this.latest = new Note(time, velocity);
            this.latest.previous = old_latest;
        }
        this.totalNotes++;
    }

    void clear() {
        if (totalNotes > 0) {
            int valuesLength = this.loopNotes();
            Note currentNote = this.latest;
            for (int i = 0; i < valuesLength; i++) {
                currentNote.dim();
                currentNote = currentNote.previous;
            }
        }
    }

    boolean event() {
        boolean event = false;
        if (totalNotes > 0) {
            int valuesLength = this.loopNotes();
            Note currentNote = this.latest;
            for (int i = 0; i < valuesLength; i++) {
                //println(timer.recentTime, timer.previousTime, timer.deltaT, (timer.recentTime - timer.previousTime) * timer.deltaT);
                if (currentNote.velocity.targetValue == 1. && currentNote.time <= timer.loopLocation && currentNote.time > timer.loopLocation - (timer.recentTime - timer.previousTime) * timer.deltaT) {
                    event = true;
                }
                currentNote = currentNote.previous;
            }
        }
        return event;
    }
}
