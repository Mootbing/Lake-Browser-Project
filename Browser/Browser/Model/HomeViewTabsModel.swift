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
            "Tabs": DatabaseModel.tabs.map {
                tabObj in
                SettingButton(label: "tab", icon: "square.3.layers.3d.down.right")
            },
            "History": DatabaseModel.history.map {
                tabObj in
                SettingButton(label: "history", icon: "network")
            }
        ]
        
        for (key, value) in StaticTabModels {
            TabsModel[key, default: []].append(contentsOf: value)
        }
        
        return TabsModel
    }
}
