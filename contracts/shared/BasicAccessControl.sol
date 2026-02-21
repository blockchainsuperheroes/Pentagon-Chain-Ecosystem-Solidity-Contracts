// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BasicAccessControl is Ownable {
    uint16 public totalModerators = 0;
    mapping(address => bool) public moderators;
    bool public isMaintaining = false;

    modifier onlyModerators() {
        require(
            _msgSender() == owner() || moderators[_msgSender()] == true,
            "Restricted Access!"
        );
        _;
    }

    modifier isActive() {
        require(!isMaintaining);
        _;
    }

    function addModerator(address _newModerator) public onlyOwner {
        if (moderators[_newModerator] == false) {
            moderators[_newModerator] = true;
            totalModerators += 1;
        } else {
            delete moderators[_newModerator];
            totalModerators -= 1;
        }
    }

    function updateMaintaining(bool _isMaintaining) public onlyOwner {
        isMaintaining = _isMaintaining;
    }
}
