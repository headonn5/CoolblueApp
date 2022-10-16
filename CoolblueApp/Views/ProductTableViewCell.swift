//
//  ProductTableViewCell.swift
//  CoolblueApp
//
//  Created by Nishant Paul on 16/10/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    private(set) var viewModel: ProductItemViewModel?
    
    private lazy var productDescriptionStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var uspLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        // Product imageview constraints
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalToConstant: 100.0),
            productImageView.heightAnchor.constraint(equalToConstant: 150.0),
        ])
        // Product Description Stack constraints
        NSLayoutConstraint.activate([
            productDescriptionStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 20),
            productDescriptionStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productDescriptionStackView.topAnchor.constraint(equalTo: productImageView.topAnchor),
            productDescriptionStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setupView() {
        [productImageView, productDescriptionStackView].forEach {
            contentView.addSubview($0)
        }
        
        [titleLabel, reviewLabel, uspLabel, priceLabel].forEach {
            productDescriptionStackView.addArrangedSubview($0)
        }
        
        contentView.backgroundColor = .white
        selectionStyle = .none
        
        setupConstraints()
    }
    
    func configure(with viewModel: ProductItemViewModel?) {
        guard let viewModel = viewModel else { return }
        self.viewModel = viewModel
        
        let api = ImageAPI(urlString: viewModel.imagePath)
        productImageView.image = nil
        viewModel.imageService.fetchImage(with: api) { [weak self] (result: Result<Data, AppError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard api.urlString == self.viewModel?.imagePath else { return }
                self.productImageView.image = UIImage(data: data)
            case .failure(let error):
                print(error)
            }
        }
        
        titleLabel.text = viewModel.name
        reviewLabel.attributedText = viewModel.formattedReview
        uspLabel.attributedText = viewModel.formattedUSPs
        priceLabel.text = viewModel.formattedPrice
    }

}
