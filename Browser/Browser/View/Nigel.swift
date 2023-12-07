import SwiftUI

struct Nigel: View {
    @State private var selectedOption: String = "Tabs"
    
    let options = ["Tabs", "Downloads", "Settings", "Bookmarks", "Favorites", "History", "Actions"]
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // Main content
                VStack(spacing: 20) {
                    // Tabs, Downloads, Settings, etc.
                    VStack(alignment: .leading, spacing: 25) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .font(.system(size: 25))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .scaleEffect(selectedOption == option ? 1.25 : 0.8)
                                .opacity(selectedOption == option ? 0.75 : 0.25)
                                .padding(.leading, selectedOption == option ? 20 : 0)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        self.selectedOption = option
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct Nigel_Previews: PreviewProvider {
    static var previews: some View {
        Nigel()
    }
}
