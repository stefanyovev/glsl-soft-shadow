
#version 120

uniform mat4 matrix;

attribute vec4 vertex;

void main(void){
	gl_Position = matrix * vertex;}

---

#version 120

void main(void){
	gl_FragColor = vec4(1,1,1,1);}
