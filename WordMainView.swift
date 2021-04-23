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
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          Text("Your Words")

          NavigationLink(destination: WordListView()) {
            AddedWordButton()
          }

          NavigationLink(destination: WordListView()) {
            LearningWordButton()
          }

          NavigationLink(destination: WordListView()) {
            CompleteWordButton()
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
    })
  }

  var body: some View {
    // TODO: 이거 네비게이션 말고 딴걸로 변경 하든가
    // NavigationView{
    VStack {
      HStack {
        // back button
        Text("단어장 이름")
        // 선택 버튼? -> 삭제
      }
      /*
       HStack { // learn btn and test btn
         NavigationLink(destination: WordLearnView()) {
           LearnButton()
         }.navigationBarTitle("Words")

         NavigationLink(destination: WordSelectTestView()) {
           TestButton()
         }.navigationBarTitle("Words")
       }
       */
      // wordlist

      Text("list here")
    }
    // }
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: backButton)
  }
}

struct LearningWordListView: View {
  // var input as option 1~3

  var body: some View {
    // TODO: 이거 네비게이션 말고 딴걸로 변경 하든가

    VStack {
      HStack {
        // back button
        Text("단어장 이름")
        // 선택 버튼? -> 삭제
      }

      HStack { // learn btn and test btn
        NavigationLink(destination: WordLearnView()) {
          LearnButton()
        }.navigationBarTitle("Words")

        NavigationLink(destination: WordSelectTestView()) {
          TestButton()
        }.navigationBarTitle("Words")
      }

      // wordlist

      Text("list here")
    }
  }
}

struct CompleteWordListView: View {
  // var input as option 1~3

  var body: some View {
    // TODO: 이거 네비게이션 말고 딴걸로 변경 하든가

    VStack {
      HStack {
        // back button
        Text("단어장 이름")
        // 선택 버튼? -> 삭제
      }

      HStack { // learn btn and test btn
        NavigationLink(destination: WordLearnView()) {
          LearnButton()
        }.navigationBarTitle("Words")

        NavigationLink(destination: WordSelectTestView()) {
          TestButton()
        }.navigationBarTitle("Words")
      }

      // wordlist

      Text("list here")
    }
  }
}

struct LearnButton: View {
  var body: some View {
    ZStack {
      // Image()
      Text("Learn")
    }
  }
}

struct TestButton: View {
  var body: some View {
    ZStack {
      // Image()
      Text("Test")
    }
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
  var body: some View {
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

// 단어장 속 단어 목록
struct WordCollectionView: View {
  let data: WordInfo
  var body: some View {
    VStack {
      HStack {
        ForEach(0 ..< 2) { items in
          Spacer()
          Image("")
            .resizable()
            .frame(width: 150, height: 150)
            .foregroundColor(.yellow)
            .clipShape(Circle())
            .shadow(radius: 10) // click -> popup
          Spacer()
        }.padding(.bottom, 16)
      }
      HStack {
        Spacer()
        Text(self.data.word)
        Spacer()
        Text(self.data.word)
        Spacer()
      }
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
      Image("mae")
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

      VStack {
        Text("Added Word List")
        Text("number of words")
      }
    }
  }
}

struct LearningWordButton: View {
  var body: some View {
    ZStack {
      Image("mae")
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

      VStack {
        Text("Learning Word List")
        Text("number of words")
      }
    }
  }
}

struct CompleteWordButton: View {
  var body: some View {
    ZStack {
      Image("mae")
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/)

      VStack {
        Text("Complete Word List")
        Text("number of words")
      }
    }
  }
}
