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
  @Binding var word: WordInfo

  //@State var cancellable = Set<AnyCancellable>()

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .frame(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2 - 30)
        .foregroundColor(.green)
        .opacity(0.8)
      
      VStack {
        Text(word.word)
        Text(word.meaning)
      }
    }
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
