//
//  ViewController.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 11.03.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class MainViewController: UIViewController {
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesTableView.rx.setDelegate(self).disposed(by: bag)
        
        bindTableViewContent()
        addSubviews()
        setupConstraints()
        categorieViewModelInstance.fetchMovies()
    }
    
    //MARK: - Properties
    private lazy var categoriesTableView: UITableView =  {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private let viewModel = CategoriesViewModel()
    private let bag = DisposeBag()

    private let categorieViewModelInstance = CategoriesViewModel()
}

private extension MainViewController {
    //MARK: - Binding
    func bindTableViewContent() {
        categorieViewModelInstance.moviesSections
            .bind(to: categoriesTableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: bag)
    }
    
    //MARK: - UI Setup
    func addSubviews() {
        view.addSubview(categoriesTableView)
    }
    
    func setupConstraints() {
        categoriesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - TableView delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
}


