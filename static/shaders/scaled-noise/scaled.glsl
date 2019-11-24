// Author:
// Title:

#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D img;

// Some useful functions
vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

float snoise(vec2 v) {

    // Precompute values for skewed triangular grid
    const vec4 C = vec4(0.211324865405187,
                        // (3.0-sqrt(3.0))/6.0
                        0.366025403784439,
                        // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626,
                        // -1.0 + 2.0 * C.x
                        0.024390243902439);
                        // 1.0 / 41.0

    // First corner (x0)
    vec2 i  = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);

    // Other two corners (x1, x2)
    vec2 i1 = vec2(0.0);
    i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
    vec2 x1 = x0.xy + C.xx - i1;
    vec2 x2 = x0.xy + C.zz;

    // Do some permutations to avoid
    // truncation effects in permutation
    i = mod289(i);
    vec3 p = permute(
            permute( i.y + vec3(0.0, i1.y, 1.0))
                + i.x + vec3(0.0, i1.x, 1.0 ));

    vec3 m = max(0.5 - vec3(
                        dot(x0,x0),
                        dot(x1,x1),
                        dot(x2,x2)
                        ), 0.0);

    m = m*m ;
    m = m*m ;

    // Gradients:
    //  41 pts uniformly over a line, mapped onto a diamond
    //  The ring size 17*17 = 289 is close to a multiple
    //      of 41 (41*7 = 287)

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt(a0*a0 + h*h);
    m *= 1.79284291400159 - 0.85373472095314 * (a0*a0+h*h);

    // Compute final noise value at P
    vec3 g = vec3(0.0);
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
    return 130.0 * dot(m, g);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    //st.x *= u_resolution.x/u_resolution.y;
    st.y = 1.0 - st.y;

    vec3 color = vec3(0.);
    //color = vec3(st.x,st.y,abs(sin(u_time)));

    //scan = vec2(snoise(vec2(st.x, u_time/5.))* 0.5 + 0.5, st.y);
    //scan = vec2(st.x, snoise(vec2(st.y, u_time/5.))* 0.5 + 0.5);
    //scan = vec2(st.x, snoise(vec2(st.y, u_mouse.y + u_time/10.))* 0.5 + 0.5);
    
    //options
    // float zoomX = 0.5;
    // float zoomY = 0.5;
    // float zoomX = 1. - mod(u_mouse.x, 0.5);
    // float zoomY = 1. - mod(u_mouse.x, 0.5);
    float currentDist = sqrt(pow(st.x - 0.5, 2.) + pow(st.y - 0.5, 2.));
    float totalDist = sqrt(2.) / 2.;

    float scaleVal = snoise(vec2(44. + u_time/2.5, 1013.)) * 0.5 + 0.5;

    float zoomX = 0.95 - (floor(currentDist / (totalDist * u_mouse.x)) * u_mouse.x);
    float zoomY = 0.95 - (floor(currentDist / (totalDist * u_mouse.x)) * u_mouse.x);
    float numGrids = 1.;
    float gridSize = 1. / numGrids;

    //basic horizontal and vertical offsets
    float xOff = floor(gl_FragCoord.x / (u_resolution.x * gridSize)) * (1. - u_mouse.x);
    float yOff = floor(gl_FragCoord.y / (u_resolution.y * gridSize)) * (1. - u_mouse.y);

    //radial offsets (distance from center)
    // float xOff = floor(abs(gl_FragCoord.x - u_resolution.x / 2) / (u_resolution.x * gridSize)) * (1. - u_mouse.x);
    // float yOff = floor(abs(gl_FragCoord.y - u_resolution.y / 2) / (u_resolution.y * gridSize)) * (1. - u_mouse.y);

    vec2 scan = vec2(mod(st.x, gridSize) * zoomX + (snoise(vec2(20. + xOff + yOff, 40.) + u_time/10.)* ((1. - zoomX)/2.) + ((1. - zoomX)/2.)), mod(st.y, gridSize) * zoomY + (snoise(vec2(1. + xOff + yOff, 3.) + u_time/10.)* ((1. - zoomY)/2.) + ((1. - zoomY)/2.)));
    // scan = vec2(mod(st.x, gridSize) * zoomX + ((u_mouse.x * 2. - 1.) * ((1. - zoomX)/2.) + ((1. - zoomX)/2.)), mod(st.y, gridSize) * zoomY + ((u_mouse.y * 2. - 1.) * ((1. - zoomY)/2.) + ((1. - zoomY)/2.)));
    
    // scan.x *= 1 + (2. * u_mouse.x);
    // scan.y *= 1 + (2. * u_mouse.x);

    // scan += u_mouse;
    color = texture2D(img, scan).rgb;
    // color = texture2D(img, scan).rgb * min(step(u_mouse.x, st.x) - step(abs(1. - u_mouse.x), st.x), 1) * min(step(u_mouse.x, st.y) - step(abs(1. - u_mouse.x), st.y), 1);
    gl_FragColor = vec4(color,1.0);
}
