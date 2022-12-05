pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract Voting {
  /* поле сопоставления ниже эквивалентно ассоциативному массиву или хешу.
   Ключом сопоставления является имя кандидата, хранящееся как тип bytes32, а значение
   целое число без знака для хранения подсчета голосов
  */
  
  mapping (bytes32 => uint8) public votesReceived;
  
  /*Solidity не позволяет вам передавать массив строк в конструкторе (пока).
   Вместо этого мы будем использовать массив из байтов32 для хранения списка кандидатов.
  */
  
  bytes32[] public candidateList;

  /* Это конструктор, который будет вызываться один раз, когда вы
   развернуть контракт в блокчейне. Когда мы развертываем контракт,
   мы пропустим ряд кандидатов, которые будут участвовать в выборах
  */
  function Voting(bytes32[] candidateNames) {
    candidateList = candidateNames;
  }

  // Эта функция возвращает общее количество голосов, полученных кандидатом на данный момент
  function totalVotesFor(bytes32 candidate) returns (uint8) {
    if (validCandidate(candidate) == false) throw;
    return votesReceived[candidate];
  }

  // Эта функция увеличивает количество голосов за указанного кандидата. Это равносильно голосованию
  function voteForCandidate(bytes32 candidate) {
    if (validCandidate(candidate) == false) throw;
    votesReceived[candidate] += 1;
  }

  function validCandidate(bytes32 candidate) returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
}
