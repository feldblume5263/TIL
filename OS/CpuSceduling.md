프로그램은 CPU burst 와 I/O burst의 연속이다.

<img width="429" alt="스크린샷 2022-08-23 오전 11 44 20" src="https://user-images.githubusercontent.com/53016167/186057873-75139769-b776-411e-9f74-ca0e7aacd96f.png">

I/O burst가 빈번하게 일어나서 CPU burst가 짧은 경우를 I/O bound job이라고 부르고
CPU burst가 긴 경우를 CPU bound job이라고 부른다.

**사람하고 interaction을 더 많이 하는 프로그램(I/O burst)에 CPU를 더 주는게 효율적이다.**

## CPU Scheduler & Dispatcher

### CPU Scheduler

CPU를 누구에게 줄 지 결정하는 운영체제의 코드

### Dispatcher



CPU를 스케줄러를 통해 누구에게 줄지 결정했으면, 그 프로세스에게 CPU를 넘겨주는 역할을 하는 코드 
이 과정을 context switch라고 한다.



### CPU 스케줄링이 필요한 경우

1. Running -> Blocked
   
   - CPU를 프로세스를 잡고 있다가 그 프로세스가 I/O 작업처럼 오래 걸리는 작업을 하러 가는 경우 

2. Running -> Ready
   
   - 프로세스는 CPU를 계속 쓰고 싶지만 할당시간이 만료되면 빼앗아와야 한다.

3. Blocked -> Ready
   
   - I/O 요청한 작업이 끝났으면 device controller가 interrupt를 걸어서 프로세스를 Ready로 바꿔준다.

4. Terminate
   
   - 프로세스가 종료되어 더 이상 할일 없을 때, CPU가 필요 없을 때



## 성능 척도

**시스템 입장에서의 성능 척도**

### CPU utilization(이용률)

- 전체 시간 중 CPU가 일을 하는 시간의 비율

- 가능한 바쁘게 일을 시켜야 한다.

### Throughput (처리량)

- 주어진 시간 동안 몇개의 일을 처리했는지의 지표



**프로세스 입장에서의 성능 척도** (가능하면 내가 빨리 CPU를 쓰고 I/O를 하러 나가고 싶다.)

### Turnaround time (소요 시간, 반환 시간)

- CPU를 쓰러 들어와서 다 쓰고 나갈 때까지 걸린 시간 (기다리고 쓰는 시간 모두 포함)

### Waiting time (대기 시간)

- Ready queue에 줄을 서서 기다리는 시간

### Response time (응답 시간)

- CPU 쓰러 들어와서 처음으로 CPU를 얻기 까지 걸리는 시간

- waiting time과 response time의 차이점
  
  - waiting time = 한번의 CPU Burst 동안에도 얻었다 뺐겼다를 반복하다보면 줄서서 기다린 시간이 계속 생기는데 이 시간들을 다 합친 것
  
  - response time = 처음으로 CPU를 얻기까지의 시간



중국집을 운영하는 입장에서 주방장을 고용 - 주방장 일을 많이 시키는게 좋다.

이용률 - 전체 시간 중 주방장이 일하는 시간의 비율

처리량 - 중국집에서 단위 시간당 몇명의 손님을 받았는가

고객입장에서

소요시간 - 고객이 주문해서 식사를 다 하고 나갈 때 까지 걸리는 시간 (코스요리를 시키면 요리를 먹고 다른 요리를 기다리고 등등 기다리는 시간 모두 시간 포함)

대기시간 - 밥 먹는 시간 말고 기다리는 시간을 합친 시간

응답시간 - 첫번째 음식이 나올 때까지 기다리는 시간





## FCFS (First-Come First-Served)

**먼저 온 순서대로 처리하는 방법**

비선점형 스케쥴링 - 일단 CPU를 얻으면 끝날 때까지 내놓지 않는다. 

-> 효율적이지 않음 CPU를 오래 쓰는 프로그램이 있으면, CPU를 짧게 쓰는 프로그램이 있어도 기다려야 한다.

| Process | Burst Time |
| ------- |:----------:|
| P1      | 24         |
| P2      | 3          |
| P3      | 3          |

<img src="https://user-images.githubusercontent.com/53016167/186839679-56f3cf22-e6e6-441a-81ba-5c283e50db93.png" title="" alt="image" width="412">

- Waiting time for P1 = 0, P2 = 24, P3 = 27

- Average Waiting time = 17

<img src="https://user-images.githubusercontent.com/53016167/186840290-c9061ec6-47f6-48bf-ab29-306445f472f0.png" title="" alt="image" width="421">

- Waiting time for P1 = 0, P2 = 3, P3 = 6

- Average Waiting time = 3



**Convoy Effect = 긴 프로세스가 하나 도착해서 짧은 프로세스가 지나치게 오래 기다려야 하는 현상**



## SJF (Shortest-Job-First)

**프로세스의 CPU burst time이 가장 짧은 프로세스를 먼저 스케쥴**

Average waiting time이 최소화할 수 있는 알고리즘



두가지 방식이 있다.

1. Nonpreemptive
   
   - 일단 CPU를 잡으면 이번 CPU burst가 완료될 때 까지 CPU를 선점당하지 않는다.

2. Preemptive
   
   - 현재 수행중인 프로세스의 남은 burst time보다 더 짧은 CPU burst time을 가지는 새로운 프로세스가 도착하면 CPU를 빼앗김
   
   - 이 방법을 Shortest-Remaining-Time-First (SRTF)라고 한다.
     
     
     

| Process | Arrival Time | Burst Time |
|:-------:|:------------:|:----------:|
| P1      | 0.0          | 7          |
| P2      | 2.0          | 4          |
| P3      | 4.0          | 1          |
| P4      | 5.0          | 4          |

**SJF**![image](https://user-images.githubusercontent.com/53016167/186856879-1a6a516c-e643-4db6-92d8-bd7d51f78a2a.png)

- Average waiting time = 4



**SRTF**

![image](https://user-images.githubusercontent.com/53016167/186857659-cde043b2-8372-4464-b0ee-2d8ac950ea80.png)

- Average waiting time = 3



이 알고리즘에는 두가지 문제점이 있다.

1. Starvation
   
   - CPU 사용시간이 긴 프로세스는 영원히 서비스를 못받을 수도 있다.

2. CPU 사용시간을 미리 알 수가 없다.
   
   - CPU를 쓰러 들어와서 얼마나 쓰고 나갈지 미리 알 수가 없다. 실제 시스템에서 SJF를 사용하기 힘들다. (CPU 사용시간을 미리 알 수는 없지만 추정은 가능하다.)
   
   - Exponential average (추정하는 방법)
     
     - n+1사용 예측 시간 = a * n사용 실제 시간 + (1-a) * n사용 예측 시간
     
     - 0 <= a <= 1
     
     - 점화식을 쭉 풀어나가면...
     
     - 최근 CPU 사용량을 크게 반영하고 과거를 적게 반영하는 식으로 예측하는 것이다.





## Priority Scheduling (우선 순위 스케줄링)

**우선 순위가 제일 높은 프로세스에게 CPU를 할당**

우선 순위가 낮은 프로세스가 지나치게 오래 기다려서 영원히 CPU를 얻을 수 없는 상황이 있다.

이를 해결하기 위해 **Aging**을 도입 - 오래 기다리면 우선순위를 높여준다



## Round Robin (RR)

현대 CPU 사용 방식은 Round Robin에 기반하고 있다.

Primprive에 기반

**동일한 할당 시간을 세팅해서 CPU를 준다. 할당 시간이 끝나면 뒤로 가서 줄을 선다.**



- Response time이 빨라진다. 어떤 CPU든지 조금만 기다리면 Running이 된다.
  
  - CPU를 조금 쓰는 프로세스들이 빨리 쓰고 나갈 수도 있다.
    (현재 queue에 N개의 프로세스가 있다면 적어도 N * 할당시간 을 기다리면 차례가 돌아오게 된다.)

- CPU를 burst 시간과 waiting time이 비례함
  
  - CPU를 길게 쓰는 프로세스는 waiting time이 길고, CPU를 짧게 쓰는 프로세스는 waiting time이 찗다.



q large = FCFS(비효율)

q short = context switch (overhead)가 빈번히 발생

적당한 시간을 찾는게 중요



SJF보다 waiting, turnaround time은 길어지지만, response time은 짧아진다.






