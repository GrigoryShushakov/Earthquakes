import UIKit

final class EarthquakeTableViewCell: UITableViewCell {
    static let identifier = "EarthquakeTableViewCell"
    
    let imgView = UIImageView()
    let cityLabel = UILabel()
    let regionLabel = UILabel()
    let magnitudeLabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func buildUI() {
        [imgView,cityLabel, regionLabel, magnitudeLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacing),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset),
            imgView.widthAnchor.constraint(equalToConstant: Layout.placeholderSize.width),
            imgView.heightAnchor.constraint(equalToConstant: Layout.placeholderSize.height),
            
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacing),
            cityLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Layout.offset),
            
            regionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: Layout.spacing),
            regionLabel.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: Layout.offset),
            
            magnitudeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            magnitudeLabel.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: Layout.offset),
            magnitudeLabel.leadingAnchor.constraint(equalTo: regionLabel.trailingAnchor, constant: Layout.offset),
            magnitudeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset),
            
        ])
        
        let bottomConstraint = imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacing)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        selectionStyle = .none
        cityLabel.font = Font.headline
        regionLabel.font = Font.caption
        magnitudeLabel.font = Font.body
        magnitudeLabel.setContentHuggingPriority(.required, for: .horizontal)
        magnitudeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
