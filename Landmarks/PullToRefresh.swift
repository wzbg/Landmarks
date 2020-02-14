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
  @State public var showRefreshView = false
  @State public var pullStatus: CGFloat = 0
  
  var title: String
  let action: () -> Void
  let content: () -> Content
  
  var body: some View {
    NavigationView{
      RefreshableList(showRefreshView: $showRefreshView, pullStatus: $pullStatus, action: self.action) {
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
  @Binding var pullStatus: CGFloat
  
  let action: () -> Void
  let content: () -> Content
  
  var body: some View {
    List{
      PullToRefreshView(showRefreshView: $showRefreshView, pullStatus: $pullStatus)
      content()
    }
    .onPreferenceChange(RefreshableKeyTypes.PrefKey.self) { values in
      guard let bounds = values.first?.bounds else { return }
      self.pullStatus = CGFloat((bounds.origin.y - 106) / 80)
      self.refresh(offset: bounds.origin.y)
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
  @Binding var pullStatus: CGFloat
  
  var body: some View {
    GeometryReader{ geometry in
      RefreshView(isRefreshing: self.$showRefreshView, status: self.$pullStatus)
        .opacity(Double((geometry.frame(in: CoordinateSpace.global).origin.y - 106) / 80))
        .preference(key: RefreshableKeyTypes.PrefKey.self, value: [RefreshableKeyTypes.PrefData(bounds: geometry.frame(in: CoordinateSpace.global))])
        .offset(x: 0, y: -90)
    }
  }
}

struct RefreshView: View {
  @Binding var isRefreshing:Bool
  @Binding var status: CGFloat
  
  var body: some View {
    HStack{
      Spacer()
      VStack(alignment: .center) {
        if (!isRefreshing) {
          Spinner(percentage: $status)
        } else {
          ActivityIndicator(isAnimating: .constant(true), style: .large)
        }
        Text(isRefreshing ? "Loading" : "Pull to refresh").font(.caption)
      }
      Spacer()
    }
  }
}

struct Spinner: View {
  @Binding var percentage: CGFloat
  
  var body: some View {
    GeometryReader{ geometry in
      ForEach(1...10, id: \.self) {
        Rectangle()
          .fill(Color.gray)
          .cornerRadius(1)
          .frame(width: 2.5, height: 8)
          .opacity(self.percentage * 10 >= CGFloat($0) ? Double($0)/10.0 : 0)
          .offset(x: 0, y: -8)
          .rotationEffect(.degrees(Double(36 * $0)), anchor: .bottom)
      }
      .offset(x: 20, y: 12)
    }
    .frame(width: 40, height: 40)
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

struct Spinner_Previews: PreviewProvider {
  static var previews: some View {
    Spinner(percentage: .constant(1)) // 0.1 ~ 1
  }
}

struct ActivityIndicator_Previews: PreviewProvider {
  static var previews: some View {
    ActivityIndicator(isAnimating: .constant(true), style: .large)
  }
}
