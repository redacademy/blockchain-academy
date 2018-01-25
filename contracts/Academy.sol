pragma solidity ^0.4.12;

contract Academy {
    
    struct Student {
        string email;
        string fullname;
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

    function enroll(string _email, string _fullname) public {
        require(students[msg.sender].enrolled == false);
        students[msg.sender] = Student({ email: _email, fullname: _fullname, enrolled: true });

        Enroll(msg.sender);
    }

    function graduate(address _student) public {
        require(students[_student].enrolled == true);
        graduates[msg.sender] = students[_student];
        delete students[_student];

        Graduate(msg.sender);
    }
}