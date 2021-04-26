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

  @ObservedObject var viewModel: WordListViewModel

  @State var showPopup: Bool = false
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
        .foregroundColor(.white)
    })
  }

  var body: some View {
    NavigationView {
      ZStack {
        Image("center_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack(alignment: .center) {
          Text("Words List")
            .foregroundColor(.white)
            .font(.title)
            .padding(.vertical, 20)

          HStack {
            NavigationLink(destination: WordLearnView()) {
              LearnButton()
                .frame(width: 200, height: 100, alignment: .center)
            }
            Spacer()
            NavigationLink(destination: WordSelectTestView()) {
              TestButton()
                .frame(width: 200, height: 100, alignment: .center)
            }
          }
          .padding(.horizontal, 20)
          Spacer()
          Text("list here")

          WordGridView(rows: (viewModel.wordlist.count + 1) / 2, columns: 2) { row, col in

            let num = row * 2 + col

            if (viewModel.wordlist.count > num) && (num >= 0) {
              Button(action: {
                self.showPopup = true
              }, label: {
                WordCellView(word: $viewModel.wordlist[num])
              })
                .sheet(isPresented: $showPopup, onDismiss: {
                  print(self.showPopup)
                }) {
                  
                  //PopUpWindow(viewModel: viewModel)
                    //.frame(width: 300, height: 400)
                    //.clearModalBackground()
                }
            }
          }
          
          GeometryReader { geometry in
                      Color.green
                      BottomSheetView(
                          isOpen: self.$showPopup,
                          maxHeight: geometry.size.height * 0.7
                      ) {
                          Color.blue
                      }
                  }.edgesIgnoringSafeArea(.all)
        }
      }
    }
    .navigationBarTitle("")
    .ignoresSafeArea()
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: self.backButton)
  }
}

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}

struct LearnButton: View {
  var body: some View {
    Text("Learn")
      // .overlay(RoundedRectangle(cornerRadius: 25).frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/))
      .foregroundColor(.white)
      .font(.title)
  }
}

struct TestButton: View {
  var body: some View {
    Text("Test")
      // .overlay(RoundedRectangle(cornerRadius: 25).frame(width: UIScreen.main.bounds.width - 100, height: 150, alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/).foregroundColor(/*@START_MENU_TOKEN@*/ .blue/*@END_MENU_TOKEN@*/))
      .foregroundColor(.white)
      .font(.title)
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

      // WordBox()

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
      ZStack {
        Image("right_bg")
          .resizable()
          .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
          .ignoresSafeArea()

        VStack {
          Text("단어장 이름")
            .foregroundColor(.white)
            .padding(.vertical, 20)

          Text("시험 볼 단어")
            .foregroundColor(.white)

          Rectangle()
            .frame(width: 250, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
            .foregroundColor(.orange)
            .padding(.horizontal, 20)

          Text("test type select")
            .foregroundColor(.white)

          NavigationView {
            List {}
          }

          ZStack {
            Rectangle()
              .frame(width: 250, height: 50, alignment: .center)
              .foregroundColor(.blue)
              .padding(.horizontal, 20)
            Text("1")
          }
          Rectangle()
            .frame(width: 250, height: 50, alignment: .center)
            .foregroundColor(.blue)
            .padding(.horizontal, 20)
          Rectangle()
            .frame(width: 250, height: 50, alignment: .center)
            .foregroundColor(.blue)
            .padding(.horizontal, 20)
          Rectangle()
            .frame(width: 250, height: 50, alignment: .center)
            .foregroundColor(.blue)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
          // four button
        }
        .background(Color.gray.opacity(0.5))
      }
    }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    .navigationBarItems(leading: self.backButton)
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

struct BottomSheetView<Content: View>: View {
  var body: some View {
      GeometryReader { geometry in
          VStack(spacing: 0) {
              //self.indicator.padding()
              self.content
          }
          .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(25)
          .frame(height: geometry.size.height, alignment: .bottom)
          //.offset(y: self.offset)
      }
  }
  
    @Binding var isOpen: Bool

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = 200
        self.maxHeight = 400
        self.content = content()
        self._isOpen = isOpen
    }
}

struct PopUpWindow: View {
  @ObservedObject var viewModel: WordListViewModel
  @Environment(\.presentationMode) var presentation

  var body: some View {
    ZStack {
      if viewModel.didSelectWord {
        // PopUp background color
        Color.black.opacity(viewModel.didSelectWord ? 0.3 : 0).edgesIgnoringSafeArea(.all)

        // PopUp Window
        VStack(alignment: .center, spacing: 0) {
          Text(viewModel.selectedWord?.word ?? "")
            .frame(maxWidth: .infinity)
            .frame(height: 45, alignment: .center)
            .font(Font.system(size: 23, weight: .semibold))
            .foregroundColor(Color.black)
            .background(Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)))

          Text(viewModel.selectedWord?.meaning ?? "")
            .multilineTextAlignment(.center)
            .font(Font.system(size: 16, weight: .semibold))
            .padding(EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25))
            .foregroundColor(Color.blue)

          Button(action: {
            // Dismiss the PopUp
            withAnimation(.linear(duration: 0.3)) {
              viewModel.didSelectWord = false
            }
          }, label: {
            Text("xxxxxx")
              .frame(maxWidth: .infinity)
              .frame(height: 54, alignment: .center)
              .foregroundColor(Color.black)
              .background(Color(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)))
              .font(Font.system(size: 23, weight: .semibold))
          }).buttonStyle(PlainButtonStyle())

          Button("Dismiss") {
           // self.presentation.
          }
        }
        .frame(height: 300)
        .border(Color.white, width: 2)
        .background(Color(#colorLiteral(red: 0.737254902, green: 0.1294117647, blue: 0.2941176471, alpha: 1)))
      }
    }
  }
}

struct AddedWordButton: View {
  var body: some View {
    ZStack {
      // Image("mae")
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
