//
//  DetailBeerViewController.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 28.07.2021.
//

import UIKit

class DetailBeerViewController: UIViewController {
    
    private let beerImageView = UIImageView()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let descriptionLabel:UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let ingredientsLabel:UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Ingredients:"
        return label
    }()
    
    private let ingradientsStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let greatWithLabel:UILabel = {
        let greatWithlabel = UILabel()
        greatWithlabel.lineBreakMode = .byWordWrapping
        greatWithlabel.numberOfLines = 0
        greatWithlabel.textAlignment = .center
        greatWithlabel.font = UIFont.boldSystemFont(ofSize: 18)
        greatWithlabel.text = "Great with:"
        return greatWithlabel
    }()
    
    private let greatWithStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    var viewModel: DetailBeerViewModelDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setViews()
    }
    
    private func setViews() {
        DispatchQueue.global(qos: .utility).async {
            if let urlStr = self.viewModel.beer.imageUrl ,let imageData = Proxy.getImageDataForUrl(urlString: urlStr)  {
                DispatchQueue.main.async {
                    self.beerImageView.image = UIImage(data: imageData)
                }
            } else {
                DispatchQueue.main.async {
                    self.beerImageView.image = UIImage.defaultBeerImage
                }
            }
        }
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(beerImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingradientsStackView)
        setupIngradientsStackView()
        contentView.addSubview(greatWithLabel)
        contentView.addSubview(greatWithStackView)
        setupGreatWithStackView()
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
        beerImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.topMargin).offset(20)
            make.bottom.equalTo(nameLabel.snp.top).offset(-20)
            make.height.equalTo(300)
            make.width.equalTo(150)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-20)
        }
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(ingredientsLabel.snp.top).offset(-20)
        }
        ingredientsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(ingradientsStackView.snp.top).offset(-20)
        }
        ingradientsStackView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(greatWithLabel.snp.top).offset(-20)
            //make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        greatWithLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            
            make.bottom.equalTo(greatWithStackView.snp.top).offset(-20)
        }
        greatWithStackView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        nameLabel.text = viewModel.beer.name
        descriptionLabel.text = viewModel.beer.description
        beerImageView.contentMode = .scaleAspectFit
    }
    
    private func setupIngradientsStackView() {
        let maltLabel = UILabel()
        maltLabel.text = "Malt"
        maltLabel.textAlignment = .center
        maltLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ingradientsStackView.addArrangedSubview(maltLabel)
        for malt in viewModel.beer.ingredients.malt {
            let label = UILabel()
            label.text = "\(malt.name) - \(malt.amount.value) \(malt.amount.unit)"
            label.lineBreakMode = .byTruncatingTail
            label.numberOfLines = 0
            label.textAlignment = .left
            ingradientsStackView.addArrangedSubview(label)
        }
        let hopsLabel = UILabel()
        hopsLabel.text = "Hops"
        hopsLabel.textAlignment = .center
        hopsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        ingradientsStackView.addArrangedSubview(hopsLabel)
        for hops in viewModel.beer.ingredients.hops {
            guard let add = hops.add, let attribute = hops.attribute else { continue }
            let label = UILabel()
            label.text = "\(hops.name) - \(hops.amount.value) \(hops.amount.unit), add at the \(add), it has \(attribute) attribute"
            label.lineBreakMode = .byTruncatingTail
            label.numberOfLines = 0
            label.textAlignment = .left
            ingradientsStackView.addArrangedSubview(label)
        }
        if viewModel.beer.ingredients.yeast != nil {
            let yeastLabel = UILabel()
            yeastLabel.text = "Yeast"
            yeastLabel.textAlignment = .center
            yeastLabel.font = UIFont.boldSystemFont(ofSize: 16)
            ingradientsStackView.addArrangedSubview(yeastLabel)
            let label = UILabel()
            label.text = "\(viewModel.beer.ingredients.yeast ?? "")"
            label.lineBreakMode = .byTruncatingTail
            label.numberOfLines = 0
            label.textAlignment = .left
            ingradientsStackView.addArrangedSubview(label)
        }
    }
    
    private func setupGreatWithStackView() {
        for food in viewModel.beer.foodPairing {
            let label = UILabel()
            label.text = food
            label.lineBreakMode = .byTruncatingTail
            label.numberOfLines = 0
            label.textAlignment = .left
            greatWithStackView.addArrangedSubview(label)
        }
    }

}
