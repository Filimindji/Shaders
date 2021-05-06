//UNITY_SHADER_NO_UPGRADE
#ifndef FBMINCLUDE_INCLUDED
#define FBMINCLUDE_INCLUDED

// Original source
// https://www.shadertoy.com/view/Md33zB


/*
 A noise function mirrored and thresholded to maximize the value at the center of the screen
 Combined with a second layer of noise to produce an ink on paper effect
*/

//3D simplex noise from: https://www.shadertoy.com/view/XsX3zB

float3 random3(float3 c) {
	float j = 4096.0*sin(dot(c, float3(17.0, 59.4, 15.0)));
	float3 r;
	r.z = frac(512.0*j);
	j *= .125;
	r.x = frac(512.0*j);
	j *= .125;
	r.y = frac(512.0*j);
	return r - 0.5;
}

float simplex3d(float3 p) {
	const float F3 = 0.3333333;
	const float G3 = 0.1666667;

	float3 s = floor(p + dot(p, float3(F3, F3, F3)));
	float3 x = p - s + dot(s, float3(G3, G3, G3));

	float3 e = step(float3(0.0, 0.0, 0.0), x - x.yzx);
	float3 i1 = e * (1.0 - e.zxy);
	float3 i2 = 1.0 - e.zxy*(1.0 - e);

	float3 x1 = x - i1 + G3;
	float3 x2 = x - i2 + 2.0*G3;
	float3 x3 = x - 1.0 + 3.0*G3;

	float4 w, d;

	w.x = dot(x, x);
	w.y = dot(x1, x1);
	w.z = dot(x2, x2);
	w.w = dot(x3, x3);

	w = max(0.6 - w, 0.0);

	d.x = dot(random3(s), x);
	d.y = dot(random3(s + i1), x1);
	d.z = dot(random3(s + i2), x2);
	d.w = dot(random3(s + 1.0), x3);

	w *= w;
	w *= w;
	d *= w;

	const float H4 = 52.0;

	return dot(d, float4(H4, H4, H4, H4));
}


void fbm_float(float3 p, out float Out)
{
	float f = 0.0;
	float frequency = 1.0;
	float amplitude = 0.5;
	for (int i = 0; i < 5; i++)
	{
		f += simplex3d(p * frequency) * amplitude;
		amplitude *= 0.5;
		frequency *= 2.0 + float(i) / 100.0;
	}

	Out = min(f, 1.0);
}


#endif // FBMINCLUDE_INCLUDED