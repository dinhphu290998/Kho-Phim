//
//  SearchViewModel.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel: BaseViewModel {
    
    public let success: PublishSubject<Bool> = PublishSubject()
    public let error: PublishSubject<String> = PublishSubject()
    public let results: PublishSubject<Result> = PublishSubject()
    
    public func searchMovie(query: String) {
        provider.requestAPI(api: SearchMovie + query, parameter: nil, headers: nil, method: .get, encoding: .prettyPrinted) { [weak self] (success, message, data) -> (Void) in
            guard let self = self else { return }
            self.loading.onNext(!success)
            if success, let data = data {
                guard let jsonData = try? JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted) else {return}
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(Result.self, from: jsonData)
                    self.results.onNext(results)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let message = message {
                    self.errorMsg.onNext(message)
                    self.error.onNext("Lỗi kết nối")
                }
            }
        }
    }
}
