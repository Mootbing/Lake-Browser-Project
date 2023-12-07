import SwiftUI

struct WebsiteCreator: View
{
    @ObservedObject var viewModel = ViewModel()
    @State var showLoader = false
    @State var message = ""
    @State var webTitle = ""
    @State var validator = URLValidator(urlString: "")
    
    var group = Group
    {
        Spacer()
        Divider()
        Spacer()
    }
    
    //NAVIGATION VIEW
    // For WebView's forward, backward, and reload navigation
    var webViewNavigationBar: some View
    {
        
        VStack(spacing: 0)
        {
            Divider()
            HStack
            {
                Spacer()
                Button(action: {self.viewModel.webViewNavigationPublisher.send(.backward)})
                {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                group
                Button(action: {self.viewModel.webViewNavigationPublisher.send(.forward)})
                {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
               group
                Button(action: {self.viewModel.webViewNavigationPublisher.send(.reload)})
                {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray).padding(.bottom, 4)
                }
                Spacer()
            }.frame(height: 50)
            Divider()
        }
    }
    
    
    
    //BROWSER VIEW
    var body: some View
    {
        ZStack
        {
            VStack(spacing: 0)
            {
                
                HStack
                {
                    TextField("Search or enter address", text: $message).textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        .autocapitalization(.none)
                        .keyboardType(.URL)
                        .onSubmit
                        {
                            //message = validator.fixURL(urlString: message)
                            self.viewModel.valuePublisher.send(message)
                        }
                    
                    Button(action: {self.viewModel.valuePublisher.send(self.message)})
                    {
                        Text("GO")
                            .padding(.trailing, 10)
                            .padding(.leading, 10)
                            .padding(.top, 4)
                            .padding(.bottom, 4)
                            .overlay (RoundedRectangle(cornerRadius: 4, style: .circular)
                                     .stroke(Color.gray, lineWidth: 0.5))
                    }
                }.padding()
                
                WebView(url: .publicUrl, viewModel: viewModel)
                             .overlay (RoundedRectangle(cornerRadius: 4, style: .circular)
                             .stroke(Color.gray, lineWidth: 1.8))
                             .padding(.leading, 1).padding(.trailing, 1)
                
                webViewNavigationBar
            }
            .onReceive(self.viewModel.showLoader.receive(on: RunLoop.main))
            { value in
                self.showLoader = value
            }

            if showLoader
            {
                LoadingView()
            }
        }
    }
    
    
}
