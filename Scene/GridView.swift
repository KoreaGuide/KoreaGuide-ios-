//
//  GridView.swift
//  KoreaGuide
//
//  Created by Song chi hyun on 2021/06/01.
//
import Combine
import Foundation
import SwiftUI
import Kingfisher
struct GridView<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content

  var body: some View {
    ScrollView {
      ForEach(0 ..< rows, id: \.self) { row in
        HStack {
          ZStack {
            ForEach(0 ..< self.columns, id: \.self) { column in
              self.content(row, column)
                .padding(column == 0 ? .trailing : .leading, UIScreen.main.bounds.width / 2 - 10)
            }
          }
        }
      }
    }
    .padding(.horizontal, 20)
  }

  // 컨텐츠 클로저
  init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
    self.rows = rows
    self.columns = columns
    self.content = content
  }
}




struct PostGridSquareViewForKeeped: View {
  @ObservedObject var viewModel: MyPageSceneViewModel
  @State var index: Int

  @State var cancellable = Set<AnyCancellable>()
  @State private var showingAlert = false

  @State var isBookmarkIn: Bool = true

  let unit: CGFloat = UIScreen.main.bounds.width / 23

  var body: some View {
    if (viewModel.placeInfo.count > index) && (index >= 0) {
      VStack {
        ZStack {
          KFImage.url(URL(string: viewModel.placeInfo[index].first_image ?? ""))
            .placeholder { ImagePlaceHolder() }
            .fade(duration: 0.25)
            .resizable()
            .frame(width: unit * 10, height: unit * 10) // 1:1 aspect ratio

          // 책갈피랑 라벨이 들은 VStack
          VStack {
              // 책갈피
              BookmarkButton
            
            Spacer()
            // 테두리 있는 라벨
          }
          .padding(unit * 0.7)
          .frame(width: unit * 10, height: unit * 10, alignment: .leading)
        }
        .cornerRadius(5.8)

        TitleTextView
      }
    }
  }

  var BookmarkButton: some View {
    HStack {
      Spacer()
        .frame(width: unit * 6.5)
      Button(action: {
               
             },
             label: {
               Image("bookmarkOn")
              
             })
    }
    .frame(width: unit * 10, alignment: .center)
  }

  var TitleTextView: some View {
    HStack {
        Text(viewModel.placeInfo[index].title)
          .foregroundColor(Color(.white))
          .frame(width: unit * 10, height: 70, alignment: .topLeading)
      
    }
  }
}

