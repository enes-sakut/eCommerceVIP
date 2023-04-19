//
//  ProductDetailView.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 17.04.2023.
//

import UIKit

protocol ProductDetailViewDelegate: AnyObject {
    func didTapDismiss()
    func didTapAddBasket(_ product: ProductList.ProductModel?, piece: Int?)
    func didTapDisplayBasket()
}

public class ProductDetailView: UIView {
    weak var delegate: ProductDetailViewDelegate?
    var product: ProductList.ProductModel? {
        didSet {
            guard let product = product,
                  let price = product.price,
                  let imageURL = product.imageUrl,
                  let size = product.productInfo?.size,
                  let type = product.productInfo?.type,
                  let brand = product.productInfo?.productBrand,
                  let color = product.productInfo?.color  else {
                return
            }
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            priceLabel.text = "\(price.priceFormatted) TL"
            productInfoSizeLabel.text = "Ürün Ölçüsü: \(size)"
            productInfoTypeLabel.text = "Ürün Tipi: \(type)"
            productInfoColorLabel.text = "Ürün Rengi: \(color)"
            productInfoBrandLabel.text = "Ürün Markası: \(brand)"
        
            productImageGalleryView.imageUrls = imageURL
        }
    }
    
    public let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
        return button
    }()
    
    public let basketButton: BadgeButton = {
        let button = BadgeButton()
        button.setImage(UIImage(named: "navBarBasketItem"), for: .normal)
        button.addTarget(self, action: #selector(didTapDisplayBasket), for: .touchUpInside)
        return button
    }()
    
    public let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    public let productImageGalleryView: GalleryView = {
        let view = GalleryView()
        view.clipsToBounds = true
        return view
    }()
    
    public lazy var zoomDriver = InteractiveZoomDriver(
        gestureTargetView: productImageGalleryView,
        sourceView: productImageGalleryView,
        targetViewFactory: { (_: GalleryView) -> UIView in
            let view = UIImageView()
            if let currentImageView = self.productImageGalleryView.getCurrentImageView() {
                view.image = currentImageView.image
                view.clipsToBounds = currentImageView.clipsToBounds
                view.contentMode = currentImageView.contentMode
            }
            return view
        }, shouldZoomTransform: {(_: GalleryView) -> Bool in
            if self.productImageGalleryView.getCurrentImageView() != nil {
                return true
            }
            return false
        })
    
    public let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 12
        return view
    }()
    
    public let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 14
        stackView.axis = .vertical
        return stackView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold20
        label.numberOfLines = 0
        label.textColor = UIColor(named: "textColor")
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    public let productInfoHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold12
        label.lineBreakMode = .byWordWrapping
        label.text = "Ürün Özellikleri"
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()

    
    public let productInfoSizeLabel: UILabel = {
        let label = UILabel()
        label.font = .latoRegular12
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "placeHolderColor")
        return label
    }()
    public let productInfoTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .latoRegular12
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "placeHolderColor")
        return label
    }()
    public let productInfoColorLabel: UILabel = {
        let label = UILabel()
        label.font = .latoRegular12
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "placeHolderColor")
        return label
    }()
    public let productInfoBrandLabel: UILabel = {
        let label = UILabel()
        label.font = .latoRegular12
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "placeHolderColor")
        return label
    }()

    public let descriptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold12
        label.text = "Ürün Açıklaması"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .latoRegular12
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "placeHolderColor")
        return label
    }()
    
    public let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    public let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold18
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    public let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepete Ekle", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .latoSemiBold16
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 12
        button.addTarget(self, action: #selector(didTapAddBasket), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    private var roundedImageViewAspectRatioConstraint: NSLayoutConstraint?
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    public func setupView() {
        backgroundColor = .white
        setupScrollView()
        setupImageView()
        setupNavButtons()
        setupBottomView()
        setupVerticalStackView()
        setupBottomStackView()
        
        roundedImageViewAspectRatioConstraint = productImageGalleryView.heightAnchor.constraint(equalTo: productImageGalleryView.widthAnchor, multiplier: 1)
        roundedImageViewAspectRatioConstraint?.priority = UILayoutPriority(rawValue: 999)
        roundedImageViewAspectRatioConstraint?.isActive = true
        _ = zoomDriver
    }
    
    public func setupNavButtons() {
        addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.productImageGalleryView.topAnchor, constant: 20),
            dismissButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        addSubview(basketButton)
        basketButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketButton.topAnchor.constraint(equalTo: self.productImageGalleryView.topAnchor, constant: 20),
            basketButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    
    public func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5.0),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -125.0),
            scrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    public func setupImageView() {
        scrollView.addSubview(productImageGalleryView)
        productImageGalleryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageGalleryView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            productImageGalleryView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageGalleryView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageGalleryView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    public func setupVerticalStackView() {
        scrollView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionHeaderLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        verticalStackView.addArrangedSubview(productInfoHeaderLabel)
        verticalStackView.addArrangedSubview(productInfoSizeLabel)
        verticalStackView.addArrangedSubview(productInfoTypeLabel)
        verticalStackView.addArrangedSubview(productInfoColorLabel)
        verticalStackView.addArrangedSubview(productInfoBrandLabel)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: productImageGalleryView.bottomAnchor, constant: 10.0),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    public func setupBottomView() {
        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -96.0),
        ])
    }
    
    public func setupBottomStackView() {
        bottomView.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(priceLabel)
        bottomStackView.addArrangedSubview(addBasketButton)

        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16.0),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16.0),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16.0),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -38.0),
           
        ])
    }
    
    @objc private func didTapDismissButton() {
        delegate?.didTapDismiss()
    }
    @objc private func didTapAddBasket() {
        delegate?.didTapAddBasket(product, piece: 1)
    }
    @objc private func didTapDisplayBasket() {
        delegate?.didTapDisplayBasket()
    }
    public func basketButtonUpdateBadgeCount() {
        basketButton.setBadgeCount(count: 1)
    }
}
