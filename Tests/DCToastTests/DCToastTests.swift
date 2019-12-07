import XCTest
import SnapshotTesting
@testable import DCToast

final class DCToastTests: XCTestCase {
    
    let timeout: TimeInterval = 10
    let record = false
    
    func testLongMessage() {
        let message = """
                      test toast with a really long body, and including 😬 emojis
                      meaning that this can break in multipe lines 😱 indeed!
                      """
        let toast = ToastMessage(backgroundColor: .purple, message: message, textColor: .white, roundness: .mid)
        let container = self.container(for: toast)
        assertSnapshot(matching: container, as: .image, record: record)
    }
    
    func testShortMessage() {
        let toast = ToastMessage(backgroundColor: .purple, message: "hey 😬 emojis", textColor: .white, roundness: .mid)
        let container = self.container(for: toast)
        assertSnapshot(matching: container, as: .image, record: record)
    }
    
    func testRoundnessHigh() {
        let toast = ToastMessage(backgroundColor: .purple, message: "hey 😬 emojis", textColor: .white, roundness: .high)
        let container = self.container(for: toast)
        assertSnapshot(matching: container, as: .image, record: record)
    }
    
    func testRoundnessLow() {
        let toast = ToastMessage(backgroundColor: .purple, message: "hey 😬 emojis", textColor: .white, roundness: .low)
        let container = self.container(for: toast)
        assertSnapshot(matching: container, as: .image, record: record)
    }
    
    func testRoundnessNone() {
        let toast = ToastMessage(backgroundColor: .purple, message: "hey 😬 emojis", textColor: .white, roundness: .none)
        let container = self.container(for: toast)
        assertSnapshot(matching: container, as: .image, record: record)
    }
    
    
    /// Generates a container for the given view
    /// - Parameter view: The view to be contained in
    /// - Returns: A Container UIView
    func container(for view: ToastMessage) -> UIView{
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                  container.backgroundColor = .white
        container.addSubview(view)
        view.constraint(in: container, place: .down)
        view.layoutSubviews()
        return container
    }

    static var allTests = [
        ("testLongMessage", testLongMessage),
        ("testShortMessage", testShortMessage)
    ]
}

extension UIView {

    var snapshot: UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }

}
