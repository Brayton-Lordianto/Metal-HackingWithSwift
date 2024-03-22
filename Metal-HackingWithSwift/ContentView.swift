//
//  ContentView.swift
//  Metal-HackingWithSwift
//
//  Created by Brayton Lordianto on 3/22/24.
//

import SwiftUI

/// distortion effect is like vertex shader
/// color effect is like fragment shader
struct ContentView: View {
    @State private var startTime = Date.now
    @State private var strength = 8.0
    @State private var touch = CGPoint.zero
    
    var body: some View {
        VStack {
            TimelineView(.animation) { timeline in
                let deltaTime = startTime.distance(to: timeline.date)
                
                Image(systemName: "figure.run.circle")
                    .font(.system(size: 300))
                //.colorEffect(ShaderLibrary.weirdRainbowTest(.float(deltaTime)))
                //.colorEffect(ShaderLibrary.checkerboard(.float(10), .color(.blue)))
                //.distortionEffect(ShaderLibrary.simpleWave(.float(deltaTime)), maxSampleOffset: .zero)
                    .visualEffect { content, proxy in
                        content
//                            .distortionEffect(ShaderLibrary.complexWave(
//                                .float(deltaTime),
//                                .float2(proxy.size),
//                                .float(0.5),
//                                .float(strength),
//                                .float(10)
//                            ), maxSampleOffset: .zero)
                            .layerEffect(ShaderLibrary.loupe(.float2(proxy.size)), maxSampleOffset: .zero)
                    }
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({
                            touch = $0.location
                            
                        }))
            }
            
            Slider(value: $strength, in: 0...20)
        }
    }
}

#Preview {
    ContentView()
}
