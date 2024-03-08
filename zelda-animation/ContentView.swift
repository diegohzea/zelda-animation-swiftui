//
//  ContentView.swift
//  zelda-animation
//
//  Created by Diego Zea on 6/03/24.
//

import SwiftUI
import Accelerate

struct ContentView: View {
    @State private var cardAnimationValue = 0.0
    @State private var linkAnimationValue = -25.0
    @State private var linkOpacityValue = 0.0
    @State private var cardBackgroundOpacity = 0.0
    @State private var showLink = false
    
    var body: some View {
        VStack{
            ZStack{
                CardBackground(opacityValue: cardBackgroundOpacity)
                    .rotation3DEffect(.degrees(cardAnimationValue), axis: (x:0.15, y: 0, z: 0))
                
                Link(linkOpacityValue: linkOpacityValue).offset(x: 0, y: linkAnimationValue)
            }
            
            HStack{
                ZeldaButton(onTap: {
                    linkOpacityValue = 1
                    withAnimation(.easeInOut(duration: 0.4)){
                        cardBackgroundOpacity = 1
                        cardAnimationValue = 45.0
                        linkAnimationValue = -75.0
                    }
                }, text: "Animate")
                
                ZeldaButton(onTap: {
                    linkOpacityValue = 0
                    withAnimation(.easeInOut(duration: 0.7)){
                        cardBackgroundOpacity = 0
                        cardAnimationValue = 0.0
                        linkAnimationValue = -25.0
                    }
                }, text: "Reverse")
            }
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center).background(LinearGradient(
                    gradient: Gradient(colors: [.black, .blue]),
                    startPoint: .leading,
                    endPoint: .trailing
                ).ignoresSafeArea(.all, edges: .all))
        
    }
}

struct CardBackground: View {
    var opacityValue: Double = 0
    
    var body: some View {
        let black = Color.black.opacity(opacityValue)
        let transparent = Color.white.opacity(0)
        
        ZStack {
            AsyncImage(url: URL(string: "https://assets.codepen.io/527512/zelda_cover-image.webp")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 260, height: 400).cornerRadius(8).shadow(color: .black, radius: 20)
            
            VStack{
                Spacer()
                AsyncImage(url: URL(string: "https://assets.codepen.io/527512/zelda_title.webp")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 85).cornerRadius(8).shadow(color: .black, radius: 20)
            }.frame(width: 260).background(LinearGradient(
                gradient: Gradient(colors: [black, transparent, transparent, black]),
                startPoint: .topTrailing,
                endPoint: .bottomTrailing
            ))
            
        }
        .frame(width: 260, height: 400)
        .padding(30)
    }
}

struct Link: View {
    var linkOpacityValue = 0.0
    
    var body: some View {
        AsyncImage(url: URL(string: "https://assets.codepen.io/527512/zelda_character.webp")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 290, height: 400).opacity(linkOpacityValue).animation(.easeInOut(duration: 0.45))
    }
}

struct ZeldaButton: View {
    var onTap: () -> Void
    var text: String
    
    var body: some View {
        Button(action: onTap, label: {
            Text(text)
                .foregroundColor(.white).font(.title2)
        }).padding(10)
    }
}

#Preview {
    ContentView()
}
