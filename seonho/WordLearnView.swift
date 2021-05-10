//
//  WordLearnView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//
import AVKit
import Foundation
import SwiftUI

struct WordLearnView: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel: WordLearnViewModel

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
          Text("learn view")
            .font(Font.custom("Bangla MN", size: 18))
          LearnBox(viewModel: viewModel)
          Text("")

          // WordBox(viewModel: viewModel)
        }
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
    // .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct LearnBox: View {
  @ObservedObject var viewModel: WordLearnViewModel
  @State var audioPlayer: AVAudioPlayer!
  @State var playing: Bool = false
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)

        VStack {
          // 1.circle

          Image(viewModel.word_list[viewModel.currentWordCount].image)
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
            .cornerRadius(10)
            .padding(.vertical, 20)

          Spacer().frame(height: 10)

          Text(viewModel.word_list[viewModel.currentWordCount].word_kor)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 20))

          Text(viewModel.word_list[viewModel.currentWordCount].word_eng)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))

          Text(viewModel.word_list[viewModel.currentWordCount].meaning_kor1)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))

          Text(viewModel.word_list[viewModel.currentWordCount].meaning_eng1)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))

          Button(action: {
            self.playing.toggle()
            self.audioPlayer.play()
            // self.audioPlayer.pause()
          }, label: {
            Image(systemName: self.playing ? "play.circle.fill" : "play.circle")
              .resizable()
              .frame(width: 30, height: 30, alignment: .center)
              .foregroundColor(Color.orange)
          })
            .onAppear {
              //  let sound = Bundle.main.path(forResource: "1", ofType: "mp3")
              // self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            }
            .padding(.bottom, 20)
        }
      }
      .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
    }
  }
}

struct WordLearnFinishView: View {
  var body: some View {
    Text("end of learning")
      .font(Font.custom("Bangla MN", size: 18))
    // 뭘 보여주지... 잘햇다?
    // learn 도 기록이 되면 공부한 횟수라든가...
    // Button()
  }
}
