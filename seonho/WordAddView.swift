//
//  wordAddView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import AVKit
import Combine
import Foundation
import SwiftUI

// destination: WordAddView(viewModel: WordAddViewModel(place_id: 0)) 이런식으로 진입

struct ProgressBar: View {
  @Binding var value: Float

  init(value: Binding<Float>) {
    _value = value // beta 4
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
          .frame(width: UIScreen.main.bounds.width + 10, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          Spacer()
            .frame(height: 60)
          
          // place title
          Label(viewModel.place_title, systemImage: "flag") // flag.fill
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 20))
          Spacer()
            .frame(height: 20)
          // label
          Section {
            Text(String(viewModel.currentWordCount) + "  /  " + String(viewModel.totalWordCount))
              .foregroundColor(.white)
              .fontWeight(.heavy)
              .font(Font.custom("Bangla MN", size: 18))

            ProgressBar(value: $viewModel.progressValue)
              .frame(width: UIScreen.main.bounds.width - 100, height: 15, alignment: .center)
              .padding(.vertical, 5)
          }
          Spacer()
            .frame(height: 40)
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
            if viewModel.currentWordCount == viewModel.totalWordCount {
              VStack {
                ZStack {
                  RoundedRectangle(cornerRadius: 25)
                    .fill(Color("Navy"))
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)

                  VStack {
                    Text(viewModel.place_title)
                    Text("You got " + String(viewModel.added_word_id_list.count) + " words")
                    HStack {
                      Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                      }, label: {
                        Text("Let's go back to place page")
                          .font(Font.custom("Bangla MN", size: 15))
                          .padding(.top, 10)
                      })
                        .padding(.bottom, 20)
                      Button(action: {}, label: {
                        Text("Let's go to check the words")
                          .font(Font.custom("Bangla MN", size: 15))
                          .padding(.top, 10)
                      })
                        .padding(.bottom, 20)
                    }
                  }
                  .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
                }
              }
            } else {
              WordBox(viewModel: WordBoxViewModel(currentCount: viewModel.currentWordCount, word: viewModel.word_list[viewModel.currentWordCount]))
            }

            // right
            Button(action: {
              if viewModel.currentWordCount < viewModel.totalWordCount {
                viewModel.currentWordCount += 1
                // self.progressValue = Float(viewModel.currentWordCount + 1) / Float(viewModel.totalWordCount)
                if viewModel.currentWordCount == viewModel.totalWordCount {
                  viewModel.finish = true
                }
              }

            }, label: {
              Image(systemName: "chevron.right.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(.white)
            })
          }

          Spacer().frame(height: 30)

          if viewModel.currentWordCount != viewModel.totalWordCount {
            InOutButton(viewModel: viewModel)
          }

          Spacer()
        }
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct WordBox: View {
  @ObservedObject var viewModel: WordBoxViewModel
  @State var audioPlayer: AVAudioPlayer!
  // @State var added: Bool = false
  // @State var playing: Bool = false

  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)

        VStack {
          // 1.circle
          Image(viewModel.word.word.image)
            .resizable()
            .frame(width: 200, height: 200, alignment: .center)
            .cornerRadius(10)
            .padding(.vertical, 20)

          Spacer().frame(height: 10)

          Text(viewModel.word.word.word_kor)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 20))

          Text(viewModel.word.word.pronunciation_eng)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))

          Text(viewModel.word.word.word_eng)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))

          Text(viewModel.word.word.meaning_eng1)
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))

          Button(action: {
            viewModel.word.playing.toggle()
            self.audioPlayer.play()
            // self.audioPlayer.pause()
          }, label: {
            Image(systemName: viewModel.word.playing ? "play.circle.fill" : "play.circle")
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

struct InOutButton: View {
  @ObservedObject var viewModel: WordAddViewModel

  var body: some View {
    // TODO: 수정
    Button(action: {
      viewModel.addButton.toggle()
      if viewModel.addButton == true {
        viewModel.added_word_id_list.append(viewModel.word_list[viewModel.currentWordCount].word.word_id)
      } else {
        viewModel.added_word_id_list = viewModel.added_word_id_list
          .filter { $0 != viewModel.word_list[viewModel.currentWordCount].word.word_id }
      }
    }, label: {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 80, height: 50)

        HStack {
          Image(systemName: viewModel.word_list[viewModel.currentWordCount].added ? "tray.and.arrow.up.fill" : "tray.and.arrow.down.fill")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .foregroundColor(Color.orange)
            .padding(.horizontal, 5)
          Text(viewModel.word_list[viewModel.currentWordCount].added ? "Get it out of my vocabulary" : "Put it in my vocabulary")
            .foregroundColor(Color.orange)
            .font(Font.custom("Bangla MN", size: 18))
            .padding(.top, 10)
        }
      }

    })
      .padding(.bottom, 20)
  }
}
