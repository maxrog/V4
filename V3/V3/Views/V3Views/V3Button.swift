//
//  V3Button.swift
//  V3
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

struct V3Button: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(title, action: action)
            .buttonStyle(.plain)
    }
}

struct V3Button_Previews: PreviewProvider {
    static var previews: some View {
        V3Button(title: "Test Button") {
            print("Test Button Pressed!")
        }
    }
}
