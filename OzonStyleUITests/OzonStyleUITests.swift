import XCTest

// End-to-end UI coverage: the 5-tab structure, each screen's content marker,
// and the product → detail → back navigation flow driven by the coordinators.
final class OzonStyleUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // Convenience: tap a tab-bar button by its Russian label.
    private func openTab(_ label: String) {
        let tab = app.tabBars.buttons[label]
        XCTAssertTrue(tab.waitForExistence(timeout: 5), "Tab \"\(label)\" not found")
        tab.tap()
    }

    private func assertText(_ text: String, _ message: String) {
        XCTAssertTrue(app.staticTexts[text].waitForExistence(timeout: 5), message)
    }

    // MARK: Structure

    func testTabBarHasFiveTabs() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5), "Tab bar missing")
        for label in ["Главная", "Каталог", "Избранное", "Корзина", "Мой Ozon"] {
            XCTAssertTrue(tabBar.buttons[label].exists, "Missing tab: \(label)")
        }
    }

    // MARK: Per-screen content (launch lands on Home)

    func testHomeScreen() {
        assertText("Рекомендуем", "Home recommended section missing")
    }

    func testCatalogScreen() {
        openTab("Каталог")
        assertText("Электроника", "Catalog category grid missing")
    }

    func testFavoritesScreen() {
        openTab("Избранное")
        assertText("Подобрали для вас", "Favorites section header missing")
    }

    func testCartScreen() {
        openTab("Корзина")
        assertText("Корзина пуста", "Cart empty-state band missing")
    }

    func testProfileScreen() {
        openTab("Мой Ozon")
        assertText("Войдите в личный кабинет", "Profile CTA missing")
    }

    // MARK: Navigation flow — product → detail → back

    func testProductDetailNavigationFromHome() {
        let card = app.buttons.matching(identifier: "productCard").firstMatch
        XCTAssertTrue(card.waitForExistence(timeout: 5), "No product card on Home")
        card.tap()

        let detailBar = app.navigationBars["Товар"]
        XCTAssertTrue(detailBar.waitForExistence(timeout: 5), "Product detail did not push")

        detailBar.buttons.firstMatch.tap() // back button
        XCTAssertTrue(app.staticTexts["Рекомендуем"].waitForExistence(timeout: 5),
                      "Did not return to Home after back")
        XCTAssertFalse(app.navigationBars["Товар"].exists, "Detail still on screen after back")
    }

    // Detail is reachable from every product-bearing tab (coordinator per tab).
    func testProductDetailNavigationFromCart() {
        openTab("Корзина")
        let card = app.buttons.matching(identifier: "productCard").firstMatch
        XCTAssertTrue(card.waitForExistence(timeout: 5), "No product card on Cart")
        card.tap()
        XCTAssertTrue(app.navigationBars["Товар"].waitForExistence(timeout: 5),
                      "Cart tab did not push product detail")
    }
}
