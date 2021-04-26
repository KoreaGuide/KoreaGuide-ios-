//
//  TodayWordView.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/26.
//

import Foundation
import SwiftUI


struct TodayWordView: View {
  var body: some View{
    ZStack{
      Image("background")
        .resizable()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .ignoresSafeArea()

      VStack{
        Text("Word of Today")
        
        Image("")
        
        HStack{
          Text("")
          Spacer()
        }
        HStack{
          Text("")
          Spacer()
        }
        
        //add button
        //close button
        
        Text("Related Places")
        //List
      }
    }
  }
}
