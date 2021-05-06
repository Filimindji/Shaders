//UNITY_SHADER_NO_UPGRADE
#ifndef SPECTRAL_ZUCCONI6_INCLUDED
#define SPECTRAL_ZUCCONI6_INCLUDED

// Based on GPU Gems
// Optimised by Alan Zucconi
inline float3 bump3y(float3 x, float3 yoffset)
{
    float3 y = 1 - x * x;
    y = saturate(y - yoffset);
    return y;
}

// Based on GPU Gems
// Optimised by Alan Zucconi
void spectral_zucconi6_float(float w, out float3 _out)
{    
    // w: [400, 700]
    // x: [0,   1]
    float x = saturate((w - 400.0) / 300.0);

    const float3 c1 = float3(3.54585104, 2.93225262, 2.41593945);
    const float3 x1 = float3(0.69549072, 0.49228336, 0.27699880);
    const float3 y1 = float3(0.02312639, 0.15225084, 0.52607955);

    const float3 c2 = float3(3.90307140, 3.21182957, 3.96587128);
    const float3 x2 = float3(0.11748627, 0.86755042, 0.66077860);
    const float3 y2 = float3(0.84897130, 0.88445281, 0.73949448);

    _out = 
        bump3y(c1 * (x - x1), y1) +
        bump3y(c2 * (x - x2), y2);
}


#endif //SPECTRAL_ZUCCONI6_INCLUDED