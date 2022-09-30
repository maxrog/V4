//
//  V4Text.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

struct V4Text: View {
    let text: String
    let textColor: Color
    let backgroundColor: Color
    
    init(_ text: String? = nil, textColor: Color = Preferences.colors.textColor, backgroundColor: Color = .clear) {
        self.text = text ?? ""
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
            .background(backgroundColor)
    }
}

struct V4Text_Previews: PreviewProvider {
    static var previews: some View {
        V4Text("Test Text")
    }
}
