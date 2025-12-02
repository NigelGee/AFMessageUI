//
//  MailViewModifier.swift
//  MailProject
//
//  Created by Nigel Gee on 20/03/2025.
//

import SwiftUI
import MessageUI

/// A modifier to show `MailView` when presented.
/// - Authors: @rebeloper on YouTube
struct MailViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var mailResult: Result<MFMailComposeResult, Error>?

    @State private var message = ""
    @State private var showAlert = false

    let toRecipients: [String]
    let ccRecipients:[String]?
    let bccRecipients: [String]?
    let subject: String?
    let body: String?
    let onDismiss: (() -> Void)?

    var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }

    func body(content: Content) -> some View {
        content
            .alert("Mail", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(message)
            }
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                if canSendMail {
                    MailView(
                        result: $mailResult,
                        toRecipients: toRecipients,
                        ccRecipients: ccRecipients,
                        bccRecipients: bccRecipients,
                        subject: subject,
                        body: body
                    )
                    .onDisappear(perform: alertDisplay)
                } else {
                    ContentUnavailableView(
                        "No Mail App Detected",
                        systemImage: "envelope",
                        description: Text("Device unable to send emails!")
                    )
                }
            }
    }
    
    /// A method that will display a message of the result of user sending email.
    ///
    /// This is private access by the modifier.
    private func alertDisplay() {
        if let mailResult {
            switch mailResult {
            case .success(let result):
                switch result {
                case .cancelled:
                    message = "Cancelled!"
                case .saved:
                    message = "Saved to Draft."
                case .sent:
                    message = "Sent."
                case .failed:
                    message = "Failed to Send!"
                @unknown default:
                    message = "Unknown Error"
                }
            case .failure(let error):
                message = error.localizedDescription
            }
        }
        showAlert.toggle()
    }
}
