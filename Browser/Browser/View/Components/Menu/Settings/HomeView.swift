import SwiftUI

struct HomeView: View {
    
    var HomeViewTabs: [String: [SettingButton]];
    @State private var SearchBar : GlassMorphicSearchBar;
    
    init (SearchBar: GlassMorphicSearchBar, HomeViewTabs: [String: [SettingButton]]){
        _SearchBar = State(initialValue: SearchBar)
        self.HomeViewTabs = HomeViewTabs
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
                            let keyValuePairs = HomeViewTabs.sorted { $0.key < $1.key }
                            ForEach(keyValuePairs, id: \.key) { (title, buttons) in
                                InformationRow(title: title, buttons: buttons)
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    SearchBar.advanced()
                }
                    .padding(.leading, 35)
                    .padding(.trailing, 35)
                    .padding(.top, 50)
            }
        }
    }
}
