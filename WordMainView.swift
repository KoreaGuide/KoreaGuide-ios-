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
  @ObservedObject var viewModel: WordMainViewModel = WordMainViewModel()
  
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
              .padding(.horizontal, 20)
              .font(Font.custom("Bangla MN", size: 20))

            Spacer()
          }
          .padding(.vertical, 10)
          
          HStack {
            Text("Welcome, " + "user")
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 30))
              .padding(.horizontal, 20)
            Spacer()
          }
          HStack{
            Text("Let's review your words!")
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 20))
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
                Text("Total Words : " + String(""))
                  .foregroundColor(.black)
                  .font(Font.custom("Bangla MN", size: 25))
                  .padding(.top, 10)
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

          NavigationLink(destination: WordAddView(viewModel: WordAddViewModel(place_id: 0))) {
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
          .font(Font.custom("Bangla MN", size: 25))
          .padding(.top, 10)
        Text("number of words : ")
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 20))
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
          .font(Font.custom("Bangla MN", size: 25))
          .padding(.top, 10)
        Text("number of words : ")
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 20))
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
          .font(Font.custom("Bangla MN", size: 25))
          .padding(.top, 10)
        Text("number of words : ")
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 20))
      }
    }
  }
}
