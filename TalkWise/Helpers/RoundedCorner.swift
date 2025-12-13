//
//  RoundedCorner.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 09.12.2025.
//

import Foundation
import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = 16
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
