//
//  BaseViewModel.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {

    lazy var provider: Provider = {
        return Provider()
    }()
    let disposeBag = DisposeBag()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let errorMsg:  PublishSubject<String> = PublishSubject()
    
}
