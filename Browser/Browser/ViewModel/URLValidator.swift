
import Foundation
import SwiftUI

enum SearchEngineChoice {
    case google
    case bing
    case youtube
    case reddit
    case duckduckgo
    case ai
    case baidu
    case yandex
}

public class URLValidator
{
    static let googleBase = "https://www.google.com/search?q="
    static let bingBase = "https://www.bing.com/search?q="
    static let youtubeBase = "https://www.youtube.com/results?search_query="
    static let redditBase = "https://www.reddit.com/search/?q="
    static let duckDuckGoBase = "https://duckduckgo.com/?q="
    static let AIBase = "https://www.bing.com/search?showconv=1&q="
    static let yandexBase = "https://yandex.com/search/?text="
    static let baiduBase = "https://www.baidu.com/s?wd="
    
    public static var baseURLSearch = googleBase
    
    static func changeBaseURL(choice: SearchEngineChoice) {
            switch choice {
            case .google:
                baseURLSearch = googleBase
            case .bing:
                baseURLSearch = bingBase
            case .youtube:
                baseURLSearch = youtubeBase
            case .reddit:
                baseURLSearch = redditBase
            case .duckduckgo:
                baseURLSearch = duckDuckGoBase
            case .ai:
                baseURLSearch = AIBase
            case .baidu:
                baseURLSearch = baiduBase
            case .yandex:
                baseURLSearch = yandexBase
            }
        }
    
    
    
    var urlString = ""
    
    init(urlString: String)
    {
        self.urlString = urlString
    }
    
    func validateAndSplit() -> (isSecure: Bool, searchText: String, ending: String) {
        
        var URL = self.urlString
        
        var searchText = "";
        var ending = "";
        var isSecure = true;
        
        //if searching without .smt ending
        //todo, check if there's content after .
        if !URL.contains(".") {
            URL = URLValidator.baseURLSearch + URL;
        }
        
        var prechoppedURL = "";
        
        isSecure = !URL.starts(with: "http://")
        if let searchTextRange = URL.range(of: "://") {
            let startIndex = URL.index(searchTextRange.upperBound, offsetBy: 0)
            prechoppedURL = String(URL[startIndex...])
        }
        else {
            prechoppedURL = URL
        }
        
        //get URL ending and assign to ending variable
        if let lastDotIndex = prechoppedURL.lastIndex(of: ".") {
            let afterLastDotIndex = prechoppedURL.index(after: lastDotIndex)
            ending = String(prechoppedURL[afterLastDotIndex...])
            prechoppedURL = String(prechoppedURL[...lastDotIndex])
        }
        
        searchText = prechoppedURL
        
        searchText = searchText.lowercased()
        
        if searchText.hasPrefix("www.") {
            searchText = String(searchText.dropFirst(4))
        }
        
        return (isSecure, searchText, ending)
    }
  
    
    
    //http vs https
    //dot in address
    //search engine
    //extensions
    //url format
    //correct url does not produce a site - timeout
    
    
    
    
}
