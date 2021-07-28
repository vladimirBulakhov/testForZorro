//
//  ViewController.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 27.07.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BeerListViewController: UIViewController {
    
    var viewModel: BeerListViewModelDelegate!
    private let disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setBindings()
        viewModel.getBeerList()
    }
    
    private func setBindings() {
        tableView.refreshControl?.rx.controlEvent(.valueChanged).subscribe(onNext: { _ in
            self.viewModel.refreshList().subscribe {
                self.tableView.refreshControl?.endRefreshing()
            } onError: { (error) in
                self.presentAlert(withMessage: error.localizedDescription)
                self.tableView.refreshControl?.endRefreshing()
            }.disposed(by: self.disposeBag)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        viewModel.beerArray.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "Cell", cellType: BeerTableViewCell.self)) { index, element, cell in
            cell.configure(beer: element)
            self.viewModel.updateListIfNeeded(index: index)
        }.disposed(by: disposeBag)
        
        viewModel.errorSubject.subscribe(onNext: { error in
            self.presentAlert(withMessage: error)
        }).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Beer.self).subscribe(onNext: { beer in
            self.pushToDetailVC(beer: beer)
        }).disposed(by: disposeBag)
            
    }
    
    private func presentAlert(withMessage message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func pushToDetailVC(beer: Beer) {
        let vc = ViewControllerBuilder.createDetailBeerViewController(beer: beer)
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension BeerListViewController {
    private func setViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
}

