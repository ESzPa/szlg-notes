#import "@preview/cetz:0.5.2"
#import "config.typ": setup

#show: doc => setup(
  title: "A Körrel Kapcsolatos Ismeretek Bővítése",
  subtitle: "A Körrel Kapcsolatos Ismeretek Bővítése",
  doc,
)

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

  text(size: 1.25em)[
    *Középponti szög $(alpha)$:*\
    egy szög amelynek a csúcsa egy adott kör középpontja\
    \
    *Kerületi szög $(beta)$:*\
    egy szög, amelynek csúcsa a körvonal egy pontja, szárai pedig illeszkednek:
    1. a kör két húrjára, vagy
    2. a kör egy húrjára és egy érintőjére.
  ],

  cetz.canvas({
    import cetz.draw: *

    let r-val = 3
    let pos-angle = 300deg
    let angle = 35deg

    let start-a = pos-angle - angle
    let stop-a = pos-angle + angle

    let p_1 = (r-val * calc.cos(start-a), r-val * calc.sin(start-a))
    let p_2 = (r-val * calc.cos(stop-a), r-val * calc.sin(stop-a))
    let p_3 = (r-val * calc.cos(pos-angle + 180deg), r-val * calc.sin(pos-angle + 180deg))

    let p_4 = p_1

    let tan-dir = start-a + 90deg - 360deg
    let chord-dir = 30deg
    let mid-purple = (tan-dir + chord-dir) / 2

    let p_5_forward = (p_4.at(0) + 2.2 * calc.cos(tan-dir), p_4.at(1) + 2.2 * calc.sin(tan-dir))
    let p_5_back = (p_4.at(0) - 1.2 * calc.cos(tan-dir), p_4.at(1) - 1.2 * calc.sin(tan-dir))

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    arc(
      (0, 0),
      start: start-a,
      stop: stop-a,
      radius: r-val,
      anchor: "origin",
      stroke: 1.2pt + red,
    )

    arc(
      (0, 0),
      start: start-a,
      stop: stop-a,
      radius: 1.1,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (0.7 * calc.cos(pos-angle), 0.7 * calc.sin(pos-angle)),
      [ *$alpha$* ],
    )

    arc(
      p_3,
      start: pos-angle - angle / 2,
      stop: pos-angle + angle / 2,
      radius: 1.5,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + green.darken(20%),
      fill: green.lighten(85%),
    )
    content(
      (
        p_3.at(0) + 1.1 * calc.cos(pos-angle),
        p_3.at(1) + 1.1 * calc.sin(pos-angle),
      ),
      [ *$beta$* ],
    )

    arc(
      p_4,
      start: tan-dir,
      stop: chord-dir,
      radius: 1.2,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + purple,
      fill: purple.lighten(85%),
    )
    content(
      (
        p_4.at(0) + 0.8 * calc.cos(mid-purple),
        p_4.at(1) + 0.8 * calc.sin(mid-purple),
      ),
      [ *$beta$* ],
    )

    line((0, 0), p_1, stroke: 1.2pt + blue)
    line((0, 0), p_2, stroke: 1.2pt + blue)
    line(p_3, p_1, stroke: 1.2pt + green.darken(20%))
    line(p_3, p_2, stroke: 1.2pt + green.darken(20%))
    line(p_4, p_2, stroke: 1.2pt + purple)
    line(p_5_back, p_5_forward, stroke: 1.2pt + purple)

    circle((0, 0), radius: 2.5pt, fill: black)
    circle(p_1, radius: 2.5pt, fill: blue)
    circle(p_2, radius: 2.5pt, fill: blue)
    circle(p_3, radius: 2.5pt, fill: green.darken(20%))
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
    circle(p-small, radius: 2.5pt, fill: blue)
    circle(p-big, radius: 2.5pt, fill: blue)

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

=== Thálész-tétel, és megfordítása
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  gutter: 1em,

  text(size: 1.25em)[
    *Tétel:*\
    Ha egy kör valamely átmérőjének két végpontját összekötjük a kör bármely más pontjával akkor derékszögű háromszöget kapunk, amelynek átfogója a kör átmérője\

    *Megfordítása:*\
    Derékszögű háromszög köré írt körének középpontja, az átfogó felezőpontja
  ],

  cetz.canvas({
    import cetz.draw: *

    let r-val = 3

    let p_1 = (r-val * calc.cos(0deg), r-val * calc.sin(0deg))
    let p_2 = (r-val * calc.cos(180deg), r-val * calc.sin(180deg))

    let p_3 = (r-val * calc.cos(50deg), r-val * calc.sin(50deg))
    let p_4 = (r-val * calc.cos(140deg), r-val * calc.sin(140deg))

    let a3_start = calc.atan2(p_2.at(0) - p_3.at(0), p_2.at(1) - p_3.at(1))
    let a3_stop = calc.atan2(p_1.at(0) - p_3.at(0), p_1.at(1) - p_3.at(1))
    let a3_mid = (a3_start + a3_stop) / 2

    let a4_start = calc.atan2(p_2.at(0) - p_4.at(0), p_2.at(1) - p_4.at(1))
    let a4_stop = calc.atan2(p_1.at(0) - p_4.at(0), p_1.at(1) - p_4.at(1))
    let a4_mid = (a4_start + a4_stop) / 2

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    arc(
      p_3,
      start: a3_start,
      stop: a3_stop,
      radius: 1,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_3.at(0) + 0.55 * calc.cos(a3_mid),
        p_3.at(1) + 0.55 * calc.sin(a3_mid),
      ),
      [ $90 degree$ ],
    )

    arc(
      p_4,
      start: a4_start,
      stop: a4_stop,
      radius: 1,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + green.darken(20%),
      fill: green.lighten(85%),
    )
    content(
      (
        p_4.at(0) + 0.55 * calc.cos(a4_mid),
        p_4.at(1) + 0.55 * calc.sin(a4_mid),
      ),
      [ $90 degree$ ],
    )

    line(p_1, p_2, stroke: 1.2pt)

    line(p_3, p_1, stroke: 1.2pt + blue)
    line(p_3, p_2, stroke: 1.2pt + blue)

    line(p_4, p_1, stroke: 1.2pt + green.darken(20%))
    line(p_4, p_2, stroke: 1.2pt + green.darken(20%))

    circle((0, 0), radius: 2.5pt, fill: black)
    content((0, 0), [ $O$ ], anchor: "north-east", padding: 0.15)

    circle(p_1, radius: 2.5pt, fill: black)
    circle(p_2, radius: 2.5pt, fill: black)

    circle(p_3, radius: 2.5pt, fill: blue, stroke: 0.5pt + black)
    circle(p_4, radius: 2.5pt, fill: green.darken(20%), stroke: 0.5pt + black)
  }),
)

=== Kerületi és középponti szögek tétele, és következménye
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  gutter: 1em,

  text(size: 1.25em)[
    *Tétel:*\
    Adott körben adott ívhez tartozó bármely kerületi szög nagysága fele az ugyanazon ívhez tartozó középponti szög nagyságának\

    *Következménye:*\
    Adott kör adott ívéhez tartozó kerületi szögek nagysága megegyezik
  ],

  cetz.canvas({
    import cetz.draw: *

    let r-val = 3
    let pos-angle = 300deg
    let angle = 35deg

    let start-a = pos-angle - angle
    let stop-a = pos-angle + angle

    let p_1 = (r-val * calc.cos(start-a), r-val * calc.sin(start-a))
    let p_2 = (r-val * calc.cos(stop-a), r-val * calc.sin(stop-a))
    let p_3 = (r-val * calc.cos(pos-angle + 180deg), r-val * calc.sin(pos-angle + 180deg))

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")
    content("c.south", text(size: 1.15em)[ $alpha = 2 beta$ ], anchor: "north", padding: 0.25)

    arc(
      (0, 0),
      start: start-a,
      stop: stop-a,
      radius: r-val,
      anchor: "origin",
      stroke: 1.2pt + red,
    )

    arc(
      (0, 0),
      start: start-a,
      stop: stop-a,
      radius: 1.1,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (0.7 * calc.cos(pos-angle), 0.7 * calc.sin(pos-angle)),
      [ *$alpha$* ],
    )

    arc(
      p_3,
      start: pos-angle - angle / 2,
      stop: pos-angle + angle / 2,
      radius: 1.5,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + green.darken(20%),
      fill: green.lighten(85%),
    )
    content(
      (
        p_3.at(0) + 1.1 * calc.cos(pos-angle),
        p_3.at(1) + 1.1 * calc.sin(pos-angle),
      ),
      [ *$beta$* ],
    )

    line((0, 0), p_1, stroke: 1.2pt + blue)
    line((0, 0), p_2, stroke: 1.2pt + blue)
    line(p_3, p_1, stroke: 1.2pt + green.darken(20%))
    line(p_3, p_2, stroke: 1.2pt + green.darken(20%))

    circle((0, 0), radius: 2.5pt, fill: black)
    circle(p_1, radius: 2.5pt, fill: blue)
    circle(p_2, radius: 2.5pt, fill: blue)
    circle(p_3, radius: 2.5pt, fill: green.darken(20%))
  }),
)
