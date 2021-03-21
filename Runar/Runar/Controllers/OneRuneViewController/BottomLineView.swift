//
//  BottomLineView.swift
//  Runar
//
//  Created by Юлия Лопатина on 14.03.21.
//

import UIKit

final class BottomLineView: UIView {
    
    private var runesSet = [RuneType]()
    var pageControl = UIPageControl()
    var movePage: ((CGFloat)->())?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addBlackView()
        setVectorsConstr()
        setUpPageControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(runesSet: [RuneType], runeType: RuneType) {
        self.init(frame: .zero)
        self.runesSet = runesSet
        pageControl.numberOfPages = runesSet.count
        pageControl.currentPage = runesSet.firstIndex(of: runeType) ?? 0
    }
    
    //MARK: -BlackView
    private var blackView: UIImageView = {
        let blackView = UIImageView()
        blackView.image = UIImage(named: "bottomBlackGradient")
        blackView.translatesAutoresizingMaskIntoConstraints = false
        return blackView
    }()
    
    private func addBlackView() {
        self.addSubview(blackView)
        NSLayoutConstraint.activate([
            blackView.topAnchor.constraint(equalTo: self.topAnchor),
            blackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    //MARK: - Vectors
    
    private let leftVectror: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popUpVectorLeft")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let rightVectror: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "popUpVectorRight")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private func setVectorsConstr() {
        let tapGestureLeft = UITapGestureRecognizer()
        leftVectror.addGestureRecognizer(tapGestureLeft)
        tapGestureLeft.addTarget(self, action: #selector(lefrVectorTap))
        let tapGestureRight = UITapGestureRecognizer()
        rightVectror.addGestureRecognizer(tapGestureRight)
        tapGestureRight.addTarget(self, action: #selector(rightVectorTap))
        self.addSubview(leftVectror)
        self.addSubview(rightVectror)
        NSLayoutConstraint.activate([
            leftVectror.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24.heightDependent()),
            leftVectror.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.heightDependent()),
            leftVectror.heightAnchor.constraint(equalToConstant: 12.heightDependent()),
            leftVectror.widthAnchor.constraint(equalToConstant: 22.heightDependent()),
            
            rightVectror.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            rightVectror.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30.heightDependent()),
            rightVectror.heightAnchor.constraint(equalToConstant: 12.heightDependent()),
            rightVectror.widthAnchor.constraint(equalToConstant: 22.heightDependent())
        ])
    }
    
    @objc private func lefrVectorTap() {
        guard let movePage = movePage else {return}
        var current:CGFloat = CGFloat(pageControl.currentPage-1)
        if current < 0 {
            current = CGFloat(pageControl.numberOfPages - 1)
        }
        movePage(current)
    }
    
    @objc private func rightVectorTap() {
        guard let movePage = movePage else {return}
        var current:CGFloat = CGFloat(pageControl.currentPage+1)
        if current > CGFloat(pageControl.numberOfPages-1) {
            current = 0
        }
        movePage(current)
    }
    
    private func setUpPageControl()  {
        pageControl.currentPage = 2
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor(red: 0.825, green: 0.77, blue: 0.677, alpha: 0.3)
       pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        
        self.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15.heightDependent()),
            pageControl.heightAnchor.constraint(equalToConstant: 45.heightDependent()),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
}
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        guard let movePage = movePage else {return}
        movePage(CGFloat(current))
    }
    
}
