// SPDX-License-Identifier: None

pragma solidity ^0.7.0;

import "@opengsn/gsn/contracts/BaseRelayRecipient.sol";
import "@opengsn/gsn/contracts/interfaces/IKnowForwarderAddress.sol";

contract StringOwner is BaseRelayRecipient, IKnowForwarderAddress {

    address public deployer;
    string private _str;
    address private _strOwner;

    // event to be emitted for denoting string got updated
    event StringUpdated(string _prev, address _preOwner, string _current, address _currentOwner);

    constructor(address forwarder) {
        trustedForwarder = forwarder;

        deployer = msg.sender;

        // initializing it with this
        _str = "init";
        _strOwner = msg.sender;
    }

    function getTrustedForwarder() public override view returns(address) {
        return trustedForwarder;
    }

    function setTrustedForwarder(address forwarder) public {
        require(_msgSender() == deployer, "Only deployer can update it");

        trustedForwarder = forwarder;
    }

    // get current string
    function getString() public view returns(string memory) {
        return _str;
    }

    // get current string owner
    function getStringOwner() public view returns(address) {
        return _strOwner;
    }

    // updates string content & also owner address
    // with the address which invoked this function
    function update(string memory _string) external {
        string memory _tmpStr = _str;
        address _tmpStrOwner = _strOwner;

        _str = _string;
        _strOwner = _msgSender();

        emit StringUpdated(_tmpStr, _tmpStrOwner, _str, _strOwner);
    }

    function versionRecipient() external virtual view override returns (string memory) {
        return "1.0";
    }

}