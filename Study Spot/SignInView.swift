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
    @State private var showPassword: Bool = false
    @State private var showError: Bool = false

    let studyBackground = Color(red: 238.0 / 255, green: 240.0 / 255, blue: 228.0 / 255)
    let studyGreen = Color(red: 28.0 / 255, green: 64.0 / 255, blue: 44.0 / 255)
    let studyText = Color(red: 16.0 / 255, green: 45.0 / 255, blue: 30.0 / 255)
    let fieldColor = Color(red: 251.0 / 255, green: 249.0 / 255, blue: 243.0 / 255)

    var body: some View {
        ZStack {
            studyBackground
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(studyText)

                Text("Sign in to find your\nperfect study spot.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)

                    TextField("Student ID or Email", text: $studentIDOrEmail)
                        .autocapitalization(.none)
                }
                .foregroundColor(studyText)
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                HStack {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.gray)

                    if showPassword {
                        TextField("Password", text: $password)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Password", text: $password)
                    }

                    Button {
                        showPassword = !showPassword
                    } label: {
                        if showPassword {
                            Image(systemName: "eye.slash")
                                .foregroundColor(.gray)
                        } else {
                            Image(systemName: "eye")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .foregroundColor(studyText)
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                if showError {
                    HStack {
                        Text("Please complete all fields.")
                            .font(.subheadline)
                            .foregroundColor(.red)

                        Spacer()
                    }
                }

                Button(action: checkFields) {
                    Text("Sign In")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(studyGreen)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }

                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)

                    Text("or")
                        .font(.subheadline)
                        .foregroundColor(studyText)

                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }

                Button {
                    // بنربطه بشاشة Create Account يوم نسويها.
                } label: {
                    Text("Create Account")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(fieldColor)
                        .foregroundColor(studyGreen)
                        .cornerRadius(20)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }

    func checkFields() {
        if studentIDOrEmail.isEmpty || password.isEmpty {
            showError = true
        } else {
            showError = false
        }
    }
}
#Preview {
    SignInView()
}
