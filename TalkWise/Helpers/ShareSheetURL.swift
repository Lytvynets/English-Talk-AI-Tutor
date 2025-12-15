//
//  ShareSheetURL.swift
//  TalkWise
//
//  Created by Vlad Lytvynets on 15.12.2025.
//

import Foundation
import SwiftUI


struct ShareSheetURL: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
