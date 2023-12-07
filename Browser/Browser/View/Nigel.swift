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
                
                LinearGradient(gradient: Gradient(colors: [.black, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.75)
                
                // Main content
                VStack(spacing: 20) {
                    // Tabs, Downloads, Settings, etc.
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(options, id: \.self) { option in
                            VStack(alignment: .leading) {
                                Text(option)
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .scaleEffect(selectedOptions.contains(option) ? 1.2 : 1)
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
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 20) {
                                            ForEach(additionalTexts, id: \.self) { text in
                                                Text(text)
                                                    .foregroundColor(.white)
                                                    .padding(25)
                                                    .offset(x: selectedOptions.contains(option) ? 0 : 500)
                                                    .font(.system(size: 12))
                                            }
                                        }
                                  }
                                    .background(Color.white.opacity(0.05))
                                    .cornerRadius(20)
                                    .opacity(selectedOptions.contains(option) ? 1 : -1)
                                    .padding(.bottom, selectedOptions.contains(option) ? 0 : -60)
                                    .offset(y: selectedOptions.contains(option) ? 0 : -50)
                                    .animation(.easeOut(duration: 0.5), value: selectedOptions.contains(option))
//                                    .scaleEffect(selectedOptions.contains(option) ? 1 : 0)
                                }
                            }
                        }
                    }
                }
                .padding(.leading, 50)
                .padding(.trailing, 50)
                
//                GlassMorphicSearchBar()
            }
        }
    }
}

struct Nigel_Previews: PreviewProvider {
    static var previews: some View {
        Nigel()
    }
}
