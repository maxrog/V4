//
//  V3Text.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

struct V3Text: View {
    let text: String
    
    init(_ text: String? = nil) {
        self.text = text ?? ""
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(Preferences.colors.textColor)
    }
}

struct V3Text_Previews: PreviewProvider {
    static var previews: some View {
        V3Text("Test Text")
    }
}
