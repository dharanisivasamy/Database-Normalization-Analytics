# Normalization Process

## 1. Unnormalized Form (UNF)

Initial Table Structure:

| OrderID | CustomerName | CustomerCity | Product1 | Product2 | TotalAmount |

### Problems:
- Repeating groups (Product1, Product2)
- Data redundancy
- Update anomalies
- Poor scalability

---

## 2. First Normal Form (1NF)

Rule:
- Remove repeating groups
- Each attribute must contain atomic values

Converted Structure:

| OrderID | CustomerName | CustomerCity | ProductName | Quantity | Price |

Now:
- Each row represents one product
- No repeating columns

---

## 3. Second Normal Form (2NF)

Rule:
- Must be in 1NF
- Remove partial dependency

Problem:
CustomerCity depends only on CustomerName, not full primary key.

Solution:
Created separate Customer table.

Tables after 2NF:
- Customer
- Orders
- Order_Details

---

## 4. Third Normal Form (3NF)

Rule:
- Remove transitive dependency

Problem:
CategoryName depends indirectly on ProductID.

Solution:
Created separate Category table.

Final Tables:
- Customer
- Orders
- Order_Details
- Product
- Category

---

## Conclusion

Normalization reduces redundancy, improves data integrity, and enhances query performance for analytics applications.

