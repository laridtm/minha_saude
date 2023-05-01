import Foundation
import PDFKit

public protocol PdfRederingLogic {
    func renderAndSharePDF()
}

public class PdfRender: PdfRederingLogic {
    private let userId: String
    private let worker: MedicalHistoryWorkerLogic
    
    public weak var viewController: UIViewController?
    
    public init(userId: String, worker: MedicalHistoryWorkerLogic) {
        self.userId = userId
        self.worker = worker
    }
    
    public func renderAndSharePDF() {
        worker.fetchMedicalHistory(id: userId, options: .init()) { result in
            switch result {
            case .success(let records):
                let pdfData = self.buildPDF(records: records)
                self.sharePDF(data: pdfData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func sharePDF(data: Data) {
        let vc = UIActivityViewController(activityItems: [data], applicationActivities: [])
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    private func buildPDF(records: [MedicalRecord]) -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: "Larissa Diniz",
            kCGPDFContextAuthor: "Larissa Diniz",
            kCGPDFContextTitle: "Histórico Médico"
        ]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageRect = CGRect(x: 10, y: 10, width: 595.2, height: 841.8)
        let graphicsRenderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = graphicsRenderer.pdfData { (context) in
            context.beginPage()
            
            let initialCursor: CGFloat = 32
            
            var cursor = context.addCenteredText(fontSize: 32, weight: .bold, text: "Histórico Médico 🩺", cursor: initialCursor, pdfSize: pageRect.size)
            
            cursor+=42
            
            for record in records {
                cursor = generateRecordText(record: record, context: context, cursorY: cursor, pdfSize: pageRect.size)
            }
        }
        return data
    }
    
    func generateRecordText(record: MedicalRecord, context: UIGraphicsPDFRendererContext, cursorY: CGFloat, pdfSize: CGSize) -> CGFloat {
        var cursor = cursorY
        let leftMargin: CGFloat = 74
        
        cursor = context.addSingleLineText(fontSize: 14, weight: .bold, text:  "Nome: \(record.name)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: .underline, annotationColor: .black)
        cursor+=6
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Compromisso: \(record.type.description)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor+=2
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy - HH:mm"
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Data e horário: \(dateFormatter.string(from: record.date))", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor+=2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Clínica/Hospital: \(record.hospital)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor+=2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Nome do Profissional: \(record.professional)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor+=2
        
        cursor = context.addSingleLineText(fontSize: 12, weight: .thin, text: "Observação: \(record.observation)", indent: leftMargin, cursor: cursor, pdfSize: pdfSize, annotation: nil, annotationColor: nil)
        cursor+=2
        
        cursor+=8
        
        return cursor
    }
}
