#import "@preview/cetz:0.5.2"

#show heading: set align(center)

#let hatch-circle(r, spacing: 0.3, stroke: 0.55pt + luma(140)) = {
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

= Unknown topic
== A Körrel Kapcsolatos Ismeretek Bővítése

\

// "Kör" definition
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

    circle((0, 0), radius: 2.5pt, fill: black)
    content((0, 0), [ $O$ ], anchor: "north-east", padding: 0.1)

    line((0, 0), p, stroke: 1.2pt + blue)

    content(((0, 0), 50%, p), [ $r$ ], anchor: "south-east", padding: 0.1)

    circle(p, radius: 2.5pt, fill: black)
    content(p, [ $P$ ], anchor: "south-west", padding: 0.1)

    content("c.south", [ *OP = r* ], anchor: "north", padding: 0.25)
  }),
)

\

// Types of "kör"
#grid(
  columns: (1fr, 1fr),
  align: center + horizon,
  gutter: 2em,

  cetz.canvas({
    import cetz.draw: *

    let r-val = 2.2

    hatch-circle(r-val)

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    content("c.north", text(size: 1.35em)[ *Zárt körlap* ], anchor: "south", padding: 0.25)
    content("c.south", text(size: 1.15em)[ $"OP" <= "r"$ ], anchor: "north", padding: 0.25)
  }),

  cetz.canvas({
    import cetz.draw: *

    let r-val = 2.2

    hatch-circle(r-val)

    circle((0, 0), radius: r-val, stroke: (dash: "dashed", paint: luma(50), thickness: 1pt), name: "c")

    content("c.north", text(size: 1.35em)[ *Nyílt körlap* ], anchor: "south", padding: 0.25)
    content("c.south", text(size: 1.15em)[ $"OP" < "r"$ ], anchor: "north", padding: 0.25)
  }),
)
