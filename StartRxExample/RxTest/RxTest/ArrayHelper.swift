//
//  ArrayHelper.swift
//  RxTest
//
//  Created by Guilherme Martins on 2021/03/14.
//

import UIKit

extension Array {
    func random() -> Iterator.Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}
