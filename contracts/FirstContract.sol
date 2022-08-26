// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FirstContract {

    struct Webmob {
        string department;
        string position;
    }

    mapping(uint => string) public names;
    mapping(string => Webmob) public company;
    mapping(uint => mapping(string => Webmob)) public EmployeeData;
    uint8 count;
    uint8[3] public arr;

    Webmob public WikiDLT;

    constructor() {
        names[1] = "Nitin";
        names[2] = "Amit";
        names[3] = "Tejas";
        names[4] = "Aryan";
    }


    function addEmployee(
        string memory _name, string memory _department, string memory _position
        ) public {
        
        WikiDLT = Webmob({
            department:_department,
            position: _position
        });
        
        company[_name] = Webmob(_department, _position);
    }

    function addDatabase( uint _id, string memory _name ) public {
        
        string memory _department = company[_name].department;
        string memory _position = company[_name].position;

        EmployeeData[_id][_name] =  Webmob(_department, _position);
    }

    function loop() public{
        do{
            arr[count] = count;
            count++;
        }while(count < arr.length);
    }


}