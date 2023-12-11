import SwiftUI

struct InformationRow: View {
    let title = "";
    let buttons = {};
    @State var selected = false;

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .scaleEffect(selected ? 1.2 : 1)
                .opacity(selected ? 0.75 : 0.25)
                .padding(.leading, selected ? 20 : 0)
                .padding(.top, selected ? 10 : 0)
                .padding(.bottom, selected ? 10 : 0)
                .onTapGesture {
                    withAnimation(.spring()) {
                        if selected {
                            selected = false
                        }
                    }
                }
            HStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(buttons, id: \.self) { text in
                            VStack() {
                                Button(action: {}) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                }
                                    .frame(width: 32, height: 32) // Adjust to your Figma design
                                    .background(Color.white.opacity(0.05))
                                    .clipShape(Circle())
                                
                                Text(text)
                                    .foregroundColor(.white)
                                    .opacity(0.75)
                                    .fontWeight(.semibold)
                                    .padding(.top, 3)
                                    .kerning(1)
                                    .font(.system(size: 12))
                            }
                                .padding(.leading, 30)
    //                                                        .padding(.trailing, 30)
                                .padding(.top, 30)
                                .padding(.bottom, 30)
    //                                                        .offset(x: selected ? 0 : 0)
                                .opacity(selected ? 1 : -3)
    //                                                        .offset(y: selected ? 0 : 20)
                        }
                    }
                }
                .background(Color.white.opacity(0.05))
                .cornerRadius(20)
                .opacity(selected ? 1 : -1)
                .padding(.bottom, selected ? 0 : -150)
                .offset(y: selected ? 0 : 50)
                .animation(.easeOut(duration: 0.5), value: selected)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.08), lineWidth: selected ? 1 : 0)
                )
            }
        }
    }
}

struct InformationRow_Previews: PreviewProvider {
    static var previews: some View {
        InformationRow()
    }
}
