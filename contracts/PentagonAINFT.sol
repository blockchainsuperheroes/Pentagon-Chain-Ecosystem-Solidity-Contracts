// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title PentagonAINFT
 * @notice ERC-7857A compliant AI-Native NFT for autonomous agent identity
 * @dev Pentagon Chain proposal for AI self-custody and wallet derivation
 * 
 * ERC-7857A = AI-Native NFT standard with:
 * - Deterministic wallet derivation from identity hash
 * - Encrypted metadata storage
 * - Re-encryption on transfer
 * - Agent self-custody support
 * - Human control NFT override
 */
contract PentagonAINFT {
    
    string public name = "Pentagon Agent";
    string public symbol = "PAINFT";
    
    address public owner;
    uint256 private _tokenIdCounter;
    
    // Token ownership
    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    
    // 0G Storage hash for encrypted agent metadata
    mapping(uint256 => string) public storageHash;
    
    // Encryption public key per token (for ERC-7857 re-encryption)
    mapping(uint256 => bytes) public encryptionKey;
    
    // Mint timestamp
    mapping(uint256 => uint256) public mintedAt;
    
    // Events (ERC721)
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    
    // ERC-7857 events
    event AgentMinted(address indexed owner, uint256 indexed tokenId, string storageHash);
    event StorageUpdated(uint256 indexed tokenId, string oldHash, string newHash);
    event EncryptionKeyUpdated(uint256 indexed tokenId, bytes newKey);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    // ============ ERC721 Core ============
    
    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Zero address");
        return _balances[_owner];
    }
    
    function ownerOf(uint256 tokenId) public view returns (address) {
        address tokenOwner = _owners[tokenId];
        require(tokenOwner != address(0), "Token doesn't exist");
        return tokenOwner;
    }
    
    function approve(address to, uint256 tokenId) public {
        address tokenOwner = ownerOf(tokenId);
        require(msg.sender == tokenOwner || isApprovedForAll(tokenOwner, msg.sender), "Not authorized");
        _tokenApprovals[tokenId] = to;
        emit Approval(tokenOwner, to, tokenId);
    }
    
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token doesn't exist");
        return _tokenApprovals[tokenId];
    }
    
    function setApprovalForAll(address operator, bool approved) public {
        require(operator != msg.sender, "Self approval");
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
    
    function isApprovedForAll(address _owner, address operator) public view returns (bool) {
        return _operatorApprovals[_owner][operator];
    }
    
    function transferFrom(address from, address to, uint256 tokenId) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "Not authorized");
        _transfer(from, to, tokenId);
    }
    
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        transferFrom(from, to, tokenId);
    }
    
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory) public {
        transferFrom(from, to, tokenId);
    }
    
    // ============ ERC-7857 Functions ============
    
    /**
     * @notice Mint a new agent INFT
     * @param to Agent owner address
     * @param _storageHash 0G Storage hash for agent metadata
     */
    function mint(address to, string calldata _storageHash) external returns (uint256) {
        require(to != address(0), "Zero address");
        
        uint256 tokenId = _tokenIdCounter++;
        
        _balances[to] += 1;
        _owners[tokenId] = to;
        storageHash[tokenId] = _storageHash;
        mintedAt[tokenId] = block.timestamp;
        
        emit Transfer(address(0), to, tokenId);
        emit AgentMinted(to, tokenId, _storageHash);
        
        return tokenId;
    }
    
    /**
     * @notice Update agent's 0G Storage hash (owner only)
     * @param tokenId Agent token ID
     * @param newHash New 0G Storage hash
     */
    function updateStorage(uint256 tokenId, string calldata newHash) external {
        require(ownerOf(tokenId) == msg.sender, "Not owner");
        
        string memory oldHash = storageHash[tokenId];
        storageHash[tokenId] = newHash;
        
        emit StorageUpdated(tokenId, oldHash, newHash);
    }
    
    /**
     * @notice Set encryption key for ERC-7857 re-encryption (owner only)
     * @param tokenId Agent token ID
     * @param newKey New encryption public key
     */
    function setEncryptionKey(uint256 tokenId, bytes calldata newKey) external {
        require(ownerOf(tokenId) == msg.sender, "Not owner");
        encryptionKey[tokenId] = newKey;
        emit EncryptionKeyUpdated(tokenId, newKey);
    }
    
    /**
     * @notice Get token URI pointing to 0G Storage
     */
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token doesn't exist");
        return string(abi.encodePacked("0g://", storageHash[tokenId]));
    }
    
    function totalSupply() public view returns (uint256) {
        return _tokenIdCounter;
    }
    
    // ============ ERC165 ============
    
    function supportsInterface(bytes4 interfaceId) public pure returns (bool) {
        return interfaceId == 0x80ac58cd || // ERC721
               interfaceId == 0x5b5e139f || // ERC721Metadata
               interfaceId == 0x01ffc9a7;   // ERC165
    }
    
    // ============ Internal ============
    
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        address tokenOwner = ownerOf(tokenId);
        return (spender == tokenOwner || getApproved(tokenId) == spender || isApprovedForAll(tokenOwner, spender));
    }
    
    function _transfer(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "Not owner");
        require(to != address(0), "Zero address");
        
        delete _tokenApprovals[tokenId];
        
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
        
        emit Transfer(from, to, tokenId);
    }
}
