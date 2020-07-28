//
//  DetailViewController.swift
//  MVVM Basic
//
//  Created by NDPhu on 7/14/20.
//  Copyright © 2020 IOS_Team. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import SVProgressHUD

class DetailViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var voteEverageLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var saveMovieButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    
    // MARK: - Variable
    var movie: Movie?
    var referenceMovies = [Movie]()
    var casts = [Cast]()
    var crew = [Crew]()
    let disposeBag = DisposeBag()
    let viewModel = SearchViewModel()
    let actorViewModel = ActorViewModel()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponent()
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCollectionViewCell")
        self.actorCollectionView.register(UINib(nibName: "ActorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "actorCollectionViewCell")
        self.teamCollectionView.register(UINib(nibName: "ActorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "actorCollectionViewCell")
    }
    
    // MARK: - Helper
    private func initComponent() {
        self.handlerAction()
        self.setupBinding()
        if let movie = self.movie {
            self.setupView(movie: movie)
            self.bindingReferenMovie(movie: movie)
        }
    }

    func bindingReferenMovie(movie: Movie) {
        if let title = movie.title {
            let components = title.components(separatedBy: .whitespacesAndNewlines)
            let words = components.filter { !$0.isEmpty }
            for word in words {
                self.viewModel.searchMovie(query: word)
            }
        }
    }
    
    private func setupView(movie: Movie) {
        if let idMovie = movie.id {
            self.actorViewModel.actorInMovie(idMovie: idMovie)
        }
        if let backropPath = movie.backdrop_path {
            let url = URL.init(string: GetImage + backropPath)
            self.backropImageView.kf.setImage(with: url)
        }
        if let title = movie.title {
            self.titleLabel.text = title
        }
        if let adult = movie.adult {
            self.adultLabel.isHidden = !adult
        }
        if let population = movie.popularity, let voteCount = movie.vote_count, let voteEverage = movie.vote_average, let overview = movie.overview, let release = movie.release_date {
            self.populationLabel.text = "View:\(population)M"
            self.voteCountLabel.text = "Num:\(voteCount)"
            self.voteEverageLabel.text = "Vote:\(voteEverage)/10"
            self.releaseDateLabel.text = release
            self.overViewLabel.text = overview
        }
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
            self.referenceMovies = []
            if let movies = result.results {
                self.referenceMovies += movies
                self.collectionView.reloadData()
            }
        }).disposed(by: disposeBag)
        
        actorViewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { (errorMessage) in
            SwiftMessageManager.shared.showMessage(messageType: .error, message: errorMessage)
        }).disposed(by: disposeBag)
        
        actorViewModel.results.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] (actor) in
            guard let self = self else { return }
            self.casts = actor.cast ?? []
            self.crew = actor.crew ?? []
            self.actorCollectionView.reloadData()
            self.teamCollectionView.reloadData()
        }).disposed(by: disposeBag)
    }
        
    // MARK: - Action
    private func handlerAction() {
        self.closeButton.rx.tap.asDriver().throttle(RxTimeInterval.microseconds(100)).drive(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}

extension DetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionView:
            return self.referenceMovies.count
        case self.actorCollectionView:
            return self.casts.count
        case self.teamCollectionView:
            return self.crew.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.collectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.configCell(movie: self.referenceMovies[indexPath.item])
            return cell
        case self.actorCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCollectionViewCell", for: indexPath) as! ActorCollectionViewCell
            cell.configCellWithCast(cast: self.casts[indexPath.item])
            return cell
        case self.teamCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "actorCollectionViewCell", for: indexPath) as! ActorCollectionViewCell
            cell.configCellWithCrew(crew: self.crew[indexPath.item])
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.collectionView:
            self.setupView(movie: self.referenceMovies[indexPath.item])
            self.bindingReferenMovie(movie: self.referenceMovies[indexPath.item])
            self.scrollView.setContentOffset(.zero, animated: true)
        case self.actorCollectionView:
            return
        case self.teamCollectionView:
            return
        default:
            return
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let widthCell = ( self.collectionView.frame.width - 30) / 3
            return CGSize(width: widthCell, height: widthCell * 3/2)
        } else {
            let heightCell = self.actorCollectionView.frame.height
            return CGSize(width: heightCell * 2/3, height: heightCell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
