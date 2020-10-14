


#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_c3_blend;
uniform vec3 u_c0;
uniform vec3 u_c1;
uniform vec3 u_c2;
uniform vec3 u_c3;
uniform float u_noise_position;
uniform float u_noise;
uniform float u_noise_pixel;
uniform float u_color_noise;
uniform sampler2D u_canvas;



vec2 hash( vec2 p ) // replace this by something better
{
	p = vec2( dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)) );
	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}



float mod289(float x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 mod289(vec4 x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 perm(vec4 x){return mod289(((x * 34.0) + 1.0) * x);}

float noise(vec3 p){
    vec3 a = floor(p);
    vec3 d = p - a;
    d = d * d * (3.0 - 2.0 * d);

    vec4 b = a.xxyy + vec4(0.0, 1.0, 0.0, 1.0);
    vec4 k1 = perm(b.xyxy);
    vec4 k2 = perm(k1.xyxy + b.zzww);

    vec4 c = k2 + a.zzzz;
    vec4 k3 = perm(c);
    vec4 k4 = perm(c + 1.0);

    vec4 o1 = fract(k3 * (1.0 / 41.0));
    vec4 o2 = fract(k4 * (1.0 / 41.0));

    vec4 o3 = o2 * d.z + o1 * (1.0 - d.z);
    vec2 o4 = o3.yw * d.x + o3.xz * (1.0 - d.x);

    return o4.y * d.y + o4.x * (1.0 - d.y);
}





void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 texOffset = vec2(1.)/u_resolution;
    float xy_scale = u_resolution.x/u_resolution.y;


    float c1_mix = texture2D(u_canvas,st)[0] + ((noise(vec3(st,u_time))-.1) * u_color_noise) ;;
    float c2_mix = texture2D(u_canvas,st)[1] + ((noise(vec3(st,-u_time))-.1) * u_color_noise) ;;




    vec3 c0 = u_c0;
    vec3 c1 = u_c1;
    vec3 c2 = u_c2;
    vec3 c3 = u_c3_blend * u_c3 + (1-u_c3_blend) * ((c2+c1)/2.);
    vec3 lerp1 = c0 + c1_mix * (c1 - c0);
    vec3 lerp2 = c2 + c1_mix * (c3 - c2);


    vec3 color = lerp1 + c2_mix * (lerp2 - lerp1);

    gl_FragColor = vec4(color/255.,1.);

}
