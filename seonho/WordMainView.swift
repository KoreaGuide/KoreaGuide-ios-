//
//  wordMainView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//


import Combine
import Foundation
import SwiftUI

struct TopLabel: View {
  var body: some View {
    HStack {
      Text("ForWord")
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .font(Font.custom("Bangla MN", size: 20))
      // .fontWeight(.heavy)

      Spacer()
    }
    .padding(.vertical, 10)

    HStack {
      Text("Welcome, " + String(UserDefaults.id!)) // nickname으로 변경
        .foregroundColor(.white)
        .font(Font.custom("Bangla MN", size: 30))
        .padding(.horizontal, 20)
      Spacer()
    }
    HStack {
      Text("Let's review your words!")
        .foregroundColor(.white)
        .font(Font.custom("Bangla MN", size: 20))
        .padding(.horizontal, 20)

      Spacer()
    }
  }
}

struct TotalCountBox: View {
  @ObservedObject var viewModel: WordMainViewModel

  var body: some View {
    HStack {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .foregroundColor(.white)
          .opacity(0.8)
          .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .center)

        VStack {
          Text("Total Words : " + String(viewModel.totalCount))
            .foregroundColor(.black)
            .font(Font.custom("Bangla MN", size: 25))
            .padding(.top, 10)
        }
      }
    }.padding(20)
  }
}

// word 탭 눌렀을때 진입 WordMainView()
struct WordMainView: View {
  @ObservedObject var viewModel = WordMainViewModel()

  var body: some View {
    NavigationView {
      ZStack {
        Image("left_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          TopLabel()
          TotalCountBox(viewModel: viewModel)

          NavigationLink(destination: WordListView(viewModel: WordListViewModel(word_folder_id: UserDefaults.add_folder_id ?? 1))) {
            AddedWordButton(viewModel: viewModel)
              .padding(.vertical, 10)
          }
          .isDetailLink(false)

          NavigationLink(destination: WordListView(viewModel: WordListViewModel(word_folder_id: UserDefaults.learning_folder_id ?? 2))) {
            LearningWordButton(viewModel: viewModel)
              .padding(.vertical, 10)
          }
          .isDetailLink(false)

          NavigationLink(destination: WordListView(viewModel: WordListViewModel(word_folder_id: UserDefaults.complete_folder_id ?? 3))) {
            CompleteWordButton(viewModel: viewModel)
              .padding(.vertical, 10)
          }
          .isDetailLink(false)
        }
        .padding(.bottom, 20)
      }
      .ignoresSafeArea()
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .ignoresSafeArea()
    // .navigationViewStyle(StackNavigationViewStyle())
  }
}

// .animation(.easeInOut)

struct AddedWordButton: View {
  @ObservedObject var viewModel: WordMainViewModel
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment: .center)

      VStack {
        Text("Added Word List")
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 25))
          .padding(.top, 10)
        Text("number of words : " + String(viewModel.added_word_info?.data.now_word_count ?? 0))
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 20))
      }
    }
  }
}

struct LearningWordButton: View {
  @ObservedObject var viewModel: WordMainViewModel
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment: .center)

      VStack {
        Text("Learning Word List")
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 25))
          .padding(.top, 10)
        Text("number of words : " + String(viewModel.learning_word_info?.data.now_word_count ?? 0))
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 20))
      }
    }
  }
}

struct CompleteWordButton: View {
  @ObservedObject var viewModel: WordMainViewModel
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment: .center)

      VStack {
        Text("Complete Word List")
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 25))
          .padding(.top, 10)
        Text("number of words : " + String(viewModel.complete_word_info?.data.now_word_count ?? 0))
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 20))
      }
    }
  }
}
