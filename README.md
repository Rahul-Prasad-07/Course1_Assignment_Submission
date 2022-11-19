# A Decentralized KYC Verification Process for Banks

### Origin of KYC
Know your customer, or KYC, as it is referred to, originated as a standard to combat the laundering of illicit money flowing from terrorism, organized crime, and drug trafficking. The primary process behind KYC is that governments and enterprises need to track customers for illegal and money laundering activities. Moreover, KYC also enables banks to understand their customers and their financial dealings better. This helps them manage their risks and make better decisions.

### Need for KYC
Taking in the origin of KYC, we can state that there are four major banking sectors where KYC is needed. They are as described below:

- **Customer admittance** : This sector defines opening accounts with anonymous names as restricted entry into the banking system. In other words, accounts with anonymous names are not allowed. Preliminary information, such as names, dates of birth, addresses, and contact numbers, is to be collected to provide banking services.

- **Customer identification** : In case of suspicious banking transactions by a customer, their accounts can be tracked and flagged. Further, they can be sent for processing under the bank’s head office for review.

- **Monitoring of bank activities** : Banks can, after understanding their customer base through KYC, zero in on suspicious and dubious activities in any of their accounts.

- **Risk management** : Since banks now have all preliminary information and are aware of their customers’ activity patterns, they can assess the risk and likelihood of customers being involved in illegal transactions.

The aforementioned requirements make the KYC process an essential entity in the banking and financial sphere. The traditional KYC process is already followed in some banks, although that process has certain associated major challenges. Through this case study, we will assess these challenges and tackle them. First, we will list the challenges related to the traditional KYC process.

# Problems/Challenges in KYC

### The Disparity in KYC Specifications
- Each bank has its own KYC process set up. Due to this, customers have to do KYC separately for each individual bank.The lack of KYC standards makes it a time-consuming task to compile each KYC request.

### Adverse Impact on Customer Relationship
- Due to disparate KYC specifications, customers have to provide the same information to different banking entities and industries. This becomes irksome for customers.Banks sometimes even follow up with customers to get more details for KYC.

### Escalating Costs and Time for Banks
- A recent study concluded that overheads for KYC in a bank increase the onboarding cost for a customer by 18% and the minimum time required to 26 days.

# Solution Using Blockchain

A blockchain is an immutable distributed ledger that is shared with everyone on the network. Each participant interacts with the blockchain using a public–private cryptographic key combination. Moreover, blockchains are immutable, which means the records stored on a blockchain are extremely difficult to tamper with.

Banks can utilize a blockchain’s feature set to reduce the difficulties faced by the traditional KYC process. A distributed ledger can be set up between all banks; one bank can then upload a customer’s KYC on this ledger while the others can vote on the legitimacy of the customer’s details. The customer’s KYC will be stored immutably on the blockchain and will be accessible to all banks that are involved in it.

This case study is divided into three phases to achieve the solution. The phases are explained below.

## Phase 1:
- Banks add customers and their data on the network.
- Whenever a bank needs to append new data, the ledger could enable encrypted updates of data. Mining will ensure that the data is validated over the blockchain and is distributed to all other banks.
- Banks can modify the customers’ data that is stored in the database. In phase 1, any bank can modify customers’ data. In phase 2, we will add admin and bank functionalities, which will provide the necessary restrictions over the network and over customers’ data.
- Banks can also view customers’ data.

## Phase 2:
- Admin functionalities are provided for the system, where an admin can track the actions such as upload or approval of KYC documents performed by banks.
- The admin can block any bank from doing a KYC; the admin can also add new banks or remove untrusted banks from the smart contract.
- Whenever a new customer enters into the system, a bank initiates a KYC request for the customer with the additional data provided by the customer to the bank. Any bank can raise the KYC request.
- Once a KYC request of a customer is added, any bank can upvote or downvote, stating their stand on the data provided by the customer.
- The bank can remove the KYC request of the customer.
- Now, the customer struct will also store the number of upvotes and downvotes, and the KYC status of the customer. For the KYC status to be true for any customer, the number of upvotes should be greater than the number of downvotes. Also, if one-third of the total number of banks downvote the customer, then the KYC status is set to false even if the number of upvotes is greater than that of downvotes for that customer.
- Customers' KYC status will be stored on the chain depending on the number of upvotes/downvotes.
- Banks also report the other banks to make sure that the banks are secure and not tampered with for the KYC process. This identifies whether the bank is corrupted and whether it is uploading fake KYC. This rating will help us to judge the bank activities and remove the fraudulent bank from our network. 
- The admin can anytime disallow the bank from upvoting/downvoting.
- Depending on the number of reports and the number of banks present in the network, it will be decided whether any bank is allowed to downvote or upvote. If any bank gets reported more than one-third of the banks present in the network, it will not be allowed to do KYC anymore. 

You can use some other logic to identify corrupted banks over the network. (For example, if more than half of the banks report the bank or the upvoted customers by a bank get more than a threshold number of downvotes by the other). If a bank is corrupted, set the 'isAllowedToVote' variable of the bank struct to false.
