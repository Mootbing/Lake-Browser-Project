import SwiftUI

struct HomeView: View {
    let options = ["Tabs", "Settings", "Bookmarks", "Favorites", "History", "Share"]
    let additionalTexts = ["Option 1", "Option 2", "Option 3", "Option 4", "Scuff"] // Example additional texts
    
    @State private var SearchBar : GlassMorphicSearchBar;
    
    init (SearchBar: GlassMorphicSearchBar){
        _SearchBar = State(initialValue: SearchBar)
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .red]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.75)
                
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
                    SearchBar.taskbar()
                }
                    .padding(.leading, 35)
                    .padding(.trailing, 35)
                    .padding(.top, 50)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            SearchBar: GlassMorphicSearchBar()
        )
    }
}
