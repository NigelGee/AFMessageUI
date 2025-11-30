//
//  File.swift
//  AFMessageUI
//
//  Created by Nigel Gee on 29/11/2025.
//

import SwiftUI
import MessageUI

/// A UIKit View Controller to return a message composer view.
@MainActor
public struct MessageView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var result: MessageComposeResult?

    let recipients: [String]
    let body: String?

    public class Coordinator: NSObject, @preconcurrency MFMessageComposeViewControllerDelegate {
        var parent: MessageView

        init(parent: MessageView) {
            self.parent = parent
        }

        @MainActor
        public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            defer { parent.dismiss () }

            parent.result = result
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = MFMessageComposeViewController()
        viewController.messageComposeDelegate = context.coordinator
        viewController.recipients = recipients
        viewController.body = body

        return viewController
    }

    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
