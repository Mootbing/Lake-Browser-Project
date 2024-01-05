import SwiftUI

enum SwipeDirection {
    case up
    case down
    case left
    case right
    case none
}

struct GlassMorphicSearchBar: View {
    @State private var searchText = "0.0.0.0"
    @State private var isSecure = false;
    @State private var ending = "";
    @State private var showToolsets = false;
    
    @State public var URL = "defaulturlglassmorph"
    
    @State private var isSwiping = false;

    // Variable to store the callback function
    private var onClick: () -> Void = {}
    private var onURLChange: (String) -> Void = {newURL in}
    private var onSwipe: (SwipeDirection) -> Void = {swipe in}
    
    init() {}

    // Initialize the class with the callback function
    init(onClick: @escaping () -> Void, onSwipe: @escaping (SwipeDirection) -> Void, URL: String) {
        //remember to change below if anything changes here
        self.onClick = onClick;
        _URL = State(initialValue: URL)
        
        self.onSwipe = onSwipe;
    }
    
    init(onClick: @escaping () -> Void, onSwipe: @escaping (SwipeDirection) -> Void, URL: String, onURLChange: @escaping (String) -> Void, showToolsets: Bool) {
        // If anything changes here, remember to change above
        self.onClick = onClick
        _URL = State(initialValue: URL)
        
        self.onURLChange = onURLChange
        _showToolsets = State(initialValue: showToolsets)
        
        self.onSwipe = onSwipe
    }
    
    func advanced() -> GlassMorphicSearchBar {
        return GlassMorphicSearchBar(
            onClick: onClick,
            onSwipe: onSwipe,
            URL: URL,
            onURLChange: { newURL in
                URL = newURL
            },
            showToolsets: true
        )
    }
    
    func ProcessURL(URL: String) {
        let validator = URLValidator(urlString: self.URL)
        (self.isSecure, self.searchText, self.ending) = validator.validateAndSplit()
    }
    
    func setURL(newURL: String) {
        self.URL = URL
        onURLChange(newURL)
    }

    var body: some View {
        ZStack {
            // Background with glass morphism effect
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.25))
                .background(
                    VisualEffectView(effect: UIBlurEffect(style: .light))
                )
                .background(Color.white.opacity(0.05))
                .frame(height: 60) // Adjust to your Figma design height
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            
                            if isSwiping {
                                return
                            }
                            
                            let swipeThreshold: CGFloat = 10 // Adjust as needed
                            let translation = gesture.translation.width
                            
                            let swipeThresholdH: CGFloat = 5 // Adjust as needed
                            let translationH = gesture.translation.height
                            
                            var dir: SwipeDirection = .none;
                            
                            if translation > swipeThreshold {
                                // Swiped right
                                print("previous")
                                isSwiping = true
                                dir = .right;
                            } else if translation < -swipeThreshold {
                                // Swiped left
                                print("next")
                                isSwiping = true
                                dir = .left;
                            }
                            else if translationH > swipeThresholdH {
                                print ("down")
                                isSwiping = true
                                dir = .down;
                            }
                            else if translationH < -swipeThreshold {
                                print ("up")
                                isSwiping = true
                                dir = .up;
                            }
                            
                            if dir != .none {
                                onSwipe(dir)
                            }
                            else {
                                print("asdf")
                            }
                        }
                        .onEnded { _ in
                            isSwiping = false;
                        }
                )
            
            Button(action: onClick) {
                HStack {
                    // Placeholder/Text field
                    HStack {
                        if !(ending == "" && searchText == "What's on your mind?") {
                            Image(systemName: isSecure ? "lock.fill" : "lock.open.fill")
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .kerning(2)
                                .foregroundColor(.white)
                                .padding(.leading, showToolsets ? 20 : 0)
                        }
                        Text(searchText)
                            .font(.system(size: 15))
                            .fontWeight(.bold)
                            .kerning(1.5)
                            .foregroundColor(.white)
                            .padding(.leading, 0)
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
                    if showToolsets {
                        Spacer() // Pushes all elements to the sides

                        // Copy icon
                        Button(action: {
                            UIPasteboard.general.string = URL
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        }
                        .frame(width: 32, height: 32) // Adjust to your Figma design
                        .background(Circle() // This will create the circular shape for the background
                            .stroke(Color.white.opacity(0.25), lineWidth: 2)) // This adds the border with 0.8 opacity and 1px width
                        .clipShape(Circle())
                        .padding(.trailing, 5) // Adjust to your Figma design

                        // Clear icon
                        Button(action: {
                            searchText = "What's on your mind?"
                            ending = ""
                            isSecure = false
                            showToolsets = false
                            
                            setURL(newURL: URLValidator.baseURLSearch)
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 12))
                        }
                        .frame(width: 32, height: 32) // Adjust to your Figma design
                        .background(Color.white.opacity(0.25))
                        .clipShape(Circle())
                        .padding(.trailing, 20) // Adjust to your Figma design
                    }
                }
            }
            .frame(height: 50) // Adjust to your Figma design height
        }
        .cornerRadius(20)
        .onChange(of: URL) { newURL in
            ProcessURL(URL: URL)
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
