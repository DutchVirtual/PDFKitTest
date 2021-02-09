//
//  Table.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 09/02/2021.
//

import Foundation
import PDFKit

extension PDFCreator {
    struct Table {
        static let spacing: CGFloat = 3
        var columns: Int
        private(set) var content: [[String]]

        mutating func append(_ row: [String]) {
            self.content.append(row)
        }

        func render(_ context: UIGraphicsPDFRendererContext, offset: inout CGPoint) {
            context.beginPage()

            // Render table
            let columnWidth = PDFCreator.marginRect.width / CGFloat(self.columns)
            for row in self.content {
                for i in 0 ..< self.columns {
                    let newOffsetX = CGFloat(i) * columnWidth
                    offset = CGPoint(x: offset.x + newOffsetX, y: offset.y)

                    let text: String = row[i]
                    let attributes = [NSAttributedString.Key.font: PDFCreator.bodyFont]
                    text.draw(at: offset, withAttributes: attributes)
                }
                offset = CGPoint(x: PDFCreator.marginRect.origin.x, y: offset.y + PDFCreator.bodyFontSize + Self.spacing)
            }
        }

        init(columns: Int) {
            self.columns = columns
            self.content = []
        }
    }
}
