//
//  wordMainView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Combine
import Foundation
import SwiftUI

struct WordPopup: View {
  @Binding var displayItem: Int
  @ObservedObject var viewModel: WordListViewModel

  var body: some View {
    ZStack {
      // Rectangle().fill(Color.gray).opacity(0.5)
      if self.displayItem != -1 {
        Color.black.opacity(displayItem != -1 ? 0.3 : 0).edgesIgnoringSafeArea(.all)

        VStack {
          // Text("word")
          Text(viewModel.wordlist[displayItem].word)
            .padding(10)
          // Text("meaning")
          Text(viewModel.wordlist[displayItem].meaning)
            .padding(10)

          Text("이게 무슨 말이냐면 어쩌고 저쩌고 응")
            .padding(10)

          Text("추가된 날짜 등")
            .padding(10)
        }
        .frame(width: 300, height: 300, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 27).fill(Color.white.opacity(1)))
      }
    }
    .ignoresSafeArea()
    .onTapGesture {
      self.displayItem = -1
    }
  }
}

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

          NavigationLink(destination: WordListView(viewModel: WordListViewModel())) {
            LearningWordButton()
              .padding(.vertical, 10)
          }

          NavigationLink(destination: WordAddView(viewModel: WordAddViewModel())) {
            CompleteWordButton()
              .padding(.vertical, 10)
          }
        }
        .padding(.bottom, 20)
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

  @State var showPopup: Int = -1
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
    ZStack {
      NavigationView {
        ZStack {
          Image("center_bg")
            .resizable()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            .ignoresSafeArea()

          VStack(alignment: .center) {
            HStack{
              Text("Words List")
                .foregroundColor(.white)
                .font(.title)
                .padding(.vertical, 20)
              Spacer()
            }
            .padding(.horizontal, 40)

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
            .padding(.horizontal, 40)
            Spacer()
            Text("list here")

            WordGridView(rows: (viewModel.wordlist.count + 1) / 2, columns: 2) { row, col in

              let num = row * 2 + col

              if (viewModel.wordlist.count > num) && (num >= 0) {
                Button(action: {
                  self.showPopup = num
                }, label: {
                  WordCellView(word: $viewModel.wordlist[num])
                })
              }
            }
          }
        }
      }
      .navigationBarTitle("")
      .ignoresSafeArea()
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: self.backButton)

      if showPopup != -1 {
        WordPopup(displayItem: $showPopup, viewModel: viewModel)
          .padding(.top, -180)
      }
    }
  }
}

// .animation(.easeInOut)

struct LearnButton: View {
  var body: some View {
    Text("Learn")
      .frame(width: 120, height: 50, alignment: .center)
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)))
      .foregroundColor(Color("Navy"))
      .font(.title)
  }
}

struct TestButton: View {
  var body: some View {
    Text("Test")
      .frame(width: 120, height: 50, alignment: .center)
      .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8)))
      .foregroundColor(Color("Navy"))
      .font(.title)
  }
}

// from this view ...
// button navigation to learn
// button navigation to test

struct WordLearnView: View {
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
      VStack {
        Text("learn view")

        Text("")

        // WordBox(viewModel: viewModel)
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct WordLearnFinishView: View {
  var body: some View {
    Text("end of learning")
    // 뭘 보여주지... 잘햇다?
    // learn 도 기록이 되면 공부한 횟수라든가...
    // Button()
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
          Text("단어장 이름")
            .foregroundColor(.white)
            .padding(.vertical, 20)

          Text("시험 볼 단어")
            .foregroundColor(.white)

          Rectangle()
            .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
            .foregroundColor(.orange)
            .padding(.horizontal, 20)

          Text("test type select")
            .foregroundColor(.white)

          // NavigationView {
          List {
            NavigationLink(destination: WordTestView(viewModel: LearningWordViewModel())) {
              Text("1. ")
                .foregroundColor(.black)
            }
            NavigationLink(destination: WordTestView(viewModel: LearningWordViewModel())) {
              Text("2. ")
                .foregroundColor(.black)
            }
            NavigationLink(destination: WordTestView(viewModel: LearningWordViewModel())) {
              Text("3. ")
                .foregroundColor(.black)
            }
            NavigationLink(destination: WordTestView(viewModel: LearningWordViewModel())) {
              Text("4. ")
                .foregroundColor(.black)
            }
          }
          // .background(Color.clear)
          // }
          // .navigationBarTitle("")
          // .navigationBarHidden(true)

          // four button
        }
        // .background(Color.gray.opacity(0.5))
      }
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .navigationBarItems(leading: self.backButton)
    .ignoresSafeArea()
  }
}

struct WordTestView: View {
  @ObservedObject var viewModel: LearningWordViewModel // 변경

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
    VStack {
      Text("test page")
      Text("3/3")

      // ProgressBar
      Text("3/3")
        .foregroundColor(.white)
      progressBar
        .frame(width: UIScreen.main.bounds.width - 100, height: 20, alignment: .center)

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
  @ObservedObject var viewModel: WordListViewModel
  @Environment(\.presentationMode) var presentation

  var body: some View {
    ZStack {
      if viewModel.didSelectWord {
        // PopUp background color
        Color.black.opacity(viewModel.didSelectWord ? 0.3 : 0).edgesIgnoringSafeArea(.all)

        // PopUp Window
        VStack(alignment: .center, spacing: 0) {
          Text(viewModel.selectedWord?.word ?? "")
            .frame(maxWidth: .infinity)
            .frame(height: 45, alignment: .center)
            .font(Font.system(size: 23, weight: .semibold))
            .foregroundColor(Color.black)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))

          Text(viewModel.selectedWord?.meaning ?? "")
            .multilineTextAlignment(.center)
            .font(Font.system(size: 16, weight: .semibold))
            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
            .foregroundColor(Color.blue)

          Button(action: {
            // Dismiss the PopUp
            withAnimation(.linear(duration: 0.3)) {
              viewModel.didSelectWord = false
            }
          }, label: {
            Text("xxxxxx")
              .frame(maxWidth: .infinity)
              .frame(height: 54, alignment: .center)
              .foregroundColor(Color.black)
              .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
              .font(Font.system(size: 23, weight: .semibold))
          }).buttonStyle(PlainButtonStyle())

          Button("Dismiss") {
            // self.presentation.
          }
        }
        .frame(height: 300)
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
