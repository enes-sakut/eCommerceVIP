//
//  BasketView.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//


import UIKit

protocol BasketViewDelegate: AnyObject {
    func didTapBuyButton()
}

final class BasketView: UIView {
    weak var delegate: BasketViewDelegate?
    var totalPrice = 0.0
    
    var product: [ProductList.ProductModel]? {
        didSet {
            product?.forEach({ product in
                totalPrice += product.price ?? 0
            })
            priceLabel.text = "\(totalPrice.priceFormatted) TL"
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.tintColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    public let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 12
        return view
    }()
    public let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    public let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sepeti Onayla", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .latoSemiBold16
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 12
        button.addTarget(self, action: #selector(didTapBuyButton), for: .touchUpInside)
        return button
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold18
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .latoBold18
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "$0.00"
        return label
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView() {
        backgroundColor = .white
        setupBottomView()
        setupBottomStackView()
        setupTableView()
    }
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
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
    
    @objc private func didTapBuyButton(_ sender: UIButton) {
        delegate?.didTapBuyButton()
    }
    
    func setTableViewDelegate(_ delegate: UITableViewDelegate, andDataSource datasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadTotalPrice(_ totalPrice: Double) {
        totalPriceLabel.text = "\(totalPrice.priceFormatted)"
    }
    
}

