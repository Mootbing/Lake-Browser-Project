import SwiftUI

struct SelectableButton: View {
    var title = "";
    var icon = "xmark"
    @State var selected = false;
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 12))
        }
            .frame(width: 32, height: 32) // Adjust to your Figma design
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
        
        Text(title)
            .foregroundColor(.white)
            .opacity(0.75)
            .fontWeight(.semibold)
            .padding(.top, 3)
            .kerning(1)
            .font(.system(size: 12))
    }
}

struct SelectableButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectableButton()
    }
}
