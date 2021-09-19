//
//  StringProtocol.swift
//  iOSEngineerCodeCheck
//
//  Created by matsui kento on 2021/09/19.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

extension StringProtocol where Self: RangeReplaceableCollection {
    //　文字列中の全ての空白を削除する
    var removeWhitespaces: Self {
        filter { !$0.isWhitespace }
    }
}
