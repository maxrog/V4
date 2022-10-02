//
//  V4App.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

@main
struct V4App: App {
    
    // TODO create a widget/lock screen widget
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            TabView {
                SessionLaunchView()
                    .tabItem {
                        // indoor session
                        Image(systemName: "point.3.connected.trianglepath.dotted")
                            .foregroundColor(Preferences.colors.accentColor)
                    }
//                Rectangle()
//                    .tabItem {
//                        // outdoor project session
//                        Image(systemName: "globe.americas")
//                            .foregroundColor(Preferences.colors.accentColor)
//                    }
//                Rectangle()
//                    .tabItem {
//                        // tick list / stats
//                        Image(systemName: "text.book.closed")
//                            .foregroundColor(Preferences.colors.accentColor)
//                    }
                Rectangle()
                    .tabItem {
                        // settings
                        Image(systemName: "gearshape.circle")
                            .foregroundColor(Preferences.colors.accentColor)
                    }
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch scenePhase {
            case .active:
                /// application became active
                break
            case .background:
                /// application went to background
                break
            case .inactive:
                /// application became inactive
                break
            default:
                break
            }
        }
    }
}
