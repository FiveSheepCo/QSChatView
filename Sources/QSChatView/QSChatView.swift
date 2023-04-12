import SwiftUI

public struct QSChatView: View {
    @State private var chatText: String = ""
    
    public var body: some View {
        VStack {
            Spacer()
            ChatTextField($chatText)
        }
    }
}

struct QSChatView_Previews: PreviewProvider {
    static var previews: some View {
        QSChatView()
            .padding()
    }
}
