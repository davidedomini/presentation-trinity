#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#import "@preview/fontawesome:0.5.0": *
#import "@preview/ctheorems:1.1.3": *
#import "@preview/numbly:0.1.0": numbly
#import "utils.typ": *

// Pdfpc configuration
// typst query --root . ./example.typ --field value --one "<pdfpc-file>" > ./example.pdfpc
#let pdfpc-config = pdfpc.config(
    duration-minutes: 30,
    start-time: datetime(hour: 14, minute: 10, second: 0),
    end-time: datetime(hour: 14, minute: 40, second: 0),
    last-minutes: 5,
    note-font-size: 12,
    disable-markdown: false,
    default-transition: (
      type: "push",
      duration-seconds: 2,
      angle: ltr,
      alignment: "vertical",
      direction: "inward",
    ),
  )

// Theorems configuration by ctheorems
#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox("theorem", "Theorem", fill: rgb("#eeffee"))
#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)
#let definition = thmbox("definition", "Definition", inset: (x: 1.2em, top: 1em))
#let example = thmplain("example", "Example").with(numbering: none)
#let proof = thmproof("proof", "Proof")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-common(
    // handout: true,
    preamble: pdfpc-config,
    show-bibliography-as-footnote: bibliography(title: none, "bibliography.bib"),
  ),
  config-info(
    title: [Many-Agent Cooperative Learning in Collective Adaptive
Systems],
    subtitle: [],
    author: author_list(
      (
        (first_author("Davide Domini"), "davide.domini@unibo.it"),
      ), logo: "images/disi.svg"
    ),
   // date: datetime(day: 31, month: 03, year: 2025).display("[day] [month repr:long] [year]"),
    // institution: [University of Bologna],
    // logo: align(right)[#image("images/disi.svg", width: 55%)],
  ),
)

#set text(font: "Fira Sans", weight: "light", size: 17pt)
#show math.equation: set text(font: "Fira Math")

#set raw(tab-size: 4)
// #show raw: set text(size: 0.85em)
#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: (x: 1em, y: 1em),
  radius: 0.7em,
  width: 100%,
)
#show raw.where(block: true): set text(size: 0.75em)

#show bibliography: set text(size: 0.75em)
#show footnote.entry: set text(size: 0.75em)

#set list(marker: box(height: 0.65em, align(horizon, text(size: 2em)[#sym.dot])))

#let emph(content) = text(weight: "bold", style: "italic", content)
#show link: set text(hyphenate: true)

// #set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

// == Outline <touying:hidden>

// #components.adaptive-columns(outline(title: none, indent: 1em))

== Who am I?

#components.side-by-side(columns: (1fr, 2fr), gutter: 0em)[
  #block(clip: true, radius: 50%, stroke: 0.5em + rgb("#eb811b5f"))[#figure(image("images/myself.jpg", width: 85%))]
][
  === Davide Domini

  - PhD Student at the _University of Bologna_ (Cesena)
  - Teaching Tutor on topics related to Software Engineering and Machine Learning
  - Researcher at the #emph[Pervasive Software Lab] \ #fa-globe() #h(0.4em) #text(blue)[#link("https://pslab-unibo.github.io")] (prof. Mirko Viroli)

  === Research Scope and Interests
  - Federated Learning and Reinforcement Learning
  - Macroprogramming languages for _collective adaptive systems_
  - Automated design for collective behaviors
  - Integration of #emph[AI] and #emph[ML] with collective programming paradigms
]

#focus-slide[
  Research Interests
]

== Scenarios of interest
#components.side-by-side(columns: (1fr, 1fr, 1fr))[
  #figure(image("images/smart-city.jpeg", height: 60%))
][
  #figure(image("images/crowd.jpeg", height: 60%))
][
  #figure(image("/images/drones.jpeg", height: 60%))
]

== Collective-Adaptive Systems

*Collective-adaptive Systems* #cite(label("DBLP:conf/birthday/BucchiaroneM19")) refers to systems with a _large number_ of entities interacting with each other in pursuing a #bold[collective] goal without a central coordinator.

  Actual _behaviour_ arises as an #alert[emergent] property of the system.

  #components.side-by-side[
    #figure(image("images/swarms.jpg", width: 75%))
  ][
    #figure(image("images/pedastrian.png", width: 100%))
  ][
    #figure(image("images/coldplay.jpg", width: 88%))
  ]


== Three Main Topics

#figure(image("/images/topics.svg", height: 40%))


= Reinforcement Learning

== Learning and Execution Strategies
#components.side-by-side(columns: (1fr, 1fr))[
  #align(center)[#text(size: 30pt)[=== CTDE]]
  #figure((image("images/CTDE.svg", width:90%)))
][
  #align(center)[#text(size: 30pt)[=== DTDE]]
  #figure((image("images/DTDE.svg", width:90%)))
]


== Motivation
#let research-block(title, items) = block(
  stroke: 2pt + gray.darken(20%),
  fill: rgb("#eb811b5f").lighten(50%),
  radius: 0em,
  inset: 1em,
  width: 100%,
  height: 30%
)[
  === #title
  #set text(size: 16pt)
  #items
]

#components.side-by-side(columns: (1fr, 1fr, 1fr))[
  #research-block("Key challenge in MARL", [
     Balancing #emph[scalability] and #emph[performance]
  ])
][
  #research-block("Limitations of CTDE", [
    Effective but suffers from #emph[computational bottlenecks] and #emph[scalability] issues
  ])
][
  #research-block("Limitations of DTDE", [
     Improves scalability but often #emph[ignores inter-agent coordination], leading to suboptimal performance
  ])
]
#components.side-by-side(columns: (1fr, 1fr, 1fr))[
  #only(2)[#research-block("Neighbor-based approaches", [
    Promising in tabular settings but largely #emph[unexplored] in deep reinforcement learning
  ])]
][
  #only(2)[#research-block("Contribution of this work", [
  Integrates #emph[deep learning] with #emph[neighbor-based strategies] 
  ])]
][
  #only(2)[#research-block("Goal", [
    Achieve both efficient #emph[decentralized learning] and #emph[effective coordination]
  ])]
]

== Importance of neighbors

#quote[Devices in #emph[spatial proximity] have #emph[similar experiences] and make #emph[similar observations], as the phenomena to capture are often intrinsically #emph[context dependent].#cite(label("esterle2022deep"))]

#only(2)[
 === Reference Scenarios
 - *Urban traffic prediction:* traffic patterns observed by devices within the same city district are likely to be more similar compared to those observed by devices in different districts
 - *Building heating management:* buildings in residential districts exhibit different heating patterns compared to those in industrial districts
]

// == K-nearest Neighbors Formalization

// Formally, we consider a #emph[weighted communication graph] $G = (N, E, W)$
//   - $N$ is the set of *agents*
//   - $E$ is the set of *edges* (i.e., communication link)
//   - $W: E #sym.arrow.r #sym.RR^+$ is a weight function assigning a *positive weight* to each edge

// #only(2)[
//   Let $d(i,j)$ denote the *shortest path* length between agents $i$ and $j$ in the weighted graph $G$
//   - The length of a path is the *sum of the weights* of the edges along the path
//   - If no path exists between $i$ and $j$, we set $d(i,j) = #sym.infinity$
//   - Then, the set of *k-nearest neighbors* of agent $i$ is defined as: 
//     - $N_(k)(i) = \{ j | i #sym.eq.not j, "rank"(d(i,j))#sym.lt.eq k \}$
// ]

== K-Nearest Neighbor Averaging

- Each agent maintains a *local Q-network* and shares its Q-values with its neighbors
- Each neighbor *average the received Q-values* and use the result to update its own Q-network
- Formally, the update rule for agent $i$ at time $t+1$ is:
  - $#sym.theta^(t+1)_i = #sym.theta^t_i + #sym.alpha #sym.sum _(j #sym.in N_(k)(i)) frac(1,k) #sym.theta^t_j$ 

== K-Nearest Neighbor Consensus

- This approach allows each agent to *learn independently* and periodically select the *best-performing agent within its neighborhood*
- Let $R^n_(i)(t)$ be the average reward obtained by agent $i$ over the last $n$ episodes
- At each time step $t$, each agent $i$ identifies the best-performing neighbor $#sym.beta$ within its k-neighborhood $N_(k)(i)$:
  - $#sym.beta = op("argmax", limits: #true)_(j #sym.in N_(k)(i)) R_(j)(t)^n$

- Agent $i$ then updates its Q-network parameters $#sym.theta _i$ using the parameters of the best-performing neighbor:

  - $#sym.theta^(t+1)_(i) #sym.arrow.l #sym.theta^(t+1)_(#sym.beta)$ 

== K-Nearest Neighbor Experience Sharing

- Each agent maintains *its own experience replay buffer*, but also *augments* it by collecting a fraction of each *neighbor’s buffer*
- This allows agents to learn from each other’s experiences
- Formally, we define:
  - $cal(D)_i^t$ the replay buffer of the agent $i$ at time $t$
  - $#sym.beta #sym.in #sym.NN^+$ the number of experiences to collect from each neighbor
  - $#sym.phi : cal(D) #sym.times #sym.NN^+ #sym.arrow.r cal(D)$ a function that extracts a subset of cardinality $k$ from a replay buffer $H$ 
  - The update rule for agent $i$ at time $t+1$ is: $cal(D)^(t+1)_i = cal(D)^t_i #sym.union #sym.union.big _(j #sym.in N_(k)(i)) #sym.phi (cal(D)^t_i, #sym.beta)$ 

== Evaluation: Simulation Scenario

- Multiple agents must *cooperate* to achieve a *common goal*
- It consists of a 2D Euclidean space populated by *A agents* and *T targets*, initially placed at random locations
- #emph[Goal:] agents must work together to *capture* all targets, resulting in a successful termination of the environment episode
- #emph[Reward composed by various factor:] collisions, time steps, moving towards items, moving away from agents

#figure((image("images/behavior.svg", width:40%)))


== Evaluation: Experimental Setup
- The environment was implemented using the #emph[Gymnasium framework]
- #emph[Libraries]: *Ray* (in particular,its module *RLlib*), and *PyTorch*
- #emph[Multiple learning algorithms:] totally centralized, totally distributed, MAPPO and the three neighbor-based strategies
- Each method was evaluated across *10 distinct random seeds*
- Each experiment consisted of *50 training episodes*
- #emph[Evaluation:] 5 different methods and for each method we varied the number of agents (8, 16 and 32)

== Evaluation: Metrics

#feature-block("Mean Episode Reward", [
  - For a certain episode $i$, composed of $n$ agents, last $T$ time steps, the total reward is calculated as: $R_i = #sym.sum^T_(t=0) #sym.sum^t_(j=1) r_j^t$
- The reward $R_("mean")$, for the all the episodes N, can be calculated as the *arithmetic mean* of the individual rewards per episode 
], icon: fa-award() + " ")

#feature-block("Mean Episode Length", [
- Represents the average number of time steps needed to *reaching the terminal state*
- $L_("mean") = frac(1,N) #sym.sum^N_(i=0) L_i$
], icon: fa-stopwatch-20() + " ")

// === Mean Episode Reward

// - For a certain episode $i$, composed of $n$ agents, last $T$ time steps, the total reward is calculated as: $R_i = #sym.sum^T_(t=0) #sym.sum^t_(j=1) r_j^t$
// - The reward $R_("mean")$, for the all the episodes N, can be calculated as the *arithmetic mean* of the individual rewards per episode 

// === Mean Episode Length
// - Represents the average number of time steps needed to reaching the terminal state
// - $L_("mean") = frac(1,N) #sym.sum^N_(i=0) L_i$


== Evaluation: Training Results

#components.side-by-side[
   #figure((image("images/episode_len_mean.jpg", width: 90%)))
][
  #figure((image("images/episode_reward_mean.jpg", width: 90%)))
]

= Macroprogramming

== Aggregate Computing

#underline[Aggregate computing] #cite(label("DBLP:journals/computer/BealPV15")) as a way to #bold[engineer] *collective-adaptive systems*.

#place(right, dx: -28em)[
  #line(start: (0em, 0em), end: (0em, 55%), stroke: 0.05em + rgb("#23373b"))
]

#v(1em)

#components.side-by-side(columns: (auto, 1fr), gutter: 2em)[
  #figure(image("images/channel.svg", height: 45%))
][
  #figure(image("images/ac.svg"))
]

#v(1em)

#align(center)[Typical deployments assume that all the devices #bold[can] execute the program.]

== Self-Organizing Coordination Regions (SCR)

#components.side-by-side(columns: (1fr, 1fr, 1fr), gutter: 2em)[
  #align(center)[
    === Information collection
    #figure(image("images/scr1.svg", height: 50%))
  ]
][
  #align(center)[
    === Leader computation
    #figure(image("images/scr2.svg", height: 50%))
  ]
][
  #align(center)[
    === Information sharing
    #figure(image("images/scr3.svg", height: 50%))
  ]
]

= Federated Learning

= Initial plan for my TCD visit