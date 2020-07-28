//
//  SearchViewController.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/10/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD
import SwiftMessages

class SearchViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    // MARK: - Variable
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()
    var result: Result?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponent()
        // Do any additional setup after loading the view.
    }

    // MARK: - Helper
    private func initComponent() {
        self.setupView()
        self.handlerAction()
        self.setupBinding()
    }
    
    private func setupView() {
        self.searchTextField.placeholder = "Tên phim, diễn viên, đạo diễn ..."
        self.searchTextField.attributedPlaceholder = NSAttributedString.init(string: searchTextField.placeholder ?? "", attributes:  [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCollectionViewCell")
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupBinding() {
        viewModel.loading.observeOn(MainScheduler.instance).subscribe(onNext: { (loading) in
            if loading {
                SVProgressHUD.show()
            } else {
                SVProgressHUD.dismiss(withDelay: 2)
            }
        }).disposed(by: disposeBag)
        
        viewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { (errorMessage) in
            SwiftMessageManager.shared.showMessage(messageType: .error, message: errorMessage)
        }).disposed(by: disposeBag)
        
        viewModel.results.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (result) in
            guard let self = self else { return }
            self.result = result
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Action
    private func handlerAction() {
        self.searchTextField.rx.text.debounce(.milliseconds(100), scheduler: MainScheduler.instance).distinctUntilChanged().subscribe(onNext: { [weak self] (result) in
            guard let self = self else { return }
            if result != "" && result != nil {
                self.viewModel.searchMovie(query: result!)
            }
        }).disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let result = self.result , let movies = result.results {
            return movies.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        if let result = self.result, let movies = result.results {
            cell.configCell(movie: movies[indexPath.item])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailViewController.init(nibName: "DetailViewController", bundle: nil)
        detailController.modalPresentationStyle = .overFullScreen
        if let result = self.result ,let movies = result.results {
            detailController.movie = movies[indexPath.item]
            self.present(detailController, animated: true, completion: nil)
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = ( self.collectionView.frame.width - 30) / 3
        return CGSize(width: widthCell, height: widthCell * 3/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
