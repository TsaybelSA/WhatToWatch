//
//  CategoryTableViewCell.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 11.03.2023.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        addSubviews()
        setupConstraints()
    }
    
    //MARK: - Properties
    var viewModel: GridViewModel<Movie>! {
        didSet {
            self.configure()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout())
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.stringSelf)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let bag = DisposeBag()
}

// MARK: - Configuration
extension CategoryTableViewCell {
    private func configure() {
        self.bindCollectionView()
        
        collectionView.collectionViewLayout = collectionViewLayout()
    }
}

// MARK: - Binding
extension CategoryTableViewCell {
    private func bindCollectionView() {
        viewModel.data
            .bind(to:
                collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.stringSelf,
                cellType: MovieCollectionViewCell.self)) { indexPath, data, cell in
                    cell.data = data
        }
        .disposed(by: bag)
    
    }
}

private extension CategoryTableViewCell {
    //MARK: - UI Setup
    func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let edgeInsets = Constants.itemsPadding
        
        layout.itemSize = CGSize(
            width: Constants.collectionCellWidth,
            height: Constants.collectionCellHeight)
        layout.minimumLineSpacing = edgeInsets
        layout.sectionInset = UIEdgeInsets(top: 0, left: edgeInsets,
                                           bottom: 0, right: edgeInsets)
        return layout
    }
}
