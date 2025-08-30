#import "@preview/fuzzy-cnoi-statement:0.2.0": *

#show: init

#new-problem(
    (
    name: "圆格染色",            // 题目名
    name-en: "color",           // 英文题目名，同时也是目录
    time-limit: "1.0 秒",       // 每个测试点时限（会显示为 $1.0$ 秒）
    memory-limit: "512 MiB",    // 内存限制（显示同上）
    test-case-count: "10",      // 测试点数目（显示同上）
    test-case-equal: "是",      // 测试点是否等分
    year: "2023",               // 你可以添加自定义的属性
  )
)


== 题目描述

输入两个正整数 $a, b$，输出它们的和。

你可以*强调一段带 $f+or+mu+l+a$ 的文本*。用 `#underline` 加 ``` `` ``` 来实现 #underline[`underlined raw text`]。
+ 第一点
+ 第二点

- 第一点
  - 列表可以嵌套
  - 但目前，有序列表和无序列表的互相嵌套会有缩进上的问题。
- 第二点
  - 第二点的第一点
  - 第二点的第二点


== 输入格式

从文件 #current-filename("in") 中读入数据。// 自动获取当前题目的输入文件名

输入的第一行包含两个正整数 $a, b$，表示需要求和的两个数。

== 输出格式

输出到文件 #filename[color.out] 中。

输出一行一个整数，表示 $a+b$。

== 样例1输入
// 从文件中读取样例
#raw(read("../color1.in"), block: true)

== 样例1输出
// 或者直接写在文档中
```text
13
```

== 样例1解释

#figure(caption: "凹包")[#image("../fig.png", width: 40%)]<aobao>

如@aobao，这是一个凹包。

#for (i,case) in range(2, 8).zip((
  $1 tilde 5$,
  $6 tilde 9$,
  $10 tilde 13$,
  $14 tilde 17$,
  $18 tilde 19$,
  $20$)){[
== 样例#{i+2}
见选手目录下的 #current-sample-filename(i, "in") 与 #current-sample-filename(i, "ans")。

这个样例满足测试点 #case 的条件限制。
]}

== 数据范围

对于所有测试数据保证：$1 <= a,b <= 10^9$。

#figure(
  table(
    columns: 4,
    ..data-constraints-table-args, // 默认的针对数据范围的三线表样式
    table.header(
    [测试点编号],   $n,m <=$,                      $q<=$,                          [特殊性质],
    ),
    $1 tilde 5$,   $300$,                         $300$,                          table.cell(rowspan:2)[无],
    $6 tilde 9$,   table.cell(rowspan:4)[$10^5$], $2000$,
    $10 tilde 13$,                                table.cell(rowspan:4)[$10^5$],  [A],
    $14 tilde 17$,                                                                [B],
    $18 tilde 19$,                                                                table.cell(rowspan:2)[无],
    $20$,          $10^9$,
  )
)

特殊性质 A: 你可以像上面这样创建复杂的表格。
