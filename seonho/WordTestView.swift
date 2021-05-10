//
//  WordTestView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/27.
//

import Foundation
import SwiftUI

struct WordTestView: View {
  @ObservedObject var viewModel: WordTestViewModel
  @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
  
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
    ZStack{
      Image("background")
        .resizable()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .ignoresSafeArea()
      
      VStack {
        HStack {
          BackButton(tapAction: { self.presentationMode.wrappedValue.dismiss() })
        }
        
        
        Text(self.viewModel.quiz_type)
          .font(Font.custom("Bangla MN", size: 18))
        
        Text(String(self.viewModel.currentWordCount) + " / " + String(self.viewModel.totalWordCount))
          .foregroundColor(.white)
          .font(Font.custom("Bangla MN", size: 18))

        // ProgressBar
        progressBar
          .frame(width: UIScreen.main.bounds.width - 100, height: 20, alignment: .center)

        // test box...
        Text("Match the meaning of the word!")
          .font(Font.custom("Bangla MN", size: 18))
          .foregroundColor(.white)
        
        MatchQuizView(viewModel: self.viewModel)
      }
    }
  }
  
  // 한국어 단어, 사진 -> 영어 단어 or 영어 설명

  
}


struct MatchQuizView: View {
  @ObservedObject var viewModel: WordTestViewModel
  var body: some View {
    
    ZStack{
      //background
      
      VStack{
        //Text(self.viewModel.quiz_type)
        //  .font(Font.custom("Bangla MN", size: 18))
        
        Image(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.image ?? "")
        
        Text(self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].selected_word.word_kor ?? "")
          .font(Font.custom("Bangla MN", size: 20))
        
        
        Button(action: {
          self.viewModel.choice = 1
        }, label: {
          Text("1. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[0].word_eng ?? "") )
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
        .background(self.viewModel.choice == 1 ? Color.gray.opacity(0.5) :  Color.white.opacity(0.8))
        .padding(10)
        
        
        Button(action: {
          self.viewModel.choice = 2
        }, label: {
          Text("2. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[1].word_eng ?? "") )
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
        .background(self.viewModel.choice == 2 ? Color.gray.opacity(0.5) :  Color.white.opacity(0.8))
        .padding(10)
        
        Button(action: {
          self.viewModel.choice = 3
        }, label: {
          Text("3. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[2].word_eng ?? ""))
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
        .background(self.viewModel.choice == 3 ? Color.gray.opacity(0.5) :  Color.white.opacity(0.8))
        .padding(10)
        
        
        Button(action: {
          self.viewModel.choice = 4
        }, label: {
          Text("4. " + (self.viewModel.test_word_info?.quiz_list[viewModel.currentWordCount].word_choice_list[3].word_eng ?? "") )
            .font(Font.custom("Bangla MN", size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
            .multilineTextAlignment(TextAlignment.center)
        })
        .background(self.viewModel.choice == 4 ? Color.gray.opacity(0.5) :  Color.white.opacity(0.8))
        .padding(10)
        
        
        Button(action: {
          if self.viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id == self.viewModel.choice {
            let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, true)
            
            viewModel.result.append(tuple)
          }
          else{
            let tuple = (viewModel.currentWordCount, viewModel.test_word_info!.quiz_list[viewModel.currentWordCount].selected_word.id, false)
            viewModel.result.append(tuple)
          }
          
          viewModel.choice = -1
          viewModel.currentWordCount += 1
        }, label: {
          Text(" NEXT ")
            .font(Font.custom("Bangla MN", size: 25))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 20)
                          .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .bottom)
                          .foregroundColor(viewModel.choice == -1 ? Color.gray : Color.green))
        })
        .background(Color.white.opacity(0.8))
        .padding(10)
        
        
      }
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
