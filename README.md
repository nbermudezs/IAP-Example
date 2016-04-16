0. Add the `StoreKit` framework to your project.

1. The code inside **Classes** doesn't need to be changed.

2. Go to the `Constants.h` file inside **Custom** and add more keys for each of your product ids.

3. Then go to `ExtendedIAPHelper.m` and add the constants you defined in 2. into the `NSSet`.

4. Create the view controller that will be used to make the purchases and copy the methods from `ViewController.m`
