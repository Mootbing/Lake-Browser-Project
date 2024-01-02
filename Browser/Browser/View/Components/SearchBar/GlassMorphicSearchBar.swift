import SwiftUI

struct GlassMorphicSearchBar: View {
    @State private var searchText = "0.0.0.0"
    @State private var isSecure = false;
    @State private var ending = "";
    
    @State public var URL = "https://youtube.com"
    
    // Define a callback function type
    typealias CallbackFunction = () -> Void

    // Variable to store the callback function
    private var onClick: CallbackFunction

    // Initialize the class with the callback function
    init(onClick: @escaping CallbackFunction, URL: String) {
        self.onClick = onClick;
        _URL = State(initialValue: URL)
//        self.ProcessURL(URL: URL)
//        self.URL = URL;
    }
    
    func ProcessURL(URL: String) {
        let URL = self.URL
        
        var prechoppedURL = "";
        
        self.isSecure = !URL.starts(with: "http://")
        if let searchTextRange = URL.range(of: "://") {
            let startIndex = URL.index(searchTextRange.upperBound, offsetBy: 0)
            prechoppedURL = String(URL[startIndex...])
        }
        else {
            prechoppedURL = self.URL
        }
        
        //get URL ending and assign to ending variable
        if let lastDotIndex = prechoppedURL.lastIndex(of: ".") {
            let afterLastDotIndex = prechoppedURL.index(after: lastDotIndex)
            self.ending = String(prechoppedURL[afterLastDotIndex...])
            prechoppedURL = String(prechoppedURL[...lastDotIndex])
        }
        
        self.searchText = prechoppedURL
    }

    var body: some View {
        ZStack {
            // Background with glass morphism effect
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.25))
//                .background(
//                    VisualEffectView(effect: UIBlurEffect(style: .dark))
//                )
                .background(Color.white.opacity(0.05))
                .frame(height: 60) // Adjust to your Figma design height
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
            
            Button(action: onClick) {
                HStack {
                    // Placeholder/Text field
                    HStack {
                        Image(systemName: isSecure ? "lock.fill" : "lock.open.fill")
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .kerning(2)
                            .foregroundColor(.white)
                            .padding(.leading, -7)
                        Text(searchText)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .kerning(1.5)
                            .foregroundColor(.white)
                            .padding(.leading, -2)
                            .textCase(.uppercase)
                        Text(ending)
                            .font(.system(size: 8))
                            .kerning(1)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .padding(.leading, -7)
                            .padding(.top, 4)
                            .textCase(.lowercase)
                    }
                    //coda
                }
            }
            .frame(height: 50) // Adjust to your Figma design height
        }
        .cornerRadius(20)
        .onChange(of: URL) { newURL in
            ProcessURL(URL: newURL)
        }
        .onAppear {
            ProcessURL(URL: URL)
        }
    }
}

// SwiftUI View to create a UIVisualEffectView for the blur effect
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

struct GlassMorphicSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        GlassMorphicSearchBar(
            onClick: {
                
            },
            URL: "https://GlassMorphicSearchBar.com"
        )
    }
}

//                                    Spacer() // Pushes all elements to the sides
//
//                                    // Search icon
//                                    Button(action: {
//                                        // Define action
//                                    }) {
//                                        Image(systemName: "magnifyingglass")
//                                            .foregroundColor(.white)
//                                            .font(.system(size: 12))
//                                    }
//                                    .frame(width: 32, height: 32) // Adjust to your Figma design
//                                    .background(Circle() // This will create the circular shape for the background
//                                        .stroke(Color.white.opacity(0.25), lineWidth: 2)) // This adds the border with 0.8 opacity and 1px width
//                                    .clipShape(Circle())
//                                    .padding(.trailing, 10) // Adjust to your Figma design
//
//                                    // Clear icon
//                                    Button(action: {
//                                        searchText = ""
//                                        // Define additional action if needed
//                                    }) {
//                                        Image(systemName: "xmark")
//                                            .foregroundColor(.white)
//                                            .font(.system(size: 12))
//                                    }
//                                    .frame(width: 32, height: 32) // Adjust to your Figma design
//                                    .background(Color.white.opacity(0.25))
//                                    .clipShape(Circle())
//                                    .padding(.trailing, 20) // Adjust to your Figma design
