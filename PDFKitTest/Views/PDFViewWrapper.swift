//
//  PDFViewWrapper.swift
//  PDFKitTest
//
//  Created by Bart van Kuik on 07/02/2021.
//

import PDFKit
import SwiftUI

struct PDFViewWrapper: UIViewRepresentable {
    let pdfCreator: PDFCreator
    
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.autoScales = true
        let data = pdfCreator.render()
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
        PDFViewWrapper(pdfCreator: PDFCreator())
    }
}
