//
//  PullToRefresh.swift
//  SwiftUI-Common
//  Pull Down To Refresh
//  Pull Up To Load More
//
//  Created by huanbing on 2020/2/14.
//  Copyright © 2020 unrealce. All rights reserved.
//

import SwiftUI

struct RefreshableList<Content: View>: View {
  @State private var showRefreshView = false
  
  var pullUp: (() -> Void)?
  var pullDown: (() -> Void)?
  let content: () -> Content
  
  var body: some View {
    List {
      if pullDown != nil {
        PullToRefreshView(showRefreshView: $showRefreshView)
      }
      content()
      if pullUp != nil {
        PullToRefreshView(showRefreshView: $showRefreshView)
      }
    }
    .onPreferenceChange(RefreshListPrefKey.self) {
      guard let offsetY = $0.first else { return }
      self.refresh(offset: offsetY)
    }
  }
  
  func refresh(offset: CGFloat) {
    if(offset > 185 && self.showRefreshView == false) {
      self.showRefreshView = true
      DispatchQueue.main.async {
        if let pullUp = self.pullUp {
          pullUp()
        }
        if let pullDown = self.pullDown {
          pullDown()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          self.showRefreshView = false
        }
      }
    }
  }
}

struct PullToRefreshView: View {
  @Binding var showRefreshView: Bool
  
  var body: some View {
    GeometryReader {
      RefreshBarView(isRefreshing: self.$showRefreshView)
        .preference(key: RefreshListPrefKey.self, value: [$0.frame(in: .global).origin.y])
    }
  }
}

struct RefreshBarView: View {
  @Binding var isRefreshing: Bool
  
  var refreshText = ("Pull to refresh", "Loading")
  
  var body: some View {
    HStack {
      Spacer()
      ActivityIndicator(isAnimating: $isRefreshing)
      Text(isRefreshing ? refreshText.1 : refreshText.0)
      Spacer()
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

struct PullToRefreshView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      PullToRefreshView(showRefreshView: .constant(false))
      PullToRefreshView(showRefreshView: .constant(true))
    }
  }
}

struct RefreshBarView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 100) {
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
