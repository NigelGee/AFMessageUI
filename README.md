#  AFMessageUI

1. Add to Swift Package Manager
2. Import AFMeesage
3. Add Modifier `.mailSheet(isPresent: )`
```swift
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

