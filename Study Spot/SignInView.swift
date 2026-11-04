//
//  SignInView.swift
//  Study Spot
//
//  Created by apple on 04/11/2026.
//

import SwiftUI

struct SignInView: View {
    @State private var studentIDOrEmail: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color.green.opacity(0.2)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Student ID or Email", text: $studentIDOrEmail)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
        }
    }
}

#Preview {
    SignInView()
}
