//
//  HomeViewTabsModel.swift
//  Browser
//
//  Created by Cowland Xu on 1/6/24.
//

import Foundation

public class HomeViewTabsModel {
    
    public static func MakeTabsModel() -> [String: [SettingButton]] {
        
        //static but refreshing
        let StaticTabModels: [String: [SettingButton]] = [
            "For You": [
                SettingButton(label: "Google", icon: "g.circle", onClick: {
                    // Send URL to Google
                }), //toggle: GlassMorphicSearchBar.DefaultURL == currentURL
                SettingButton(label: "YouTube", icon: "y.circle", onClick: {
                    // Send URL to YouTube
                }),
                SettingButton(label: "Facebook", icon: "f.circle", onClick: {
                    // Send URL to Facebook
                }),
                SettingButton(label: "Amazon", icon: "a.circle", onClick: {
                    // Send URL to Amazon
                }),
                SettingButton(label: "Twitter", icon: "t.circle", onClick: {
                    // Send URL to Twitter
                }),
                SettingButton(label: "Instagram", icon: "i.circle", onClick: {
                    // Send URL to Instagram
                }),
                SettingButton(label: "LinkedIn", icon: "l.circle", onClick: {
                    // Send URL to LinkedIn
                }),
                SettingButton(label: "Netflix", icon: "n.circle", onClick: {
                    // Send URL to Netflix
                }),
                SettingButton(label: "Reddit", icon: "r.circle", onClick: {
                    // Send URL to Reddit
                }),
                SettingButton(label: "Wikipedia", icon: "w.circle", onClick: {
                    // Send URL to Wikipedia
                }),
                SettingButton(label: "Microsoft", icon: "m.circle", onClick: {
                    // Send URL to Microsoft
                }),
                SettingButton(label: "Apple", icon: "a.circle", onClick: {
                    // Send URL to Apple
                }),
                SettingButton(label: "Yahoo", icon: "y.circle", onClick: {
                    // Send URL to Yahoo
                }),
                SettingButton(label: "Netflix", icon: "n.circle", onClick: {
                    // Send URL to Netflix
                }),
                SettingButton(label: "Pinterest", icon: "p.circle", onClick: {
                    // Send URL to Pinterest
                }),
                SettingButton(label: "Etsy", icon: "e.circle", onClick: {
                    // Send URL to Etsy
                }),
                SettingButton(label: "CNN", icon: "c.circle", onClick: {
                    // Send URL to CNN
                }),
                SettingButton(label: "BBC", icon: "b.circle", onClick: {
                    // Send URL to BBC
                }),
                SettingButton(label: "Adobe", icon: "a.circle", onClick: {
                    // Send URL to Adobe
                }),
                SettingButton(label: "GitHub", icon: "g.circle", onClick: {
                    // Send URL to GitHub
                }),
                SettingButton(label: "Stack Overflow", icon: "s.circle", onClick: {
                    // Send URL to Stack Overflow
                }),
                SettingButton(label: "CNN", icon: "c.circle", onClick: {
                    // Send URL to CNN
                }),
                SettingButton(label: "BBC", icon: "b.circle", onClick: {
                    // Send URL to BBC
                }),
                SettingButton(label: "Adobe", icon: "a.circle", onClick: {
                    // Send URL to Adobe
                }),
                SettingButton(label: "GitHub", icon: "g.circle", onClick: {
                    // Send URL to GitHub
                }),
            ],
            "Settings": [
                SettingButton(label: "Chengcognito", icon: "person.slash", onClick: {
                    DatabaseModel.isChengHuaMode = !DatabaseModel.isChengHuaMode
                }, toggle: DatabaseModel.isChengHuaMode),
            ],
            "Search Engine": [
                SettingButton(label: "Google", icon: "g.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .google)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.google),
                SettingButton(label: "Bing", icon: "b.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .bing)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.bing),
                SettingButton(label: "YouTube", icon: "y.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .youtube)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.youtube),
                SettingButton(label: "Reddit", icon: "r.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .reddit)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.reddit),
                SettingButton(label: "DuckDuckGo", icon: "d.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .duckduckgo)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.duckduckgo),
                SettingButton(label: "AI", icon: "a.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .ai)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.ai),
                SettingButton(label: "Yandex", icon: "y.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .yandex)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.yandex),
                SettingButton(label: "Baidu", icon: "b.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .baidu)
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.baidu)
            ],
        ];
        
        var TabsModel: [String: [SettingButton]] = [
            "Tabs": [SettingButton(label: "Add", icon: "plus", onClick: {
                
            }),] + DatabaseModel.tabs.map {
                tabObj in
                SettingButton(label: "Tab", icon: "square.3.layers.3d.down.right")
            },
            "History": [SettingButton(label: "Clear", icon: "trash", onClick: {
                
            }),SettingButton(label: "Remove", icon: "xmark", onClick: {
                
            }),] + DatabaseModel.history.map {
                tabObj in
                SettingButton(label: "History", icon: "network")
            },
            "Bookmarks": [SettingButton(label: "Add", icon: "plus", onClick: {
                
            }),] + DatabaseModel.bookmarks.map {
                tabObj in
                SettingButton(label: "Bookmark", icon: "bookmark")
            }
        ]
        
        for (key, value) in StaticTabModels {
            TabsModel[key, default: []].append(contentsOf: value)
        }
        
        return TabsModel
    }
}
