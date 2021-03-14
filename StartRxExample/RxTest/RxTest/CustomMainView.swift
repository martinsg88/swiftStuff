//
//  CustomTableView.swift
//  RxTest
//
//  Created by Guilherme Martins on 2021/03/14.
//

import UIKit
import RxSwift
import RxCocoa
import Moya

class CustomMainView: UIViewController {
    
    @IBOutlet weak var refresh: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var provider = MoyaProvider<GitHub>()
    var dataSource = [Users]()
    var responseStream:Observable<[Users]> = Observable.just([])
    
    var disposeBag:DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupBinding()
    }
    
    func setupTable() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 70.0
    }
    
    func setupBinding() {
        let requestStream: Observable<Int> = refresh.rx.tap.startWith(())
            .map{ _ in
                Array(1...1000).random()
            }
        
        responseStream = requestStream.flatMap{ [weak self] since -> Observable<[Users]> in
            guard let _self = self else { return Observable.empty() }
            return UserModel(provider: _self.provider).getUsers(since: since)
        }
    }
}

extension CustomMainView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
    
    func clearCell(cell: CustomCell) {
        cell.cancel.isHidden = true
        cell.avatar.image = nil
        cell.name.text = nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowCell", for: indexPath) as! CustomCell
        cell.cancel.showsTouchWhenHighlighted = true
        cell.avatar.layer.cornerRadius = cell.avatar.frame.size.width / 2
        cell.avatar.clipsToBounds = true

        let closeStream = cell.cancel.rx.tap.startWith(())
        let userStream: Observable<Users?> = Observable.combineLatest(
            closeStream,
            responseStream)
        { (_, users) in
            guard users.count > 0 else {return nil}
            return users.random()
        }
        let nilOnRefreshTapStream: Observable<Users?> = refresh.rx.tap.map {_ in return nil}
        let suggestionStream = Observable.of(userStream, nilOnRefreshTapStream)
            .merge()
            .startWith(.none)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    func setCell(cell: CustomCell, user: Users) {
        clearCell(cell: cell)
        guard let url = NSURL(string: user.avatarUrl) else { return }
        guard let data = NSData(contentsOf: url as URL) else {return}
        cell.cancel.isHidden = false
        cell.avatar.image = UIImage(data: data as Data)
        cell.name.text = user.name
    }
    
    
}


