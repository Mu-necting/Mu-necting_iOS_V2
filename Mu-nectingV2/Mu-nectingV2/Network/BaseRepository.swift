//
//  BaseRepository.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 7/29/24.
//

import Foundation
import Moya

typealias DictionaryType = [String: Any]

class BaseRepository<API: TargetType> {
    var provider = MoyaProvider<API>()
//    lazy var rx = provider.rx
//    let disposeBag = DisposeBag()
}
