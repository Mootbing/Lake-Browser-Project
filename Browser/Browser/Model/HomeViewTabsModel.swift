//
//  HomeViewTabsModel.swift
//  Browser
//
//  Created by Cowland Xu on 1/6/24.
//

import Foundation

public class HomeViewTabsModel {
    
    public static func MakeTabsModel() -> [String: [SettingButton]] {
        return ["": [SettingButton(label: "N/A", icon: "cross")]]
    }
    
    public static func MakeTabsModel(viewModel: ViewModel, refreshViewCallback: @escaping () -> Void, closeDrawerCallback: @escaping () -> Void) -> [String: [SettingButton]] {
        
        //static but refreshing
        let StaticTabModels: [String: [SettingButton]] = [
            "For You": [
                //, toggle: GlassMorphicSearchBar.DefaultURL == "https://google.com"
                SettingButton(label: "Google", icon: "g.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.google.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "YouTube", icon: "y.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.youtube.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Facebook", icon: "f.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.facebook.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Amazon", icon: "a.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.amazon.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Twitter", icon: "t.circle", onClick: {
                    viewModel.valuePublisher.send("https://twitter.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Instagram", icon: "camera", onClick: {
                    viewModel.valuePublisher.send("https://www.instagram.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "LinkedIn", icon: "l.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.linkedin.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Netflix", icon: "n.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.netflix.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Reddit", icon: "r.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.reddit.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Wikipedia", icon: "w.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.wikipedia.org")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Microsoft", icon: "m.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.microsoft.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Apple", icon: "a.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.apple.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Yahoo", icon: "y.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.yahoo.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Pinterest", icon: "p.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.pinterest.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Etsy", icon: "e.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.etsy.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "CNN", icon: "c.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.cnn.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "BBC", icon: "b.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.bbc.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Adobe", icon: "a.circle", onClick: {
                    viewModel.valuePublisher.send("https://www.adobe.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "GitHub", icon: "g.circle", onClick: {
                    viewModel.valuePublisher.send("https://github.com")
                    closeDrawerCallback()
                }),
                SettingButton(label: "Stack Overflow", icon: "s.circle", onClick: {
                    viewModel.valuePublisher.send("https://stackoverflow.com")
                    closeDrawerCallback()
                }),
            ],
            "Settings": [
                SettingButton(label: "Chengcognito", icon: "person.slash", onClick: {
                    DatabaseModel.isChengHuaMode = !DatabaseModel.isChengHuaMode
                    refreshViewCallback()
                }, toggle: DatabaseModel.isChengHuaMode),
            ],
            "Search Engine": [
                SettingButton(label: "Google", icon: "g.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .google)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.google),
                SettingButton(label: "Bing", icon: "b.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .bing)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.bing),
                SettingButton(label: "YouTube", icon: "y.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .youtube)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.youtube),
                SettingButton(label: "Reddit", icon: "r.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .reddit)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.reddit),
                SettingButton(label: "DuckDuckGo", icon: "d.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .duckduckgo)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.duckduckgo),
                SettingButton(label: "AI", icon: "a.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .ai)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.ai),
                SettingButton(label: "Yandex", icon: "y.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .yandex)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.yandex),
                SettingButton(label: "Baidu", icon: "b.circle", onClick: {
                    URLValidator.changeBaseURL(choice: .baidu)
                    refreshViewCallback()
                }, toggle: URLValidator.selectedEngine == SearchEngineChoice.baidu)
            ],
        ];
        
        var TabsModel: [String: [SettingButton]] = [
            "History": (!DatabaseModel.history.isEmpty ? [SettingButton(label: "Clear", icon: "trash", onClick: {
                DatabaseModel.clearHistory()
                refreshViewCallback()
            }),SettingButton(label: "Remove", icon: "xmark", onClick: {
                DatabaseModel.popHistory()
                refreshViewCallback()
            }),] : []) + DatabaseModel.history.map {
                tabObj in
                SettingButton(label: tabObj.Title, icon: "network", onClick: {
                    viewModel.valuePublisher.send(tabObj.URL.absoluteString)
                    closeDrawerCallback()
                })
            },
            "Bookmarks": [SettingButton(label: "Add", icon: "plus", onClick: {
                DatabaseModel.addToBookmarks(tab: DatabaseModel.makeURLObject(URL: URL(string: GlassMorphicSearchBar.DefaultURL)!, Title: String(GlassMorphicSearchBar.DefaultURL.prefix(10))))
                refreshViewCallback()
            }),] + DatabaseModel.bookmarks.map {
                tabObj in
                SettingButton(label: tabObj.Title, icon: "bookmark", onClick: {
                    viewModel.valuePublisher.send(tabObj.URL.absoluteString)
                    closeDrawerCallback()
                })
            }
        ]
        
        for (key, value) in StaticTabModels {
            TabsModel[key, default: []].append(contentsOf: value)
        }
        
        return TabsModel
    }
}

//"Tabs": [SettingButton(label: "Add", icon: "plus", onClick: {
////                DatabaseModel.addToBookmarks(tab: DatabaseModel.makeURLObject(URL: URL(string: GlassMorphicSearchBar.DefaultURL)!))
////                refreshViewCallback()
//}),] + DatabaseModel.tabs.map {
//    tabObj in
//    SettingButton(label: "Tab", icon: "square.3.layers.3d.down.right")
//},
