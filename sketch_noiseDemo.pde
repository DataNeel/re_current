PShader noiseDemo_shader;



void noiseDemo_setup() {
    shader = color_shader;
}

void noiseDemo_draw() {



    float[][] colors = palette.getRGB();
    canvas.shader(noiseDemo_shader);
    noiseDemo_shader.set("u_resolution", float(width), float(height));
    noiseDemo_shader.set("u_time", timer.T/10);
    noiseDemo_shader.set("u_noisePosition", noise_position);

    noiseDemo_shader.set("u_noise1", param1.updateGet());
    noiseDemo_shader.set("u_noise2", param2.updateGet());
    noiseDemo_shader.set("u_noise3", param3.updateGet());
    noiseDemo_shader.set("u_noise4", param4.updateGet());
    noiseDemo_shader.set("u_noise5", param5.updateGet());
    noiseDemo_shader.set("u_noise6", param6.updateGet());
    noiseDemo_shader.set("u_noise7", param7.updateGet());
    noiseDemo_shader.set("u_noise8", param8.updateGet());
    noiseDemo_shader.set("u_noise9", param9.updateGet());
    noiseDemo_shader.set("u_noise10", param10.updateGet());
    noiseDemo_shader.set("u_noise11", param11.updateGet());
    noiseDemo_shader.set("u_noise12", param12.updateGet());
    noiseDemo_shader.set("u_noise13", param13.updateGet());
    noiseDemo_shader.set("u_noise14", param14.updateGet());
    noiseDemo_shader.set("u_noise15", param15.updateGet());
    noiseDemo_shader.set("u_noise16", param16.updateGet());


    noiseDemo_shader.set("u_c0", colors[0][0],colors[0][1],colors[0][2]);
    noiseDemo_shader.set("u_c1", colors[1][0],colors[1][1],colors[1][2]);
    noiseDemo_shader.set("u_c2", colors[2][0],colors[2][1],colors[2][2]);
    noiseDemo_shader.set("u_c3", colors[3][0],colors[3][1],colors[3][2]);
    canvas.fill(255);
    canvas.rect(0,0,width,height);



    }
