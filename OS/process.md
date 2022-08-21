## 프로세의의 개념
프로세스는 실행 중인 프로그램을 의미한다.


현재 시점에 프로그램count가 어디를 가리키고 있는가, 프로세스의 메모리에 어떤 내용을 담고 있는가, 데이터 영역의 변수의 값은 얼마이고, 프로그램이 실행되면서 레지스터에 어떤 값이 들어가있고 어떤 instruction까지 실행했는가
프로세스의 현재 상태를 나타내는 모든 요소를 프로세스의 문맥이라고 한다.

1. CPU와 관련된 하드웨어 문맥
레지스터가 어떤 값을 가지고 있는가
프로그램 counter

2. 프로세스의 주소 공간 (code, data, stack)

3. 프로세스가 하나 생길 떄 마다 운영체제는 프로세스를 관리하기 위해 PCB를 하나씩 두고 있으면서 cpu를 얼마나 줄지, 메모리를 얼마나 줄지 등을 결정한다.
kernel stack - 각 프로세스가 실행되다가 본인이 할 수 없는 일을 운영체제에게 system call 하면 kernerl 도 stack에 할 일을 쌓아놓게 된다.
커널은 어떤 프로세스가 호출했는지에 대해서 프로세스마다 stack을 별도로 두고 있다.


## 프로세스의 상태

### Running
CPU를 잡고 instruction을 수행중인 상태
### Ready
CPU를 기다리는 상태 (메모리 등 다른 조건들을 모두 만족하고)
### Blocked(wait, sleep)
CPU를 주어도 당장 instruction을 수행할 수 없는 상태
process 자신이 요청한 event(예 I/O)가 즉시 만족되지 않아 이를 기다리는 상태
(예) 디스크에서 file을 읽어와야 하는 경우

### Suspended(stopped) 
외부적인 이유로 프로세스의 수행이 정지된 상태
프로세스는 통째로 디스크에 swap out 된다.
(예) 사용자가 프로그램을 일시정지 시킨 경우 (break key)
시스템이 여러 이유로 프로세스를 잠시 중단 (메모리에 너무 많은 프로세스가 올라와 있을 때) - 중기 스케줄러

**Blocked: 자신이 요청한 event가 만족되어서 ready상태로 돌아가 있는 상태**
**Suspended: 외부에서 정지시켰고 resume 해 주어야 Active할 수 있는 상태** 

New - 프로세스가 생성중인 상태
Terminated - 수행이 끝난 상태

<img width="597" alt="image" src="https://user-images.githubusercontent.com/53016167/185730157-e65e81aa-ae94-41fd-9e28-641bffe5c815.png">
<img width="597" alt="image" src="https://user-images.githubusercontent.com/53016167/185730192-50969a17-c060-4110-b500-7ca70f2309ad.png">


하나의 프로세스가 CPU에서 Running을 학고 있다가 timer interrupt 등이 되면 CPU를 뺏기고 다시 줄을 서고 그 다음 프로세스가 CPU를 얻는 식이다.
Disk에서 뭘 읽어와야 한다면 프로세스의 상태는 Running에서 Blocked로 바뀌면서 Disk에서 서비스를 받는 queue에 들어가게 된다.
Disk 작업이 끝나면, Disk controller가 CPU에게 interrupt를 걸고, I/O 작업이 끝났다는 것을 알려주고, CPU는 하던 작업을 멈추고 CPU 제어권이 OS Kernel에게 넘어가게 된다.
Kernel은 I/O 작업이 끝난 프로세서의 메모리 영역에 해당하는 데이터를 넘겨주고, 이 프로세스의 상태를 Blocked에서 Ready로 바꿔준다.

공유데이터 - 여러 프로세스가 동시에 접근하면 일관성이 깨지는 경우가 있다. 이를 CPU가 일관성이 깨지는 것을 방지 (나중에 정리 필요)


Queue는 운영체젝 커널이 Data 영역에 자료구조로 Queue를 만들어놓고 바꿔가면서 실행하는것임

## PCB (Process Control Block)
운영체제가 각 프로세스를 관리하기 위해 프로세스 당 유지하는 정보
다음의 구성 요소를 가진다 (구조체로 유지)
1. OS가 관리상 사용하는 정보
   - Process state, Process ID, scheduling information, priority
2. CPU 수행 관련 하드웨어 값
   - Program counter, registers
4. 메모리 관련
   - Code, data, stack의 위치 정보
5. 파일 관련
    - Open file descriptors ...

<img width="203" alt="image" src="https://user-images.githubusercontent.com/53016167/185730831-ba39b53a-14d2-47a4-8385-c66161cc5f5a.png">


## 문맥 교환 (Context Switch)
CPU를 한 프로세스에서 다른 프로세스로 넘겨주는 과정
CPU가 다른 프로세스에게 넘어갈 때 OS는 다음을 수행
   - CPU를 내어주는 프로세스의 상태를 그 프로세스의 PCB에 저장
   - CPU를 새롭게 얻는 프로세스의 상태를 PCB에서 읽어옴

<img width="468" alt="image" src="https://user-images.githubusercontent.com/53016167/185731018-3a93fd0d-7038-4801-b0d4-d096e27cc0a2.png">

즉, CPU를 빼앗기기 전 마지막 상태를 PCB에 저장하는 것임.
또, CPU를 얻게 된 프로세스도 기존 위치부터 재개하기 위해 context를 PCB로부터 찾아서 사용한다.


## System call, interrupt VS context switch

<img width="575" alt="image" src="https://user-images.githubusercontent.com/53016167/185731128-c7e4eb65-18d7-4322-857f-1fa9998c794e.png">

System Call은 프로세스가 필요해서 OS Kernel에 요청하는 것이다.
(하드웨어)Interrupt는 Controller와 같은 장치가 CPU에게 정보를 전달할 목적으로 거는 것이다.
CPU 제어권이 사용자 프로세스로부터 운영체제 Kernel에게 넘어가게 된다.

VS

Context Switch 는 사용자 process로부터 또 다른 사용자 process로 넘어가는 것을 의미한다.
System Call 나 Interrupt 후에 다른 process로 CPU가 넘어가게 되면 Context Switch가 된다. <- (2) 참조

Context Switch가 일어나면, cache memory를 다 지워야 한다. 근데 (1)의 경우에는 그렇게 할 필요가 없다. (overhead)


## 프로세스 스케쥴링을 위한 Queue

Job Queue
   - 현재 시스템 내에 있는 모든 프로세스의 집합
Ready Queue
   - 현재 메모리 내에 있으면서 CPU를 잡아서 실행되기를 기다리는 프로세스의 집합
Device Queues
   - I/O device 처리를 기다리는 프로세스의 집합
프로세스들은 각 큐들을 오가며 수행된다. 
<img width="464" alt="image" src="https://user-images.githubusercontent.com/53016167/185731754-e0537b74-bc54-4906-893f-21a36988f4fa.png">


## 스케줄러 (Scheduler)

스케줄러 - 순서를 정해주는 것

### **Short-term scheduler (단기 스케줄러 or CUP Scheduler)**
- 어떤 프로세스를 다음 번에 running 시킬 지 결정
- 프로세스 CPU를 주는 문제
- 충분히 빨라야 함 (millisecond 단위)

### Long-term scheduler (장기 스케줄러 or Job Scheduler)
- 시작 프로세스 중 어떤 것을 ready queue로 보낼 지 결정(처음 프로세스가 시작될 때, 메모리에 적재되어야만 running 상태로 들어갈 수 있다.)
- 프로세스에 memroy(및 각종 자원)을 주는 문제
- degree of Multiprogramming을 제어 (메모리에 프로그램이 몇개 올라갈지를 제어)
- time sharing system에는 보통 장기 스케줄러가 없음 (무조건 ready)
- 요즘 컴퓨터에는 장기 스케줄러가 없다. 요즘 100개 프로그램이면 모든 프로그램이 ready 상태로 들어감. 중기 스케줄러로 관리

### **Medium-term scheduler (중기 스케줄러 or Swapper)**
- 여유 공간 마련을 위해 프로세스를 통째로 메모리에서 디스크로 쫒아냄
- 프로세스에게서 memroy를 뺏는 문제
- dergree of Multiprogramming을 제어

<img width="590" alt="image" src="https://user-images.githubusercontent.com/53016167/185778579-60f055e5-23b1-47f4-8506-78169a8e91ea.png">


## 동기식 입출력과 비동기식 입출력의 차이점

<img width="550" alt="image" src="https://user-images.githubusercontent.com/53016167/185778656-a5cc2211-0646-4551-addf-9173c6a89f29.png">

동기식 입출력은 프로세스가 입출력 요청을 했을 때, 입출력은 오래 걸려서 수행된다. 수행되는 동안에 입출력을 요청한 프로세스가 입출력이 끝날 때까지 아무것도 못하고 기다려야 하면 동기식 입출력이다.
이와 달리, 요청을 하고 입출력을 기다리는 동안 다른 작업을 할 수 있으면 비동기식 입출력이다.

<img width="459" alt="image" src="https://user-images.githubusercontent.com/53016167/185778764-3058e35e-3f74-4f9f-8ff1-63869634acf1.png">

동기식 입출력이 일을 못하는 동안에 CPU를 가지고 있으면서 일을 못하면, 구현방법1이 되는 것이고, 어차피 일을 못하는 김에 다른 프로세스에게 CPU를 넘겨주면 구현방법2가 되는 것이다.



## Thread
프로세스 내부에 CPU 사용 단위가 여러개 있는 경우

프로세스가 여러개 있다고 하면, 프로세스 마다 별도의 주소 공간이 만들어져서 메모리 낭비가 된다.
같은 일을 하는 프로세스를 여러개 띄워놓고 싶다면 주소 공간을 하나만 띄워놓고 각 프로세스 마다 다른 부분의 코드를 실행할 수 있게 하면 된다.
이것이 Thread의 개념

CPU가 코드의 어는 부분을 실행하고 있는지, 즉 Program counter만 여러개 두는 것이다.
CPU 수행을 위해서는 현재 코드의 어느 부분을 실행하는지 나타내는 Program Counter가 있어야 하고 레지스터가 있어야 한다.

함수를 호출하고 리턴하는 것과 관련된 정보를 스택에 쌓는다. 근데 스레드가 여러개가 있으면 그만큼 stack도 여러개가 들어간다.

<img width="557" alt="image" src="https://user-images.githubusercontent.com/53016167/185780096-7aa11180-50ff-41b8-8159-c28a3f2f40b2.png">

스레드는 CPU를 수행하는 단위이다. 스레드의 구성은 Program Counter, Register Set, Stack Space 이다.

thread들 끼리는 Code section, data section, OS resources를 공유한다. (= Task)
즉 하나의 프로세스 안에 쓰레드가 여러개 있어도 Task는 한개이다.



### Thread를 사용했을 때 장점

**빠른 응답성 제공**

스레드 하나가 Blocked(waiting) 상태 일 때 다른 스레드가 CPU를 잡고 Running 상태가 되어 빠른 처리를 할 수 있다.
Ex) 네트워크를 통해 웹 페이지를 읽어온다고 하면, 웹 페이지를 읽어오는 동안 오래걸리기 때문에 웹브라우저는 Blocked 상태가 된다. 그러면 사용자는 답답하다.
웹 브라우저를 여러개의 스레드를 통해 만들게 되면 하나의 스레드가 그림 등을 불러오는 동안 또 다른 스레드가 텍스트라도 미리 display 해주면 사용자는 결과를 빨리 볼 수 있기 때문에 답답함이 덜하게 된다.
하나의 스레드가 다른 작업을 하는 동안 또 다른 스레드가 별도의 작업을 하게 되면 사용자에게 빠른 경험을 제공해줄 수 있다.


**메모리 등 자원 낭비 방지**
같은 일을 하는 일을 별도의 프로세스로 만들게 되면 자원이 낭비된다. 프로세스 각각이 메모리에 만들어져야 하는데 쓸데 없이 메모리를 차지하게 된다.
하나의 프로세스 안에 스레드를 여러개 두게 되면 성능 향상과 자원 절약의 효과가 있다.




<img width="591" alt="image" src="https://user-images.githubusercontent.com/53016167/185780781-6d4434f7-9727-43db-a91c-2fec4c383ae2.png">

프로세스는 하나이기 때문에 PCB는 하나만 만들어진다.

하지만, 프로세스 안에 스레드가 여러개 있게 되면, CPU 수행과 관련된 정보만 스레드 마다 별도의 copy를 가지게 된다.
PC와 레지스터 정보

<img width="562" alt="image" src="https://user-images.githubusercontent.com/53016167/185780846-a94c52a3-d07f-4b0a-81e3-5dbc28671d6a.png">



## 스레드를 사용하는 장점
### 스레드의 장점은 크게 4가지로 요약 가능하다.

1. **응답성**
웹브라우저 예시를 들었던 것 처럼 하나의 스레드가 무거운 사진을 통신 하는 동안 다른 스레드는 빠른 텍스트를 통신해서 빠른 응답성을 부여한다. (일종의 비동기식 입출력)

2. **자원 공유**
똑같은 일을 하는 프로그램이 여러개 있는데, 이것을 별도의 프로세스로 사용하는 것 보다는 하나의 프로세스로 만들고 여러 그 안에 CPU 수행 단위만 여러개를 두게 되면 코드 데이터를 공유하게 된다.

3. **경제성**
좀 더 빠르다는 뜻이다.
프로세스를 하나 만드는 것은 overhead가 큰 작업이다. 하지만 프로세스 안에 스레드를 추가하는 것은 작은 overhead를 가지는 작업니다.
그리고 프로세스로 다른 프로세스로 CPU가 넘어가는 context switch는 overhead가 큰 작업이다. (cpu 관련 정보를 저장하고, 캐시 메모리 flush) 반면에 프로세스 내부에서 thread 간의 swtich가 일어나는 것은 매우 간단하다.
Solaris 운영체제의 경우 생성에는 30배, switch에 5배 overhead가 든다.

4. **Utilization of MP architectures**
스레드가 여러개 있으면, 서로 다른 CPU에서 병렬적으로 처리할 수 있다.
ex) 큰 행렬을 곱한다던지 등


