import SwiftUI

struct Nigel: View {
    @State private var selectedOptions: Set<String> = []

    let options = ["Tabs", "Downloads", "Settings", "Bookmarks", "Favorites", "History", "Actions"]
    let additionalTexts = ["Option 1", "Option 2", "Option 3"] // Example additional texts

    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [.red, .purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                // Main content
                VStack(spacing: 20) {
                    // Tabs, Downloads, Settings, etc.
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(options, id: \.self) { option in
                            VStack(alignment: .leading) {
                                Text(option)
                                    .font(.system(size: 25))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .scaleEffect(selectedOptions.contains(option) ? 1.5 : 1)
                                    .opacity(selectedOptions.contains(option) ? 0.75 : 0.25)
                                    .padding(.leading, selectedOptions.contains(option) ? 20 : 0)
                                    .padding(.top, selectedOptions.contains(option) ? 10 : 0)
                                    .padding(.bottom, selectedOptions.contains(option) ? 10 : 0)
                                    .onTapGesture {
                                        withAnimation(.spring()) {
                                            if selectedOptions.contains(option) {
                                                selectedOptions.remove(option)
                                            } else {
                                                selectedOptions.insert(option)
                                            }
                                        }
                                    }
                                HStack(spacing: 20) {
                                    if selectedOptions.contains(option) {
                                        HStack {
                                            ForEach(additionalTexts, id: \.self) { text in
                                                Text(text)
                                                    .foregroundColor(.white)
                                                    .padding()
                                            }
                                        }
                                        .scaleEffect(1.2)
                                        .transition(.slide)
                                        .animation(.spring(), value: selectedOptions)
                                    }
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
