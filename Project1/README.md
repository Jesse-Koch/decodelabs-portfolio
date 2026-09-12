# Project 1: Data Cleaning & Preparation

**DecodeLabs Industrial Training Kit**

Cleaned an e-commerce dataset (1,200 rows, 14 columns) from raw and messy to analysis-ready.

---

## Requirements Met

- 0% duplicate Order IDs
- 0% incorrect date formats (ISO 8601: YYYY-MM-DD)
- 309 nulls in CouponCode column replaced with “No Coupon”, no other nulls detected
- All cross-validation rules pass or are documented

---

## What I Did

| Change | Columns Affected |
|--------|------------------|
| Set correct data types | All 14 |
| Checked for duplicates | Order ID (0 found) |
| Trimmed & cleaned text | 9 text columns |
| Standardized case | Product, Payment Method, Order Status, Referral Source |
| Converted to decimal & rounded | Unit Price, Total Price |
| Created ISO 8601 dates | Date |
| Imputed nulls (median/mode) | Quantity, Items in Cart, Payment Method, Order Status |
| Replaced nulls with labels | Coupon Code → "No Coupon" |
| Cross-validated 8 rules | See below |

---

## Cross-Validation Results

| Rule | Result |
|------|--------|
| Total Price = Quantity × Unit Price | 0 mismatches |
| Items in Cart ≥ Quantity | 0 flags |
| Tracking Number vs Order Status | 487 documented |
| Quantity > 0 | 0 errors |
| Prices > 0 | 0 errors |
| Order ID format | 0 errors |
| Customer ID format | 0 errors |

---

## Documented Exception

**487 records** have a Tracking Number but Order Status shows "Processing" or "Pending".

**Why:** The source system assigns tracking numbers before updating status.

**Breakdown:**
- 237 DOCUMENTED (Processing/Pending with tracking)
- 250 REVIEW_RETURN (Cancelled with return tracking)

**What I did:** Left data as-is, labeled each pattern separately, and logged it.

---

## Files

- `DecodeLabs_Dataset_Cleaned.xlsx` - Final cleaned dataset
- `Project1_Change_Log.pdf` - Full change log

---

## Tools

Excel (formulas, Text to Columns, conditional formatting), python-docx
