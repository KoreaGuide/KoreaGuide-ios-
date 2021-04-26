//
//  wordAddView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Foundation
import SwiftUI
import Combine

struct WordInfo {
  let word_id: Int
  let word: String // kor
  let meaning: String // eng
}

struct WordAddView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel: WordAddViewModel
  @State private var cancellable: AnyCancellable?
  
  

  var backButton: some View {
    // 뒤로가기
    Button(action: {
      self.presentationMode.wrappedValue.dismiss()
    }, label: {
      Image(systemName: "chevron.left.square")
        .resizable()
        .scaledToFit()
        .padding(.top, 15)
        .padding(.trailing, 20)
        .padding(.bottom, 10)
        .frame(width: 50, height: 50, alignment: .center)
        .foregroundColor(.white)
    })
  }

  var progressBar: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
          .opacity(0.3)
          .foregroundColor(Color(UIColor.systemTeal))

        Rectangle().frame(width: min(CGFloat(self.viewModel.progressValue) * geometry.size.width, geometry.size.width), height: geometry.size.height)
          .foregroundColor(Color(UIColor.systemBlue))
          .animation(.linear)
      }.cornerRadius(45.0)
    }
  }
  
  var body: some View {
    NavigationView {
      ZStack{
      Image("background")
        .resizable()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .ignoresSafeArea()
        
      VStack {
        HStack {
          // place title
          Label(viewModel.placeTitle, systemImage: "book.fill") // icon change
            .foregroundColor(.white)
        }

        // label
        Text("3/3")
          .foregroundColor(.white)
        progressBar
          .frame(width: UIScreen.main.bounds.width - 100, height: 20, alignment: .center)

        // label
        Text("Add to my list")
          .foregroundColor(.white)

        HStack {
          // left
          Button(action: {
            if viewModel.currentWordCount > 0 {
              viewModel.currentWordCount -= 1
            }
            
          }, label: {
            Image(systemName: "chevron.left.circle")
              .resizable()
            .scaledToFit()
              .frame(width: 30, height: 30, alignment: .center)
              .foregroundColor(.white)
            
          })

          // box
          WordBox(viewModel: viewModel)

          // right
          Button(action: {
            if viewModel.currentWordCount < viewModel.totalWordCount - 1 {
              
              viewModel.currentWordCount += 1
            }
            
          }, label: {
            Image(systemName: "chevron.right.circle")
              .resizable()
            .scaledToFit()
              .frame(width: 30, height: 30, alignment: .center)
              .foregroundColor(.white)
          })
        }
        
        Spacer()
          .frame(height: 120, alignment: .center)
      }
      }
      
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}


struct WordBox: View {
  @ObservedObject var viewModel: WordAddViewModel
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 5 * 3)

      VStack {
        Image("mae")
          .resizable()
          .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          .cornerRadius(10)
        Spacer().frame(height: 30)
        Text(viewModel.wordList[viewModel.currentWordCount].word)
          .foregroundColor(.white)
        Text("pronun")
          .foregroundColor(.white)
        Text(viewModel.wordList[viewModel.currentWordCount].meaning)
          .foregroundColor(.white)
        Button(action: {
          //replay
        }, label: {
          Image(systemName: "play.circle") //play.circle.fill
        })
      }
    }
  }
}

struct WordAddFinishView: View {
  @ObservedObject var viewModel: WordAddViewModel
  
  var body: some View {
    Text(viewModel.placeTitle)

    Rectangle() // 총 단어 개수, 담은 개수, 어쩌고

    // button 장소페이지로 돌아가기
    // button 단어장으로 가기
  }
}
