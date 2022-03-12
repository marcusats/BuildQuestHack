// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

contract Items is ERC1155, Ownable {
    
    string baseURI;
    string public baseExtension = ".json";
    uint nextId = 0;

    constructor(string _baseURI) ERC1155(_baseUri) {

    }

    struct Item {
        address owner;
        uint256 supply;
        string name;
        uint256 cost;
        bool forSale;

    }

    modifier forSale(uint256 tokenId) {
        require(_itemDetails[tokenId], "item is not for sale");
    }

    mapping(uint => Item) private _itemDetails;

    function getItemDetails(uint _tokenId) public view returns(Item memory) {
        return _itemDetails[_tokenId];
    }

    function mint(uint256 _supply, string memory _name, uint256 cost) {

        Item memory thisItem = Item(msg.sender, _supply, _name, _cost, true);
        _itemDetails[nextId] = thisItem;

        _mint(msg.sender(), tokenID, supply);

        nextId++;

    }

    function buyItem(uint256 tokenId, uint256 amount) public payable forSale(tokenId) {
        // amount less then supply
        // safe transfer from
        require(msg.sender != address(0));

        require(amount <= _itemDetails[tokenId].supply);

        _safeTransferFrom(_itemDetails[tokenId].owner, msg.sender, tokenId, amount);

    }

    function sellItem(address _to, uint256 tokenId, uint256 amount) {
        
        require(to != address(0));

        _safeTransferFrom(msg.sender, _to, tokenId, amount);

    }

}

//pick up shoes, the whole website changes to just shoes everywhere.
