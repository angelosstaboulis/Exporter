//
//  ExporterApp.swift
//  Exporter
//
//  Created by Angelos Staboulis on 17/7/24.
//

import SwiftUI

@main
struct ExporterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(source: "", destination: "", showExporter: false, target: .init(), export: .init(image: .init()))
        }
    }
}
