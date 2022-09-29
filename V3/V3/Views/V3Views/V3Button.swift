//
//  V3Button.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

struct V3Button: View {
    let title: String
    var body: some View {
        V3Button(title: title)
            .buttonStyle(.plain)
    }
}

struct V3Button_Previews: PreviewProvider {
    static var previews: some View {
        V3Button(title: "Test Button")
    }
}
