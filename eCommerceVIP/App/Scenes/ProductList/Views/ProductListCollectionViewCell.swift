//
//  ProductListCollectionViewCell.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 17.04.2023.
//

import UIKit
import Kingfisher

protocol ProductListCollectionViewCellDelegate: AnyObject {
    func didTapAddBasket(_ product: ProductList.ProductModel?, piece: Int?)
}

final class ProductListCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ProductListCollectionViewCellDelegate?
    
    var product: ProductList.ProductModel? {
        didSet {
            guard let product = product, let price = product.price else {
                return
            }
            guard let url = URL(string: product.imageUrl?.first ?? "") else {
                return
            }
            imageView.kf.setImage(with: url)
            productName.text = product.title
            productPrice.text = "\(price.priceFormatted)TL"
        }
    }
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.font = .latoRegular14
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = .latoBold16
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.titleLabel?.font = .latoSemiBold14
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "buttonPinkColor")
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(didTapAddToBasketButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupCollectionViewCell() {
        setupContentView()
        setupImageView()
        setupProductName()
        setupProductPrice()
        setupProductButton()
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(named: "contentBorderColor")?.cgColor
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 12
    }

    
    private func setupImageView() {
        let imageViewHeight = CGFloat(contentView.frame.height * 0.65)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight)
        ])
    }
    
    private func setupProductName() {
        addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])
    }
    
    private func setupProductPrice() {
        addSubview(productPrice)
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 11),
            productPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0)
        ])
    }
    
    private func setupProductButton() {
        addSubview(addBasketButton)
        addBasketButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addBasketButton.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 12),
            addBasketButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            addBasketButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            addBasketButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10.0),
            addBasketButton.heightAnchor.constraint(equalToConstant: (contentView.frame.height / 10.45))
        ])
    }
    
    @objc private func didTapAddToBasketButton(_ sender: UIButton) {
        delegate?.didTapAddBasket(product, piece: 1)
    }
}
