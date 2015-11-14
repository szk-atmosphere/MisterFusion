# MisterFusion

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![Version](https://img.shields.io/cocoapods/v/MisterFusion.svg?style=flat)](http://cocoapods.org/pods/MisterFusion)
[![License](https://img.shields.io/cocoapods/l/MisterFusion.svg?style=flat)](http://cocoapods.org/pods/MisterFusion)

![](./logo.png)

MisterFusion makes more easier to use AutoLayout in Swift & Objective-C code.

#### MisterFusion Code for Swift

```swift
let view = UIView()
self.view.addSubview(view)
self.view.translatesAutoresizingMaskIntoConstraints = false
self.view.addLayoutConstraints(
    view.Top    |+| 10,
    view.Right  |-| 10,
    view.Left   |+| 10,
    view.Bottom |-| 10
)
```

#### Ordinary Code for Swift

This is same implementation as above code, but this is hard to see.

```swift
let view = UIView()
self.view.addSubview(view)
self.view.translatesAutoresizingMaskIntoConstraints = false
self.view.addConstraints([
    NSLayoutConstraint(item: view, attribute: .Top,    relatedBy: .Equal, toItem: self.view, attribute: .Top,    multiplier: 1, constant:  10),
    NSLayoutConstraint(item: view, attribute: .Right,  relatedBy: .Equal, toItem: self.view, attribute: .Right,  multiplier: 1, constant: -10),
    NSLayoutConstraint(item: view, attribute: .Left,   relatedBy: .Equal, toItem: self.view, attribute: .Left,   multiplier: 1, constant:  10),
    NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -10),
])
```

#### MisterFusion Code for Objective-C

```objective-c
UIView *view = [UIView new];
view.backgroundColor = [UIColor yellowColor];
view.translatesAutoresizingMaskIntoConstraints = NO;
[self.view addSubview:view];
[self.view addLayoutConstraints:@[
    view.Top   .Constant(10.0f),
    view.Right .Constant(-10.0f),
    view.Left  .Constant(10.0f),
    view.Bottom.Constant(-10.0f)
]];
```

#### Ordinary Code for Objective-C

This is same implementation as above code, but this is hard to see.

```objective-c
UIView *view = [UIView new];
view.backgroundColor = [UIColor redColor];
view.translatesAutoresizingMaskIntoConstraints = NO;
[self.view addSubview: view];
[self.view addConstraints:@[
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop    multiplier:1.0f constant:10.0f],
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight  multiplier:1.0f constant:-10.0f],
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft   multiplier:1.0f constant:10.0f],
    [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.5f constant:-15.0f]
]];
```

## Installation

#### CocoaPods

MisterFusion is available through [CocoaPods](http://cocoapods.org). If you have cocoapods 0.39.0 or greater, you can install
it, simply add the following line to your Podfile:

	pod "MisterFusion"

In addtion, import **MisterFusion** like this.

##### Swift

    import MisterFusion

##### Objective-C

    #import <MisterFusion/MisterFusion-Swift.h>

## Advanced Setting

You can set `multiplier`, `constant` and `priority` like this.
(This is same implementation as [first example](#misterfusion-code).)

#### Swift

```swift
self.view.addConstraints(
    view.Top    |==| self.view.Top    |*| 1 |+| 10 |<>| UILayoutPriorityRequired,
    view.Right  |==| self.view.Right  |*| 1 |-| 10 |<>| UILayoutPriorityRequired,
    view.Left   |==| self.view.Left   |*| 1 |+| 10 |<>| UILayoutPriorityRequired,
    view.Bottom |==| self.view.Bottom |*| 1 |-| 10 |<>| UILayoutPriorityRequired
)
```

#### Objective-C

```objective-c
[self.view addLayoutConstraints:@[
    view.Top   .Equal(self.view.Top)   .Multiplier(1.0f).Constant(10.0f) .Priority(UILayoutPriorityRequired),
    view.Right .Equal(self.view.Right) .Multiplier(1.0f).Constant(-10.0f).Priority(UILayoutPriorityRequired),
    view.Left  .Equal(self.view.Left)  .Multiplier(1.0f).Constant(10.0f) .Priority(UILayoutPriorityRequired),
    view.Bottom.Equal(self.view.Bottom).Multiplier(1.0f).Constant(-10.0f).Priority(UILayoutPriorityRequired)
]];
```

## For Swift

#### Operators

- `|==|`, `|<=|`, `|>=|` ... `NSLayoutRelation`
- `|*|`, `|/|` ... `multiplier`
- `|+|`, `|-|` ... `constant`
- `|<>|` ... `UILayoutPriority`

#### UIView Extensions

```swift
public func addLayoutConstraint(misterFusion: MisterFusion) -> NSLayoutConstraint
public func addLayoutConstraints(misterFusions: MisterFusion...) -> [NSLayoutConstraint]
public func addLayoutConstraints(misterFusions: [MisterFusion]) -> [NSLayoutConstraint]
```

You can get added `NSLayoutConstraint` like this.

```swift
let bottomConstraint: NSLayoutConstraint = self.view.addLayoutConstraints(
    view.Top    |+| 10,
    view.Right  |-| 10,
    view.Left   |+| 10,
    view.Bottom |-| 10
).filter { $0.firstAttribute == .Bottom }.first
```

## For Objective-C

### Readonly Closures

```objective-c
@interface MisterFusion : NSObject
//NSLayoutRelation
@property (nonatomic, readonly, copy) MisterFusion * __nonnull (^ __nonnull Equal)(MisterFusion * __nonnull);
@property (nonatomic, readonly, copy) MisterFusion * __nonnull (^ __nonnull LessThanOrEqual)(MisterFusion * __nonnull);
@property (nonatomic, readonly, copy) MisterFusion * __nonnull (^ __nonnull GreaterThanOrEqual)(MisterFusion * __nonnull);
//multiplier
@property (nonatomic, readonly, copy) MisterFusion * __nonnull (^ __nonnull Multiplier)(CGFloat);
//constant
@property (nonatomic, readonly, copy) MisterFusion * __nonnull (^ __nonnull Constant)(CGFloat);
//UILayoutPriority
@property (nonatomic, readonly, copy) MisterFusion * __nonnull (^ __nonnull Priority)(UILayoutPriority);
@end
```

#### UIView Category

```objective-c
- (NSLayoutConstraint * __nonnull)addLayoutConstraint:(MisterFusion * __nonnull)misterFusion;
- (NSArray<NSLayoutConstraint *> * __nonnull)addLayoutConstraints:(NSArray<MisterFusion *> * __nonnull)misterFusions;
```

## Requirements

- Xcode 7.0 or greater
- iOS8.0 or greater

## Author

Taiki Suzuki, s1180183@gmail.com

## License

MisterFusion is available under the MIT license. See the LICENSE file for more info.
