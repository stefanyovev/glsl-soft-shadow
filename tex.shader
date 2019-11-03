
#version 120

attribute vec3 vertex;
attribute vec2 tc;

varying vec2 tc_;

void main(void){
	tc_ = tc;
	gl_Position = vec4( vertex, 1);}

---

#version 120

uniform sampler2D tex;

varying vec2 tc_;

void main(void){
	gl_FragColor = texture2D( tex, tc_ );}
