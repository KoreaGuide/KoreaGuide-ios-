//
//  WordCellView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/25.
//

import Combine
import Foundation
import SwiftUI

struct WordCellView: View {
  @Binding var word: RawWord

  // @State var cancellable = Set<AnyCancellable>()

  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 20)
          .frame(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2 - 30)
          .foregroundColor(.white)
          .opacity(0.8)

        VStack {
          HStack {
            Text(word.word_kor)
              .foregroundColor(.black)
              .fontWeight(.heavy)
              .font(Font.custom("Bangla MN", size: 20))
              .padding(.top, 10)
          }
          HStack {
            Text(word.word_eng)
              .foregroundColor(.black)
              .fontWeight(.regular)
              .font(Font.custom("Bangla MN", size: 18))
              .padding(.top, 10)
          }

          HStack {
            Button {
              //TODO : delete
              //api/myWord/{id} **여기서 id는 user의 id (Integer), "word_folder_id": 2,
              //"word_id":5
            } label: {
              Image(systemName: "trash.circle")
                .resizable()
                .frame(width: 30 , height: 30, alignment: .center)
                .foregroundColor(Color("Pink"))
            }
            //.padding(.leading, 60)
          }
          .padding(.top, 10)
        }
       
      }
    }
    .padding(5)
  }
}

struct WordGridView<Content: View>: View {
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
