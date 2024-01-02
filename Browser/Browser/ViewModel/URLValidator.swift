
import Foundation
import SwiftUI

public class URLValidator
{
    var urlString = ""
    public let baseURLSearch = "https://www.google.com/search?q="
    
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
            URL = baseURLSearch + URL;
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
