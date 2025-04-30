import SwiftUI

extension View {
    /// A method to return a sheet with the mail composer.
    /// - Parameters:
    ///   - isPresented: A boolean to present the `mailSheet`
    ///   - toRecipients: A variadic for a list of recipients to send to.
    ///   - ccRecipients: An array of recipients to "cc" to. (Optional).
    ///   - bccRecipients: n array of recipients to blind "cc" to. (Optional).
    ///   - subject: The subject line of email. (Optional).
    ///   - body: The main body of an an email. (Optional).
    /// - Returns: A sheet with the email composer on a view when `isPresented` is `true`
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var showMailComposer = false
    ///     var body: some View {
    ///         Button("Compose Mail") {
    ///             showMailComposer.toggle()
    ///         }
    ///         .buttonStyle(.bordered)
    ///         .mailSheet(
    ///             isPresented: $showMailComposer,
    ///             toRecipients: "myemail@example.com",
    ///             subject: "My Important Email",
    ///             body: "This is very important information."
    ///         )
    ///    }
    /// }
    /// ```
    /// - Important: This will not send an email. It will present the email composer and user has the option to send the email or not.
    public func mailSheet(
        isPresented: Binding<Bool>,
        toRecipients: String...,
        ccRecipients: [String]? = nil,
        bccRecipients: [String]? = nil,
        subject: String? = nil,
        body: String? = nil,
        onDismiss: (() -> Void)? = nil
    ) -> some View {
        modifier(
            MailViewModifier(
                isPresented: isPresented,
                toRecipients: toRecipients,
                ccRecipients: ccRecipients,
                bccRecipients: bccRecipients,
                subject: subject,
                body: body,
                onDismiss: onDismiss
            )
        )
    }
}
