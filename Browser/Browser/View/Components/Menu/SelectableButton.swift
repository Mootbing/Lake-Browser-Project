import SwiftUI

struct SelectableButton: View {
    @State var btnObj : SettingButton;
    
    init(btnObj: SettingButton) {
        _btnObj = State(initialValue: btnObj)
    }
    
    var body: some View {
        Button(action: btnObj.onClick) {
            Image(systemName: btnObj.icon)
                .foregroundColor(.white)
                .font(.system(size: 12))
        }
            .frame(width: 32, height: 32) // Adjust to your Figma design
            .background(Color.white.opacity(btnObj.toggle ?? false ? 0.25 : 0.05))
            .clipShape(Circle())
            .padding(.top, 15)
        
        Text(btnObj.label)
            .foregroundColor(.white)
            .opacity(0.75)
            .fontWeight(.semibold)
            .padding(.top, 3)
            .kerning(1)
            .font(.system(size: 12))
            .padding(.top, -40)
            .padding(.bottom, -25)
    }
}

