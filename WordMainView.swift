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
  @ObservedObject var viewModel: WordMainViewModel = WordMainViewModel(wordlist: [WordInfo(word_id: 1, word: "첫번째 단어", meaning: "first word"), WordInfo(word_id: 2, word: "두번째 단어", meaning: "second word"), WordInfo(word_id: 3, word: "세번째 단어", meaning: "third word")])
  
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
              .fontWeight(.heavy)
              .font(.title3)
              .padding(.horizontal, 20)
              

            Spacer()
          }
          .padding(.vertical, 10)
          
          HStack {
            Text("Welcome, " + "user")
              .foregroundColor(.white)
              .font(.title)
              .padding(.horizontal, 20)
            Spacer()
          }
          HStack{
            Text("Let's review your words!")
              .foregroundColor(.white)
              .font(.title)
              .padding(.horizontal, 20)
            Spacer()
          }
          

          HStack {
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .opacity(0.8)
                .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment:  .center)

              VStack {
                Text("Total Words : " + String(viewModel.wordlist.count))
                  .foregroundColor(.black)
                  .font(.title2)
              }
            }
          }
          .padding(20)
          

          NavigationLink(destination: WordListView(viewModel: WordListViewModel()))
          {
            AddedWordButton()
              .padding(.vertical, 10)
          }
          .isDetailLink(false)

          NavigationLink(destination: TodayWordView(viewModel: TodayWordViewModel(wordInfo: WordInfo(word_id: 1, word: "첫번째 단어", meaning: "first word"))))
          {
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
    //.navigationViewStyle(StackNavigationViewStyle())
  }
}

// .animation(.easeInOut)

struct AddedWordButton: View {
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .foregroundColor(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment:  .center)

      VStack {
        Text("Added Word List")
          .foregroundColor(.white)
          .font(.title)
        Text("number of words : ")
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
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment:  .center)

      VStack {
        Text("Learning Word List")
          .foregroundColor(.white)
          .font(.title)
        Text("number of words : ")
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
        .frame(width: UIScreen.main.bounds.width - 100, height: 100, alignment:  .center)

      VStack {
        Text("Complete Word List")
          .foregroundColor(.white)
          .font(.title)
        Text("number of words : ")
          .foregroundColor(.white)
      }
    }
  }
}
