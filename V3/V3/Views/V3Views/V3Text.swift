//
//  V3Text.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

struct V3Text: View {
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

struct V3Text_Previews: PreviewProvider {
    static var previews: some View {
        V3Text("Test Text")
    }
}
