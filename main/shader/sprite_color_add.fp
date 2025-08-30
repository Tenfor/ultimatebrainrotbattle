varying mediump vec2 var_texcoord0;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 tint;
uniform lowp vec4 color_add;

void main()
{
	vec4 texColor = texture2D(texture_sampler, var_texcoord0.xy);
	vec3 color = texColor.rgb + (color_add.rgb * color_add.w);
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
	texColor.rgb = color * texColor.w;
	gl_FragColor = texColor * tint_pm;
}
