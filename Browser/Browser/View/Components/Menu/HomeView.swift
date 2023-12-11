import SwiftUI

struct Nigel: View {
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
                    ScrollView() {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(options, id: \.self) { option in
                                InformationRow(
                                    title: option,
                                    buttons: additionalTexts
                                )
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    GlassMorphicSearchBar()
                }
                    .padding(.leading, 35)
                    .padding(.trailing, 35)
            }
        }
    }
}

struct Nigel_Previews: PreviewProvider {
    static var previews: some View {
        Nigel()
    }
}
