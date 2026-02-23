//
//  CertificateBadge.swift
//  MovieApp
//
//  Created by rentamac on 2/23/26.
//

import SwiftUI

struct CertificateBadge: View {
    
    let certificate: String
    
    var body: some View {
        Text(certificate)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color.red.opacity(0.15))
            .foregroundColor(.red)
            .cornerRadius(8)
    }
}
