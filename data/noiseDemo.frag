


#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_noise1;
uniform float u_noise2;
uniform float u_noise3;
uniform float u_noise4;
uniform float u_noise5;
uniform float u_noise6;
uniform float u_noise7;
uniform float u_noise8;
uniform float u_noise9;
uniform float u_noise10;
uniform float u_noise11;
uniform float u_noise12;
uniform float u_noise13;
uniform float u_noise14;
uniform float u_noise15;
uniform float u_noise16;
uniform float u_noisePosition;

uniform float u_c3_blend;
uniform vec3 u_c0;
uniform vec3 u_c1;
uniform vec3 u_c2;
uniform vec3 u_c3;



vec2 hash( vec2 p ) // replace this by something better
{
	p = vec2( dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)) );
	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}


vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}

float snoise(vec3 v){
  const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
  const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

// First corner
  vec3 i  = floor(v + dot(v, C.yyy) );
  vec3 x0 =   v - i + dot(i, C.xxx) ;

// Other corners
  vec3 g = step(x0.yzx, x0.xyz);
  vec3 l = 1.0 - g;
  vec3 i1 = min( g.xyz, l.zxy );
  vec3 i2 = max( g.xyz, l.zxy );

  //  x0 = x0 - 0. + 0.0 * C
  vec3 x1 = x0 - i1 + 1.0 * C.xxx;
  vec3 x2 = x0 - i2 + 2.0 * C.xxx;
  vec3 x3 = x0 - 1. + 3.0 * C.xxx;

// Permutations
  i = mod(i, 289.0 );
  vec4 p = permute( permute( permute(
             i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
           + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))
           + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

// Gradients
// ( N*N points uniformly over a square, mapped onto an octahedron.)
  float n_ = 1.0/7.0; // N=7
  vec3  ns = n_ * D.wyz - D.xzx;

  vec4 j = p - 49.0 * floor(p * ns.z *ns.z);  //  mod(p,N*N)

  vec4 x_ = floor(j * ns.z);
  vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

  vec4 x = x_ *ns.x + ns.yyyy;
  vec4 y = y_ *ns.x + ns.yyyy;
  vec4 h = 1.0 - abs(x) - abs(y);

  vec4 b0 = vec4( x.xy, y.xy );
  vec4 b1 = vec4( x.zw, y.zw );

  vec4 s0 = floor(b0)*2.0 + 1.0;
  vec4 s1 = floor(b1)*2.0 + 1.0;
  vec4 sh = -step(h, vec4(0.0));

  vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
  vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

  vec3 p0 = vec3(a0.xy,h.x);
  vec3 p1 = vec3(a0.zw,h.y);
  vec3 p2 = vec3(a1.xy,h.z);
  vec3 p3 = vec3(a1.zw,h.w);

//Normalise gradients
  vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
  p0 *= norm.x;
  p1 *= norm.y;
  p2 *= norm.z;
  p3 *= norm.w;

// Mix final noise value
  vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
  m = m * m;
  return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1),
                                dot(p2,x2), dot(p3,x3) ) );
}


float mod289(float x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 mod289(vec4 x){return x - floor(x * (1.0 / 289.0)) * 289.0;}
vec4 perm(vec4 x){return mod289(((x * 34.0) + 1.0) * x);}



void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.y;
    float xy_scale = u_resolution.x/u_resolution.y;

    float scale = .5;
    float adjustment = 0;
    float n1 = snoise(vec3(st*scale,u_time)) - adjustment;
    float n2 = snoise(vec3(st*scale*2.,u_time)) - adjustment;
    float n3 = snoise(vec3(st*scale*3.,u_time)) - adjustment;
    float n4 = snoise(vec3(st*scale*4.,u_time)) - adjustment;
    float n5 = snoise(vec3(st*scale*5.,u_time)) - adjustment;
    float n6 = snoise(vec3(st*scale*6.,u_time)) - adjustment;
    float n7 = snoise(vec3(st*scale*7.,u_time)) - adjustment;
    float n8 = snoise(vec3(st*scale*8.,u_time)) - adjustment;
    float n9 = snoise(vec3(st*scale*9.,u_time)) - adjustment;
    float n10 = snoise(vec3(st*scale*10.,u_time)) - adjustment;
    float n11 = snoise(vec3(st*scale*11.,u_time)) - adjustment;
    float n12 = snoise(vec3(st*scale*12.,u_time)) - adjustment;
    float n13 = snoise(vec3(st*scale*13.,u_time)) - adjustment;
    float n14 = snoise(vec3(st*scale*14.,u_time)) - adjustment;
    float n15 = snoise(vec3(st*scale*15.,u_time)) - adjustment;
    float n16 = snoise(vec3(st*scale*16.,u_time)) - adjustment;


    float c1_mix = (u_noise1 * n1 +
                   u_noise2 * n2 +
                   u_noise3 * n3 +
                   u_noise4 * n4 +
                   u_noise5 * n5 +
                   u_noise6 * n6 +
                   u_noise7 * n7 +
                   u_noise8 * n8 +
                   u_noise9 * n9 +
                   u_noise10 * n10 +
                   u_noise11 * n11 +
                   u_noise12 * n12 +
                   u_noise13 * n13 +
                   u_noise14 * n14 +
                   u_noise15 * n15 +
                   u_noise16 * n16) // (n1+n2+n3+n4+n5+n6+n7+n8+n9+n10+n11+n12+n13+n14+n15+n16)
                   ;
    float c2_mix;

    vec3 c0 = u_c0;
    vec3 c1 = u_c1;
    vec3 c2 = u_c2;
    vec3 c3 = u_c3_blend * u_c3 + (1-u_c3_blend) * ((c2+c1)/2.);
    vec3 lerp1 = c0 + step(.05,c1_mix) * (c1 - c0);
    vec3 lerp2 = c2 + step(.05,c1_mix) * (c3 - c2);


    vec3 color = lerp1 + c2_mix * (lerp2 - lerp1);

    gl_FragColor = vec4(color/255.,1.);


}
