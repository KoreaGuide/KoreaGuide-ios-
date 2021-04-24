//
//  wordAddView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/14.
//

import Foundation
import SwiftUI

struct WordInfo{
  let word: String //kor
  let meaning: String //eng
  let wordId: Int
}

struct WordAddView: View {
  var totalWordCount: Int //1~
  var currentWord: Int //1~
  @State var progressValue: Float = 0.5
  var wordlist: [WordInfo]
  
  
  var body: some View {
    
    VStack{
      HStack{
        //back button
        Button(action: {
          //back to place detail page
        }, label: {
          Text("Back")
        })
        //place title
        
        Label("place title", systemImage: "book.fill") // icon change
      }
      
      //label
      Text("3/3")
      //progress bar
      ProgressBar(value: $progressValue)
      
      //label
      Text("Swipe up to add")
      
      HStack{
        //left
        Button(action: {
          
        }, label: {
          Text("<")
        })
        
        
        //box
        WordBox()
        
        //right
        Button(action: {
          
        }, label: {
          Text(">")
        })
      }
      
    }
  }
}

struct ProgressBar: View {
  @Binding var value: Float
  
  var body: some View {
      GeometryReader { geometry in
          ZStack(alignment: .leading) {
              Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                  .opacity(0.3)
                  .foregroundColor(Color(UIColor.systemTeal))
              
              Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                  .foregroundColor(Color(UIColor.systemBlue))
                  .animation(.linear)
          }.cornerRadius(45.0)
      }
  }
}

struct WordBox: View {
  var body: some View {
    ZStack{
      RoundedRectangle(cornerRadius: 25)
          .fill(Color.green)
          .frame(width: 150, height: 300)
      
      VStack{
        //Image()
        
        Text("word")
        Text("pronun")
        
        Text("meaning")
        
        Button(action: {
          //back to place detail page
        }, label: {
          Text("play")
        })
        
        
      }
      
    }
    
  }
}

struct WordAddFinishView: View{
  var body: some View {
    Text("place title")
    
    Rectangle() // 총 단어 개수, 담은 개수, 어쩌고
    
    //button 장소페이지로 돌아가기
    //button 단어장으로 가기
  }
}
