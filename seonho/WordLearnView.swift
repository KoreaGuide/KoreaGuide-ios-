//
//  WordLearnView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//
import AVKit
import Foundation
import SwiftUI

struct WordLearnScene: View {
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @ObservedObject var viewModel: WordLearnSceneViewModel

  var body: some View {
    VStack {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
            Spacer()
          }
          .padding(.horizontal, 20)

          Spacer()
            .frame(height: 80)

          // Text("learn view")
          //  .font(Font.custom("Bangla MN", size: 18))
          HStack{
            // left
            if 1 < viewModel.totalWordCount {
              Button(action: {
                if viewModel.currentWordCount > 0 {
                  viewModel.currentWordCount -= 1
                }

              }, label: {
                Image(systemName: "chevron.left.circle")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 30, height: 30, alignment: .center)
                  .foregroundColor(viewModel.currentWordCount == 0 ? .gray : .white)
              })
              .disabled(viewModel.currentWordCount == 0 )
            }
            
            if viewModel.word_list.count == 0 {
              EmptyLearnBox()
            } else {
              LearnBox(viewModel: viewModel)
            }
            // right
            if 1 < viewModel.totalWordCount {
              Button(action: {
                if viewModel.currentWordCount < viewModel.totalWordCount - 1 {
                  viewModel.currentWordCount += 1
                }
              }, label: {
                Image(systemName: "chevron.right.circle")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 30, height: 30, alignment: .center)
                  .foregroundColor(viewModel.currentWordCount == viewModel.totalWordCount - 1 ? .gray : .white)
              })
              .disabled(viewModel.currentWordCount == viewModel.totalWordCount - 1 )
              
            }
          }
          
          Spacer()
            .frame(height: 60)
        }
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
}

struct EmptyLearnBox: View {
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
      }
    }
  }
}

struct LearnBox: View {
  @ObservedObject var viewModel: WordLearnSceneViewModel
  @State var audioPlayer: AVAudioPlayer!
  @State var playing: Bool = false
  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 100)

        VStack {
          // 1.circle

          ImageView(withURL: viewModel.word_list[viewModel.currentWordCount].image)
            .frame(width: 200, height: 200, alignment: .center)
            .cornerRadius(10)
            .padding(.top, 20)

          Spacer().frame(height: 5)

          Text(viewModel.word_list[viewModel.currentWordCount].word_kor)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .font(Font.custom("Bangla MN", size: 16))

          Text(viewModel.word_list[viewModel.currentWordCount].word_eng)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 16))

          VStack(alignment: .leading) {
            Text(viewModel.word_list[viewModel.currentWordCount].meaning_kor1)
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 14))
              .lineLimit(6)
              .multilineTextAlignment(.leading)
            
          }
          VStack(alignment: .leading) {
            Text(viewModel.word_list[viewModel.currentWordCount].meaning_eng1)
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 14))
              .lineLimit(6)
              .multilineTextAlignment(.leading)
          }
          
          Spacer()

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
        .padding(.horizontal, 20)
      }
      .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 100)
    } .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 100)
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
