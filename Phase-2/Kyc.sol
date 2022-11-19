// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface BankInterface {
    function addKycRequest(string memory _name, string memory _data) external;
    function removeKycRequest(string memory _name) external;
    function addCustomer(string memory _name, string memory _data) external;
    function viewCustomer(string memory _name) external view returns(string memory, string memory, bool, uint, uint, address);
    function upvoteCustomer(string memory _name) external;
    function downvoteCustomer(string memory _name) external;
    function modifyCustomer(string memory _name, string memory _data) external;
    function getBankComplaints(address _bankAddress) external view returns(uint);
    function viewBankDetails(address _bankAddress) external view returns(string memory, address, uint, uint, bool, string memory);
    function reportBank(address _bankAddress, string memory _bankName) external;
}

interface Admin {
    function addBank(string memory _name, address _bankAddress, string memory _regNumber) external;
    function isAllowedToVote(address _bankAddress, bool _isAllowedToVote) external;
    function removeBank(address _bankAddress) external;
}

contract Kyc is BankInterface, Admin{

    address owner;
    uint public totalBanks = 0;

    struct Customer {
        string name;
        string data;
        bool kycStatus;
        uint downVotes;
        uint upVotes;
        address bank;
    }

    struct Bank {
        string name;
        address ethAddress;
        uint complaintsReported;
        uint KYC_count;
        bool isAllowedToVote;
        string regNumber;
    }

    struct KycRequest {
        string userName;
        address bankAddress;
        string customerData;
    }

    mapping (string => Customer) customers;
    mapping (address => Bank) banks;
    mapping (string => KycRequest) public kycRequests;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require (owner == msg.sender, "owner address not found");
        _;
    }

    modifier onlyBank {
        require (msg.sender == banks[msg.sender].ethAddress, "Only banks can do");
        _;
    }

    function addCustomer(string memory _name, string memory _data) external override {
        // This function will add a customer to the customer list.
        // bytes32 name = bytes32(abi.encode(_name));
        // bytes32 data = bytes32(abi.encode(_data));
        require (keccak256(abi.encode(customers[_name].name)) != keccak256(abi.encode(_name)),"Customer is already present,Why are you adding same Customer?");
        customers[_name] = Customer(_name, _data, false, 0, 0, msg.sender);
    }

    function viewCustomer(string memory _name) external override view returns(string memory, string memory, bool, uint, uint, address) {
        // This function allows a bank to view the details of a customer.
        // All the variables of the customer structure 
        // bytes32 name = bytes32(abi.encode(_name));
        Customer memory c = customers[_name];
        return (c.name, c.data, c.kycStatus, c.upVotes, c.downVotes, c.bank);
    }

    function upvoteCustomer(string memory _name) external override onlyBank {
        // This function allows a bank to cast an upvote for a customer. 
        // This vote from a bank means that it accepts the customer details as well as 
        // acknowledges the KYC process done by some bank for the customer.
        customers[_name].upVotes += 1;
        if (customers[_name].upVotes > customers[_name].downVotes && customers[_name].downVotes >= totalBanks/3) {
            customers[_name].kycStatus = true;
        } else {
            customers[_name].kycStatus = false;
        }
    }

    function downvoteCustomer(string memory _name) external override onlyBank {
        // This function allows a bank to cast a downvote for a customer. 
        // This vote from a bank means that it does not accept the customer details.
        customers[_name].downVotes += 1;
    }


    function modifyCustomer(string memory _name, string memory _data) external override {
        // This function allows a bank to modify a customer's data. 
        // This will remove the customer from the KYC request list and set the number of downvotes and upvotes to zero. 
        require(customers[_name].bank != address(0), "User is not registered");
        customers[_name].data = _data;
    }

    function addKycRequest(string memory _name, string memory _data) external override {
        // This function is used to add the KYC request to the requests list
        string memory name = customers[_name].name;
        kycRequests[name] = KycRequest({
        userName: customers[name].name,
        bankAddress: customers[name].bank,
        customerData: _data
        });
    }

    function removeKycRequest(string memory _name) external override {
        // This function will remove the request from the requests list.
        // string memory name = customers[_name].name;
        delete kycRequests[_name];
    }

    function getBankComplaints(address _bankAddress) external override view returns(uint) {
        // This function will be used to fetch bank complaints from the smart contract.  
        // Integer number of complaintsReported against the bank 
        return banks[_bankAddress].complaintsReported;
    }

    function viewBankDetails(address _bankAddress) external override view returns(string memory, address, uint, uint, bool, string memory) {
        // This function is used to fetch the bank details.
        // The return type of this function will be of type Bank    
        Bank memory b = banks[_bankAddress];
        return (b.name, b.ethAddress, b.complaintsReported, b.KYC_count, b.isAllowedToVote, b.regNumber);
    }

    function reportBank(address _bankAddress, string memory _bankName) external override onlyBank {
        // This function is used to report a complaint against any bank in the network. 
        // It will also modify the isAllowedToVote status of the bank according to the conditions mentioned in the problem statement. 
        require(keccak256(abi.encode(banks[_bankAddress].name)) == keccak256(abi.encode(_bankName)), "Bank name is not found");
        banks[_bankAddress].complaintsReported += 1;

        // change isAllowedToVote status as per condition : If the number of complaints exceeds more than half (or one-third) of the total banks on the network, you can set isAllowedToVote to false; 
        if (banks[_bankAddress].complaintsReported > totalBanks/3) {
            banks[_bankAddress].isAllowedToVote = false;
        }
    }

    function addBank(string memory _name, address _bankAddress, string memory _regNumber) external override onlyOwner{
        // This function is used by the admin to add a bank to the KYC Contract. 
        // You need to verify whether the user trying to call this function is the admin or not.
        require (_bankAddress != banks[_bankAddress].ethAddress, "Bank is already registered");
        banks[_bankAddress] = Bank(_name, _bankAddress, 0, 0, true, _regNumber);
        totalBanks++;
    }

    function isAllowedToVote(address _bankAddress, bool _isAllowedToVote) external override onlyOwner{
        // This function can only be used by the admin to change the status of isAllowedToVote of any of the banks at any point in time.
        // require (banks[_bankAddress].complaintsReported)
        banks[_bankAddress].isAllowedToVote = _isAllowedToVote;
    }

    function removeBank(address _bankAddress) external override onlyOwner{
        // This function is used by the admin to remove a bank from the KYC Contract. 
        // You need to verify whether the user trying to call this function is the admin or not.
        require (banks[_bankAddress].ethAddress == _bankAddress, "Bank not found");
        delete banks[_bankAddress];
    }
}