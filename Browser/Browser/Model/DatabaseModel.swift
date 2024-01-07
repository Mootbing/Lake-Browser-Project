//
//  DatabaseModel.swift
//  Browser
//
//  Created by Cowland Xu on 1/4/24.
//

import Foundation

public class TabObject {
    public var URL: URL;
    public var Title: String;
    
    init(URL: URL, Title: String) {
        self.URL = URL
        self.Title = Title
    }
}

public class DatabaseModel {
    static var tabs: [TabObject] = []
    static var history: [TabObject] = []
    static var favorites: [TabObject] = []
    static var bookmarks: [TabObject] = []
    static var isChengHuaMode = false;

    static func makeURLObject(URL: URL, Title: String) -> TabObject {
        return TabObject(URL: URL, Title: Title)
    }

    static func addTab(tab: TabObject) {
        tabs.append(tab)
//        print(tabs)
    }

    static func removeTab(tab: TabObject) {
        tabs = tabs.filter { $0 !== tab }
    }

    static func addToHistory(tab: TabObject) {
        history.append(tab)
    }

    static func removeFromHistory(tab: TabObject) {
        history = history.filter { $0 !== tab }
    }
    
    static func popHistory() {
        
        if history.isEmpty {
            return
        }
        
        history.removeLast()
    }
    
    static func clearHistory () {
        history = []
    }

    static func addToFavorites(tab: TabObject) {
        favorites.append(tab)
    }

    static func removeFromFavorites(tab: TabObject) {
        favorites = favorites.filter { $0 !== tab }
    }

    static func addToBookmarks(tab: TabObject) {
        bookmarks.append(tab)
    }

    static func removeFromBookmarks(tab: TabObject) {
        bookmarks = bookmarks.filter { $0 !== tab }
    }
}
