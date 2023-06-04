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
    
    private var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .gray.withAlphaComponent(0.2)
        return view
    }()
    
    //MARK: - Properties
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var movieTitle: String!
    
    var data: Movie! {
        didSet {
            self.configure()
        }
    }
}

private extension MovieCollectionViewCell {
    //MARK: - UI Setup
    func addSubviews() {
        addSubview(containerView)
        addSubview(imageView)
        addSubview(label)
        addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView).offset(10)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.bottom.equalTo(contentView).offset(-30)
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalTo(containerView)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalTo(containerView)
        }
    }
}

// MARK: - Configuration
extension MovieCollectionViewCell {
    func configure() {
        DispatchQueue.main.async { [self] in
            label.text = data.name
            imageView.image = data.image

            if data.coverImage == nil {
                startLoadingAnimation()
            } else {
                stopLoadingAnimation()
            }
        }
    }
    
    private func startLoadingAnimation() {
        activityIndicator.startAnimating()
    }
    
    private func stopLoadingAnimation() {
        activityIndicator.stopAnimating()
    }
}
