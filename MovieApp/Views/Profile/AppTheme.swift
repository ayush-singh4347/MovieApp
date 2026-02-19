//
//  AppTheme.swift
//  MovieApp
//
//  Created by rentamac on 2/19/26.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Codable {
    case system
    case light
    case dark

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }

    var icon: String {
        switch self {
        case .system: return "circle.lefthalf.filled"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }

    var displayName: String {
        rawValue.capitalized
    }
}
