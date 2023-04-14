//
//  File.swift
//  
//
//  Created by SplittyDev on 14.04.23.
//

import Foundation
import SwiftUI

class ScrollViewData: ObservableObject, Equatable {
    @Published var scrollView: ScrollViewProxy?
    @Published var scrollViewHeight: Double = 0
    @Published var scrollOffset: Double = 0 {
        didSet {
            updateIsScrolledToBottom()
        }
    }
    @Published var contentHeight: Double = 0
    @Published var isScrolledToBottom: Bool = false
    
    var screenHeight: Double {
        #if os(iOS)
        return UIScreen.main.bounds.height
        #elseif os(macOS)
        return Double(NSApplication.shared.mainWindow?.frame.height ?? 0)
        #endif
    }
    
    func updateIsScrolledToBottom() {
        isScrolledToBottom = contentHeight - scrollViewHeight <= screenHeight / 2
    }
    
    func scrollTo<ID>(_ id: ID, anchor: UnitPoint?) where ID: Hashable {
        scrollView?.scrollTo(id, anchor: anchor)
    }
    
    static func == (lhs: ScrollViewData, rhs: ScrollViewData) -> Bool {
        lhs.scrollViewHeight == rhs.scrollViewHeight
        && lhs.scrollOffset == rhs.scrollOffset
        && lhs.contentHeight == rhs.contentHeight
    }
}
