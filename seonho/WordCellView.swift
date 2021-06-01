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
  @ObservedObject var viewModel: WordListSceneViewModel
  @State var index: Int // 이걸 viewmodel로 옮겨야함
  @State var showingDeleteAlert: Bool = false

  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 20)
          .frame(width: UIScreen.main.bounds.width / 2 - 30, height: UIScreen.main.bounds.width / 2 - 30)
          .foregroundColor(.white)
          .opacity(0.8)

        VStack {
          HStack {
            Text(viewModel.word_list[viewModel.index].word_kor)
              .foregroundColor(.black)
              .font(.system(size: 20, weight: .heavy))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.heavy)
              //.padding(.top, 10)
          }
          HStack {
            Text(viewModel.word_list[viewModel.index].word_eng)
              .foregroundColor(.black)
              .font(.system(size: 18, weight: .regular))
              //.font(Font.custom("Bangla MN", size: 18))
              //.fontWeight(.regular)
              //.padding(.top, 10)
          }

          HStack {
            Button {
              self.showingDeleteAlert = true

            } label: {
              Image(systemName: "trash.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color("Pink"))
                .alert(isPresented: self.$showingDeleteAlert) {
                  Alert(title: Text("Delete Word"), message: Text("Would you like to take \'" + viewModel.word_list[viewModel.index].word_kor + "\' \nout of your vocabulary?"), primaryButton: .destructive(Text("Delete")) {
                    viewModel.deleteWord(delete_word_id: viewModel.word_list[viewModel.index].id)
                    self.showingDeleteAlert = false
                  }, secondaryButton: .cancel {
                    self.showingDeleteAlert = false
                  })
                }
            }
            // .padding(.leading, 60)
          }
          .padding(.top, 10)
        }
      }
    }
    .padding(5)
  }
}

struct WordGridCellView: View {
  @ObservedObject var viewModel: WordListSceneViewModel
  @State var word: InMyListWord
  @State var folder_id: Int
  @State var index: Int // 이걸 viewmodel로 옮겨야함
  @State var showingDeleteAlert: Bool = false

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
              .font(.system(size: 20, weight: .heavy))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.heavy)
              //.padding(.top, 10)
          }
          HStack {
            Text(word.word_eng)
              .foregroundColor(.black)
              .font(.system(size: 18, weight: .regular))
              //.font(Font.custom("Bangla MN", size: 18))
              //.fontWeight(.regular)
              //.padding(.top, 10)
          }

          HStack {
            Button {
              self.showingDeleteAlert = true

            } label: {
              Image(systemName: "trash.circle")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color("Pink"))
                .alert(isPresented: self.$showingDeleteAlert) {
                  Alert(title: Text("Delete Word"), message: Text("Would you like to take \'" + word.word_kor + "\' \nout of your vocabulary?"), primaryButton: .destructive(Text("Delete")) {
                    viewModel.deleteWord(delete_word_id: word.id)
                    self.showingDeleteAlert = false
                  }, secondaryButton: .cancel {
                    self.showingDeleteAlert = false
                  })
                }
            }
            // .padding(.leading, 60)
          }
          .padding(.top, 10)
        }
      }
    }
    .padding(5)
  }
}

struct WordLazyGridView: View {
  @ObservedObject var viewModel: WordListSceneViewModel

  let coloumns = [
    GridItem(.fixed(UIScreen.main.bounds.width / 23 * 10), spacing: UIScreen.main.bounds.width / 23 * 1),
    GridItem(.fixed(UIScreen.main.bounds.width / 23 * 10), spacing: UIScreen.main.bounds.width / 23 * 1),
  ]
  // LazyVGrid(columns: coloumns, spacing: 15)

  var body: some View {
    VStack {
      ScrollView {
        WordGridView(rows: (viewModel.word_list.count + 1) / 2, columns: 2) { row, col in
          if (viewModel.word_list.count > row * 2 + col) && (row * 2 + col >= 0) {
            WordGridCellView(viewModel: viewModel, word: viewModel.word_list[row * 2 + col], folder_id: viewModel.word_folder_id, index: row * 2 + col)
              .onTapGesture {
                viewModel.showPopup = viewModel.word_list[row * 2 + col].id
              }
          }
        }
        .padding(.horizontal, UIScreen.main.bounds.width / 23 * 1)
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
