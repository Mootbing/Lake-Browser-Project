
import Foundation
import Combine
//https://www.avanderlee.com/swift/combine/
//https://www.techtarget.com/whatis/definition/Model-View-ViewModel

public class ViewModel: ObservableObject
{
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var urlActual = PassthroughSubject<String, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
    var titleActual = PassthroughSubject<String, Never> ()
}

// For identifiying WebView's forward and backward navigation
enum WebViewNavigation
{
    case backward, forward, reload
}

// For identifying what type of url should load into WebView
enum WebUrlType
{
    case localUrl, publicUrl
}
