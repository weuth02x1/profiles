//
//  rubaView.swift
//  profiles
//
//  Created by Ruba Alghamdi on 07/04/1447 AH.
//

import SwiftUI

struct rubaView: View {
    var body: some View {
        ZStack {
            // background
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.pink]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Stars
            StarParticles()
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack(spacing: 16) {
                // Profile Image
                Image("rubaimg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white, Color.pink]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 8
                        )
                    )
                
                // Name
                Text("Ruba Alghamdi")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(0.9))
                
                // about me
                Text("I'm a 22 years old passionate creator with a love for design, coding, and bringing ideas to life. Always learning, always building.")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .padding(.trailing)
            }
            .padding()
        }
    }
}

//Stars Background
struct StarParticles: View {
    let starCount = 50
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<starCount, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.white)
                    .opacity(Double.random(in: 0.1...1))
                    .frame(width: 10, height: 10)
                    .position(
                        x: CGFloat.random(in: 0...geometry.size.width),
                        y: CGFloat.random(in: 0...geometry.size.height)
                    )
            }
        }
    }
}

#Preview {
    rubaView()
}
