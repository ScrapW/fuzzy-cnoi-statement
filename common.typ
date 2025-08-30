// Typst template for making NOI-like problems
// Author: Wallbreaker5th
// MIT-0 License

#import "@preview/codelst:2.0.0": sourcecode

#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let default-fonts = (
  mono: "Consolas",
  serif: "New Computer Modern",
  cjk-serif: "FZShuSong-Z01S",
  cjk-sans: "FZHei-B01S",
  cjk-mono: "FZFangSong-Z02S",
  cjk-italic: "FZKai-Z03S",
)


#let empty-par = {
  par()[
    #v(0em, weak: true)
    #h(0em)
  ]
}

#let add-empty-par(it) = {
  it
  empty-par
}


#let default-problem-fullname(problem) = {
  if (problem.at("name", default: none) != none) {
    problem.name
    if (problem.at("name-en", default: none) != none) {
      "（" + problem.name-en + "）"
    }
  } else {
    problem.at("name-en", default: "")
  }
}

#let make-formula(s) = {
  let numbers = s.matches(regex("[\d.]+"))
  let last-end = 0
  for n in numbers {
    let start = n.start
    let end = n.end
    let number = n.text
    s.slice(last-end, start)
    math.equation(number)
    last-end = end
  }
  s.slice(last-end, s.len())
}
