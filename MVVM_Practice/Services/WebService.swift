//
//  WebService.swift
//  MVVM_Practice
//
//  Created by 이상준 on 2022/08/28.
//

import Foundation
import Alamofire

class WebService {
//    func getArticles(url: URL, completion:@escaping([Article]?) -> ()) {
//        URLSession.shared.dataTask(with: url) {(data, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                completion(nil)
//            } else if let data = data {
//                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
//                print(articleList)
//
//                if let articleList = articleList {
//                    completion(articleList.articles)
//                }
//                print(articleList?.articles)
//            }
//        }.resume()
//    }
//
    
    // Alamofire 적용
    func getArticles(url: URL, completion: @escaping([Article]?) ->()) {
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: ArticleList.self) { (response) in
                switch response.result {
                case .success(let response):
                    completion(response.articles)
                    print(response.articles)
                case .failure(let error):
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
    }
}
