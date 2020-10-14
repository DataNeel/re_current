color[][] palettes = {
    {#07C3C1,#F3E596,#F4B1AC,#673891},
    {#6F113D,#F7F498,#1D1C2A,#62668E},
    {#111111,#98235A,#19BCB7,#532952},
    {#2A2A2A,#DADADA,#A28D60,#792D28},
    {#5A1F41,#3F7A5F,#D6AF3D,#FAF7E7},
    {#020202,#0ffbf9,#cc0f39,#cdc764},
    {#7D7283,#C57DA5,#F9E6E3,#101C2C},
    {#302e38,#504e58,#a0aCa9,#E0ECE9},
    {#8EB1C7,#B02E0C,#C1BFB5,#FEFDFF}

};

Palette palette;

class Palette {
    color[][] palettes;
    Param[][] rgbPalette;
    int shift = 0;
    int paletteID;

    Palette(color[][] palettes, int paletteID) {
        this.palettes = palettes;
        this.rgbPalette = new Param[4][3];
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                this.rgbPalette[i][j] = new Param(0,0,255);
            }
        }
        this.setPalette(paletteID);
    }

    void setPalette(int paletteID) {
        this.paletteID = paletteID;
        color[] palette = this.palettes[paletteID];
        for (int i = 0; i < 4; i++) {
            this.rgbPalette[i][0].set(red(palette[i]));
            this.rgbPalette[i][1].set(green(palette[i]));
            this.rgbPalette[i][2].set(blue(palette[i]));
        }

    }

    void targetPalette(int paletteID) {
        this.paletteID = paletteID;
        color[] palette = this.palettes[paletteID];
        for (int i = 0; i < 4; i++) {
            this.rgbPalette[i][0].target(red(palette[i]));
            this.rgbPalette[i][1].target(green(palette[i]));
            this.rgbPalette[i][2].target(blue(palette[i]));
        }

    }

    float[][] getRGB() {
        float[][] paletteRGB = new float[4][3];
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 3; j++) {
                paletteRGB[i][j] = this.rgbPalette[i][j].updateGet();
            }
        }
        return paletteRGB;
    }

    void shift() {
        this.shift = (this.shift + 1)%4;
        color[] palette = this.palettes[this.paletteID];
        for (int i = 0; i < 4; i++) {
            this.rgbPalette[i][0].target(red(palette[(i + this.shift)%4]));
            this.rgbPalette[i][1].target(green(palette[(i + this.shift)%4]));
            this.rgbPalette[i][2].target(blue(palette[(i + this.shift)%4]));
        }
    }

}
