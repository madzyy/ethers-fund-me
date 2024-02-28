//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Storagee{
    uint256 favoriteNumber;
    mapping(string => uint256) nameToAge;
    People public person = People({name: "tapiwa", age: 20});
    People[] public manyPeople;

    struct People{
        string name;
        uint256 age;
    }

    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _age) public{
        // People memory personn = People({name: _name, age: _age});
        manyPeople.push(People(_name, _age));
        nameToAge[_name] = _age;
    }

 }




// pragma solidity ^0.8.19;
// //SPDX License Identifier: MIT

// contract SmartStorage{

//     uint256 public favNum;
//     People person = People({name: "Jessica", age: 30});

//     People[] peopleArray;
//     struct People{
//         string name;
//         uint256 age;
//     }

//     function store(uint256 _favNum) public {
//         favNum = _favNum;
//     }

//     function retrieveNum() public view returns(uint256){
//         return favNum;
//     }

//     function insertPeople(string memory _name, uint256 _age) public{
//         peopleArray.push(People(_name, _age));
//     }
// }































// pragma solidity ^0.8.19;
//SPDX License Identifier: MIT

// contract SimpleStore{

//     uint256 public favoriteNumber;

//     function store(uint256 _favoriteNumber) public {
//         favoriteNumber = _favoriteNumber;
//     }

//     function retrieve public view returns(uint256){
//         return favoriteNumber;
//     }
// }
