//
//  CertificateBadge.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI

struct CertificateBadge: View {
    
    let certificate: String
    
    private var badgeColor: Color {
        switch certificate.uppercased() {
        case "G":
            return .green
        case "PG":
            return .blue
        case "PG-13":
            return .orange
        case "R":
            return .red
        case "NC-17":
            return .purple
        default:
            return .gray
        }
    }
    
    var body: some View {
        Text(certificate)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(badgeColor.opacity(0.15))
            .foregroundColor(badgeColor)
            .cornerRadius(8)
    }
}
