//
//  wordAddView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Combine
import Foundation
import SwiftUI

struct WordInfo {
  let word_id: Int
  let word: String // kor
  let meaning: String // eng
  var added: Bool = false
  var folder: Int = 0
  var playing: Bool = false
  let image = Image("mae")
}

// place word list
//  [WordInfo(word_id: 1, word: "첫번째 단어", meaning: "first word"), WordInfo(word_id: 2, word: "두번째 단어", meaning: "second word"), WordInfo(word_id: 3, word: "세번째 단어", meaning: "third word")]

struct ProgressBar: View {
  @Binding var value: Float

  init(value: Binding<Float>) {
    self._value = value // beta 4
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .leading) {
        Rectangle()
          .frame(width: geometry.size.width, height: geometry.size.height)
          .opacity(0.3)
          .foregroundColor(Color(UIColor.systemTeal))

        Rectangle()
          .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
          .foregroundColor(Color(UIColor.systemBlue))
          .animation(.linear)
      }.cornerRadius(45.0)
    }
  }
}

struct WordAddView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel: WordAddViewModel
  // @State var progressValue: Float = 0.0
  // @State private var cancellable: AnyCancellable?

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

  var body: some View {
    NavigationView {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          // place title
          Label(viewModel.placeTitle, systemImage: "flag") // flag.fill
            .foregroundColor(.white)
            .font(.title3)

          // label
          Text(String(viewModel.currentWordCount + 1) + "  /  " + String(viewModel.totalWordCount))
            .foregroundColor(.white)
            .padding(.top, 5)

          ProgressBar(value: $viewModel.progressValue)
            .frame(width: UIScreen.main.bounds.width - 100, height: 15, alignment: .center)
            .padding(.vertical, 20)
          
          HStack {
            // left
            Button(action: {
              if viewModel.currentWordCount > 0 {
                viewModel.currentWordCount -= 1
                // self.progressValue = Float(viewModel.currentWordCount + 1) / Float(viewModel.totalWordCount)
              }

            }, label: {
              Image(systemName: "chevron.left.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.white)

            })

            // box
            WordBox(viewModel: WordBoxViewModel(currentCount: viewModel.currentWordCount, wordInfo: viewModel.wordList[viewModel.currentWordCount]))

            // right
            Button(action: {
              if viewModel.currentWordCount < viewModel.totalWordCount - 1 {
                viewModel.currentWordCount += 1
                // self.progressValue = Float(viewModel.currentWordCount + 1) / Float(viewModel.totalWordCount)
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
  @ObservedObject var viewModel: WordBoxViewModel
  // @State var added: Bool = false
  // @State var playing: Bool = false

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25)
        .fill(Color("Navy"))
        .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 5 * 3)

      VStack {
        // 1.circle
        Button(action: {
          viewModel.wordInfo.added.toggle()
          if viewModel.wordInfo.added == true {
            // viewModel.added_word_id_list.append(viewModel.wordList[viewModel.currentWordCount].word_id)
          } else {
            // viewModel.added_word_id_list = viewModel.added_word_id_list.filter { $0 != viewModel.wordList[viewModel.currentWordCount].word_id }
          }
        }, label: {
          Image(systemName: viewModel.wordInfo.added ? "bookmark.fill" : "bookmark")
            .resizable()
            .frame(width: 20, height: 30, alignment: .center)
            .foregroundColor(Color.orange)
        })
          .padding(.bottom, 20)

        Image("mae") // viewModel.wordList[viewModel.currentWordCount].image
          .resizable()
          .frame(width: 200, height: 200, alignment: .center)
          .cornerRadius(10)

        Spacer().frame(height: 30)

        Text(viewModel.wordInfo.word)
          .foregroundColor(.white)
        Text("pronun")
          .foregroundColor(.white)
        Text(viewModel.wordInfo.meaning)
          .foregroundColor(.white)

        Button(action: {
          viewModel.wordInfo.playing.toggle()
          //
        }, label: {
          Image(systemName: viewModel.wordInfo.playing ? "play.circle.fill" : "play.circle") // play.circle.fill
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.orange)
        })
          .padding(.bottom, 20)
      }
    }
  }
}

struct WordAddFinishView: View {
  @ObservedObject var viewModel: WordAddViewModel

  var body: some View {
    Text(viewModel.placeTitle)

    Rectangle() // 총 단어 개수, 담은 개수, 어쩌고

    Text("You got " + String(3) + "words")
    HStack{
      Button(action: {
        
      }, label: {
     Text("Let's go back to place page")
      })
        .padding(.bottom, 20)
      Button(action: {
        
      }, label: {
     Text("Let's go to check the words")
      })
        .padding(.bottom, 20)
    }
    // button 장소페이지로 돌아가기
    // button 단어장으로 가기
  }
}
