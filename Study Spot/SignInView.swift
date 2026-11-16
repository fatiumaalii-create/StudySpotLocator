//
//  SignInView.swift
//  Study Spot
//
//  Created by apple on 04/11/2026.
//

import SwiftUI

struct SignInView: View {
    @State private var studentIDOrEmail = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var showError = false
    @State private var showHome = false
    
    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()
            
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
                        } else {
                            Image(systemName: "eye")
                        }
                    }
                    .foregroundColor(.gray)
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
        .navigationDestination(isPresented: $showHome) {
            MainTabView()
        }
    }
    
    func checkFields() {
        if studentIDOrEmail.isEmpty || password.isEmpty {
            showError = true
        } else {
            showError = false
            showHome = true
            
            
            #Preview {
                NavigationStack {
                    SignInView()
                }
            }
        }
    }
}
