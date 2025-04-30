#  AFMessageUI

A package to wrap UIKit Email in a ViewModifier for SwiftUI. `isPresented` and `toRecipients` are required, however you can have `subject` and the main `body` of email as well as CC and BCC recipients. Also added the option to have onDismiss method/closure. It will handle if a devices can send email and give error sheet if so.

- **Important:** This will not send an email. It will present the email composer and user has the option to send the email or cancel it.
- **Note** onDismiss closure will run even if email is not sent/canceled or device do not handle emails.

1. Add to Swift Package Manager
2. Import AFMeesageUI
3. Add Modifier `.mailSheet(isPresented: toRecipients)`
```swift
import AFMessageUI
import SwiftUI

struct ContentView: View {
    @State private var showMailComposer = false
    
    var body: some View {
        Button("Compose Mail") {
            showMailComposer.toggle()
        }
        .buttonStyle(.bordered)
        .mailSheet(
            isPresented: $showMailComposer,
            toRecipients: "myemail@example.com",
            subject: "My Important Email",
            body: "This is very important information."
        )
    }
}
```

