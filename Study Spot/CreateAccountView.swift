
//
//  CreateAccountView.swift
//  Study Spot
//
//  Created by apple on 05/11/2026.
//

import SwiftUI

struct CreateAccountView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var studentID = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            studyBackground.ignoresSafeArea()

            VStack(spacing: 14) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                        .foregroundColor(studyText)
                    }

                    Spacer()
                }

                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Join to start finding study spots\naround campus.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 14)

                HStack {
                    Image(systemName: "person.fill").foregroundColor(.gray)
                    TextField("Name", text: $name)
                        .autocapitalization(.words)
                }
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                HStack {
                    Image(systemName: "person.fill").foregroundColor(.gray)
                    TextField("Student ID", text: $studentID)
                        .autocapitalization(.none)
                }
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                HStack {
                    Image(systemName: "envelope.fill").foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                HStack {
                    Image(systemName: "lock.fill").foregroundColor(.gray)
                    SecureField("Password", text: $password)
                }
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                HStack {
                    Image(systemName: "lock.fill").foregroundColor(.gray)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                .padding()
                .background(fieldColor)
                .cornerRadius(16)

                Button(action: checkFields) {
                    Text("Create Account")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(studyGreen)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.top, 14)

                Spacer()
            }
            .foregroundColor(studyText)
            .padding(.horizontal, 20)
            .padding(.top, 16)
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func checkFields() {
        if name.isEmpty || studentID.isEmpty || email.isEmpty ||
            password.isEmpty || confirmPassword.isEmpty {
            alertTitle = "Signup Error"
            alertMessage = "Please complete all fields."
        } else if password != confirmPassword {
            alertTitle = "Signup Error"
            alertMessage = "Passwords do not match."
        } else {
            alertTitle = "Details Checked"
            alertMessage = "All fields are complete and the passwords match."
        }

        showAlert = true
    }
}

#Preview {
    CreateAccountView()
}
