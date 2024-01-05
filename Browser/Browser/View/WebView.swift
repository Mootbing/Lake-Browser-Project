import Foundation
import UIKit
import WebKit
import SwiftUI
import Combine


// MARK: - WebViewHandlerDelegate
// For printing values received from web app
protocol WebViewHandlerDelegate
{
    func receivedJsonValueFromWebView(value: [String: Any?])
    func receivedStringValueFromWebView(value: String)
}

// MARK: - WebView
struct WebView: UIViewRepresentable, WebViewHandlerDelegate
{
   
    
    func receivedJsonValueFromWebView(value: [String : Any?])
    {
        print("JSON value received from web is: \(value)")
    }
    
    func receivedStringValueFromWebView(value: String)
    {
        print("String value received from web is: \(value)")
    }
    
    var url: WebUrlType
    // Viewmodel object
    @ObservedObject var viewModel: ViewModel
    
    // Make a coordinator to co-ordinate with WKWebView's default delegate functions
    func makeCoordinator() -> Coordinator
    {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView
    {
        // Enable javascript in WKWebView
        let preferences = WKPreferences()
        let configuration = WKWebViewConfiguration()
        // Here "iOSNative" is our delegate name that we pushed to the website that is being loaded
        configuration.userContentController.add(self.makeCoordinator(), name: "iOSNative")
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
       
       return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context)
    {
        if url == .publicUrl
        {
            // Load a public website, for example I used here google.com
            if let url = URL(string: "https://www.google.com")
            {
                webView.load(URLRequest(url: url))
            }
        }
        else
        {
            print("Nothing to load")
        }
    }
   
    
    
    class Coordinator : NSObject, WKNavigationDelegate
    {
        var parent: WebView
        var delegate: WebViewHandlerDelegate?
        var valueSubscriber: AnyCancellable? = nil
        var webViewNavigationSubscriber: AnyCancellable? = nil
      
        
        init(_ uiWebView: WebView)
        {
            self.parent = uiWebView
            self.delegate = parent
        }
        deinit
        {
            valueSubscriber?.cancel()
            webViewNavigationSubscriber?.cancel()
        }
        
        //to get URL
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
        {
            finishedNavigation = true
            
            if !DatabaseModel.isChengHuaMode
            {
                if let URL = webView.url{
                    self.parent.viewModel.showWebTitle.send(URL.absoluteString)
                    
                    if !DatabaseModel.isChengHuaMode
                    {
                        DatabaseModel.history.append(DatabaseModel.makeURLObject(URL: URL))
                    }
                }
            }
        
//            webView.evaluateJavaScript("document.location.href")
//            { (response, error) in
//                
//                if let error = error
//                {
//                    print("Error getting url")
//                    print(error.localizedDescription)
//                }
//                
//                guard let title = response as? String else
//                {
//                    return
//                }
//                
//                self.parent.viewModel.showWebTitle.send(title)
//                
//                if !DatabaseModel.isChengHuaMode
//                {
//                    DatabaseModel.history.append(DatabaseModel.makeURLObject(URL: URL(string: title)!))
//                }
//            }
            
            /* An observer that observes 'viewModel.valuePublisher' to get value from TextField and
             pass that value to web app by calling JavaScript function */
            valueSubscriber = parent.viewModel.valuePublisher.receive(on: RunLoop.main).sink(receiveValue: { value in
               
                if let url = URL(string: value)
                {
                    let request = URLRequest(url: url)
                    webView.load(request)
                }
            })
            
            // Page loaded so no need to show loader anymore
            self.parent.viewModel.showLoader.send(false)
           
        }
        
        
       
        
        
        /* Here I implemented most of the WKWebView's delegate functions so that you can know them and
         can use them in different necessary purposes */
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView)
        {
            // Hides loader
            parent.viewModel.showLoader.send(false)
        }
        
    
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
        {
            // Hides loader
            parent.viewModel.showLoader.send(false)
        }
        
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
        {
            // Shows loader
            parent.viewModel.showLoader.send(true)
        }
        
        
        
        var finishedNavigation = false
        
        @objc func showTimerEndedMessage()
        {
//            print("timer ended")
            parent.viewModel.showLoader.send(false)
        }
        func createTimer() -> Timer
        {
            return  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(showTimerEndedMessage), userInfo: nil, repeats: false)
        }
    
    
        //reload, left, right
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
        {
//            print("start navigation")
            // Shows loader
            parent.viewModel.showLoader.send(true)
            self.webViewNavigationSubscriber = self.parent.viewModel.webViewNavigationPublisher.receive(on: RunLoop.main).sink(receiveValue: { navigation in
                
//                print("NAVIGATION:", navigation)
                switch navigation
                {
                    
                    case .backward:
                        if webView.canGoBack
                        {
                            webView.goBack()
                        }
                    case .forward:
                        if webView.canGoForward
                        {
                            webView.goForward()
                        }
                    case .reload:
                        webView.reload()
                }
                
                print("sending")
                print(webView.url?.absoluteString ?? "")
                self.parent.viewModel.showWebTitle.send(webView.url?.absoluteString ?? "")
            })
            
            _ = createTimer()
        }
       
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
        {
            // Suppose you don't want your user to go a restricted site
            // Here you can get many information about new url from 'navigationAction.request.description'
            
            if let host = navigationAction.request.url?.host
            {
//                print(host)
                if host == "restricted.com"
                {
                    // This cancels the navigation
                    decisionHandler(.cancel)
                    return
                }
            }
            // This allows the navigation
            decisionHandler(.allow)
        }
    }
}

// MARK: - Extensions
extension WebView.Coordinator: WKScriptMessageHandler
{
   
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
        // Make sure that your passed delegate is called
        if message.name == "iOSNative"
        {
            if let body = message.body as? [String: Any?]
            {
                delegate?.receivedJsonValueFromWebView(value: body)
            }
            else if let body = message.body as? String
            {
                delegate?.receivedStringValueFromWebView(value: body)
            }
        }
    }
}

