//
//  AppTheme.swift
//  MovieApp
//
//  Created by rentamac on 2/19/26.
//
import SwiftUI
enum AppTheme: String, CaseIterable, Codable {
    case light
    case dark

    var colorScheme: ColorScheme {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }

    var icon: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }

    var displayName: String {
        rawValue.capitalized + " Mode"
    }
}
