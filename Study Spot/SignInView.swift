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

    var body: some View {
        ZStack {
            Color.green.opacity(0.15)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                Text("Welcome Back")
                    .font(.largeTitle)
                    .fontWeight(.bold)

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
                .padding()
                .background(Color.white)
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
                .padding()
                .background(Color.white)
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
                        .background(Color.green.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }

                HStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)

                    Text("or")
                        .font(.subheadline)

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
                        .background(Color.white)
                        .foregroundColor(.green)
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
