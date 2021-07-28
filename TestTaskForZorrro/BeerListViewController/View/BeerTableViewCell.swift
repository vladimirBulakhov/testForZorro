//
//  BeerTableViewCell.swift
//  TestTaskForZorrro
//
//  Created by Vladimir Bulakhov on 27.07.2021.
//

import UIKit
import SnapKit


class BeerTableViewCell: UITableViewCell {
    
    private let beerImageView = UIImageView()
    private let nameLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setViews() {
        contentView.addSubview(beerImageView)
        contentView.addSubview(nameLabel)
        nameLabel.textAlignment = .center
        beerImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        beerImageView.snp.makeConstraints { (make) in
            make.height.equalTo(100).priority(.high)
            make.width.equalTo(50)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.right.equalTo(nameLabel.snp.left).offset(-20)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            
        }
        nameLabel.snp.makeConstraints { (make) in
            make.right.equalTo(contentView.snp.right).offset(-20)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
    
    func configure(beer: Beer) {
        nameLabel.text = beer.name
        DispatchQueue.global(qos: .utility).async {
            guard let imageData = Proxy.getImageDataForUrl(urlString: beer.imageUrl) else { return }
            DispatchQueue.main.async {
                self.beerImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        beerImageView.image = UIImage()
    }

}
