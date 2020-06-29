# SinzuMoney
> This is a simple type-safe representation of a Monetary.


[![Swift Version][swift-image]][swift-url]
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  


## Requirements

- iOS 12.0+
- Xcode 11

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'SinzuMoney'
```

To get the full benefits import `YourLibrary` wherever you import UIKit

``` swift
import SinzuMoney
```

## Usage example

```swift
import SinzuMoney

```
Sinzu Money uses Naira as its default currency type and can be initialized with any money value:

```swift
let money = Money.from(value: 10.32) // Positive value

let localizeMoney = money.localized
print(localizeMoney) //returns  ₦10.32

let localizedMoney = Money.from(value: -10000000.32) // Negative value
let localized = localizedMoney.localized

print(localizedMoney) // returns ₦-10,000,000.32




```
But it isn’t restricted to just Naira you can use any currency type known on earth by simply using the currency code: 

```swift
let usDollarCurrency = Money.Currency(code: "USD", name: "Dollar", symbol: "$", baseUnit: "US Dollar", decimalUnit: "Cent”). 

let moneyWithNewCurrency = money.newWith(currency: usDollarCurrency)

print(moneyWithNewCurrency.localizedBalance) // returns $1,234.23K


```
You can also change only the currency symbol:

```swift
let dollarCurrency = Money.Currency.from(code: "$")

let newDollarCurrencyMoney = money.newWith(currency: dollarCurrency)

print(newDollarCurrencyMoney.localizedBalance) // returns  $1,234.23K

```
Sinzu Money can help you get the monetary unit of any value:

```swift
 let thousandMoney = Money.from(value: 30000.00)

 print(thousandMoney.unit) // returns “K”

 let millionMoney = Money.from(value: 3000000.00)
  print(millionMoney.unit) //  returns M

 let billionMoney = Money.from(value: 30000000000.00)

 print(billionMoney.unit) // returns B
```

Sinzu Money can also help you get human readable value:

```swift
let localizedMoney = Money.from(value: 1240000.6254204)
let localized = localizedMoney.humanReadable
print(localizedMoney) // returns 1,240,000.63
```

 You can also get a suffix value of any amount:
 
```swift
 let thousandMoney = Money.from(value: 30000.00)
  print(thousandMoney.suffixAmount) // returns  +30K

 let millionMoney = Money.from(value: 3000000.00)
  
 print(millionMoney.suffixAmount) // returns  +3M 

 let billionMoney = Money.from(value: -30000000000.00)

 print(billionMoney.suffixAmount) // returns  -30B

```
If you want to send monetary value to backend, you can covert your value to either decimal or integer:

```swift
let money = Money.from(value: 1234.23)

print(money.backendDecimalPostableAmount) // returns 123423
print(money.backendIntegerPostableAmount) // returns  123400

```

## Contribute

We would love you for the contribution to **SinzuMoney**, check the ``LICENSE`` file for more info.


[swift-image]:https://img.shields.io/badge/swift-5.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
