#import "@preview/fuzzy-cnoi-statement:0.2.0": *

#show: init

#new-problem((
    name: "桂花树",
    name-en: "tree",
    type: "交互型",             // 题目类型
    time-limit: "0.5 秒",
    memory-limit: "512 MiB",
    test-case-count: "10",
    test-case-equal: "是",
    year: "2023",
    // submit-file-name 为提交文件名，可以为 str、content 或一个 extension:str=>content 的函数
    // submit-file-name: e => {
    //   show raw: set text(size: 0.8em)
    //   raw("tree." + e)
    // } // 将其字体变小
  ))

*这是一道交互题。*

== 题目描述
#lorem(50)

== 实现细节
请确保你的程序开头有 `#include "tree.h"`。

```cpp
int query(int x, int y);
void answer(std::vector<int> ans);
```

```bash
g++ count.cpp -c -O2 -std=c++14 -lm && g++ count.o grader.o -o count
```

我能吞下玻璃而不伤身体。

- 赵钱孙李周吴郑王，冯陈楮卫蒋沈韩：
  - 杨朱秦尤许何吕施张孔。
    - 曹严华金魏陶姜戚谢。
  - 邹喻柏水窦章云苏潘葛奚。
- 范彭郎鲁韦昌马苗凤花，方俞任袁柳酆鲍史唐费廉岑薛雷。
- 贺倪汤滕殷罗毕郝邬安常乐于时傅皮卞齐康伍余，元卜顾孟平黄和穆萧尹姚邵湛汪，祁毛禹狄米贝明臧计伏成戴。

== 评分标准
#lorem(50)

#lorem(100)

== 数据范围
#lorem(50)
