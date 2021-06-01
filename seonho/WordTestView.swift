//
//  WordTestView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import AVKit
import Foundation
import SwiftUI

struct FinishButton: View {
  var tapAction: () -> Void = {}
  var body: some View {
    Button(action: {
      tapAction()
    }, label: {
      VStack(alignment: .center) {
        Text("Finish and Save")
          .font(.system(size: 18, weight: .heavy))
          //.font(Font.custom("Bangla MN", size: 18))
          //.fontWeight(.bold)
          .foregroundColor(Color.orange)
        Image(systemName: "cursor.rays")
          .resizable()
          .foregroundColor(Color.orange)
          .frame(width: 30, height: 30, alignment: .center)
      }
    })
  }
}

struct CorrectOrNotPopup: View {
  // @Binding var popupWordId: Int
  @ObservedObject var viewModel: WordTestSceneViewModel

  @State var isCorrect: Bool

  var body: some View {
    ZStack {
      if viewModel.showPopup == true {
        Color.black.opacity(viewModel.showPopup == true ? 0.3 : 0)
          .edgesIgnoringSafeArea(.all)

        VStack(alignment: .center) {
          VStack {
            Image(systemName: isCorrect == true ? "checkmark.square" : "xmark.square")
              .resizable()
              .foregroundColor(isCorrect ? Color("Green") : Color("Pink"))
              .frame(width: 40, height: 40)

            Text(isCorrect == true ? "Correct!" : "Don't give up!")
              .font(.system(size: 20, weight: .heavy))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.heavy)
          }

          HStack {
            Button(action: {
              viewModel.currentWordCount += 1
              
              viewModel.showPopup = false

              viewModel.choice = -1
              viewModel.answer = ""
              viewModel.chosen_answer = []

              if isCorrect == true {
                viewModel.correctCount += 1
              } else {
                viewModel.incorrectCount += 1
              }
            }, label: {
              Text("Keep going!")
                .font(.system(size: 16, weight: .regular))
                //.font(Font.custom("Bangla MN", size: 16))
                .foregroundColor(.black)
            })
          }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .frame(width: 200, height: 200, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 27).fill(Color.white.opacity(1)))
      }
    }
    .ignoresSafeArea()
    .onTapGesture {
      viewModel.currentWordCount += 1
      
      viewModel.showPopup = false

      
      
      viewModel.choice = -1
      viewModel.answer = ""
      viewModel.chosen_answer = []

      
      if isCorrect == true {
        viewModel.correctCount += 1
      } else {
        viewModel.incorrectCount += 1
      }
    }
  }
}

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
        .font(.system(size: 20, weight: .regular))
        //.font(Font.custom("Bangla MN", size: 20))
        //.padding(.top, 10)

//      Text(String(self.viewModel.currentWordCount) + " / " + String(self.viewModel.totalWordCount))
//        .foregroundColor(.white)
//        .font(Font.custom("Bangla MN", size: 18))
    }
  }
}

struct MatchAnswerKorView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  var body: some View {
    ZStack {
      if viewModel.currentWordCount < viewModel.totalWordCount {
        VStack {
          Button(action: {
            self.viewModel.choice = 1
          }, label: {
            Text("1. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[0].word_kor ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 1 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Button(action: {
            self.viewModel.choice = 2
          }, label: {
            Text("2. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[1].word_kor ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 2 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Button(action: {
            self.viewModel.choice = 3
          }, label: {
            Text("3. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[2].word_kor ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 3 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Button(action: {
            self.viewModel.choice = 4
          }, label: {
            Text("4. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[3].word_kor ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 4 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Spacer()
            .frame(height: 20)

          Button(action: {
            if self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].word_choice_list[viewModel.choice - 1].id {
              let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)

              viewModel.result.append(tuple)
            } else {
              let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
              viewModel.result.append(tuple)
            }

            // viewModel.choice = -1
            // viewModel.currentWordCount += 1
            viewModel.showPopup = true

          }, label: {
            Text(" Submit ")
              .font(.system(size: 25, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 25))
              //.fontWeight(.bold)
              .foregroundColor(viewModel.choice == -1 ? .white : .white)
              //.padding(.top, 10)
              .background(RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 100, height: 50, alignment: .center)
                .foregroundColor(viewModel.choice == -1 ? Color.gray : Color("Green")))

          })
            .disabled(viewModel.choice == -1)
            .padding(10)

          Spacer()
            .frame(height: 40)
        }
      }
    }
  }
}

struct WordTestResultView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel

  var body: some View {
    VStack {
      HStack {
        VStack {
          Text("Correct")
            //.font(Font.custom("Bangla MN", size: 20))
            .font(.system(size: 20, weight: .bold))
          Text(String(viewModel.correctCount))
            //.font(Font.custom("Bangla MN", size: 30))
            .font(.system(size: 30, weight: .bold))
        }
        .frame(width: 150, height: 240)
        .background(RoundedRectangle(cornerRadius: 27).fill(Color.white.opacity(1)))

        Spacer()
          .frame(width: 40)

        VStack {
          Text("Incorrect")
            //.font(Font.custom("Bangla MN", size: 20))
            .font(.system(size: 20, weight: .bold))
          Text(String(viewModel.incorrectCount))
            //.font(Font.custom("Bangla MN", size: 30))
            .font(.system(size: 30, weight: .bold))
        }
        .frame(width: 150, height: 240)
        .background(RoundedRectangle(cornerRadius: 27).fill(Color.white.opacity(1)))
      }

      Spacer()
        .frame(height: 60)
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
                if viewModel.endOfTest == false || viewModel.currentWordCount < viewModel.totalWordCount {
                  BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                } else {
                  Spacer()
                    .frame(height: 30)
                }

                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("     Match the meaning of the word!")
                  .font(.system(size: 18, weight: .regular))
                  //.font(Font.custom("Bangla MN", size: 18))
                  .foregroundColor(.white)
                  //.padding(.top, 5)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.bottom, 10)

          Spacer()
            .frame(height: 50)

          HStack(alignment: .center) {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)

            Spacer()
            //  if (viewModel.currentWordCount < viewModel.totalWordCount)
            if viewModel.currentWordCount < viewModel.totalWordCount {
              VStack {
                Spacer()
                Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_eng ?? "")
                  .font(.system(size: 30, weight: .heavy))
                  //.font(Font.custom("Bangla MN", size: 30))
                  //.fontWeight(.heavy)
                  .foregroundColor(.white)
                  .padding(.vertical, 10)
                Rectangle()
                  .foregroundColor(.white)
                  .frame(width: 160, height: 2)
              }
              .frame(height: 100)
            } else {
              VStack {
                Spacer()
                Text("Finish!")
                  .font(.system(size: 30, weight: .heavy))
                  //.font(Font.custom("Bangla MN", size: 30))
                  //.fontWeight(.heavy)
                  .foregroundColor(.white)
                  .padding(.vertical, 10)
              }
              .frame(height: 100)
            }
          }
          .padding(.horizontal, 40)

          Spacer()
            .frame(height: 50)
          if viewModel.currentWordCount < viewModel.totalWordCount {
            MatchAnswerKorView(viewModel: self.viewModel)
          } else if viewModel.endOfTest == true {
            WordTestResultView(viewModel: viewModel)
            FinishButton(tapAction: { self.presentationMode.wrappedValue.dismiss()
              viewModel.postTestResult()
            })
            Spacer()
              .frame(height: 50)
          }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        if viewModel.showPopup == true {
          CorrectOrNotPopup(viewModel: viewModel, isCorrect: self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].word_choice_list[viewModel.choice - 1].id)
            .padding(.top, -50)
            .ignoresSafeArea()
        }
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
  }
  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct MatchAnswerEngView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel
  var body: some View {
    ZStack {
      if viewModel.currentWordCount < viewModel.totalWordCount {
        VStack {
          Button(action: {
            self.viewModel.choice = 1
          }, label: {
            Text("1. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[0].word_eng ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 1 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Button(action: {
            self.viewModel.choice = 2
          }, label: {
            Text("2. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[1].word_eng ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 2 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Button(action: {
            self.viewModel.choice = 3
          }, label: {
            Text("3. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[2].word_eng ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 3 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Button(action: {
            self.viewModel.choice = 4
          }, label: {
            Text("4. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[3].word_eng ?? ""))
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.black)
              .frame(width: UIScreen.main.bounds.width - 40, height: 50, alignment: .center)
              .multilineTextAlignment(TextAlignment.center)
              //.padding(.top, 5)
          })
            .background(RoundedRectangle(cornerRadius: 10)
              .foregroundColor(self.viewModel.choice == 4 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8)))
            .padding(5)

          Spacer()
            .frame(height: 20)

          Button(action: {
            if self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].word_choice_list[viewModel.choice - 1].id {
              let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)

              viewModel.result.append(tuple)
            } else {
              let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
              viewModel.result.append(tuple)
            }

            // viewModel.choice = -1
            // viewModel.currentWordCount += 1
            viewModel.showPopup = true

          }, label: {
            Text(" Submit ")
              .font(.system(size: 25, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 25))
              //.fontWeight(.bold)
              .foregroundColor(viewModel.choice == -1 ? .white : .white)
              //.padding(.top, 10)
              .background(RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 100, height: 50, alignment: .center)
                .foregroundColor(viewModel.choice == -1 ? Color.gray : Color("Green")))

          })
            .disabled(viewModel.choice == -1)
            .padding(10)

          Spacer()
            .frame(height: 40)
        }
      }
    }
  }
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
          Spacer()
            .frame(height: 20)

          HStack {
            ZStack {
              HStack {
                if viewModel.endOfTest == false || viewModel.currentWordCount < viewModel.totalWordCount {
                  BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                } else {
                  Spacer()
                    .frame(height: 30)
                }
                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("Listen to the pronunciation \nand match the word!")
                  .font(.system(size: 18, weight: .regular))
                  //.font(Font.custom("Bangla MN", size: 18))
                  .foregroundColor(.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.vertical, 10)

          Spacer()
            .frame(height: 50)
          HStack {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)
            Spacer()

            if viewModel.currentWordCount < viewModel.totalWordCount {
              VStack(alignment: .center) {
                Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")
                  .font(.system(size: 22, weight: .heavy))
                  //.font(Font.custom("Bangla MN", size: 22))
                  //.fontWeight(.heavy)
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
                  .padding(.horizontal, 40)
              }
            } else {
              Text("Finish!")
                .font(.system(size: 22, weight: .heavy))
                //.font(Font.custom("Bangla MN", size: 22))
                //.fontWeight(.heavy)
                .foregroundColor(.white)
            }
          }
          .padding(.horizontal, 40)
          .padding(.bottom, 10)
          Spacer()
            .frame(height: 50)
          if viewModel.currentWordCount < viewModel.totalWordCount {
            MatchAnswerEngView(viewModel: self.viewModel)
          } else if viewModel.endOfTest == true {
            WordTestResultView(viewModel: viewModel)
            FinishButton(tapAction: { self.presentationMode.wrappedValue.dismiss()
              viewModel.postTestResult()
            })
            Spacer()
              .frame(height: 50)
          }

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        if viewModel.showPopup == true {
          CorrectOrNotPopup(viewModel: viewModel, isCorrect: self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].word_choice_list[viewModel.choice - 1].id)
            .padding(.top, -50)
            .ignoresSafeArea()
        }
      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }

  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct WordSpellingEasyTestView: View {
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
                if viewModel.endOfTest == false || viewModel.currentWordCount < viewModel.totalWordCount {
                  BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                } else {
                  Spacer()
                    .frame(height: 30)
                }
                Spacer()
              }

              HStack(alignment: .bottom) {
                Spacer()
                Text("Complete the spelling of \nwords letter by letter!")
                  .font(.system(size: 18, weight: .regular))
                  //.font(Font.custom("Bangla MN", size: 18))
                  .foregroundColor(.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
            }
          }
          .padding(.horizontal, 20)
          .padding(.bottom, 20)
          if viewModel.endOfTest == false || viewModel.currentWordCount < viewModel.totalWordCount {
            HStack {
              ImageView(withURL: self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
                .frame(width: 150, height: 150)

              VStack(alignment: .center) {
                Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_eng ?? "")
                  .font(.system(size: 20, weight: .bold))
                  //.font(Font.custom("Bangla MN", size: 20))
                  //.fontWeight(.bold)
                  .foregroundColor(.white)

                Text(self.viewModel.chosen_answer.compactMap { $0 }.joined())
                  .font(.system(size: 20, weight: .bold))
                  //.font(Font.custom("Bangla MN", size: 20))
                  //.fontWeight(.bold)
                  .foregroundColor(.white)
                  //.padding(.top, 10)
                  .background(RoundedRectangle(cornerRadius: 10)
                    .frame(width: 160, height: 50)
                    .foregroundColor(Color.white.opacity(0.5)))
                  .frame(width: 160, height: 50)
                  .onTapGesture{
                    self.viewModel.chosen_answer = self.viewModel.chosen_answer.dropLast()
                    viewModel.choice = -1
                  }
              }
              .padding(.leading, 20)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
          } else {
            Text("Finish!")
              .font(.system(size: 20, weight: .bold))
              //.font(Font.custom("Bangla MN", size: 20))
              //.fontWeight(.bold)
              .foregroundColor(.white)
          }
          if viewModel.endOfTest == false || viewModel.currentWordCount < viewModel.totalWordCount {
            EasySpellingAnswerView(viewModel: self.viewModel, word_kor_answer: self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")

          } else if viewModel.endOfTest == true {
            WordTestResultView(viewModel: viewModel)
            FinishButton(tapAction: { self.presentationMode.wrappedValue.dismiss()
              viewModel.postTestResult()
            })
            Spacer()
              .frame(height: 50)
          }

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        
        if viewModel.showPopup == true {
          CorrectOrNotPopup(viewModel: viewModel, isCorrect: self.viewModel.test_easy_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.word_kor == self.viewModel.chosen_answer.compactMap { $0 }.joined())
            .padding(.top, -50)
            .ignoresSafeArea()
        }

      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }

  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명
}

struct EasySpellingAnswerView: View {
  @ObservedObject var viewModel: WordTestSceneViewModel

  @State var word_kor_answer: String

  let fontSize: CGFloat = 22

  var body: some View {
    VStack {
      ZStack {
        // background
        VStack {
          HStack {
            Button(action: {
              self.viewModel.choice = 1
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[0] ?? "")
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[0] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 1 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 2
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[1] ?? "")
            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[1] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 2 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 3
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[2] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[2] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 3 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 4
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[3] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[3] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 4 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)
          }
          HStack {
            Button(action: {
              self.viewModel.choice = 5
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[4] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[4] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 5 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 6
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[5] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[5] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 6 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 7
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[6] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[6] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 7 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 8
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[7] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[7] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 8 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)
          }
          HStack {
            Button(action: {
              self.viewModel.choice = 9
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[8] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[8] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 9 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 10
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[9] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[9] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 10 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 11
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[10] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[10] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 11 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)

            Button(action: {
              self.viewModel.choice = 12
              self.viewModel.chosen_answer.append(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[11] ?? "")

            }, label: {
              Text(self.viewModel.test_easy_spelling_word_info?.quiz_list[viewModel.currentWordCount].alphabet_choice_list[11] ?? "")
                .font(.system(size: fontSize, weight: .bold))
                //.font(Font.custom("Bangla MN", size: fontSize))
                //.fontWeight(.bold)
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                //.padding(.top, 10)
            })
              .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(self.viewModel.choice == 12 ? Color.gray.opacity(0.5) : Color.white.opacity(0.8))
                .frame(width: 50, height: 50))
              .padding(5)
          }
          Spacer()
            .frame(height: 20)

          Button(action: {
            if self.viewModel.test_easy_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.word_kor == self.viewModel.chosen_answer.compactMap({ $0 }).joined() {
              let tuple = (viewModel.currentWordCount, viewModel.test_easy_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)

              viewModel.result.append(tuple)
            } else {
              let tuple = (viewModel.currentWordCount, viewModel.test_easy_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
              viewModel.result.append(tuple)
            }

            
            viewModel.showPopup = true

          }, label: {
            Text(" Submit ")
              .font(Font.custom("Bangla MN", size: 25))
              .fontWeight(.bold)
              .padding(.top, 10)
              .foregroundColor(viewModel.choice == -1 ? .white : .white)
              .background(RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .bottom)
                .foregroundColor(viewModel.choice == -1 ? Color.gray : Color("Green")))
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

  // @State var audioPlayer: AVAudioPlayer!
  // @State var playing: Bool = false

  // @State var answer: String = ""

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
                if viewModel.endOfTest == false || viewModel.currentWordCount < viewModel.totalWordCount {
                  BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
                } else {
                  Spacer()
                    .frame(height: 30)
                }
                Spacer()
              }
              .padding(.horizontal, 20)
              HStack(alignment: .bottom) {
                Spacer()
                Text("Enter the corresponding word \nin Korean by typing!")
                  .font(.system(size: 18, weight: .regular))
                  //.font(Font.custom("Bangla MN", size: 18))
                  .foregroundColor(.white)
                  .multilineTextAlignment(.center)
                Spacer()
              }
              .padding(.horizontal, 20)
            }
          }
          .padding(.bottom, 10)

          Spacer()
            .frame(height: 60)

          HStack(alignment: .center) {
            // ProgressBar
            CircularProgressBar(progress: $viewModel.progressValue)
              .frame(width: 80, height: 80)
            Spacer()
              .frame(width: 60)

            if viewModel.currentWordCount < viewModel.totalWordCount {
              VStack {
                ImageView(withURL: self.viewModel.test_hard_spelling_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
                  .frame(width: 150, height: 150)

                Text(self.viewModel.test_hard_spelling_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_eng ?? "")
                  .font(.system(size: 22, weight: .heavy))
                  //.font(Font.custom("Bangla MN", size: 22))
                  //.fontWeight(.heavy)
                  .foregroundColor(.white)
              }
            } else {
              VStack {
                Spacer()
                Text("Finish!")
                  .font(.system(size: 30, weight: .heavy))
                  //.font(Font.custom("Bangla MN", size: 30))
                  //.fontWeight(.heavy)
                  .foregroundColor(.white)
                  .padding(.vertical, 10)
              }
              .frame(height: 100)
            }
          }
          .padding(.horizontal, 10)
          .padding(.bottom, 10)

          if viewModel.currentWordCount < viewModel.totalWordCount {
            TextField("Enter your answer", text: $viewModel.answer)
              .textFieldStyle(RoundedBorderTextFieldStyle())
              .frame(width: 200)
              .padding(.vertical, 20)

            Button(action: {
              print("Input : \(viewModel.answer)")
              hideKeyboard()

              if self.viewModel.test_hard_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.word_kor == viewModel.answer {
                let tuple = (viewModel.currentWordCount, viewModel.test_hard_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)

                viewModel.result.append(tuple)
              } else {
                let tuple = (viewModel.currentWordCount, viewModel.test_hard_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
                viewModel.result.append(tuple)
              }

              // viewModel.currentWordCount += 1
              viewModel.showPopup = true
            }, label: {
              Text(" Submit ")
                .font(.system(size: 25, weight: .bold))
                //.font(Font.custom("Bangla MN", size: 25))
                //.fontWeight(.bold)
                //.padding(.top, 10)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 20)
                  .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .bottom)
                  .foregroundColor(viewModel.answer == "" ? Color.gray : Color("Green")))
            })
              .disabled(viewModel.answer == "")
              .background(Color.white.opacity(0.8))
              .padding(10)

            Spacer()
              .frame(height: 120)
          } else if viewModel.endOfTest == true {
            WordTestResultView(viewModel: viewModel)
            FinishButton(tapAction: { self.presentationMode.wrappedValue.dismiss()
              viewModel.postTestResult()
            })
            Spacer()
              .frame(height: 50)
          }

        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        if viewModel.showPopup == true {
          CorrectOrNotPopup(viewModel: viewModel, isCorrect: self.viewModel.test_hard_spelling_word_info!.quiz_list[viewModel.currentWordCount].selected_word.word_kor == viewModel.answer)
            .padding(.top, -50)
            .ignoresSafeArea()
        }

      }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
}

#if canImport(UIKit)
  extension View {
    func hideKeyboard() {
      UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
  }
#endif

struct WordCorrectOrNotView: View {
  var body: some View {
    VStack {
      Text("finish")
    }
  }
}
