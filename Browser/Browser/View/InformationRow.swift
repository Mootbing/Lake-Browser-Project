import SwiftUI

struct InformationRow: View {
    var title = "";
    var buttons = ["asdf"];
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
                        selected = !selected
                    }
                }
            HStack(spacing: 20) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(buttons, id: \.self) { text in
                            VStack() {
                                SelectableButton()
                            }
                                .padding(.leading, 30)
                                .padding(.top, 30)
                                .padding(.bottom, 30)
                                .opacity(selected ? 1 : -3)
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
