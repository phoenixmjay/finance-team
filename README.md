# Finance Project (Redacted)

## Schema Mapping & Data Standardization

For a unified user-customer mapping, I worked with the backend engineers, data engineers and the finance team to standardize the identifiers and transformations.

#### Raw Data Sources
| Source                      | ID Type          | Example        |
| :-------------------------- | :--------------: | :------------: |
| Backend (Users Table)       |  user_id         | 12345          |
| Stripe (Transactions Table) |  customer_id     | cus_abc123     |
| Stripe (Invoices Table)     |  subscription_id | sub_xyz987     |
| CRM (Salesforce)            |  email           | user@email.com |

Challenge: Different IDs per system required consistent user-customer mapping.
Solution: Created a crosswalk table to track relationships between: 
- user_id 
- customer_id
- subscription_id

## Building the Unified Data Model in dbt
Designed a dbt model to create a single source of truth, linking users to their Stripe transactions.

- Standardizing the user-customer mapping resolved mismatches.
- Email-based matching ensured higher success rates, even if user_id is missing in Stripe.
- Using indexed columns (user_id, customer_id) resulted in faster queries.
- Optimizing Query Performance & Revenue Attribution
- To support finance teams in tracking monthly revenue and churn, I built aggregated tables for faster queries.
- Pre-calculating revenue per user reduced query times from 4 min to under 10 sec.
- Included only active/trial subscriptions to filter out irrelevant data.
- Easily joinable with product analytics, enabling LTV and churn analysis.

## Automating Data Quality & Monitoring
To prevent data mismatches, I implemented automated checks in dbt and Airflow.

- I set up alerts if missing user-customer relationships are detected.
- I also integrated with Slack notifications to trigger alerts if mismatches exceed 5% threshold.
