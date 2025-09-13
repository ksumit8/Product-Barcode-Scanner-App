# Product Barcode Scanner App
A Flutter application to scan barcodes, view product details, and manage favorite products.

## Project Contains

- Animated heart icon when adding favorites.  
- Persist favorites locally using `shared_preferences`.  
- Responsive UI (mobile only, **not optimized for tablets**).  
- Loading indicator during network calls.  
- Use `async/await` for API calls with proper error handling. 

## Chosen State Management Approach
This project uses **Provider** for state management and follows **Clean Architecture** principles.
**Why?**  
Provider was chosen because it is simple, lightweight, and reactive, making it easy to manage state across the app while keeping the code clean and maintainable. Coupled with Clean Architecture, it ensures a clear separation of concerns, making the app more scalable, testable, and easy to maintain.

## Instructions to Run the Project
1. **Clone the repository:**
```bash
git clone https://github.com/your-username/Product-Barcode-Scanner-App.git
cd Product-Barcode-Scanner-App
in Android studio do:-  flutter pub get and run the project

## Project Setup / Environment
This project uses the following environment:
- **Flutter:** 3.27.4
- **Dart:** 3.6.2

## Demo Workflow Example
## Instructions to Run the Project

1. User clicks **Start Scanning** on the landing page.  
2. Scanner opens, and the user scans a barcode.  

> **Note:** The barcode must be **Code-128** format, with data in the format `productid1`, `productid2`, ..., `productid5`.  
> You can generate them using(assumptions)[TEC-IT Barcode Generator](https://barcode.tec-it.com/en/?data=productid1).  

3. API fetches product details → displays, for example, **iPhone 9** (dummy JSON product ID 3).  
4. User taps **Favorite**, and the product is saved to the local favorites list.  
5. User navigates to the **Favorites Screen** → sees the saved product.  
6. User clicks on the product → navigates to **Product View** to see detailed information.(additional features.)










