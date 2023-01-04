//
//  V4Button.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

struct V4Button: View {
    let title: String
    let action: () -> Void
    let textColor: Color
    let backgroundColor: Color?
    
    init(title: String, textColor: Color = Preferences.colors.accentColor, backgroundColor: Color? = nil, action: @escaping () -> Void) {
        self.title = title
        self.textColor = textColor
        self.action = action
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(.bordered)
            .foregroundColor(textColor)
            .background(backgroundColor)
    }
}

struct V4Button_Previews: PreviewProvider {
    static var previews: some View {
        V4Button(title: "Test Button") {
            print("Test Button Pressed!")
        }
    }
}
