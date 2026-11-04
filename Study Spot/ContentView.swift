//
//  ContentView.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.2)
                .ignoresSafeArea()

            VStack {
                Image("BookLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Text("Welcome to\nOur Library")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("Study Spot Locator")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
