//
//  MetalTesting.metal
//  Metal-HackingWithSwift
//
//  Created by Brayton Lordianto on 3/22/24.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h> 
using namespace metal;


[[ stitchable ]] half4 invertAlpha(float2 position,
                                   half4 currentColor,
                                   half4 fillColor) {
    return half4(fillColor.rgb, 1 - currentColor.a);
}

[[ stitchable ]] half4 weirdRainbowTest(float2 position,
                               half4 currentColor,
                               float deltaTime) {
    float angle = atan2(position.x, position.y) + deltaTime;
    return half4(sin(angle), sin(angle * 2), sin(angle * 3), currentColor.a);
}

[[ stitchable ]] half4 checkerboard(float2 position,
                                    half4 currentColor,
                                    float size,
                                    half4 newColor) {
    uint2 posInChecks = uint2(position.x / size, position.y / size);
    bool isColor = (posInChecks.x ^ posInChecks.y) & 1;
    return isColor ? newColor * currentColor.a : half4(0.0, 0.0, 0.0, 0.0);
}

[[ stitchable ]] float2 simpleWave(float2 position, float time) {
    return position + float2 (sin(time + position.y / 20), sin(time + position.x / 20)) * 5;
}

[[ stitchable ]] float2 complexWave(float2 position, float time, float2 size, float speed, float strength, float frequency) {
    float2 normalizedPosition = position / size;
    float moveAmount = time * speed;

    position.x += sin((normalizedPosition.x + moveAmount) * frequency) * strength;
    position.y += cos((normalizedPosition.y + moveAmount) * frequency) * strength;

    return position;
}

[[ stitchable ]] half4 loupe(float2 position,
                             SwiftUI::Layer layer,
                             float2 sz) {
    return layer.sample(position);
}
