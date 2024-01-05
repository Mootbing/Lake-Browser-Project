import SwiftUI
import Combine

enum SwipeDirection {
    case up
    case down
    case left
    case right
    case none
}

struct GlassMorphicSearchBar: View {
    @State private var searchText = ""
    @State private var isSecure = false;
    @State private var ending = "";
    @State private var showToolsets = false;
    
    @State public var URL = ""
    public var URLSubscription = PassthroughSubject<String, Never>()
    
    @State public var swipeDir: SwipeDirection = .none;
    @State private var isEditing: Bool = false;

    // Variable to store the callback function
    private var onURLChange: (String) -> Void = {newURL in}
    private var onSwipe: (SwipeDirection) -> Void = {swipe in}
    
    init() {}
    
    init(URLSub: PassthroughSubject<String, Never>, onSwipe: @escaping (SwipeDirection) -> Void, newURL: String, onURLChange: @escaping (String) -> Void, showToolsets: Bool) {
        // If anything changes here, remember to change above
        _URL = State(initialValue: newURL)
        _showToolsets = State(initialValue: showToolsets)
        
        self.URLSubscription = URLSub
        self.onSwipe = onSwipe
        self.onURLChange = onURLChange
    }
    
    func taskbar() -> GlassMorphicSearchBar {
        return GlassMorphicSearchBar(
            URLSub: URLSubscription, onSwipe: onSwipe, newURL: URL, onURLChange: onURLChange, showToolsets: true
        )
    }
    
    func ProcessURL(newURL: String) -> String {
        let validator = URLValidator(urlString: newURL)
        (isSecure, searchText, ending) = validator.validateAndSplit()
        
        self.isSecure = isSecure
        self.searchText = searchText
        self.ending = ending
        
        return (isSecure ? "https://" : "http://") + searchText + ending
    }
    
    func setNewURLWithUIUpdate(newURL: String) {
        let processedURL = ProcessURL(newURL: newURL)
        self.URL = processedURL
//        onURLChange(self.URL)
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
                            
                            if swipeDir != .none {
                                return
                            }
                            
                            let swipeThreshold: CGFloat = 10 // Adjust as needed
                            let translation = gesture.translation.width
                            
                            let swipeThresholdH: CGFloat = 5 // Adjust as needed
                            let translationH = gesture.translation.height
                            
                            swipeDir = .none;
                            
                            if translation > swipeThreshold {
                                // Swiped right
//                                print("previous")
                                swipeDir = .right;
                            } else if translation < -swipeThreshold {
                                // Swiped left
//                                print("next")
                                swipeDir = .left;
                            }
                            else if translationH > swipeThresholdH {
//                                print ("down")
                                swipeDir = .down;
                            }
                            else if translationH < -swipeThreshold {
//                                print ("up")
                                swipeDir = .up;
                            }
                            
                            if swipeDir != .none {
                                onSwipe(swipeDir)
                            }
                        }
                        .onEnded { _ in
                            swipeDir = .none;
                        }
                )
                .gesture(
                    LongPressGesture(minimumDuration: 0.25) // Adjust the minimum duration as needed
                        .onChanged { _ in
                            //not working
                        }
                        .onEnded { _ in
//                            showToolsets = !showToolsets
                            isEditing = true
                        }
                )
//                .onTapGesture {
//                                        //pop over keyboard and get the text written
//                }
                
            if isEditing {
                let snapshot = URL
                TextField(self.URL, text: $URL, onCommit: {
                    isEditing = false
                    
                    if snapshot == URL {
                        return
                    }
                    
                    setNewURLWithUIUpdate(newURL: URL)
                    onURLChange(self.URL)
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(
                        VisualEffectView(effect: UIBlurEffect(style: .light))
                    )
                    .background(Color.white.opacity(0.05))
                    .frame(height: 50)
            }
            else {
                if swipeDir == .left {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                }
                else if swipeDir == .right {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                }
                else {
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
                            Text(searchText.prefix(10))
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .kerning(1.5)
                                .foregroundColor(.white)
                                .padding(.leading, 0)
                                .textCase(.uppercase)
                            Text(ending.split(separator: "/").first ?? "")
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
                                searchText = ""
                                ending = ""
                                isSecure = false
                                
                                URLSubscription.send(URLValidator.baseURLSearch)
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
                    .frame(height: 50) // Adjust to your Figma design height
                    .cornerRadius(20)
                    .onReceive(URLSubscription, perform: { newURL in
                        if newURL == URL {
                            return;
                        }
                        setNewURLWithUIUpdate(newURL: newURL);
                        isEditing = false;
                    })
                    .onAppear {
                        setNewURLWithUIUpdate(newURL: URL)
                    }
                }
            }
        }
            .cornerRadius(20)
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
