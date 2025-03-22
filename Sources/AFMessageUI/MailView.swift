//
//  MailView.swift
//  MailProject
//
//  Created by Nigel Gee on 18/03/2025.
//

import SwiftUI
import MessageUI

/// A UIKit View Controller to return a mail composer view.
@MainActor
public struct MailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss

    @Binding var result: Result<MFMailComposeResult, Error>?

    let toRecipients: [String]
    let ccRecipients: [String]?
    let bccRecipients: [String]?
    let subject: String?
    let body: String?

    public class Coordinator: NSObject, @preconcurrency MFMailComposeViewControllerDelegate {
        var parent: MailView

        init(parent: MailView) {
            self.parent = parent
        }

        @MainActor
        public func mailComposeController(
            _ controller: MFMailComposeViewController,
            didFinishWith result: MFMailComposeResult,
            error: Error?
        ) {
            defer {
                parent.dismiss()
            }

            if let error {
                parent.result = .failure(error)
            } else {
                parent.result = .success(result)
            }
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients(toRecipients)

        if let ccRecipients {
            viewController.setCcRecipients(ccRecipients)
        }

        if let bccRecipients {
            viewController.setBccRecipients(bccRecipients)
        }

        if let subject {
            viewController.setSubject(subject)
        }

        if let body {
            viewController.setMessageBody(body, isHTML: false)
        }

        return viewController
    }

    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) { }

}



