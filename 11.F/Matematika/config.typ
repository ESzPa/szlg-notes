#let setup(title: none, subtitle: none, doc) = [
  #set page(
    width: 18cm,
    height: auto,
    margin: (x: 1cm, y: 1cm),
  )

  #show heading.where(level: 1): set align(center)
  #show heading.where(level: 2): set align(center)
  #show heading.where(level: 3): it => block(above: 3em, below: 1.2em)[
    #set text(size: 1.2em)
    #underline(it.body)
  ]

  = #title
  == #subtitle

  #doc
]
