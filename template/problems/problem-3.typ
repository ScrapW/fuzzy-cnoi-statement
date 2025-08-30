#import "@preview/fuzzy-cnoi-statement:0.2.0": *

#show: init

#new-problem(
    (
    name: "深搜",
    name-en: "dfs",
    type: "提交答案型",
    executable: [无],
    input: [`dfs`$1~10$`.in`],   // 输入文件名
    output: [`dfs`$1~10$`.out`], // 输出文件名
    test-case-count: "10",
    test-case-equal: "是",
    submit-file-name: [`dfs`$1~10$`.out`],
  )
)

== 题目描述
#lorem(50)

== 输入格式
从文件 #filename[dfs$1~10$.in] 中读入数据。

#lorem(50)

== 输出格式
输出到文件 #filename[dfs$1~10$.out] 中。

#lorem(50)

== 数据范围
对于所有测试数据保证：$1 <= n <= 10^5$。
