//
//  RecordTableViewCell.swift
//  GymFlow
//
//  Created by Artem Kriukov on 13.10.2025.
//

import UIKit

final class RecordTableViewCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - UI
    
    private let containerView: UIView = {
        let element = UIView()
        element.backgroundColor = R.color.cellBackgroundColor()
        element.layer.cornerRadius = UIConstants.CornerRadius.medium
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let mainHStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .center
        element.distribution = .fill
        element.spacing = UIConstants.Spacing.medium
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let leftVStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.alignment = .fill
        element.distribution = .fill
        element.setContentHuggingPriority(.defaultLow, for: .horizontal)
        element.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        element.spacing = UIConstants.Spacing.small
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let rightHStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .center
        element.distribution = .fill
        element.setContentHuggingPriority(.required, for: .horizontal)
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        element.spacing = UIConstants.Spacing.medium
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
       element.textColor = R.color.primaryTextColor()
       element.font = .systemFont(ofSize: 17, weight: .semibold)
       element.numberOfLines = 1
       element.lineBreakMode = .byTruncatingTail
       element.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
       element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let dateLabel: UILabel = {
        let element = UILabel()
        element.textColor = R.color.secondaryTextColor()
        element.font = .systemFont(ofSize: 13, weight: .regular)
        element.numberOfLines = 1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let valueLabel: UILabel = {
        let element = UILabel()
        element.textColor = R.color.secondaryTextColor()
        element.font = .systemFont(ofSize: 15, weight: .semibold)
        element.textAlignment = .right
        element.setContentHuggingPriority(.required, for: .horizontal)
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let chevronView: UIImageView = {
        let element = UIImageView()
        element.image = R.image.chevron()
        element.contentMode = .scaleAspectFit
        element.setContentHuggingPriority(.required, for: .horizontal)
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
    }
    
    // MARK: - Layout
    
    private func setupViews() {
        leftVStack.addArrangedSubview(titleLabel)
        leftVStack.addArrangedSubview(dateLabel)
        
        rightHStack.addArrangedSubview(valueLabel)
        rightHStack.addArrangedSubview(chevronView)
        
        mainHStack.addArrangedSubview(leftVStack)
        mainHStack.addArrangedSubview(rightHStack)
        
        contentView.addSubview(containerView)
        containerView.addSubview(mainHStack)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            mainHStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: inset),
            mainHStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: inset),
            mainHStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -inset),
            mainHStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -inset),
            
            chevronView.widthAnchor.constraint(equalToConstant: 12),
            chevronView.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    // MARK: - Configure
    
    func configure(with item: RecordViewItem) {
        titleLabel.text = item.title
        dateLabel.text = DateFormatter.displayFormatter.string(from: item.date)
        valueLabel.text = item.valueText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        dateLabel.text = nil
        valueLabel.text = nil
    }
}
