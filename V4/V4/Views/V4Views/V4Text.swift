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
    
    init(_ text: String? = nil, textColor: Color = Preferences.colors.textColor) {
        self.text = text ?? ""
        self.textColor = textColor
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(textColor)
    }
}

struct V4Text_Previews: PreviewProvider {
    static var previews: some View {
        V4Text("Test Text")
    }
}
