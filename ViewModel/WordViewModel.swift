//
//  WordViewModel.swift
//  KoreaGuide
//
//  Created by 임선호 on 2021/04/05.
//

import Foundation
import IGListKit

final class WordList : ListDiffable {
    
    
    
    func diffIdentifier() -> NSObjectProtocol {
        <#code#>
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        <#code#>
    }
    
    
}

class Vocab : ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        <#code#>
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        <#code#>
    }
    
    let vocabTitle: String
    let vocabTotalCount: Int
    let vocabCompleteCount: Int
    
    init(){
        self.vocabTitle = ""
        self.vocabTotalCount = 0
        self.vocabCompleteCount = 0
    }
    
}
