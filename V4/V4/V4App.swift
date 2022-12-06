//
//  V4App.swift
//  V4
//
//  Created by Max Rogers on 9/29/22.
//

import SwiftUI

@main
struct V4App: App {
        
    @Environment(\.scenePhase) var scenePhase
    @StateObject var settingsViewModel = SettingsViewModel()
    
    let sessionManager = SessionManager.shared
        
    var body: some Scene {
        WindowGroup {
            TabView(selection: $settingsViewModel.selectedTabIndex) {
                SessionLaunchView()
                    .tabItem {
                        Image(systemName: "point.3.connected.trianglepath.dotted")
                            .foregroundColor(Preferences.colors.accentColor)
                    }
                    .environment(\.managedObjectContext, sessionManager.container.viewContext)
                    .environmentObject(settingsViewModel)
                    .tag(V4Tabs.session.rawValue)
                //                Rectangle()
                //                    .tabItem {
                //                        Image(systemName: "globe.americas")
                //                            .foregroundColor(Preferences.colors.accentColor)
                //                    }
                //                    .environment(\.managedObjectContext, sessionManager.container.viewContext)
                //                    .tag(V4Tabs.project.rawValue)
                ClimbLogView()
                    .tabItem {
                        Image(systemName: "text.book.closed")
                            .foregroundColor(Preferences.colors.accentColor)
                    }
                    .environment(\.managedObjectContext, sessionManager.container.viewContext)
                    .environmentObject(settingsViewModel)
                    .tag(V4Tabs.stats.rawValue)
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.circle")
                            .foregroundColor(Preferences.colors.accentColor)
                    }
                    .environmentObject(settingsViewModel)
                    .tag(V4Tabs.settings.rawValue)
            }
        }
        .onChange(of: scenePhase) { newScenePhase in
            sessionManager.save()
            
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


private enum V4Tabs: Int {
    case session = 0
    case project
    case stats
    case settings
}
