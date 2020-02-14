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
  @State private var offsetY: CGFloat = 0
  
  let action: () -> Void
  let content: () -> Content
  
  var body: some View {
    List {
      PullToRefreshView(showRefreshView: $showRefreshView, offsetY: $offsetY)
      content()
    }
    .onPreferenceChange(RefreshListPrefKey.self) {
      guard let offsetY = $0.first else { return }
      self.offsetY = offsetY
      self.refresh(offset: offsetY)
    }
  }
  
  func refresh(offset: CGFloat) {
    if(offset > 185 && self.showRefreshView == false) {
      self.showRefreshView = true
      DispatchQueue.main.async {
        self.action()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          self.showRefreshView = false
        }
      }
    }
  }
}

struct PullToRefreshView: View {
  @Binding var showRefreshView: Bool
  @Binding var offsetY: CGFloat
  
  var body: some View {
    GeometryReader {
      RefreshBarView(isRefreshing: self.$showRefreshView, offsetY: self.$offsetY)
        .preference(key: RefreshListPrefKey.self, value: [$0.frame(in: .global).origin.y])
    }
  }
}

struct RefreshBarView: View {
  @Binding var isRefreshing: Bool
  @Binding var offsetY: CGFloat
  var refreshOffsetY: CGFloat = 185
  var refreshText = ("下拉可以刷新数据", "松开立即刷新数据", "正在刷新数据中...")
  
  var body: some View {
    HStack {
      Spacer()
      ActivityIndicator(isAnimating: $isRefreshing)
      if isRefreshing {
        Text(refreshText.2)
      } else if offsetY > refreshOffsetY {
        Text(refreshText.1)
      } else {
        Text(refreshText.0)
      }
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
    VStack(spacing: 100) {
      PullToRefreshView(showRefreshView: .constant(false), offsetY: .constant(185))
      PullToRefreshView(showRefreshView: .constant(false), offsetY: .constant(200))
      PullToRefreshView(showRefreshView: .constant(true), offsetY: .constant(215))
    }
  }
}

struct RefreshBarView_Previews: PreviewProvider {
  static var previews: some View {
    VStack(spacing: 100) {
      RefreshBarView(isRefreshing: .constant(false), offsetY: .constant(185))
      RefreshBarView(isRefreshing: .constant(false), offsetY: .constant(200))
      RefreshBarView(isRefreshing: .constant(true), offsetY: .constant(215))
    }
  }
}

struct ActivityIndicator_Previews: PreviewProvider {
  static var previews: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large)
  }
}
