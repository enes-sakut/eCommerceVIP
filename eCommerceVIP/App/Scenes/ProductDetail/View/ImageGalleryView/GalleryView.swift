//
//  GalleryView.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 18.04.2023.
//

import UIKit

public class GalleryView: UIView {
    
    private var imageViews: [UIImageView] = []
    private var scrollViewAspectRatioConstraint: NSLayoutConstraint?
   
    let targetSizeConstant: CGFloat = 360
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        return stackView
    }()
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = UIColor(named: "placeHolderColor")
        pageControl.backgroundColor = .white
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return pageControl
    }()
    
    private var currentIndex: Int = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize.width = frame.size.width * CGFloat(imageViews.count)
    }
    
    func setupView() {
        self.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(scrollView)
        verticalStackView.addArrangedSubview(pageControl)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: self.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 15),
            verticalStackView.heightAnchor.constraint(equalToConstant: 360)
        ])
        scrollView.delegate = self
    }
    
    var imageUrls: [String]? {
        didSet {
            currentIndex = 0
            imageViews.removeAll()
            scrollView.subviews.forEach({ $0.removeFromSuperview() })
            scrollView.setContentOffset(.zero, animated: false)
            setupImageUrls()
            
            
            setConstraints()
            if self.imageUrls?.count ?? 0 > 1 {
                pageControl.isHidden = false
                pageControl.numberOfPages = self.imageUrls?.count ?? 0
            } else {
                pageControl.isHidden = true
                
            }
        }
    }
    
    private  func setupImageUrls() {
        self.imageUrls?.forEach({ imageUrl in
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let url = URL(string: imageUrl)
            imageView.kf.setImage(with: url)
            let newImage = imageView.image?.resizeImage(image: imageView.image ?? UIImage(), targetSize: CGSize(width: targetSizeConstant * UIScreen.main.scale, height: targetSizeConstant * UIScreen.main.scale))
            imageView.image = newImage
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            imageViews.append(imageView)
            scrollView.addSubview(imageView)
        })
    }
    
    private func setConstraints() {
        for (index, imageView) in imageViews.enumerated() {
            if index - 1 < 0 {
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            } else {
                imageView.leadingAnchor.constraint(equalTo: imageViews[index - 1].trailingAnchor).isActive = true
            }
            if index == imageViews.count - 1 {
                imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            }
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        }
    }
    
    func getCurrentImageView() -> UIImageView? {
        return imageViews[currentIndex]
    }
    
}
extension GalleryView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / frame.width)

    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let nearestIndex = Int(CGFloat(targetContentOffset.pointee.x) / scrollView.bounds.size.width + 0.5)
        let clampedIndex = max( min( nearestIndex, (imageUrls?.count ?? 0) - 1 ), 0 )
        var xOffset = CGFloat(clampedIndex) * scrollView.bounds.size.width
        xOffset = xOffset == 0.0 ? 1.0 : xOffset
        targetContentOffset.pointee.x = xOffset
    }
    
}
