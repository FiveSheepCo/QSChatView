//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 14.04.23.
//

import SwiftUI
import Combine

fileprivate let COORDINATE_SPACE = "chatScrollView"

/// A highly customized `ScrollView`.
///
/// Supports checking whether the user has scrolled to the bottom area
/// and reports various parameters such as `contentHeight`, `scrollOffset`, etc.
struct BetterScrollView<Content: View>: View {
    typealias ContentType = () -> Content
    
    let content: ContentType
    let axis: Axis.Set
    
    @ObservedObject private var data: ScrollViewData
    
    init(_ axis: Axis.Set = .vertical, data: ScrollViewData, @ViewBuilder content: @escaping ContentType) {
        self.content = content
        self.data = data
        self.axis = axis
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollView in
                ScrollView(axis) {
                    content()
                        .modifier(
                            ScrollOffsetModifier(
                                coordinateSpace: COORDINATE_SPACE,
                                offset: $data.scrollOffset
                            )
                        )
                        .modifier(
                            ContentHeightModifier(
                                coordinateSpace: COORDINATE_SPACE,
                                contentHeight: $data.contentHeight
                            )
                        )
                }
                .coordinateSpace(name: COORDINATE_SPACE)
                .onAppear {
                    data.scrollView = scrollView
                    data.scrollViewHeight = geometry.size.height
                }
            }
        }
    }
}

struct BetterScrollView_Previews: PreviewProvider {
    static var data = ScrollViewData()
    
    static var previews: some View {
        VStack {
            BetterScrollView(data: data) {
                LazyVStack {
                    ForEach(0..<250) { index in
                        Text("SO: \(String(format: "%.2f", data.scrollOffset)); CH: \(String(format: "%.2f", data.contentHeight)); B: \(data.isScrolledToBottom ? "Y" : "N")")
                    }
                }
            }
        }
    }
}
