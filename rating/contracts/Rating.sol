// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.8.0;

pragma experimental ABIEncoderV2;

contract Rating {
    string[] public moviesList; // ["Tenant", "Mulan"] + "Sonic the Hedgehog"
    
    mapping (bytes32 => uint8) private ratings;
    
    mapping (bytes32 => bool) private movies;
    

    constructor(string[] memory _moviesList) public {
       moviesList = _moviesList; 
    }

    /**
      * @dev Adds new movie to the moviesList.
      * @param movieName Name of the movie 
      * 
      * Notes:
      * - Need to check whether movie already exists before adding to the list
      */ 
    function addNewMovie(string memory movieName) public {
        bytes32 movieNameInBytes32 = stringToBytes32(movieName);
        require(!movies[movieNameInBytes32], "Movie already exitsts!!!");
        moviesList.push(movieName);
        movies[movieNameInBytes32] = true;
    }
    
    /** 
     * @dev Get total votes.
     * @param movieName Name of the movie
     * @return The total ratings a movie has received so far
     * Notes: 
     * - You need to convert movieName from string to bytes32
     */
    function getTotalVotes(string memory movieName) public view returns (uint8) {
        return ratings[stringToBytes32(movieName)];
    }

    /** 
     * @dev Vote for a movie.
     * @param movieName Name of the movie
     * Note: 
     * - You need to convert movieName from string to bytes32
     */
    function vote(string memory movieName) public {
        ratings[stringToBytes32(movieName)] += 1;
    }
  
    /** 
     * @dev Convert string to bytes32.
     * @param source String source
     * @return bytes32
     * Notes: 
     * - You need to convert movieName from string to bytes32
     */
    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }
}