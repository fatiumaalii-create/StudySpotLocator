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

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 44)

                    Text("Welcome Back")
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                        .foregroundStyle(StudyTheme.ink)
                        .multilineTextAlignment(.center)

                    Text("Sign in to find your\nperfect study spot.")
                        .font(.subheadline)
                        .foregroundStyle(StudyTheme.muted)
                        .multilineTextAlignment(.center)
                        .padding(.top, 12)

                    Spacer(minLength: 34)

                    fieldRow(icon: "person.fill") {
                        TextField("Student ID or Email", text: $studentIDOrEmail)
                            .textContentType(.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }

                    fieldRow(icon: "lock.fill") {
                        Group {
                            if showPassword {
                                TextField("Password", text: $password)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            } else {
                                SecureField("Password", text: $password)
                            }
                        }
                        .textContentType(.password)

                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundStyle(StudyTheme.muted)
                                .frame(width: 28, height: 44)
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(showPassword ? "Hide password" : "Show password")
                    }
                    .padding(.top, 14)

                    Text("Please complete all fields.")
                        .font(.footnote.weight(.semibold))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(showError ? 1 : 0)
                        .accessibilityHidden(!showError)
                        .padding(.top, 16)

                    Button {
                        let studentID = studentIDOrEmail.trimmingCharacters(in: .whitespacesAndNewlines)
                        showError = studentID.isEmpty || password.isEmpty
                     
        }
    }
}

#Preview {
    SignInView()
}
