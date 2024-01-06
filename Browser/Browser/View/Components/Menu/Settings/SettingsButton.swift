//
//  SettingsButton.swift
//  Browser
//
//  Created by Cowland Xu on 1/6/24.
//

import Foundation

public class SettingButton {
    var label = "NAME";
    var icon = "cross";
    var onClick: () -> Void = {};
    var toggle: Bool? = false
    
    init(label: String, icon: String, onClick: @escaping () -> Void = {}, toggle: Bool? = nil) {
        self.label = label
        self.icon = icon
        self.onClick = onClick
        self.toggle = toggle ?? false
    }
}
