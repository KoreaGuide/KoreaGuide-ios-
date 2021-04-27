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


// .animation(.easeInOut)


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
      ZStack{
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()
        
        VStack {
          Text("learn view")

          Text("")

          // WordBox(viewModel: viewModel)
        }
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

struct WordTestView: View {
  @ObservedObject var viewModel: WordTestViewModel 

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
