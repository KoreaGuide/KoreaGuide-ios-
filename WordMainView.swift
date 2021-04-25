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
            Text("Your Words")
              .foregroundColor(.white)
              .font(.title)
              .padding(.horizontal, 20)
            Spacer()
          }
          .padding(.vertical, 20)
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

          NavigationLink(destination: WordListView(viewModel: WordListViewModel())) {
            LearningWordButton()
              .padding(.vertical, 10)
          }

          NavigationLink(destination: WordAddView(totalWordCount: 3, currentWord: 3, wordlist: [WordInfo(word: "단어 단어", meaning: "meaning meaning", wordId: 3)])) {
            CompleteWordButton()
              .padding(.vertical, 10)
          }
        }
      }
      .ignoresSafeArea()
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .ignoresSafeArea()
  }
}

struct WordListView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  @ObservedObject var viewModel: WordListViewModel

  // var input as option 1~3
  // @ObservedObject var navigation: Navigation

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
        Image("center_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack(alignment: .center) {
          Text("Words List")
            .foregroundColor(.white)
            .font(.title)
            .padding(.vertical, 20)

          HStack {
            NavigationLink(destination: WordLearnView()) {
              LearnButton()
                .frame(width: 200, height: 100, alignment: .center)
            }
            Spacer()
            NavigationLink(destination: WordSelectTestView()) {
              TestButton()
                .frame(width: 200, height: 100, alignment: .center)
            }
          }
          .padding(.horizontal, 20)
          Spacer()
          Text("list here")

          WordGridView(rows: (viewModel.words.count + 1) / 2, columns: 2) { row, col in

            let num = row * 2 + col

            if (viewModel.words.count > num) && (num >= 0) {
              WordCellView(word: $viewModel.words[num])
                .onTapGesture {
                  viewModel.selectedWord = viewModel.words[num]
                }
            }
          }
        }
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct LearnButton: View {
  var body: some View {
    Text("Learn")
      // .overlay(RoundedRectangle(cornerRadius: 25).frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/))
      .foregroundColor(.white)
      .font(.title)
  }
}

struct TestButton: View {
  var body: some View {
    Text("Test")
      // .overlay(RoundedRectangle(cornerRadius: 25).frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/))
      .foregroundColor(.white)
      .font(.title)
  }
}

// from this view ...
// button navigation to learn
// button navigation to test

struct WordLearnView: View {
  var body: some View {
    VStack {
      // 시험 나가기 버튼

      Text("title")

      Text("")

      WordBox()

      // segmented controll?
    }
  }
}

struct WordLearnFinishView: View {
  var body: some View {
    Text("title")
    // 뭘 보여주지... 잘햇다?
    // learn 도 기록이 되면 공부한 횟수라든가...
  }
}

struct WordSelectTestView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
        Image("right_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            // back button
            Text("단어장 이름")
          }

          Text("시험 볼 단어")
          Rectangle()
            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

          Text("test type select")
          Rectangle()
            .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

          // four button
        }
      }
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct WordTestView: View {
  var body: some View {
    VStack {
      Text("3/3")

      // ProgressBar

      // test box...
    }
  }
}

struct WordTestFinishView: View {
  var body: some View {
    VStack {
      Text("finish")
    }
  }
}

struct PopUpWindow: View {
  var title: String
  var message: String
  var buttonText: String
  @Binding var show: Bool

  var body: some View {
    ZStack {
      if show {
        // PopUp background color
        Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

        // PopUp Window
        VStack(alignment: .center, spacing: 0) {
          Text(title)
            .frame(maxWidth: .infinity)
            .frame(height: 45, alignment: .center)
            .font(Font.system(size: 23, weight: .semibold))
            .foregroundColor(Color.white)
            .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))

          Text(message)
            .multilineTextAlignment(.center)
            .font(Font.system(size: 16, weight: .semibold))
            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
            .foregroundColor(Color.white)

          Button(action: {
            // Dismiss the PopUp
            withAnimation(.linear(duration: 0.3)) {
              show = false
            }
          }, label: {
            Text(buttonText)
              .frame(maxWidth: .infinity)
              .frame(height: 54, alignment: .center)
              .foregroundColor(Color.white)
              .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
              .font(Font.system(size: 23, weight: .semibold))
          }).buttonStyle(PlainButtonStyle())
        }
        .frame(maxWidth: 300)
        .border(Color.white, width: 2)
        .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
      }
    }
  }
}

struct AddedWordButton: View {
  var body: some View {
    ZStack {
      // Image("mae")
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
