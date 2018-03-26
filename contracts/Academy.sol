pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Claimable.sol";

contract Academy is Claimable {

    event Enroll(address student);
    event Graduate(address student);
    
    struct Student {
        string name;
        string email;
        bool enrolled;
        bool graduated;
    }
    
    bytes32 public name;
    mapping(address => Student) public students;
    mapping(address => Student) public graduates;
 

    function Academy(bytes32 _name) 
        public 
    {
        name = _name;
    }

    function enroll(address _student, string _name, string _email) 
        public 
        onlyOwner 
    {
        require(!students[_student].enrolled);
        students[_student] = Student({ 
            name: _name, 
            email: _email,
            enrolled: true, 
            graduated: false 
        });
        emit Enroll(_student);
    }

    function graduate(address _student) 
        public 
        onlyOwner 
    {
        require(students[_student].enrolled);
        
        students[_student].graduated = true;
        graduates[_student] = students[_student];
       
        emit Graduate(_student);
    }

    function didAttend(address _student) 
        public 
        view 
        returns (bool)
    {
        require(_student != address(0));
        return students[_student].enrolled;
    }

    function didGraduate(address _student) 
        public 
        view 
        returns (bool)
    {
        require(_student != address(0));
        return students[_student].graduated;
    }

    function close() 
        public 
        onlyOwner 
    {
        selfdestruct(owner);
    }
    // Fallback function in case someone sends ether to the contract so it doesn't get lost.
    function() payable {}
}


