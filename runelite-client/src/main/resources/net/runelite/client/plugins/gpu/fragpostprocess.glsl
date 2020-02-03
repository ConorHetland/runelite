#version 330

uniform sampler2D tex;
uniform vec2 viewportResolution;

in vec2 TexCoord;

out vec4 FragColor;

//#include hsl_to_rgb.glsl

void main() {

    vec2 s = 2.*(gl_FragCoord.xy/viewportResolution - vec2(0.5));
    vec2 off = vec2(s.y*s.y*0.02*s.x, s.x*s.x*0.02*s.y);
    float grille 	= 0.9 + 0.1*clamp(1.5*cos(3.14*gl_FragCoord.x*viewportResolution.x/2.), 0., 1.);
    vec2 oTexCoord = vec2(TexCoord.x,1.-TexCoord.y)+off;

    if(oTexCoord.x < 0. || oTexCoord.x > 1. || oTexCoord.y < 0. || oTexCoord.y > 1.) {
        FragColor = vec4(0.);
    } else {
        vec3 u = texture(tex, oTexCoord+vec2(0., 0.0012)).rgb;
        vec3 d = texture(tex, oTexCoord+vec2(0., -0.0012)).rgb;
        vec2 l = texture(tex, oTexCoord+vec2(-0.0012, 0.)).rg;
        vec2 r = texture(tex, oTexCoord+vec2(0.0012, 0.)).gb;

        FragColor = vec4((u.r+d.r+l.r)/3., (u.g+d.g+l.g+r.x)/4., (u.b+d.b+r.y)/3., 1.)*grille;
    }
}