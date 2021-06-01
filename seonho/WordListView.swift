//
//  WordListView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI 

struct WordPopup: View {
  @Binding var popupWordId: Int
  @ObservedObject var viewModel: WordListSceneViewModel
  @State var popupWord: InMyListWord

  var body: some View {
    ZStack {
      if self.popupWordId != -1 {
        Color.black.opacity(popupWordId != -1 ? 0.3 : 0).edgesIgnoringSafeArea(.all)

        VStack(alignment: .leading) {
          HStack {
            Text(popupWord.word_kor)
              .font(.system(size: 20, weight: .heavy))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.heavy)
          }

          HStack {
            Text(popupWord.word_eng)
              .font(.system(size: 18, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 18))
              //.fontWeight(.bold)
          }

          HStack {
            Text(popupWord.meaning_eng1)
              .font(.system(size: 16, weight: .regular))
              //.font(Font.custom("Bangla MN", size: 16))
              .multilineTextAlignment(.leading)
              .lineLimit(6)
          }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .frame(width: 270, height: 240, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 27).fill(Color.white.opacity(1)))
      }
    }
    .ignoresSafeArea()
    .onTapGesture {
      self.popupWordId = -1
      viewModel.reload()
    }
  }
}

struct LearnButton: View {
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8))
          .frame(width: 150, height: 50, alignment: .center)
        HStack {
          Image(systemName: "book")
            .resizable()
            .foregroundColor(Color("Green"))
            .frame(width: 30, height: 30)
          Text("Learn")
            .foregroundColor(Color("Green"))
            .font(.system(size: 25, weight: .regular))
            //.font(Font.custom("Bangla MN", size: 25))
            //.padding(.top, 10)
        }
      }
      .frame(width: UIScreen.main.bounds.width / 23 * 10, height: 50, alignment: .center)
    }
  }
}

struct TestButton: View {
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.8))
          .frame(width: 150, height: 50, alignment: .center)
        HStack {
          Image(systemName: "square.and.pencil")
            .resizable()
            .foregroundColor(Color("Green"))
            .frame(width: 30, height: 30)
          Text("Test")
            .foregroundColor(Color("Green"))
            .font(.system(size: 25, weight: .regular))
            //.font(Font.custom("Bangla MN", size: 25))
            //.padding(.top, 10)
        }
      }
      .frame(width: UIScreen.main.bounds.width / 23 * 10, height: 50, alignment: .center)
    }
  }
}

enum FolderName: String {
  case Added
  case Learning
  case Complete
}

struct WordListNavigationLinks: View {
  @ObservedObject var viewModel: WordListSceneViewModel
  var body: some View {
    VStack {
      
//      NavigationLink(destination: NavigationLazyView(
//        WordMainScene()
//          .navigationBarTitle("")
//          .navigationBarHidden(true)
//      ), isActive: $viewModel.didTapBackButton) {
//        EmptyView()
//      }.isDetailLink(false)

      //, word_list: viewModel.word_list
      NavigationLink(destination: NavigationLazyView(
        WordLearnScene(viewModel: WordLearnSceneViewModel(word_folder_id: viewModel.word_folder_id))
          .navigationBarTitle("")
          .navigationBarHidden(true)
      ), isActive: $viewModel.didTapLearnButton) {
        EmptyView()

      }.isDetailLink(false)

      NavigationLink(destination: NavigationLazyView(
        WordTestSelectScene(viewModel: WordTestSelectSceneViewModel(word_folder_id: viewModel.word_folder_id, word_list: viewModel.word_list))
          .navigationBarTitle("")
          .navigationBarHidden(true)
      ), isActive: $viewModel.didTapTestButton) {
        EmptyView()

      }.isDetailLink(false)
    }
  }
}

struct WordListScene: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel: WordListSceneViewModel
  @ObservedObject var mainSceneViewModel: WordMainSceneViewModel
  // @State var showPopup: Int = -1

  // var input as option 1~3
  // @ObservedObject var navigation: Navigation

  var body: some View {
    VStack {
      // NavigationView {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack(alignment: .center) {
          
          HStack {
            BackButton(tapAction: {
              //self.viewModel.didTapBackButton = true
              mainSceneViewModel.reload()
              self.presentationMode.wrappedValue.dismiss()
              print("----- back button tapped")
            })
            Spacer()
          }
          .padding(.horizontal, 20)
          .padding(.top, 80)

          WordListNavigationLinks(viewModel: viewModel)
          
          Text(" Words List ") // TODO:
            .foregroundColor(.white)
            //.font(.system(size: 25, weight: .heavy))
            .fontWeight(.heavy)
            .font(Font.custom("Bangla MN", size: 25))
            .padding(.vertical, 15)

          HStack {
            Button(action: {
              self.viewModel.didTapLearnButton = true
            }, label: {
              LearnButton()
            })
            Spacer()
            Button(action: {
              self.viewModel.didTapTestButton = true
            }, label: {
              TestButton()
            })
          }
          .padding(.horizontal, 18)
          Spacer()
            .frame(height: 20)
          if viewModel.word_list.count == 0 {
            Text("This folder is empty.")
              .foregroundColor(.white)
              //.fontWeight(.heavy)
              //.font(Font.custom("Bangla MN", size: 25))
              .font(.system(size: 25, weight: .heavy))
              .padding(.vertical, 15)
            Spacer()
          } else {
            ScrollView(.vertical) {
              WordLazyGridView(viewModel: viewModel)
                .padding(.bottom, 120)
            }
            .frame(width: UIScreen.main.bounds.width, height: 600)
          }

        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        if viewModel.showPopup != -1 {
          WordPopup(popupWordId: $viewModel.showPopup, viewModel: viewModel, popupWord: viewModel.getWordById(finding_word_id: viewModel.showPopup))
            .padding(.top, -50)
            .ignoresSafeArea()
        }
      }
      // }
      // .navigationBarTitle("")
      // .navigationBarHidden(true)
      // .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
}
