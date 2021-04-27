//
//  wordMainView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Combine
import Foundation
import SwiftUI

struct WordMainView: View {
  var body: some View {
    NavigationView {
      ZStack {
        Image("left_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            Text("ForWord")
              .foregroundColor(.white)
              .font(.title3)
              .padding(.horizontal, 20)

            Spacer()
          }

          HStack {
            Text("Your Words")
              .foregroundColor(.white)
              .font(.title)
              .padding(.horizontal, 20)
            Spacer()
          }

          HStack {
            Text("Total Words : 10")
              .foregroundColor(.white)
              .font(.title2)
              .padding(.horizontal, 20)
            Spacer()
          }
          .padding(.vertical, 20)

          NavigationLink(destination: WordListView(viewModel: WordListViewModel())) {
            AddedWordButton()
              .padding(.vertical, 10)
          }
          .isDetailLink(false)

          NavigationLink(destination: WordListView(viewModel: WordListViewModel())) {
            LearningWordButton()
              .padding(.vertical, 10)
          }
          .isDetailLink(false)

          NavigationLink(destination: WordAddView(viewModel: WordAddViewModel())) {
            CompleteWordButton()
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
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

// .animation(.easeInOut)

struct AddedWordButton: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

      VStack {
        Text("Added Word List")
          .foregroundColor(.white)
          .font(.title)
        Text("number of words")
          .foregroundColor(.white)
      }
    }
  }
}

struct LearningWordButton: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

      VStack {
        Text("Learning Word List")
          .foregroundColor(.white)
          .font(.title)
        Text("number of words")
          .foregroundColor(.white)
      }
    }
  }
}

struct CompleteWordButton: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

      VStack {
        Text("Complete Word List")
          .foregroundColor(.white)
          .font(.title)
        Text("number of words")
          .foregroundColor(.white)
      }
    }
  }
}
