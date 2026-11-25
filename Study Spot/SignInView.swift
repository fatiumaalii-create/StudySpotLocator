//
//  SignInView.swift
//  Study Spot
//
//  Created by apple on 04/11/2026.
//



import SwiftUI

// Screen 2: Sign In
struct SignInView: View {
    @AppStorage("isSignedIn") private var isSignedIn = false

    @State private var studentIDOrEmail = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showError = false

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 16) {
                Spacer()

                Text("Welcome Back")
                    .font(.largeTitle)
                    .bold()

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
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
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

                Button {
                    checkFields()
                } label: {
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

                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 1)
                }

                NavigationLink(destination: CreateAccountView()) {
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
            .foregroundColor(studyText)
            .padding(.horizontal, 20)
        }
        .navigationBarHidden(true)
    }

    // Unit 1.4 + 3.1: check the fields, then go to Home
    func checkFields() {
        if studentIDOrEmail.isEmpty || password.isEmpty {
            showError = true
        } else {
            showError = false
            isSignedIn = true          // ContentView now shows the Home tabs
        }
    }
}

#Preview {
    NavigationStack {
        SignInView()
    }
}
