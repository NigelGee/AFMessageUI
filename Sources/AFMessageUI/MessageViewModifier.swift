//
//  File.swift
//  AFMessageUI
//
//  Created by Nigel Gee on 30/11/2025.
//

import SwiftUI
import MessageUI

/// A modifier to show `MessageView` when presented.
/// - Authors: @rebeloper on YouTube
struct MessageViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    @State private var result: MessageComposeResult?

    @State private var message = ""
    @State private var showAlert = false

    let toRecipients: [String]
    let body: String?
    let onDismiss: (() -> Void)?

    var canSendMessage: Bool {
        MFMessageComposeViewController.canSendText()
    }

    func body(content: Content) -> some View {
        content
            .alert("Message", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(message)
            }
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                if canSendMessage {
                    MessageView(
                        result: $result,
                        recipients: toRecipients,
                        body: body
                    )
                    .onDisappear(perform: alertDisplay)
                } else {
                    ContentUnavailableView(
                        "No Message App Detected",
                        systemImage: "exclamationmark.message",
                        description: Text("Device unable to send messages!")
                    )
                }
            }

    }

    /// A method that will display a message of the result of user sending message.
    ///
    /// A private method to show a message status.
    private func alertDisplay() {
        if let result {
            switch result {
            case .cancelled:
                message = "Cancelled!"
            case .sent:
                message = "Sent."
            case .failed:
                message = "Failed to send!"
            @unknown default:
                message = "Unknown Error"
            }

            showAlert.toggle()
        }
    }
}
