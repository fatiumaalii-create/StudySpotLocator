
//
//  CreateAccountView.swift
//  Study Spot
//
//  Created by apple on 05/11/2026.
//



import SwiftUI

// Screen 3: Create Account
// The "< Back" button is the normal NavigationStack back button (Unit 3.2)
struct CreateAccountView: View {
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

            VStack(spacing: 12) {
                Text("Create Account")
                    .font(.largeTitle)
                    .bold()

                Text("Join to start finding study spots\naround campus.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)

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

                Button {
                    checkFields()
                } label: {
                    Text("Create Account")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(studyGreen)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .padding(.top, 10)

                Spacer()
            }
            .foregroundColor(studyText)
            .padding(.horizontal, 20)
        }
        // Unit 3.1: Alert controlled by a Bool
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
            alertTitle = "Account Created"
            alertMessage = "Your account was created. Tap Back to sign in."
        }

        showAlert = true
    }
}

#Preview {
    NavigationStack {
        CreateAccountView()
    }
}
