#import "@preview/cetz:0.5.2"
#import "config.typ": setup

#show: doc => setup(
  title: "Geometria",
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

=== Látószög
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  gutter: 1em,

  text(size: 1.25em)[
    *Definíció:*\
    Adott a síkon egy $"AB"$ szakasz és egy $"P"$ pont, és ekkor azt mondjuk, hogy $"P"$ pontból az $"AB"$ szakasz $delta$ szög alatt látszik. Ez a $delta$ szög a látószög.
  ],

  cetz.canvas({
    import cetz.draw: *

    let p = (0, 0)

    let a_angle = 210deg
    let b_angle = 280deg

    let pa_len = 2.5
    let pb_len = 3

    let a = (pa_len * calc.cos(a_angle), pa_len * calc.sin(a_angle))
    let b = (pb_len * calc.cos(b_angle), pb_len * calc.sin(b_angle))

    arc(
      (0, 0),
      start: a_angle,
      stop: b_angle,
      radius: 1.1,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (0.7 * -calc.cos(b_angle - a_angle), 0.6 * -calc.sin(b_angle - a_angle)),
      [ *$alpha$* ],
    )

    line(a, b, stroke: 1.2pt)
    line(p, a, stroke: 1.2pt + blue)
    line(p, b, stroke: 1.2pt + blue)

    circle(p, radius: 2.5pt, fill: black)
    circle(a, radius: 2.5pt, fill: blue)
    circle(b, radius: 2.5pt, fill: blue)

    content(p, [ $P$ ], anchor: "south-west", padding: 0.15)
    content(a, [ $A$ ], anchor: "north-east", padding: 0.15)
    content(b, [ $B$ ], anchor: "north-west", padding: 0.15)
  }),
)

=== Korábbi tételek látószöges megfogalmazása
#grid(
  columns: (1fr, 1fr),
  align: (left + horizon, left + horizon),
  gutter: 1em,

  text(size: 1.25em)[
    *Thálész-tétel:*\
    Az $"AB"$ átmérőjű kör $"A"$-tól és $"B"$-től különböző pontjaiból az $"AB"$ átmérő derékszög alatt látszik.
  ],

  text(size: 1.25em)[
    *Kerületi szögek tétele:*\
    Egy adott kör adott $"AB"$ húrja az $"AB"$ ív belső pontjaiból ugyanakkora szög alatt látszik.
  ],
)

=== Látószögkörív _(látókörív)_
#grid(
  columns: (1fr, 1fr, 1fr),
  align: center + horizon,
  gutter: 1.5em,

  text(size: 1.15em)[
    $0 degree lt alpha lt 90 degree$
  ],

  text(size: 1.15em)[
    $alpha eq 90 degree$
  ],

  text(size: 1.15em)[
    $90 degree lt alpha lt 180 degree$
  ],

  cetz.canvas({
    import cetz.draw: *
    let r = 1.8
    let O = (0, 0)

    let inter_pct = .20
    let c1O = (O.at(0), r - r * inter_pct)
    let c2O = (O.at(0), -(r - r * inter_pct))

    let p_1_angle = 30deg
    let p_2_angle = 250deg

    let p_1 = (
      c1O.at(0) + r * calc.cos(p_1_angle),
      c1O.at(1) + r * calc.sin(p_1_angle),
    )
    let p_2 = (
      c2O.at(0) + r * calc.cos(p_2_angle),
      c2O.at(1) + r * calc.sin(p_2_angle),
    )

    let dy = r * (1 - inter_pct)
    let dx = calc.sqrt(calc.pow(r, 2) - calc.pow(dy, 2))
    let A = (-dx, 0)
    let B = (dx, 0)

    let p1_a_angle = calc.atan2(A.at(0) - p_1.at(0), A.at(1) - p_1.at(1))
    let p1_b_angle = calc.atan2(B.at(0) - p_1.at(0), B.at(1) - p_1.at(1))

    let p2_a_angle = calc.atan2(A.at(0) - p_2.at(0), A.at(1) - p_2.at(1))
    let p2_b_angle = calc.atan2(B.at(0) - p_2.at(0), B.at(1) - p_2.at(1))

    circle(c1O, radius: r, stroke: 1pt + luma(50), name: "c1")
    circle(c2O, radius: r, stroke: 1pt + luma(50), name: "c2")

    arc(
      p_1,
      start: p1_a_angle,
      stop: p1_b_angle,
      radius: 1.1,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_1.at(0) + 0.75 * calc.cos((p1_a_angle + p1_b_angle) / 2),
        p_1.at(1) + 0.75 * calc.sin((p1_a_angle + p1_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    arc(
      p_1,
      start: p1_a_angle,
      stop: p1_b_angle,
      radius: 1.2,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_1.at(0) + 0.8 * calc.cos((p1_a_angle + p1_b_angle) / 2),
        p_1.at(1) + 0.8 * calc.sin((p1_a_angle + p1_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    arc(
      p_2,
      start: p2_b_angle,
      stop: p2_a_angle,
      radius: 1.2,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_2.at(0) + 0.8 * calc.cos((p2_a_angle + p2_b_angle) / 2),
        p_2.at(1) + 0.8 * calc.sin((p2_a_angle + p2_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    line(A, B, stroke: 1.2pt)
    line(p_1, A, stroke: 1.2pt + blue)
    line(p_1, B, stroke: 1.2pt + blue)
    line(p_2, A, stroke: 1.2pt + blue)
    line(p_2, B, stroke: 1.2pt + blue)

    circle(A, radius: 2.5pt, fill: black)
    circle(B, radius: 2.5pt, fill: black)
    circle(p_1, radius: 2.5pt, fill: blue)
    circle(p_2, radius: 2.5pt, fill: blue)

    content(A, [ $A$ ], anchor: "east", padding: 0.35)
    content(B, [ $B$ ], anchor: "west", padding: 0.35)
  }),

  cetz.canvas({
    import cetz.draw: *

    let r = 1.8

    let p_1_angle = 125deg
    let p_2_angle = 320deg

    let p_1 = (r * calc.cos(p_1_angle), r * calc.sin(p_1_angle))
    let p_2 = (r * calc.cos(p_2_angle), r * calc.sin(p_2_angle))

    let A = (r * calc.cos(180deg), r * calc.sin(180deg))
    let B = (r * calc.cos(0deg), r * calc.sin(0deg))

    let p1_a_angle = calc.atan2(A.at(0) - p_1.at(0), A.at(1) - p_1.at(1))
    let p1_b_angle = calc.atan2(B.at(0) - p_1.at(0), B.at(1) - p_1.at(1))

    let p2_a_angle = calc.atan2(A.at(0) - p_2.at(0), A.at(1) - p_2.at(1))
    let p2_b_angle = calc.atan2(B.at(0) - p_2.at(0), B.at(1) - p_2.at(1))

    circle((0, 0), radius: r, stroke: 1pt + luma(50), name: "c")

    arc(
      p_1,
      start: p1_a_angle,
      stop: p1_b_angle,
      radius: 0.8,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_1.at(0) + 0.45 * calc.cos((p1_a_angle + p1_b_angle) / 2),
        p_1.at(1) + 0.45 * calc.sin((p1_a_angle + p1_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    arc(
      p_2,
      start: p2_b_angle,
      stop: p2_a_angle,
      radius: 0.8,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_2.at(0) + 0.45 * calc.cos((p2_a_angle + p2_b_angle) / 2),
        p_2.at(1) + 0.45 * calc.sin((p2_a_angle + p2_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    line(A, B, stroke: 1.2pt)
    line(p_1, A, stroke: 1.2pt + blue)
    line(p_1, B, stroke: 1.2pt + blue)
    line(p_2, A, stroke: 1.2pt + blue)
    line(p_2, B, stroke: 1.2pt + blue)

    circle(A, radius: 2.5pt, fill: black)
    circle(B, radius: 2.5pt, fill: black)
    circle(p_1, radius: 2.5pt, fill: blue)
    circle(p_2, radius: 2.5pt, fill: blue)

    content(A, [ $A$ ], anchor: "east", padding: 0.25)
    content(B, [ $B$ ], anchor: "west", padding: 0.25)
  }),

  cetz.canvas({
    import cetz.draw: *
    let r = 1.8
    let O = (0, 0)

    let inter_pct = .55
    let c1O = (O.at(0), r - r * inter_pct)
    let c2O = (O.at(0), -(r - r * inter_pct))

    let dy = r * (1 - inter_pct)
    let dx = calc.sqrt(calc.pow(r, 2) - calc.pow(dy, 2))
    let A = (-dx, 0)
    let B = (dx, 0)

    let p_1_angle = 295deg
    let p_2_angle = 110deg

    let p_1 = (
      c1O.at(0) + r * calc.cos(p_1_angle),
      c1O.at(1) + r * calc.sin(p_1_angle),
    )
    let p_2 = (
      c2O.at(0) + r * calc.cos(p_2_angle),
      c2O.at(1) + r * calc.sin(p_2_angle),
    )

    let p1_a_angle = calc.atan2(A.at(0) - p_1.at(0), A.at(1) - p_1.at(1))
    let p1_b_angle = calc.atan2(B.at(0) - p_1.at(0), B.at(1) - p_1.at(1))

    let p2_a_angle = calc.atan2(A.at(0) - p_2.at(0), A.at(1) - p_2.at(1))
    let p2_b_angle = calc.atan2(B.at(0) - p_2.at(0), B.at(1) - p_2.at(1))

    circle(c1O, radius: r, stroke: 1pt + luma(50), name: "c1")
    circle(c2O, radius: r, stroke: 1pt + luma(50), name: "c2")

    arc(
      p_1,
      start: p1_a_angle,
      stop: p1_b_angle,
      radius: 0.55,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_1.at(0) + 0.35 * calc.cos((p1_a_angle + p1_b_angle) / 2),
        p_1.at(1) + 0.35 * calc.sin((p1_a_angle + p1_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    arc(
      p_2,
      start: p2_b_angle,
      stop: p2_a_angle,
      radius: 0.55,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p_2.at(0) + 0.3 * calc.cos((p2_a_angle + p2_b_angle) / 2),
        p_2.at(1) + 0.3 * calc.sin((p2_a_angle + p2_b_angle) / 2),
      ),
      [ *$alpha$* ],
    )

    line(A, B, stroke: 1.2pt)
    line(p_1, A, stroke: 1.2pt + blue)
    line(p_1, B, stroke: 1.2pt + blue)
    line(p_2, A, stroke: 1.2pt + blue)
    line(p_2, B, stroke: 1.2pt + blue)

    circle(A, radius: 2.5pt, fill: black)
    circle(B, radius: 2.5pt, fill: black)
    circle(p_1, radius: 2.5pt, fill: blue)
    circle(p_2, radius: 2.5pt, fill: blue)

    content(A, [ $A$ ], anchor: "east", padding: 0.35)
    content(B, [ $B$ ], anchor: "west", padding: 0.35)
  }),
)

#text(size: 1.25em)[
  *Definíció:* \
  - Azon pontok mértani helye a síkon amelyekből egy adott szakasz, adott szögben látszik.
  - Szakasz végpontjai nincsenek az íven.
  - Ez az adott szakasz körívek közös húrja.
]

=== Húrnégyszögek
#grid(
  columns: (1fr, auto),
  align: (left + horizon, right + horizon),
  gutter: 1.2em,

  text(size: 1.25em)[
    *Definíció:* \
    1. Azokat a négyszögeket, amelyeknek van köré írt köre húrnégyszögeknek nevezzük.
    2. Azokat a négyszögeket amelyeknek oldalai egy kör húrjai húrnégyszögeknek nevezzük.
    *Tétel:* \
    - Bármely húrnégyszög  két szemközti szögének összege $180 degree$.
    *Megfordítása:* \
    - Ha egy négyszög két szemközti szögének összege $180 degree$, akkor a négyszög húrnégyszög.
    *Egyben:* \
    - Egy négyszög csakkor húrnégyszög, ha a szemközti szögeinek összege $180 degree$.
  ],

  cetz.canvas({
    import cetz.draw: *

    let r-val = 3

    let p1_angle = 10deg
    let p2_angle = 120deg
    let p3_angle = 190deg
    let p4_angle = 245deg

    let p1 = (r-val * calc.cos(p1_angle), r-val * calc.sin(p1_angle))
    let p2 = (r-val * calc.cos(p2_angle), r-val * calc.sin(p2_angle))
    let p3 = (r-val * calc.cos(p3_angle), r-val * calc.sin(p3_angle))
    let p4 = (r-val * calc.cos(p4_angle), r-val * calc.sin(p4_angle))

    let p1_start = calc.atan2(p2.at(0) - p1.at(0), p2.at(1) - p1.at(1))
    let p1_stop = calc.atan2(p4.at(0) - p1.at(0), p4.at(1) - p1.at(1))
    let p1_stop = if p1_stop < p1_start { p1_stop + 360deg } else { p1_stop }

    arc(
      p1,
      start: p1_start,
      stop: p1_stop,
      radius: 0.8,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p1.at(0) + 0.5 * calc.cos((p1_start + p1_stop) / 2),
        p1.at(1) + 0.5 * calc.sin((p1_start + p1_stop) / 2),
      ),
      [ *$gamma$* ],
    )

    let p3_start = calc.atan2(p4.at(0) - p3.at(0), p4.at(1) - p3.at(1))
    let p3_stop = calc.atan2(p2.at(0) - p3.at(0), p2.at(1) - p3.at(1))
    let p3_stop = if p3_stop < p3_start { p3_stop + 360deg } else { p3_stop }

    arc(
      p3,
      start: p3_start,
      stop: p3_stop,
      radius: 0.8,
      anchor: "origin",
      mode: "PIE",
      stroke: 1pt + blue,
      fill: blue.lighten(85%),
    )
    content(
      (
        p3.at(0) + 0.45 * calc.cos((p3_start + p3_stop) / 2),
        p3.at(1) + 0.45 * calc.sin((p3_start + p3_stop) / 2),
      ),
      [ *$beta$* ],
    )

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")
    circle((0, 0), radius: 2.5pt, fill: black)

    line((0, 0), p2, stroke: 1.2pt)
    line((0, 0), p4, stroke: 1.2pt)

    line(p1, p2, stroke: 1.2pt + blue)
    line(p2, p3, stroke: 1.2pt + blue)
    line(p3, p4, stroke: 1.2pt + blue)
    line(p4, p1, stroke: 1.2pt + blue)

    circle(p1, radius: 2.5pt, fill: blue)
    circle(p2, radius: 2.5pt, fill: blue)
    circle(p3, radius: 2.5pt, fill: blue)
    circle(p4, radius: 2.5pt, fill: blue)

    content("c.south", text(size: 1.15em)[ $beta + gamma eq 180 degree$ ], anchor: "north", padding: 0.25)
  }),
)

=== Érintő- és szelőszakaszok tétele
#move(dx: .5cm)[
  #text(size: 1.25em)[
    *Tétel:* \
    Egy külső pontból egy körhöz húzott érintőszakasz hossza mértani közepe az ugyanabból a pontból húzott tetszőleges szelő két szakaszának.
  ]
]

#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let r-val = 3
    let p3-dist = r-val + 2.5

    let p1_angle = 0deg
    let p2_angle = 180deg
    let p3_angle = 0deg
    let p4_angle = 60deg

    let p1 = (r-val * calc.cos(p1_angle), r-val * calc.sin(p1_angle))
    let p2 = (r-val * calc.cos(p2_angle), r-val * calc.sin(p2_angle))
    let p3 = (p3-dist * calc.cos(p3_angle), p3-dist * calc.sin(p3_angle))
    let p4 = (r-val * calc.cos(p4_angle), r-val * calc.sin(p4_angle))

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    line(p2, p3, stroke: 1.2pt + blue)
    line(p4, p3, stroke: 1.2pt + blue)

    circle((0, 0), radius: 2.5pt, fill: black)
    circle(p1, radius: 2.5pt, fill: blue)
    circle(p2, radius: 2.5pt, fill: blue)
    circle(p3, radius: 2.5pt, fill: black)
    circle(p4, radius: 2.5pt, fill: blue)

    content(
      "c.south",
      text(size: 1.15em)[ $
        & "PE"^2 eq "PA" dot "PB" \
        & "PE" eq sqrt("PA" dot "PB")
      $ ],
      anchor: "north",
      padding: 0.25,
    )
    content(p1, [ $A$ ], anchor: "north-west", padding: 0.2)
    content(p2, [ $B$ ], anchor: "north-east", padding: 0.2)
    content(p3, [ $P$ ], anchor: "south-west", padding: 0.2)
    content(p4, [ $E$ ], anchor: "south-west", padding: 0.2)
    content((0, 0), [ $O$ ], anchor: "south", padding: 0.3)
  })
]

=== Ptomaiosz-tétel
#align(center)[
  #cetz.canvas({
    import cetz.draw: *

    let r-val = 3

    let p1_angle = 75deg
    let p2_angle = 150deg
    let p3_angle = 225deg
    let p4_angle = 325deg

    let p1 = (r-val * calc.cos(p1_angle), r-val * calc.sin(p1_angle))
    let p2 = (r-val * calc.cos(p2_angle), r-val * calc.sin(p2_angle))
    let p3 = (r-val * calc.cos(p3_angle), r-val * calc.sin(p3_angle))
    let p4 = (r-val * calc.cos(p4_angle), r-val * calc.sin(p4_angle))

    circle((0, 0), radius: r-val, stroke: 1pt + luma(50), name: "c")

    line(p1, p2, stroke: 1.2pt + blue, name: "c-side")
    line(p2, p3, stroke: 1.2pt + blue, name: "d-side")
    line(p3, p4, stroke: 1.2pt + blue, name: "a-side")
    line(p4, p1, stroke: 1.2pt + blue, name: "b-side")
    line(p1, p3, stroke: 1.2pt + green.darken(20%))
    line(p2, p4, stroke: 1.2pt + green.darken(20%))

    circle(p1, radius: 2.5pt, fill: blue)
    circle(p2, radius: 2.5pt, fill: blue)
    circle(p3, radius: 2.5pt, fill: blue)
    circle(p4, radius: 2.5pt, fill: blue)

    content(
      "c.south",
      text(size: 1.15em)[ $
        "ef" eq "a" dot "c" plus "b" dot "d"
      $ ],
      anchor: "north",
      padding: 0.25,
    )
    content("a-side", [ $a$ ], anchor: "north", padding: 0.25)
    content("b-side", [ $b$ ], anchor: "west", padding: 0.25)
    content("c-side", [ $c$ ], anchor: "south", padding: 0.25)
    content("d-side", [ $d$ ], anchor: "east", padding: 0.25)
    content((p1, 30%, p3), [ $f$ ], anchor: "west", padding: 0.25)
    content((p2, 60%, p4), [ $e$ ], anchor: "south-west", padding: 0.2)
  })
]
