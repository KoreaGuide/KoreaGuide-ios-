//
//  WordTestView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import AVKit
import Foundation
import SwiftUI

struct CircularProgressBar: View {
  @Binding var progress: Float

  var body: some View {
    ZStack {
      Circle()
        .stroke(lineWidth: 10.0)
        .opacity(0.3)
        .foregroundColor(Color.gray)

      Circle()
        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
        .foregroundColor(Color.orange)
        .rotationEffect(Angle(degrees: 270.0))
        .animation(.linear)

      Text(String(format: "%.0f %%", min(self.progress, 1.0) * 100.0))
        .foregroundColor(.white)
        .font(Font.custom("Bangla MN", size: 20))
        .padding(.top, 10)

//      Text(String(self.viewModel.currentWordCount) + " / " + String(self.viewModel.totalWordCount))
//        .foregroundColor(.white)
//        .font(Font.custom("Bangla MN", size: 18))
    }
  }
}

struct WordTestScene: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  var body: some View {
    ZStack {
      Image("background")
        .resizable()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .ignoresSafeArea()

      VStack {
        HStack {
          ZStack {
            HStack {
              BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
              Spacer()
            }
            .padding(.horizontal, 20)
            HStack(alignment: .bottom) {
              Spacer()
              Text("     Match the meaning of the word!")
                .font(Font.custom("Bangla MN", size: 18))
                .foregroundColor(.white)
              Spacer()
            }
            .padding(.horizontal, 20)
          }
        }
        .padding(.bottom, 10)

        HStack(alignment: .center) {
          // ProgressBar
          CircularProgressBar(progress: $viewModel.progressValue)
            .frame(width: 80, height: 80)
          Spacer()
            .frame(width: 20)
          VStack {
            ImageView(withURL: self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
              .frame(width: 200, height: 200)

            Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")
              .font(Font.custom("Bangla MN", size: 22))
              .fontWeight(.heavy)
              .foregroundColor(.white)
          }
        }
        .padding(.horizontal, 10)
        .padding(.bottom, 10)


        // test box...
        MatchAnswerView(viewModel: self.viewModel)
      }
    }
  }

  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct MatchAnswerView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  var body: some View {
    ZStack {
      // background

      VStack {
        // Text(self.viewModel.quiz_type)
        //  .font(Font.custom("Bangla MN", size: 18))

        Button(action: {
          self.viewModel.choice = 1
        }, label: {
          Text("1. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[0].word_eng ?? ""))
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
          .background(self.viewModel.choice == 1 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
          .padding(5)

        Button(action: {
          self.viewModel.choice = 2
        }, label: {
          Text("2. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[1].word_eng ?? ""))
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
          .background(self.viewModel.choice == 2 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
          .padding(5)

        Button(action: {
          self.viewModel.choice = 3
        }, label: {
          Text("3. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[2].word_eng ?? ""))
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
          .background(self.viewModel.choice == 3 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
          .padding(5)

        Button(action: {
          self.viewModel.choice = 4
        }, label: {
          Text("4. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[3].word_eng ?? ""))
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 40, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
          .background(self.viewModel.choice == 4 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
          .padding(5)

        Spacer()
          .frame(height: 20)

        Button(action: {
          if self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.choice {
            let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)

            viewModel.result.append(tuple)
          } else {
            let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
            viewModel.result.append(tuple)
          }

          viewModel.choice = -1
          viewModel.currentWordCount += 1
        }, label: {
          Text(" NEXT ")
            .font(Font.custom("Bangla MN", size: 25))
            .fontWeight(.bold)
            .foregroundColor(viewModel.choice == -1 ? .white : .black)
            .background(RoundedRectangle(cornerRadius: 20)
              .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .bottom)
              .foregroundColor(viewModel.choice == -1 ? Color.gray : Color.green))
        })
          .background(Color.white.opacity(0.8))
          .padding(10)

        Spacer()
          .frame(height: 40)
      }
    }
  }
}

struct WordMatchTestView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  var body: some View {
    VStack {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            ZStack {
              HStack {
                BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("     Match the meaning of the word!")
                  .font(Font.custom("Bangla MN", size: 18))
                  .foregroundColor(.white)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.bottom, 10)

          HStack(alignment: .center) {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)
            Spacer()
              .frame(width: 20)
            VStack {
              ImageView(withURL: self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
                .frame(width: 200, height: 200)

              Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")
                .font(Font.custom("Bangla MN", size: 22))
                .fontWeight(.heavy)
                .foregroundColor(.white)
            }
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 10)
//        // ProgressBar#imageLiteral(resourceName: "simulator_screenshot_2ED0AF66-9D6C-485C-9F48-BF8EC5DADAF8.png")
//        CircularProgressBar(progress: $viewModel.progressValue)
//        .frame(width: 100, height: 100)

          
          MatchAnswerView(viewModel: self.viewModel)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct WordListenTestView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @State var audioPlayer: AVAudioPlayer!
  @State var playing: Bool = false
  var body: some View {
    VStack {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            ZStack {
              HStack {
                BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("Listen to the pronunciation \nand match the word!")
                  .font(Font.custom("Bangla MN", size: 16))
                  .foregroundColor(.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.bottom, 10)
          Spacer()
            .frame(height: 70)
          HStack(alignment: .center) {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)
            Spacer()
              .frame(width: 100)
            VStack(alignment: .center) {
              Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")
                .font(Font.custom("Bangla MN", size: 22))
                .fontWeight(.heavy)
                .foregroundColor(.white)

              Button(action: {
                self.playing.toggle()
                self.audioPlayer.play()
                // self.audioPlayer.pause()
              }, label: {
                Image(systemName: self.playing ? "play.circle.fill" : "play.circle")
                  .resizable()
                  .frame(width: 50, height: 50, alignment: .center)
                  .foregroundColor(Color.orange)
              })
            }
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 10)
          Spacer()
            .frame(height: 50)
          MatchAnswerView(viewModel: self.viewModel)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }

  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct WordSpellingEasyTestView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  @State var audioPlayer: AVAudioPlayer!
  @State var playing: Bool = false
  var body: some View {
    VStack {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            ZStack {
              HStack {
                BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("Complete the spelling of words \nletter by letter!")
                  .font(Font.custom("Bangla MN", size: 16))
                  .foregroundColor(.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.bottom, 10)

          HStack(alignment: .center) {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)
            Spacer()
              .frame(width: 40)
            VStack {
              ImageView(withURL: self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
                .frame(width: 200, height: 200)

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
            }
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 10)


          EasySpellingAnswerView(viewModel: self.viewModel)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }

  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct EasySpellingAnswerView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  var body: some View {
    VStack {
      ZStack {
        // background
        VStack {
          HStack {
            Button(action: {
              self.viewModel.choice = 1
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[0].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)

            })
              .background(self.viewModel.choice == 1 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 2
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[1].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)

            })
              .background(self.viewModel.choice == 2 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 3
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[2].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)
            })
              .background(self.viewModel.choice == 3 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 4
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[3].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)
            })
              .background(self.viewModel.choice == 4 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)
          }
          HStack {
            Button(action: {
              self.viewModel.choice = 5
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[4].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)

            })
              .background(self.viewModel.choice == 5 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 6
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[5].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)

            })
              .background(self.viewModel.choice == 6 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 7
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[6].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)
            })
              .background(self.viewModel.choice == 7 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 8
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[7].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)
            })
              .background(self.viewModel.choice == 8 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)
          }
          HStack {
            Button(action: {
              self.viewModel.choice = 9
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[8].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)

            })
              .background(self.viewModel.choice == 9 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 10
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[9].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)

            })
              .background(self.viewModel.choice == 10 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 11
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[10].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)
            })
              .background(self.viewModel.choice == 11 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 12
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[11].alphabet ?? "")
                .font(Font.custom("Bangla MN", size: 18))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 30, height: 30, alignment: .center)
            })
              .background(self.viewModel.choice == 12 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
              .padding(5)
          }
          Spacer()
            .frame(height: 20)

          Button(action: {
            if self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.choice {
              let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)

              viewModel.result.append(tuple)
            } else {
              let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
              viewModel.result.append(tuple)
            }

            viewModel.choice = -1
            viewModel.currentWordCount += 1
          }, label: {
            Text(" NEXT ")
              .font(Font.custom("Bangla MN", size: 25))
              .fontWeight(.bold)
              .foregroundColor(viewModel.choice == -1 ? .white : .black)
              .background(RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .bottom)
                .foregroundColor(viewModel.choice == -1 ? Color.gray : Color.green))
          })
            .background(Color.white.opacity(0.8))
            .padding(10)

          Spacer()
            .frame(height: 40)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 100)
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 100)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 100)
  }
}

struct WordSpellingHardTestView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

  @State var answer: String = ""
  
  var body: some View {
    VStack {
      ZStack {
        Image("background")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          HStack {
            ZStack {
              HStack {
                BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("Enter the corresponding word \nin Korean by typing!")
                  .font(Font.custom("Bangla MN", size: 16))
                  .foregroundColor(.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.bottom, 10)

          HStack(alignment: .center) {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)
            Spacer()
              .frame(width: 20)
            VStack {
              ImageView(withURL: self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
                .frame(width: 200, height: 200)

              Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")
                .font(Font.custom("Bangla MN", size: 22))
                .fontWeight(.heavy)
                .foregroundColor(.white)
            }
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 10)

          TextField(answer, text: $answer)
          
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }

  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct WordTestResultView: View {
  var body: some View {
    VStack {
      Text("finish")
    }
  }
}
