import SwiftUI

struct GlassMorphicSearchBar: View {
    @State private var searchText = "YOUTUBE"

    var body: some View {
        ZStack {
            // Background with glass morphism effect
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.25))
                .background(
                    VisualEffectView(effect: UIBlurEffect(style: .dark))
                )
                .frame(height: 60) // Adjust to your Figma design height
            
            HStack {
                // Placeholder/Text field
                HStack {
                    Text(searchText)
                        .foregroundColor(Color.white.opacity(1))
                        .padding(.leading, 20) // Adjust to your Figma design
                        .bold()
                        .font(.system(size: 14))
                    Text(".COM")
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.leading, -7)
                        .bold()
                        .font(.system(size: 8))
                }
                
                Spacer() // Pushes all elements to the sides
                
                // Search icon
                Button(action: {
                    // Define action
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                }
                .frame(width: 32, height: 32) // Adjust to your Figma design
                .background(Circle() // This will create the circular shape for the background
                    .stroke(Color.white.opacity(0.25), lineWidth: 2)) // This adds the border with 0.8 opacity and 1px width
                .clipShape(Circle())
                .padding(.trailing, 10) // Adjust to your Figma design
                
                // Clear icon
                Button(action: {
                    searchText = ""
                    // Define additional action if needed
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
            .frame(height: 50) // Adjust to your Figma design height
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16) // Adjust to match the horizontal padding in your Figma design
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
        ZStack {
            GlassMorphicSearchBar()
                .previewLayout(.sizeThatFits)
        }
        .background(Color.black)
        .ignoresSafeArea(.all)
    }
}
