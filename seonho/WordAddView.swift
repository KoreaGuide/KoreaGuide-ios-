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
          .transition(.slide)
      }.cornerRadius(45.0)
    }
  }
}

struct WordAddView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

  @ObservedObject var viewModel: WordAddViewModel
  // @State var progressValue: Float = 0.0

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

        VStack(alignment: .center) {
          Spacer()
            .frame(height: 10)

          // place title
          Label(viewModel.place_title, systemImage: "flag") // flag.fill
            .foregroundColor(.white)
            .font(Font.custom("Bangla MN", size: 18))
            .multilineTextAlignment(.center)
            .frame(width: 280, alignment: .center)
          Spacer()
            .frame(height: 10)
          // label
          Section {
            Text(viewModel.finish ? "Finish!" : (String(viewModel.currentWordCountforShow) + "  /  " + String(viewModel.totalWordCount)))
              .foregroundColor(.white)
              .fontWeight(.heavy)
              .font(Font.custom("Bangla MN", size: 18))

            ProgressBar(value: $viewModel.progressValue)
              .frame(width: UIScreen.main.bounds.width - 100, height: 15, alignment: .center)
              .padding(.vertical, 5)
          }
          Spacer()
            .frame(height: 20)

          HStack {
            // box
            if viewModel.finish == true {
              VStack {
                ZStack {
                  RoundedRectangle(cornerRadius: 25)
                    .fill(Color("Navy"))
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)

                  VStack {
                    Text("You got " + String(viewModel.added_word_id_list.count) + (viewModel.added_word_id_list.count <= 1 ? " word." : " words!"))
                      .font(Font.custom("Bangla MN", size: 20))
                      .fontWeight(.bold)
                      .foregroundColor(.white)

                    Spacer()
                      .frame(height: 40)

                    VStack {
                      Button(action: {
                        self.presentationMode.wrappedValue.dismiss()

                      }, label: {
                        Text("  Let's go back to place page  ")
                          .font(Font.custom("Bangla MN", size: 15))
                          .foregroundColor(Color("Navy"))
                          .padding(5)
                          .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(1)))
                      })
                        .padding(.bottom, 20)
                    }
                  }
                  .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
                }
              }
            } else {
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

              if viewModel.currentWordCount == viewModel.word_list.count - 1 {
                AddEndBox(viewModel: viewModel)
              } else {
                if viewModel.word_list.count == 0 {
                  EmptyWordBox()
                } else {
                  WordBox(viewModel: self.viewModel)
                }
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
          }

          Spacer().frame(height: 30)

          if viewModel.finish == false {
            if viewModel.word_list.count == 0 {
              EmptyView()
            }
            else if viewModel.currentWordCount == viewModel.totalWordCount - 1 {
              EmptyView()
            } else {
              InOutButton(viewModel: viewModel)
            }
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

struct EmptyWordBox: View {
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

struct AddEndBox: View {
  @ObservedObject var viewModel: WordAddViewModel

  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)

        VStack {
          Text("End of \nplace related words \nadding.")
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.white)

          Spacer()
            .frame(height: 120)

          VStack {
            Button(action: {
              viewModel.wordAdd()
              viewModel.currentWordCountforShow = viewModel.totalWordCount
              viewModel.finish = true

            }, label: {
              VStack(alignment: .center) {
                Text("Finish and Save")
                  .font(Font.custom("Bangla MN", size: 18))
                  .fontWeight(.bold)
                  .foregroundColor(Color.orange)
                Image(systemName: "cursor.rays")
                  .resizable()
                  .foregroundColor(Color.orange)
                  .frame(width: 30, height: 30, alignment: .center)
              }

            })
              .padding(.bottom, 20)
          }
        }
        .padding(.horizontal, 20)
      }
    }
    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
  }
}

struct WordBox: View {
  @ObservedObject var viewModel: WordAddViewModel
  @State var audioPlayer: AVAudioPlayer!
  // @State var added: Bool = false
  @State var playing: Bool = false

  var body: some View {
    VStack {
      ZStack {
        RoundedRectangle(cornerRadius: 25)
          .fill(Color("Navy"))
          .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)

        VStack {
          ImageView(withURL: viewModel.word_list[viewModel.currentWordCount].word_image)
            .frame(width: 200, height: 160, alignment: .center)
            .cornerRadius(10)
            .padding(.top, 20)

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
              .lineLimit(4)
              .multilineTextAlignment(.leading)

            Text(viewModel.word_list[viewModel.currentWordCount].meaning_eng1)
              .foregroundColor(.white)
              .font(Font.custom("Bangla MN", size: 14))
              .lineLimit(4)
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
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 14)
      }
      .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
    }.frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.height / 2 + 40)
  }
}

struct InOutButton: View {
  @ObservedObject var viewModel: WordAddViewModel

  var body: some View {
    // TODO: 수정
    Button(action: {
      viewModel.added_word_bool_list[viewModel.currentWordCount].toggle()
      if viewModel.added_word_bool_list[viewModel.currentWordCount] == true {
        viewModel.added_word_id_list.append(viewModel.word_list[viewModel.currentWordCount].word_id)
      } else {
        viewModel.added_word_id_list = viewModel.added_word_id_list
          .filter { $0 != viewModel.word_list[viewModel.currentWordCount].word_id }
      }
    }, label: {
      if viewModel.word_list[viewModel.currentWordCount].word_status != "NO_STATUS" {
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .fill(Color("Navy"))
            .frame(width: UIScreen.main.bounds.width - 80, height: 50)

          HStack {
            Image(systemName: "tray.fill")
              .resizable()
              .frame(width: 30, height: 30, alignment: .center)
              .foregroundColor(Color.gray)
              .padding(.horizontal, 5)
            Text("Already in my word list")
              .foregroundColor(Color.gray)
              .font(Font.custom("Bangla MN", size: 18))
              .padding(.top, 10)
          }
        }
      } else {
        if viewModel.added_word_bool_list[viewModel.currentWordCount] == true {
          ZStack {
            RoundedRectangle(cornerRadius: 10)
              .fill(Color("Navy"))
              .frame(width: UIScreen.main.bounds.width - 80, height: 50)

            HStack {
              Image(systemName: "tray.and.arrow.up.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color.orange)
                .padding(.horizontal, 5)
              Text("Take out the word you put in")
                .foregroundColor(Color.orange)
                .font(Font.custom("Bangla MN", size: 18))
                .padding(.top, 10)
            }
          }
        } else {
          ZStack {
            RoundedRectangle(cornerRadius: 10)
              .fill(Color("Navy"))
              .frame(width: UIScreen.main.bounds.width - 80, height: 50)

            HStack {
              Image(systemName: "tray.and.arrow.down.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .foregroundColor(Color.orange)
                .padding(.horizontal, 5)
              Text("Put it in my vocabulary")
                .foregroundColor(Color.orange)
                .font(Font.custom("Bangla MN", size: 18))
                .padding(.top, 10)
            }
          }
        }
      }

    })
      .disabled(viewModel.word_list[viewModel.currentWordCount].word_status != "NO_STATUS")
      .padding(.bottom, 20)
  }
}
