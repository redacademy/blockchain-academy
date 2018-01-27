pragma solidity ^0.4.17;

import 'zeppelin-solidity/contracts/ownership/Claimable.sol';

contract Academy is Claimable {
    
    struct Student {
        bool enrolled;
    }
    
    string public name;
    mapping(address => Student) public students;
    mapping(address => Student) public graduates;
    
    event Enroll(address student);
    event Graduate(address student);
    
    function Academy(string _name) public {
        name = _name;
    }

    function enroll() public onlyOwner {
        require(students[msg.sender].enrolled == false);
        students[msg.sender] = Student({ enrolled: true });

        Enroll(msg.sender);
    }

    function graduate(address _student) public onlyOwner {
        require(students[_student].enrolled == true);
        graduates[msg.sender] = students[_student];
        delete students[_student];

        Graduate(msg.sender);
    }

    function didAttend(address _student) public view returns (Student) {
        require(_student != address(0));
        return students[_student];
    }

    function didGraduate(address _student) public view returns (Student) {
        require(_student != address(0));
        return graduates[_student];
    }
}