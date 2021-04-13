//
//  wordMainView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Foundation
import SwiftUI

struct WordMainView: View {
  var body: some View {
    NavigationView {
      NavigationLink(destination: WordListView()) {
        AddedWordButton()
      }.navigationBarTitle("Your Words")

      NavigationLink(destination: WordListView()) {
        LearningWordButton()
      }.navigationBarTitle("Your Words")

      NavigationLink(destination: WordListView()) {
        CompleteWordButton()
      }.navigationBarTitle("Your Words")
    }
  }
}

struct WordListView: View {
  // var input as option 1~3

  var body: some View {
    // NavigationView
    // learn btn and test btn

    // wordlist

    Text("list here")
  }
}
//from this view ...
//button navigation to learn
//button navigation to test



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
      // Image()
      Text("Added Word List")
    }
  }
}

struct LearningWordButton: View {
  var body: some View {
    ZStack {
      // Image()
      Text("Learning Word List")
    }
  }
}

struct CompleteWordButton: View {
  var body: some View {
    ZStack {
      // Image()
      Text("Complete Word List")
    }
  }
}
