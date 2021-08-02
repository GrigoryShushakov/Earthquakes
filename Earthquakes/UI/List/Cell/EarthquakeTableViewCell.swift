import UIKit

final class EarthquakeTableViewCell: UITableViewCell {
    static let identifier = "EarthquakeTableViewCell"
    
    let idLabel = UILabel()
    let dateLabel = UILabel()
    let magnitudeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func buildUI() {
        [dateLabel, idLabel, magnitudeLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.numberOfLines = 0
        }
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.spacing),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset),
            
            magnitudeLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: Layout.spacing),
            magnitudeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset),
            magnitudeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset),
            
            dateLabel.topAnchor.constraint(equalTo: magnitudeLabel.bottomAnchor, constant: Layout.spacing),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.offset),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.offset),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Layout.spacing),
        ])
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        idLabel.font = Font.headline
        magnitudeLabel.font = Font.body
        dateLabel.font = Font.caption
    }
}
