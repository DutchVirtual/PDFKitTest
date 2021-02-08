//
//  PDFViewWrapper.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 07/02/2021.
//

import PDFKit
import SwiftUI

func createFlyer() -> Data {
    // 1
    let pdfMetaData = [
        kCGPDFContextCreator: "Flyer Builder",
        kCGPDFContextAuthor: "raywenderlich.com"
    ]
    let format = UIGraphicsPDFRendererFormat()
    format.documentInfo = pdfMetaData as [String: Any]

    // 2
    let pageWidth = 8.5 * 72.0
    let pageHeight = 11 * 72.0
    let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)

    // 3
    let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
    // 4
    let data = renderer.pdfData { context in
        // 5
        context.beginPage()
        // 6
        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 72)
        ]
        let text = "I'm a PDF!"
        text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
    }

    return data
}

struct PDFViewWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
//        if let documentURL = Bundle.main.url(forResource: "A Sample PDF", withExtension: "pdf"),
//           let document = PDFDocument(url: documentURL)
//        {
//            view.document = document
//        }
        let data = createFlyer()
        view.document = PDFDocument(data: data)
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: PDFViewWrapper

        init(_ parent: PDFViewWrapper) {
            self.parent = parent
        }
    }
}

struct PDFViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        PDFViewWrapper()
    }
}
