//
//  Article.swift
//  MVVM_Practice
//
//  Created by 이상준 on 2022/08/28.
//

import Foundation

struct ArticleList: Decodable {
    
    let articles: [Article]
    
}

struct Article: Decodable{
    let title: String?
    let description: String?
}
