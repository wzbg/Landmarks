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

struct RefreshableNavigationView<Content: View>: View {
  @State var showRefreshView = false
  @State var offsetY: CGFloat = 0
  
  var title: String
  let action: () -> Void
  let content: () -> Content
  
  var body: some View {
    NavigationView{
      RefreshableList(showRefreshView: $showRefreshView, offsetY: $offsetY, action: self.action) {
        self.content()
      }
      .navigationBarTitle(title)
    }
    .offset(x: 0, y: self.showRefreshView ? 34 : 0)
    .onAppear{
      UITableView.appearance().separatorColor = .clear
    }
  }
}

struct RefreshableList<Content: View>: View {
  @Binding var showRefreshView: Bool
  @Binding var offsetY: CGFloat
  
  let action: () -> Void
  let content: () -> Content
  
  var body: some View {
    List {
      PullToRefreshView(showRefreshView: $showRefreshView, offsetY: $offsetY)
      content()
    }
    .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
      guard let bounds = values.first?.bounds else { return }
      self.offsetY = bounds.origin.y
      self.refresh(offset: self.offsetY)
    }.offset(x: 0, y: -40)
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
    GeometryReader{ geometry in
      RefreshBarView(isRefreshing: self.$showRefreshView, offsetY: self.$offsetY)
        .opacity(Double((geometry.frame(in: CoordinateSpace.global).origin.y - 106) / 80))
        .preference(key: RefreshableKeyTypes.PrefKey.self, value: [RefreshableKeyTypes.PrefData(bounds: geometry.frame(in: CoordinateSpace.global))])
        .offset(x: 0, y: -90)
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

struct RefreshableKeyTypes {
  struct PrefData: Equatable {
    let bounds: CGRect
  }

  struct PrefKey: PreferenceKey {
    static var defaultValue: [PrefData] = []

    static func reduce(value: inout [PrefData], nextValue: () -> [PrefData]) {
      value.append(contentsOf: nextValue())
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
