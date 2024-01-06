//
//  HomeViewTabsModel.swift
//  Browser
//
//  Created by Cowland Xu on 1/6/24.
//

import Foundation

public class HomeViewTabsModel {
    
    //array of structs
    static let StaticTabModels: [String: [SettingButton]] = [
        "Settings": [
            SettingButton(label: "Chengcognito", icon: "person.slash", onClick: {
                DatabaseModel.isChengHuaMode = true
            }),
        ],
        "Search Engine": [
            SettingButton(label: "Google", icon: "g.circle", onClick: {
                URLValidator.changeBaseURL(choice: .google)
            }),
            SettingButton(label: "Bing", icon: "b.circle", onClick: {
                URLValidator.changeBaseURL(choice: .bing)
            }),
            SettingButton(label: "YouTube", icon: "y.circle", onClick: {
                URLValidator.changeBaseURL(choice: .youtube)
            }),
            SettingButton(label: "Reddit", icon: "r.circle", onClick: {
                URLValidator.changeBaseURL(choice: .reddit)
            }),
            SettingButton(label: "DuckDuckGo", icon: "d.circle", onClick: {
                URLValidator.changeBaseURL(choice: .duckduckgo)
            }),
            SettingButton(label: "AI", icon: "a.circle", onClick: {
                URLValidator.changeBaseURL(choice: .ai)
            }),
            SettingButton(label: "Yandex", icon: "y.circle", onClick: {
                URLValidator.changeBaseURL(choice: .yandex)
            }),
            SettingButton(label: "Baidu", icon: "b.circle", onClick: {
                URLValidator.changeBaseURL(choice: .baidu)
            })
        ],
//        "Share": [
//            SettingButton(
//                label: "iMsg", icon: "bubble", onClick: {
//                    //forward link to imessage
//                }
//            )
//        ]
    ];
    
    public static func MakeTabsModel() -> [String: [SettingButton]] {
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
        
        for (key, value) in HomeViewTabsModel.StaticTabModels {
            TabsModel[key, default: []].append(contentsOf: value)
        }
        
        return TabsModel
    }
}
