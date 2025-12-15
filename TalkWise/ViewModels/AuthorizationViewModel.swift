//
//  AuthorizationViewModel.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 10.12.2025.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import CryptoKit
import AuthenticationServices
import SwiftUI
import FirebaseFirestore


@MainActor
class AuthorizationViewModel: NSObject, ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var showAuthorizationView = true
    
    private var currentNonce: String?
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func signUpWithEmail() async throws -> User {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        showAuthorizationView = false
        return authResult.user
    }
    
    
    func signInWithEmail() async throws -> User {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        showAuthorizationView = false
        return authResult.user
    }
    
    
    func signInWithGoogle() async throws -> User {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw NSError(domain: "No clientID", code: 0)
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            throw NSError(domain: "No root VC", code: 0)
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        guard let idToken = result.user.idToken else {
            throw NSError(domain: "No id token", code: 0)
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                       accessToken: result.user.accessToken.tokenString)
        
        let authResult = try await Auth.auth().signIn(with: credential)
        return authResult.user
    }
    
    func startSignInWithAppleFlow() {
        isLoading = true
        
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    
    func deleteUserDocument() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "Auth", code: 401)
        }
        
        let uid = user.uid
        let db = Firestore.firestore()
        
        let userRef = db.collection("users").document(uid)
        
        try await userRef.delete()
        
        try await user.delete()
    }
    
    
}

extension AuthorizationViewModel: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let appleToken = credential.identityToken,
              let tokenString = String(data: appleToken, encoding: .utf8)
        else {
            self.isLoading = false
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: tokenString,
            rawNonce: nonce,
            accessToken: nil
        )
        
        Task {
            do {
                let result = try await Auth.auth().signIn(with: firebaseCredential)
                print("User logged:", result.user.uid)
            } catch {
                print("Auth error:", error.localizedDescription)
            }
            self.isLoading = false
        }
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithError error: Error) {
        print("Apple auth error:", error.localizedDescription)
        self.isLoading = false
    }
}

extension AuthorizationViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.windows.first }
            .first ?? ASPresentationAnchor()
    }
}


private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        var random: UInt8 = 0
        let status = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
        if status != errSecSuccess {
            fatalError("Unable to generate nonce.")
        }
        
        if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
        }
    }
    
    return result
}

private func sha256(_ input: String) -> String {
    let data = Data(input.utf8)
    let hash = SHA256.hash(data: data)
    return hash.map { String(format: "%02x", $0) }.joined()
}


struct AppleSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(type: .signIn, style: .white)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
