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
    var body: some View {
        Button(title, action: action)
            .buttonStyle(.plain)
    }
}

struct V4Button_Previews: PreviewProvider {
    static var previews: some View {
        V4Button(title: "Test Button") {
            print("Test Button Pressed!")
        }
    }
}
