shader_type canvas_item;
void fragment(){
	vec2 shifteduv = UV;
	shifteduv.x += TIME * 0.02;
	shifteduv.y -= TIME * 0.02;
	vec4 col = texture(TEXTURE, shifteduv);
	COLOR = col;
}