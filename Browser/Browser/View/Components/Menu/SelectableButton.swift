import SwiftUI

struct SelectableButton: View {
    var btnObj : SettingButton;
    @State var selected = false;
    
    init(btnObj: SettingButton) {
        self.btnObj = btnObj
        self.selected = btnObj.toggle ?? false
    }
    
    var body: some View {
        Button(action: btnObj.onClick) {
            Image(systemName: btnObj.icon)
                .foregroundColor(.white)
                .font(.system(size: 12))
        }
            .frame(width: 32, height: 32) // Adjust to your Figma design
            .background(Color.white.opacity(selected ? 0.25 : 0.05))
            .clipShape(Circle())
            .padding(.top, 10)
        
        Text(btnObj.label)
            .foregroundColor(.white)
            .opacity(0.75)
            .fontWeight(.semibold)
            .padding(.top, 3)
            .kerning(1)
            .font(.system(size: 12))
            .padding(.top, -30)
    }
}

