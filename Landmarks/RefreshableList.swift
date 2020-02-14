//
//  PullToRefresh.swift
//  SwiftUI-Common
//  Pull down to refresh
//  Pull up to load more
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 unrealce. All rights reserved.
//

import SwiftUI

struct RefreshableList<Content: View>: View {
  @State private var isLoadingMore = false
  @State private var isRefreshing = false
  
  var offsetValue: CGFloat = 185
  var pullUpText = ("Pull up to load more", "Loading more")
  var pullDownText = ("Pull down to refresh", "Refreshing")
  var pullUp: (() -> Void)?
  var pullDown: (() -> Void)?
  let content: () -> Content
  
  var body: some View {
    List {
      if pullDown != nil {
        RefreshBarView(isRefreshing: $isRefreshing, refreshText: pullDownText)
      }
      content()
      if pullUp != nil {
        RefreshBarView(isRefreshing: $isLoadingMore, refreshText: pullUpText)
      }
    }
    .onPreferenceChange(RefreshListPrefKey.self) {
      guard let offsetY = $0.last else { return }
      if self.pullDown != nil {
        self.refresh(offsetY: offsetY)
      }
      if self.pullUp != nil {
        self.loadMore(offsetY: offsetY)
      }
    }
  }
  
  private func refresh(offsetY: CGFloat) {
    guard offsetY > offsetValue && self.isRefreshing == false else {
      return
    }
    self.isRefreshing = true
    DispatchQueue.main.async {
      guard let pullDown = self.pullDown else {
        return
      }
      pullDown()
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.isRefreshing = false
      }
    }
  }
  
  private func loadMore(offsetY: CGFloat) {
    guard offsetY < -offsetValue && self.isLoadingMore == false else {
      return
    }
    self.isLoadingMore = true
    DispatchQueue.main.async {
      guard let pullUp = self.pullUp else {
        return
      }
      pullUp()
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.isLoadingMore = false
      }
    }
  }
}

struct RefreshBarView: View {
  @Binding var isRefreshing: Bool
  var refreshText = ("Pull to refresh", "Loading")
  
  var body: some View {
    GeometryReader {
      HStack {
        Spacer()
        ActivityIndicator(isAnimating: self.$isRefreshing)
        Text(self.isRefreshing ? self.refreshText.1 : self.refreshText.0)
        Spacer()
      }
      .preference(key: RefreshListPrefKey.self, value: [$0.frame(in: .global).origin.y])
    }
  }
}

struct ActivityIndicator: UIViewRepresentable {
  @Binding var isAnimating: Bool
  var style: UIActivityIndicatorView.Style?

  func makeUIView(context: Context) -> UIActivityIndicatorView {
    guard let style = style else {
      return UIActivityIndicatorView()
    }
    return UIActivityIndicatorView(style: style)
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}

struct RefreshListPrefKey: PreferenceKey {
  static var defaultValue = [CGFloat]()
  
  static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
    value.append(contentsOf: nextValue())
  }
}

struct RefreshBarView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      RefreshBarView(isRefreshing: .constant(false))
      RefreshBarView(isRefreshing: .constant(true))
    }
  }
}

struct ActivityIndicator_Previews: PreviewProvider {
  static var previews: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large)
  }
}
