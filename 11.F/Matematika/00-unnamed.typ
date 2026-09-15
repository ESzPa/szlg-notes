#import "@preview/cetz:0.5.2"

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

#let make-hatch-circle(r, spacing: 0.3, stroke: 0.55pt + luma(140)) = {
  import cetz.draw: line
  let max-d = calc.sqrt(2) * r
  let d = -max-d + spacing
  while d < max-d {
    let disc = 2 * calc.pow(r, 2) - calc.pow(d, 2)
    if disc > 0 {
      let sq = calc.sqrt(disc)
      line(
        ((-d - sq) / 2, (d - sq) / 2),
        ((-d + sq) / 2, (d + sq) / 2),
        stroke: stroke,
      )
    }
    d += spacing
  }
}

= A Körrel Kapcsolatos Ismeretek Bővítése
== A Körrel Kapcsolatos Ismeretek Bővítése

=== Definíciók
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  gutter: 1em,

  text(size: 1.25em)[
    *Kör / Körvonal:*\
    azon pontok halmaza a síkon,
    amelyek a sík egy adott pontjától adott távolságra vannak
  ],

  cetz.canvas({
    import cetz.draw: *

    let angle = 30deg
    let r-val = 3
    let p = (r-val * calc.cos(angle), r-val * calc.sin(angle))

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    content((0, 0), [ $O$ ], anchor: "north-east", padding: 0.1)

    line((0, 0), p, stroke: 1.2pt + blue)

    content(((0, 0), 50%, p), [ $r$ ], anchor: "south-east", padding: 0.1)

    circle((0, 0), radius: 2.5pt, fill: black)

    circle(p, radius: 2.5pt, fill: black)
    content(p, [ $P$ ], anchor: "south-west", padding: 0.1)

    content("c.south", text(size: 1.15em)[ $"OP" = "r"$ ], anchor: "north", padding: 0.25)
  }),
)

=== Kör típusai
#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  gutter: 2em,

  cetz.canvas({
    import cetz.draw: *

    let r-val = 2.2

    make-hatch-circle(r-val)

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    content("c.north", text(size: 1.35em)[ *Zárt körlap* ], anchor: "south", padding: 0.25)
    content("c.south", text(size: 1.15em)[ $"OP" <= "r"$ ], anchor: "north", padding: 0.25)
  }),

  cetz.canvas({
    import cetz.draw: *

    let r-val = 2.2

    make-hatch-circle(r-val)

    circle((0, 0), radius: r-val, stroke: (dash: "dashed", paint: luma(50), thickness: 1pt), name: "c")

    content("c.north", text(size: 1.35em)[ *Nyílt körlap* ], anchor: "south", padding: 0.25)
    content("c.south", text(size: 1.15em)[ $"OP" < "r"$ ], anchor: "north", padding: 0.25)
  }),
)

=== Tétel
#cetz.canvas({
  import cetz.draw: *

  let r-val = 2.2
  let angle = 50deg
  let e_1 = (r-val * calc.cos(angle), r-val * calc.sin(angle))
  let e_2 = (r-val * calc.cos(angle), -r-val * calc.sin(angle))

  circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

  line(e_1, (r-val + 3, 0), stroke: 1.2pt + blue)
  line(e_2, (r-val + 3, 0), stroke: 1.2pt + blue)

  circle((r-val + 3, 0), radius: 2.5pt, fill: black)
  circle((0, 0), radius: 2.5pt, fill: black)
  circle(e_1, radius: 2.5pt, fill: blue)
  circle(e_2, radius: 2.5pt, fill: blue)

  content((0, 0), [ $O$ ], anchor: "south-west", padding: 0.25)
  content(e_1, [ $E_1$ ], anchor: "south-west", padding: 0.25)
  content(e_2, [ $E_2$ ], anchor: "north-west", padding: 0.25)
  content((r-val + 3, 0), [ $P$ ], anchor: "south-west", padding: 0.25)

  content(
    "c.south",
    text(size: 1.2em)[ Egy körhöz külső pontból húzott\ érintő szakaszok hossza megegyezik ],
    anchor: "north",
    padding: 1,
  )

  content(
    "c.west",
    text(size: 1.2em)[ $"PE"_1 = "PE"_2$ ],
    anchor: "east",
    padding: 0.7,
  )
})

=== Koncentrikus körök
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let r-val-small = 2.2
    let r-val-big = 4

    let angle-small = -60deg
    let angle-big = -20deg

    let p-small = (r-val-small * calc.cos(angle-small), r-val-small * calc.sin(angle-small))
    let p-big = (r-val-big * calc.cos(angle-big), r-val-big * calc.sin(angle-big))

    make-hatch-circle(r-val-big)

    circle((0, 0), radius: r-val-big, stroke: 1pt + luma(50), name: "c")
    circle((0, 0), radius: r-val-small, fill: white, stroke: 1pt + luma(50))

    line((0, 0), p-small, stroke: 1pt + blue)
    line((0, 0), p-big, stroke: 1pt + blue)

    line((5.2, 3.8), (2.1, 2.1), stroke: 1.1pt + blue, mark: (end: ">"))
    content((5.3, 3.9), [ Körgyűrű ], anchor: "west")

    circle((0, 0), radius: 2.5pt, fill: black)
    circle(p-small, radius: 2.5pt, fill: black)
    circle(p-big, radius: 2.5pt, fill: black)

    content((0, 0), [ $O$ ], anchor: "south-west", padding: 0.25)
    content(((0, 0), 50%, p-small), [ $r$ ], anchor: "east", padding: 0.25)
    content(((0, 0), 45%, p-big), [ $R$ ], anchor: "south", padding: 0.25)

    content(
      "c.south",
      text(size: 1.25em)[ $
        "T"_"körgyűrű" & = "T"_"N" - "T"_"K" \
                       & = pi "R"^"2" - pi "r"^"2" \
                       & = pi ( "R"^"2" - "r"^"2" )
      $ ],
      anchor: "north",
      padding: 0.75,
    )
  })
]

=== Kör és Egyenes kölcsönös helyzete
#grid(
  columns: (1fr, 1fr, 1fr),
  align: center + horizon,
  gutter: 1.5em,

  cetz.canvas({
    import cetz.draw: *
    let r = 1.8

    circle((0, 0), radius: r, stroke: 1pt + luma(50), name: "c")
    circle((0, 0), radius: 2.5pt, fill: black)
    content((0, 0), [ $O$ ], anchor: "north-east", padding: 0.15)

    line((-2.5, 2.4), (2.5, 2.4), stroke: 1.2pt + blue)
    content((2.5, 2.4), [ $e$ ], anchor: "west", padding: 0.15)
  }),

  cetz.canvas({
    import cetz.draw: *
    let r = 1.8
    let y = 0.8
    let x = calc.sqrt(r * r - y * y)

    circle((0, 0), radius: r, stroke: 1pt + luma(50), name: "c")
    circle((0, 0), radius: 2.5pt, fill: black)
    content((0, 0), [ $O$ ], anchor: "north-east", padding: 0.15)

    line((-2.5, y), (2.5, y), stroke: 1.2pt + blue)
    content((2.5, y), [ $e$ ], anchor: "west", padding: 0.15)

    circle((-x, y), radius: 2.5pt, fill: blue)
    circle((x, y), radius: 2.5pt, fill: blue)
  }),

  cetz.canvas({
    import cetz.draw: *
    let r = 1.8

    circle((0, 0), radius: r, stroke: 1pt + luma(50), name: "c")
    circle((0, 0), radius: 2.5pt, fill: black)
    content((0, 0), [ $O$ ], anchor: "north-east", padding: 0.15)

    line((-2.5, r), (2.5, r), stroke: 1.2pt + blue)
    content((2.5, r), [ $e$ ], anchor: "west", padding: 0.15)

    circle((0, r), radius: 2.5pt, fill: blue)
    content((0, r), [ $E$ ], anchor: "south-west", padding: 0.15)
  }),

  text(size: 1.05em)[
    *Kitérőek*\
    $d(o, e) > r$
  ],

  text(size: 1.05em)[
    *Metszőek*\
    $d(o, e) < r$
  ],

  text(size: 1.05em)[
    *Érintőek*\
    $d(o, e) = r$
  ],
)
