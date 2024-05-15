//canvas item is the 2d version of a shader (if we want pixels or something we've got it")"
shader_type canvas_item;

uniform bool active = false;
//fragment goes over every pixel pixel by pixel
void fragment() {
	//previous color is the texture and UV values
	vec4 previous_color = texture(TEXTURE, UV);
	//this is just the alpha (if there is a value or not) combined with white
	vec4 white_color = vec4(1.0, 1.0, 1.0, previous_color.a);
	//sets it to the normal color by default
	vec4 new_color = previous_color;
	//if we want it active or set it to be as such, we swap our color to white
	if (active == true)
	{
		new_color = white_color;
	}
	//export the appropriate color
	COLOR = new_color;
}
