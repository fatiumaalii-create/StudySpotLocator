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
                     
                        // Connect to Home when the sign-in flow is ready.
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .background(StudyTheme.green, in: RoundedRectangle(cornerRadius: 16))
                    }
                    .buttonStyle(.plain)
                    .padding(.top, 22)

                    HStack(spacing: 12) {
                        Rectangle()
                            .fill(StudyTheme.border)
                            .frame(height: 1)

                        Text("or")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(StudyTheme.ink)

                        Rectangle()
                            .fill(StudyTheme.border)
                            .frame(height: 1)
                    }
                    .padding(.vertical, 18)

                    Button {
                        // Connect to Create Account when screen 3 is ready.
                    } label: {
                        Text("Create Account")
                            .font(.headline)
                            .foregroundStyle(StudyTheme.green)
                            .frame(maxWidth: .infinity, minHeight: 56)
                            .overlay {
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(StudyTheme.green, lineWidth: 1)
                            }
                    }
                    .buttonStyle(.plain)

                    Spacer(minLength: 44)
                }
                .frame(maxWidth: 420)
                .padding(.horizontal, 22)
                .frame(maxWidth: .infinity)
                .frame(minHeight: geometry.size.height)
            }
        }
        .background(StudyTheme.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private func fieldRow<Content: View>(
        icon: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(StudyTheme.muted)
                .frame(width: 22)
                .accessibilityHidden(true)

            content()
        }
        .font(.subheadline)
        .foregroundStyle(StudyTheme.ink)
        .padding(.horizontal, 14)
        .frame(minHeight: 58)
        .background(StudyTheme.cream, in: RoundedRectangle(cornerRadius: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(StudyTheme.border, lineWidth: 1)
        }
    }
}

#Preview {
    SignInView()
}
