// Typst template for making NOI-like problems
// Author: Wallbreaker5th
// MIT-0 License

#import "/common.typ": *

#let cnoi-initialized-state = state("cnoi-initialized", false)
#let contest-info-state = state("contest-info", ())
#let contest-fonts-state = state("fonts", default-fonts)
#let contest-header-state = state("header", [])
#let contest-footer-state = state("footer", [])
#let statement-page-begin-state = state("statement-page-begin", false)

#let new-problem(meta) = {
  [#metadata(meta)<cnoi-problem>]

  context if contest-info-state.get() == () {
    v(0pt)
  } else {
    pagebreak(weak: true)
  }

  statement-page-begin-state.update(true)
  heading(level: 1, default-problem-fullname(meta))
}

#let get-current-problem(here) = {
  let before-problem-metadata = query(selector(<cnoi-problem>).before(here))

  let idx = before-problem-metadata.len() - 1

  if (idx >= 0) { before-problem-metadata.last().value }
}

#let current-header = context {
  let current-problem = get-current-problem(here())
  let contest-info = contest-info-state.get()

  set par(first-line-indent: 0em)
  if (current-problem == none) {
    return
  }
  set text(size: 字号.五号)
  contest-info.name
  h(1fr)
  let round = contest-info.at("round", default: none)
  if (round != none) {
    round + " "
  }
  default-problem-fullname(current-problem)
  v(-2pt)
  line(length: 100%, stroke: 0.3pt)
}

#let current-footer = context {
  let current-problem = get-current-problem(here())
  let contest-info = contest-info-state.get()

  if (current-problem == none) {
    return
  }
  set text(size: 字号.五号)
  align(center, {
    [第]
    counter(page).display()
    [页]
    h(2em)
    [共]
    context {
      let cnt = counter(page).final().at(0)
      link((page: cnt, x: 0pt, y: 0pt), text(fill: rgb("#00f"), [#cnt]))
    }
    [页]
  })
}


#let contest-init(
  contest-info,
  custom-fonts: (:),
  header: current-header,
  footer: current-footer,
  body,
) = context {
  contest-info-state.update(contest-info)
  contest-fonts-state.update(default-fonts + custom-fonts)
  contest-header-state.update(header)
  contest-footer-state.update(footer)

  body
}



#let init(it) = context {
  if cnoi-initialized-state.get() == true {
    return it
  }

  let fonts = contest-fonts-state.get()
  let contest-info = contest-info-state.get()

  set text(
    font: (
      (
        name: fonts.serif,
        covers: "latin-in-cjk",
      ),
      fonts.cjk-serif,
    ),
    size: 字号.小四,
    lang: "zh",
    region: "CN",
  )
  show emph: set text(font: (
    (
      name: fonts.serif,
      covers: "latin-in-cjk",
    ),
    fonts.cjk-italic,
  ))
  show strong: st => {
    // Dotted strong text
    set text(font: (
      (
        name: fonts.serif,
        covers: "latin-in-cjk",
      ),
      fonts.cjk-sans,
    ))
    show regex("\p{sc=Hani}+"): s => {
      underline(s, offset: 3pt, stroke: (
        cap: "round",
        thickness: 0.1em,
        dash: (array: (0em, 1em), phase: 0.5em),
      ))
    }
    st
  }
  show raw: set text(
    font: (
      (
        name: fonts.mono,
        covers: "latin-in-cjk",
      ),
      fonts.cjk-mono,
    ),
    size: 字号.小四,
  )

  set list(indent: 1.75em, marker: ([•], [#h(-1em)•]))
  set enum(
    indent: 1.75em,
    numbering: x => {
      grid(
        columns: (0em, auto),
        align: bottom,
        hide[悲], numbering("1.", x),
      ) // As a workaround
    },
  )

  show heading: set text(
    font: (
      (
        name: fonts.serif,
        covers: "latin-in-cjk",
      ),
      fonts.cjk-sans,
    ),
    weight: 500,
  )
  show heading.where(level: 1): it => {
    set text(size: 字号.小二)
    set heading(bookmarked: true)
    pad(top: 8pt, align(center, it))
  }
  show heading.where(level: 2): it => {
    set text(size: 字号.小四)
    set heading(bookmarked: true)
    pad(left: 1.5em, top: 1em, bottom: .5em, [【] + box(it.body) + [】])
  }
  show raw.where(block: true): it => {
    show raw.line: it => {
      if (it.text == "" and it.number == it.count) {
        return
      }
      box(
        grid(
          columns: (0em, 1fr),
          align: (right, left),
          move(
            text(str(it.number), fill: gray, size: 0.8em),
            dx: -1em,
            dy: 0.1em,
          ),
          it.body,
        ),
      )
    }
    pad(
      rect(it, stroke: 0.5pt + rgb("#00f"), width: 100%, inset: (y: 0.7em)),
      left: 0.5em,
    )
  }

  let header = contest-header-state.get()
  let footer = contest-footer-state.get()

  // Page Layout
  set page(
    margin: 2.4cm,
    header: header,
    footer: context if (statement-page-begin-state.at(here())) {
      footer
    },
  )

  show table: pad.with(y: .5em)

  set par(first-line-indent: (amount: 2em, all: true), leading: 0.7em)
  // Looks right but I'm not sure about the exact value
  set par(spacing: 0.6em)

  cnoi-initialized-state.update(true)

  it
}

#let title() = context {
  let contest-info = contest-info-state.get()
  let fonts = contest-fonts-state.get()

  align(center, {
    text(contest-info.name, size: 字号.二号, font: (
      (
        name: fonts.serif,
        covers: "latin-in-cjk",
      ),
      fonts.cjk-sans,
    ))

    parbreak()
    v(10pt)

    let name-en = contest-info.at("name-en", default: none)
    if (name-en != none) {
      text(name-en, size: 字号.小一)
      parbreak()
      v(10pt)
    }


    let round = contest-info.at("round", default: none)
    if (round != none) {
      emph(text(round, size: 字号.二号))
      parbreak()
    }

    let author = contest-info.at("author", default: none)
    if (author != none) {
      text(author, size: 字号.小三, font: (
        (
          name: fonts.serif,
          covers: "latin-in-cjk",
        ),
        fonts.cjk-sans,
      ))
      parbreak()
      v(5pt)
    }

    let time = contest-info.at("time", default: none)
    if (time != none) {
      text(time, size: 字号.小三, font: (
        (
          name: fonts.serif,
          covers: "latin-in-cjk",
        ),
        fonts.cjk-sans,
      ))
    }
  })
}

#let generate-problem-list() = {
  let problem_list = ()
  let metadata_items = query(metadata)


  for (i, metadata) in metadata_items.enumerate() {
    problem_list.push(metadata.value)
  }

  problem_list
}

#let problem-table(
  extra-rows: (:),
  languages: (("C++", "cpp"),),
  compile-options: (("C++", "-O2 -std=c++14 -static"),),
) = context {
  let problem-list = generate-problem-list()

  let default-row = (
    wrap: text,
    always-display: false,
    default: "无",
  )
  let rows = (
    (
      name: (
        name: "题目名称",
        always-display: true,
      ),
      type: (
        name: "题目类型",
        always-display: true,
        default: "传统型",
      ),
      name-en: (
        name: "目录",
        wrap: raw,
        always-display: true,
      ),
      executable: (
        name: "可执行文件名",
        wrap: raw,
        always-display: true,
        default: x => x.name-en,
      ),
      input: (
        name: "输入文件名",
        wrap: raw,
        always-display: true,
        default: x => x.name-en + ".in",
      ),
      output: (
        name: "输出文件名",
        wrap: raw,
        always-display: true,
        default: x => x.name-en + ".out",
      ),
      time-limit: (
        name: "每个测试点时限",
        wrap: make-formula,
      ),
      memory-limit: (
        name: "内存限制",
        wrap: make-formula,
      ),
      test-case-count: (
        name: "测试点数目",
        default: "10",
        wrap: make-formula,
      ),
      subtask-count: (
        name: "子任务数目",
        default: "1",
      ),
      test-case-equal: (
        name: "测试点是否等分",
        default: "是",
      ),
    )
      + extra-rows
  )
  rows = rows
    .pairs()
    .map(
      row => (row.at(0), default-row + row.at(1)),
    )
  set table(align: bottom)
  let first-column-width = if (problem-list.len() <= 3) { 22% } else { 1fr }
  let columns = (first-column-width,) + (1fr,) * problem-list.len()
  table(
    columns: columns,
    stroke: 0.4pt,
    ..{
      rows
        .filter(row => {
          let (field, r) = row
          if (r.always-display) {
            true
          } else {
            problem-list.any(p => p.at(field, default: none) != none)
          }
        })
        .map(row => {
          let (field, r) = row
          (text(r.name),)
          problem-list.map(p => {
            let v = p.at(field, default: none)
            let w = if (v == none) {
              if (type(r.default) == str) {
                (r.wrap)(r.default)
              } else if (type(r.default) == function) {
                (r.wrap)((r.default)(p))
              } else if (type(r.default) == content) {
                (r.wrap)(r.default)
              }
            } else {
              v
            }

            if (type(w) == str) {
              (r.wrap)(w)
            } else {
              w
            }
          })
        })
        .flatten()
    }
  )

  [提交源程序文件名]
  table(
    columns: columns,
    stroke: 0.4pt,
    align: horizon,
    ..{
      languages
        .map(l => {
          if (l.len() == 2) {
            l += (1em,)
          }
          (text(size: l.at(2))[对于 #l.at(0) #h(1fr) 语言],)
          problem-list.map(p => {
            let v = p.at("submit-file-name", default: p.name-en + "." + l.at(1))
            if (type(v) == str) {
              raw(v)
            } else if (type(v) == function) {
              v(l.at(1))
            } else {
              v
            }
          })
        })
        .flatten()
    }
  )

  [编译选项]
  table(
    columns: columns,
    align: (left + bottom, center + bottom),
    stroke: 0.4pt,
    ..{
      compile-options
        .map(l => {
          if (l.len() == 2) {
            l += (1em,)
          }
          (
            text(size: l.at(2))[对于 #l.at(0) #h(1fr) 语言],
            table.cell(
              colspan: problem-list.len(),
              raw(l.at(1)),
            ),
          )
        })
        .flatten()
    }
  )
}


#let filename(it) = {
  set text(style: "italic", weight: "bold")
  it
}

#let current-filename(ext) = context {
  let problem = get-current-problem(here())
  filename(problem.at("name-en") + "." + ext)
}

#let current-sample-filename(idx, ext) = context {
  let problem = get-current-problem(here())
  filename(problem.at("name-en") + "/" + problem.at("name-en") + str(idx) + "." + ext)
}

#let data-constraints-table-args = {
  (
    stroke: (x, y) => (
      left: if (x > 0) { .4pt },
      bottom: 2pt,
      top: if (y == 0) { 2pt } else if (y == 1) { 1.2pt } else { .4pt },
    ),
    align: center + horizon,
  )
}
