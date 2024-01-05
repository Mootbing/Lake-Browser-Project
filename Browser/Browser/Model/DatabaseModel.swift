//
//  DatabaseModel.swift
//  Browser
//
//  Created by Cowland Xu on 1/4/24.
//

import Foundation

public class TabObject {
    private var URL: URL;
    
    init(URL: URL) {
        self.URL = URL
    }
}

public class DatabaseModel {
    static var tabs: [TabObject] = []
    static var history: [TabObject] = []
    static var favorites: [TabObject] = []
    static var bookmarks: [TabObject] = []
    static var isChengHuaMode = false;

    static func makeURLObject(URL: URL) -> TabObject {
        return TabObject(URL: URL)
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
        print(history)
    }

    static func removeFromHistory(tab: TabObject) {
        history = history.filter { $0 !== tab }
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
