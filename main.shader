#version 120

uniform mat4 matrix;
uniform mat4 mapT;

attribute vec3 vertex;
attribute vec3 normal;

varying vec4 v_map;
varying vec4 normal_;

void main(void){
   gl_Position = matrix * vec4( vertex, 1 );
   normal_ =     matrix * vec4( normal, 0 );
   v_map =       mapT * vec4( vertex, 1 );

   }



---

#version 120

uniform bool shadow_only;

uniform sampler2D map;

uniform vec3 lp;

varying vec4 v_map;
varying vec4 normal_;

mat4 bias = mat4(
0.5, 0.0, 0.0, 0.0,
0.0, 0.5, 0.0, 0.0,
0.0, 0.0, 0.5, 0.0,
0.5, 0.5, 0.5, 1.0);

void main(void){

   vec4 lpos = vec4( normalize( lp ), 0 );
   vec4 N = normalize( normal_ );
    vec4 x = bias * v_map;

   float val = dot( N, lpos );
   val = clamp( ( val + pow( val, 25 ) )  ,0,1);

   float vis = 1.0;

    for( int i=-2; i<=2; i++ )
        for( int j=-2; j<=2; j++ ){
            vec2 testpos = vec2( x.x + i*0.005, x.y +j*0.005 );
            if( texture2D( map, testpos ).r < x.z -0.05 )
                vis -= 0.04;
        }


   gl_FragColor = vec4( vec3(1,1,1) * val * vis, 1 );

   if(shadow_only)
	gl_FragColor = vec4(0,0,0, 1-vis );

   }
