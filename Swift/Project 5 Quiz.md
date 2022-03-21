## Quiz

- 약한 참조는 사용 전 언래핑이 되어야한다. 참조에 별다른 조건을 걸지 않았다면 바로 사용이 가능하다.
- ```isEmpty```는 ```count == 0``` 보다 더 빠르다: ```isEmpty```는 false값을 리턴할 수 있지만 ```count()``` 메서드는 String의 모든 문자 개수를 세어야하기 때문에
- ```reloadData()```를 호출하면 ```numberOfRowsInSection```과 ```cellForRowAt```을 포함한 모든 테이블 뷰 메서드를 다시 호출한다.
- Objective-C와 Swift는 문자열을 다른 방식으로 저장한다. Swift의 경우 grapheme cluster으로 문자여릉ㄹ 저장하므로 Objective-C API들과 작업할때 주의해야한다.
- 클로져의 캡쳐 리스트는 파라미터 전에 온다. -> ```[weak self] param1, param2 in``` 이렇게 적는다.
- ```randomElement()```는 배열에서 항상 랜덤한 아이템을 반환하는 것이 아니라, 그 배열이 비어있을 수도 있기 때문에 옵셔널 아이템을 반환한다.
- ```NSRange```는 UIKit와 같은 Objective-C API들과 자주 함께 쓰인다. ```NSRange```는 어떠한 것의 위치와 길이를 저장한다.
