//
//  CustomCell.swift
//  RxTest
//
//  Created by Guilherme Martins on 2021/03/14.
//

import UIKit
import RxSwift

class CustomCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cancel: UIButton!
    
    var disposeBagCell:DisposeBag = DisposeBag()
    override func prepareForReuse() { disposeBagCell = DisposeBag() }
}
