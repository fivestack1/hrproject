//
//  SubscriptionManager.swift
//  MyHoroscope2
//
//  Created by admin on 29.06.2026.
//
import Foundation
import StoreKit
import Observation

@MainActor
@Observable
final class SubscriptionManager {

    static let shared = SubscriptionManager()

    private init() {}

    // MARK: - Product IDs

    static let weeklyID = "cellmap_pro_weekly"
    static let yearlyID = "cellmap_pro_yearly"

    // MARK: - Published State

    var products: [Product] = []

    var weeklyProduct: Product?

    var yearlyProduct: Product?

    var selectedProduct: Product?

    var purchasedProductIDs: Set<String> = []

    var isSubscribed = false

    var isLoading = false

    var purchaseInProgress = false

    var errorMessage: String?
    

    // MARK: - Load Products

    func loadProducts() async {

        guard products.isEmpty else { return }

        isLoading = true

        do {

            let storeProducts = try await Product.products(
                for: [
                    Self.weeklyID,
                    Self.yearlyID
                ]
            )

            products = storeProducts

            weeklyProduct = storeProducts.first {
                $0.id == Self.weeklyID
            }

            yearlyProduct = storeProducts.first {
                $0.id == Self.yearlyID
            }

            selectedProduct = yearlyProduct ?? weeklyProduct

        } catch {

            errorMessage = error.localizedDescription

            print(error)
        }

        isLoading = false
    }

    // MARK: - Purchase

    func purchaseSelected() async {

        guard let product = selectedProduct else {
            return
        }

        purchaseInProgress = true

        do {

            let result = try await product.purchase()

            switch result {

            case .success(let verification):

                switch verification {

                case .verified(let transaction):

                    await transaction.finish()

                    await updatePurchasedProducts()

                case .unverified(_, let error):

                    errorMessage = error.localizedDescription
                }

            case .pending:
                break

            case .userCancelled:
                break

            @unknown default:
                break
            }

        } catch {

            errorMessage = error.localizedDescription
        }

        purchaseInProgress = false
    }

    // MARK: - Restore

    func restorePurchases() async {

        do {

            try await AppStore.sync()

            await updatePurchasedProducts()

        } catch {

            errorMessage = error.localizedDescription
        }
    }

    // MARK: - Check Entitlements

    func updatePurchasedProducts() async {

        purchasedProductIDs.removeAll()

        for await result in Transaction.currentEntitlements {

            guard case .verified(let transaction) = result else {
                continue
            }

            purchasedProductIDs.insert(
                transaction.productID
            )
        }

        isSubscribed = purchasedProductIDs.contains(Self.weeklyID) || purchasedProductIDs.contains(Self.yearlyID)
    }

    // MARK: - Transaction Listener

    func startListening() {

        Task {

            for await update in Transaction.updates {

                guard case .verified(let transaction) = update else {
                    continue
                }

                await transaction.finish()

                await updatePurchasedProducts()
            }
        }
    }

    // MARK: - Helpers

    func selectWeekly() {

        selectedProduct = weeklyProduct
    }

    func selectYearly() {

        selectedProduct = yearlyProduct
    }

    var yearlySelected: Bool {

        selectedProduct?.id == Self.yearlyID
    }

    var weeklySelected: Bool {

        selectedProduct?.id == Self.weeklyID
    }
}


extension Product {

    var displayPriceText: String {

        displayPrice
    }

    var hasTrial: Bool {

        subscription?
            .introductoryOffer != nil
    }

    var weeklyEquivalent: String? {

        guard
            let subscription,
            subscription.subscriptionPeriod.unit == .year,
            let price = Decimal(string: price.description)
        else {
            return nil
        }

        let weekly = price / 52

        let formatter = NumberFormatter()

        formatter.numberStyle = .currency

        formatter.currencyCode = priceFormatStyle.currencyCode

        return formatter.string(
            from: weekly as NSNumber
        )
    }
}
