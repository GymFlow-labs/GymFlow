//
//  RecordDetailCell.swift
//  GymFlow
//
//  Created by Artem Kriukov on 14.10.2025.
//

import UIKit

final class RecordDetailCell: UITableViewCell, ReuseIdentifying {

    // MARK: - UI
    private lazy var cardView: UIView = {
        let element = UIView()
        element.backgroundColor = R.color.cellBackgroundColor()
        element.layer.cornerRadius = UIConstants.CornerRadius.medium
        element.layer.masksToBounds = false
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOpacity = 0.08
        element.layer.shadowRadius = 10
        element.layer.shadowOffset = CGSize(width: 0, height: 3)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var contentStack: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fillEqually
        element.alignment = .fill
        element.spacing = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var leftColumn: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.alignment = .leading
        element.spacing = UIConstants.Spacing.small
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var dateTitleLabel: UILabel = {
        let element = UILabel()
        element.text = "Дата"
        element.font = .systemFont(ofSize: 13)
        element.textColor = R.color.secondaryTextColor()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var dateValueLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.textColor = R.color.primaryTextColor()
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var rightColumn: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.alignment = .trailing
        element.spacing = UIConstants.Spacing.small
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var weightTitleLabel: UILabel = {
        let element = UILabel()
        element.text = "Вес"
        element.font = .systemFont(ofSize: 13)
        element.textColor = R.color.secondaryTextColor()
        element.textAlignment = .right
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var weightValueLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 17)
        element.textColor = R.color.primaryTextColor()
        element.textAlignment = .right
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configure(with item: WorkoutRecordItem) {
        
        dateValueLabel.text = DateFormatter.displayFormatter.string(from: item.date)
        weightValueLabel.text = String(item.weight)
    }
}

private extension RecordDetailCell {
    func setupViews() {
        selectionStyle = .none
        backgroundColor = R.color.backgroundColor()
        
        contentView.addSubview(cardView)
        cardView.addSubview(contentStack)

        leftColumn.addArrangedSubview(dateTitleLabel)
        leftColumn.addArrangedSubview(dateValueLabel)

        rightColumn.addArrangedSubview(weightTitleLabel)
        rightColumn.addArrangedSubview(weightValueLabel)

        contentStack.addArrangedSubview(leftColumn)
        contentStack.addArrangedSubview(rightColumn)
    }

    func setupConstraints() {
        let insetH: CGFloat = 16
        let insetV: CGFloat = 12

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            contentStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: insetV),
            contentStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: insetH),
            contentStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -insetH),
            contentStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -insetV),
        ])
    }
}
