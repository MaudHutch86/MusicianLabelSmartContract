// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract MusiciansManager {

    struct Track{
    string _title;
    uint _duration;
  }

  struct Musician {
    string _artistName;
    Track[] _tracks;
  }


  event musicianCreated(string _artistName);
  event trackCreated(string _artistName , string _trackTitle);
  event getTheTrack(Track[] _tracks);

 
  mapping(address => Musician) Musicians;

  address owner;


  constructor () {
     owner= msg.sender;
  }
  modifier onlyOwner() {
    require(msg.sender == owner, "Not right to use this function ");
    _;
  }

  function addMusician(address _musicianAddress, string memory _artistName) external onlyOwner {
    require(bytes(Musicians[_musicianAddress]._artistName).length == 0, "this musician has already been created");
    Musicians [_musicianAddress]._artistName = _artistName;
    emit musicianCreated(_artistName);
  }

  function addTracck(address _musicianAddress, string memory _title,uint _duration) external onlyOwner  {
    require(bytes(Musicians[_musicianAddress]._artistName).length > 0 , "You cannot add new track without an artist you must add an artist first");
     Track  memory thisTrack = Track( _title, _duration);
     Musicians[_musicianAddress]._tracks.push(thisTrack);
     emit trackCreated( Musicians[_musicianAddress]._artistName, _title);
  }

}
