//
//  MovieCollectionViewCell.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 11.03.2023.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "somePic")
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    var data: Movie! {
        didSet {
            self.configure()
        }
    }
}

private extension MovieCollectionViewCell {
    //MARK: - UI Setup
    func addSubviews() {
        addSubview(imageView)
        addSubview(label)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
    }
}

// MARK: - Configuration
extension MovieCollectionViewCell {
    private func configure() {
        label.text = data.title
    }
}
