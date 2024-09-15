shader_type canvas_item;

//void vertex() {
	// Called for every vertex the material is visible on.
//}

const float blur = 0.04;

void fragment() {
	COLOR = texture(TEXTURE, UV) * vec4(0.25, 0.25, 1.0, 1.0);
	COLOR += texture(TEXTURE, UV) * vec4(0.0, 0.0, 0.5, 1.0);
	
	vec4 left = texture(TEXTURE, UV+vec2(-blur,0.0));
	vec4 right = texture(TEXTURE, UV+vec2(blur,0.0));
	
	COLOR += left;
	COLOR += right;
	COLOR /= 3.0;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
