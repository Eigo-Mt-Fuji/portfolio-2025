# Mermaidスニペット
## Reference

- Flowchart Diagram https://mermaid.js.org/syntax/flowchart.html
- Sequence Diagram https://mermaid.js.org/syntax/sequenceDiagram.html
- Class Diagram https://mermaid.js.org/syntax/classDiagram.html
- State Diagram https://mermaid.js.org/syntax/stateDiagram.html
- Entity Relationship Diagram https://mermaid.js.org/syntax/entityRelationshipDiagram.html
- User Journey https://mermaid.js.org/syntax/userJourney.html
- Gantt https://mermaid.js.org/syntax/gantt.html
- Pie Chart https://mermaid.js.org/syntax/pie.html
- Quadrant Chart https://mermaid.js.org/syntax/quadrantChart.html
- Requirement Diagram https://mermaid.js.org/syntax/requirementDiagram.html
- Gitgraph (Git) Diagram https://mermaid.js.org/syntax/gitgraph.html
- C4 Diagram 🦺⚠️ https://mermaid.js.org/syntax/c4.html
- Mindmaps https://mermaid.js.org/syntax/mindmap.html
- Timeline https://mermaid.js.org/syntax/timeline.html
- ZenUML https://mermaid.js.org/syntax/zenUML.html
- Sankey 🔥 https://mermaid.js.org/syntax/sankey.html
- XY Chart 🔥 https://mermaid.js.org/syntax/xyChart.html
- Block Diagram 🔥 https://mermaid.js.org/syntax/blockDiagram.html
- Packet 🔥 https://mermaid.js.org/syntax/packet.html
- Kanban 🔥 https://mermaid.js.org/syntax/kanban.html
- Architecture 🔥 https://mermaid.js.org/syntax/architecture.html

## Sample

### 0. Flowchart

- flowchartの例

```mermaid
flowchart TB
    X[Start] --> |api call|sub1
    subgraph sub1["sub1(^o^)"]
        direction LR
        A --> |api call|B
        B --> CheckResultB{IsSuccess?}
        CheckResultB -.->|Yes| Y[Done]
        CheckResultB -.->|No| C[Fail]
    end
    subgraph sub2
        direction LR
        A2 --> |api call|B2
        B2 --> CheckResultB2{IsSuccess?}
        CheckResultB2 -.->|Yes| Y2[Done]
        CheckResultB2 -.->|No| C2[Fail]
    end
    %% node B to reference
    click B href "https://www.github.com" "Yes"
    sub1 --> sub2
```

- Expanded Node Shapes in Mermaid Flowcharts (v11.3.0+)
  - Mermaid introduces 30 new shapes to enhance the flexibility and precision of flowchart creation. 

```mermaid
flowchart RL
    A-->B
    A@{ shape: manual-file, label: "File Handling"}
```

- flowchartの構成要素
  - flowchart: mermaid flowchartのエントリーポイント
  - orientation: フローチャートの向き。LRは左から右に向かうチャート,TBは上から下に向かうチャート。
  - span(arrow) style: 動線のスタイル。実線と点線。右端・両端の矢印・記号(<, >・x・⚫︎)の有無が調整可能。、---は動線のみ・記号なし, -.-は動線のみ・記号なしで点線, -->は右向きの矢印・実線, --oは右側に⚫︎がついた実線, --xは右側にxがついた実線, <-->は両端に矢印がついた動線, o--oは両端に⚫︎がついた動線, x--xは両端にxがついた動線
  - span length: 矢印の長さは、ハイフン(-)の数で調整可能。数が多い方が長い。-->, ---->, ----->, -.->, -...->, -....->
  - text label: ノードや動線にラベルを付与できる。例えばY2[Done]は、Y2というノードのラベルをDoneと設定する。--> |api call|は、動線（右矢印付きの実線）に「api call」というラベルを設定する
  - conditional process(): ノード作成時に{}という括弧記号を使うことで、条件分岐のノードを作成できる。条件分岐ノードの具体例はCheckResultB2{IsSuccess?}。CheckResultB2という分岐のノード（菱形の図形）をフローチャート上に作成される（表示されるラベルはIsSuccess?）
  - subgraph: 「subgraph」という構文で、フローチャート内に複数の部分チャートを表現することができる subgraph 名前 で始まり endで終わる。
  - click: ノードに外部リンクを設定できる。例えば、click B href "https://www.github.com" "Yes"は、Bというノードに外部リンクを設定する。
  - comment: フローチャート内にコメントを記載できる。「%%」から始まる行がコメントです。コメントはmermaidでレンダリング後は表示されませんが、mermaidのコードの可読性やメンテナンス性を高める効果がある。コメントの具体例は、%% this is a comment A -- text --> B{node}です

### 1. Sequence Diagram

- **Example:**

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>Bob: Hello Bob, how are you?
    Bob-->>Alice: I am fine, thank you!
```
- **Components:**
  - `participant`: Define entities (e.g., Alice, Bob).
  - `->>`: Denotes messages.
  - `-->>`: Denotes responses.

### 2. Class Diagram
- **Example:**
```mermaid
classDiagram
    class Animal {
        +String name
        +void eat()
    }
    class Dog {
        +String breed
    }
    Animal <|-- Dog
```
- **Components:**
  - `class`: Defines a class.
  - Attributes and methods: Listed inside the class.
  - Relationships: `<|--` denotes inheritance.

### 3. State Diagram
- **Example:**
```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Working
    Working --> [*]
```
- **Components:**
  - States: e.g., `Idle`, `Working`.
  - Transitions: `-->` denotes state transitions.

### 4. Entity Relationship Diagram
- **Example:**
```mermaid
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ ITEM : contains
    CUSTOMER {
        string name
    }
```
- **Components:**
  - Entities: `CUSTOMER`, `ORDER`, `ITEM`.
  - Relationships: `||--o{` (one-to-many).

### 5. User Journey
- **Example:**
```mermaid
journey
    title User Journey
    section Login
      User enters username: 5: Happy
```
- **Components:**
  - `title`: Title of the journey.
  - `section`: A phase or action.

### 6. Gantt
- **Example:**
```mermaid
gantt
    title Project Plan
    section Section
      Task 1: 2023-01-01, 1d
```
- **Components:**
  - `section`: Logical grouping.
  - Tasks: Defined with duration.

### 7. Pie Chart
- **Example:**
```mermaid
pie
    title Language Usage
    "Python": 50
    "JavaScript": 30
```
- **Components:**
  - Sectors: Defined with labels and values.

### 8. Quadrant Chart
- **Example:**
```mermaid
quadrantChart
    title Reach and engagement of campaigns
    x-axis Low Reach --> High Reach
    y-axis Low Engagement --> High Engagement
    quadrant-1 We should expand
    quadrant-2 Need to promote
    quadrant-3 Re-evaluate
    quadrant-4 May be improved
    Campaign A: [0.3, 0.6]
    Campaign B: [0.45, 0.23]
    Campaign C: [0.57, 0.69]
    Campaign D: [0.78, 0.34]
    Campaign E: [0.40, 0.34]
    Campaign F: [0.35, 0.78]
```
- **Components:**
  - Axes: `x1`, `y1`.
  - Labels: Titles for sections.

### 9. Requirement Diagram
- **Example:**
```mermaid
requirementDiagram
    requirement req1 {
        id: R1
    }
```
- **Components:**
  - Requirements: `requirement req1`.
  - Attributes: e.g., `id`.

### 10. Gitgraph (Git) Diagram
- **Example:**
```mermaid
gitGraph
    commit
    branch feature
```
- **Components:**
  - `commit`: Represents a commit.
  - `branch`: Defines a branch.

### 11. C4 Diagram
- **Example:**

```mermaid
    C4Context
      title System Context diagram for Internet Banking System
      Enterprise_Boundary(b0, "BankBoundary0") {
        Person(customerA, "Banking Customer A", "A customer of the bank, with personal bank accounts.")
        Person(customerB, "Banking Customer B")
        Person_Ext(customerC, "Banking Customer C", "desc")

        Person(customerD, "Banking Customer D", "A customer of the bank, <br/> with personal bank accounts.")

        System(SystemAA, "Internet Banking System", "Allows customers to view information about their bank accounts, and make payments.")

        Enterprise_Boundary(b1, "BankBoundary") {

          SystemDb_Ext(SystemE, "Mainframe Banking System", "Stores all of the core banking information about customers, accounts, transactions, etc.")

          System_Boundary(b2, "BankBoundary2") {
            System(SystemA, "Banking System A")
            System(SystemB, "Banking System B", "A system of the bank, with personal bank accounts. next line.")
          }

          System_Ext(SystemC, "E-mail system", "The internal Microsoft Exchange e-mail system.")
          SystemDb(SystemD, "Banking System D Database", "A system of the bank, with personal bank accounts.")

          Boundary(b3, "BankBoundary3", "boundary") {
            SystemQueue(SystemF, "Banking System F Queue", "A system of the bank.")
            SystemQueue_Ext(SystemG, "Banking System G Queue", "A system of the bank, with personal bank accounts.")
          }
        }
      }

      BiRel(customerA, SystemAA, "Uses")
      BiRel(SystemAA, SystemE, "Uses")
      Rel(SystemAA, SystemC, "Sends e-mails", "SMTP")
      Rel(SystemC, customerA, "Sends e-mails to")

      UpdateElementStyle(customerA, $fontColor="red", $bgColor="grey", $borderColor="red")
      UpdateRelStyle(customerA, SystemAA, $textColor="blue", $lineColor="blue", $offsetX="5")
      UpdateRelStyle(SystemAA, SystemE, $textColor="blue", $lineColor="blue", $offsetY="-10")
      UpdateRelStyle(SystemAA, SystemC, $textColor="blue", $lineColor="blue", $offsetY="-40", $offsetX="-50")
      UpdateRelStyle(SystemC, customerA, $textColor="red", $lineColor="red", $offsetX="-50", $offsetY="20")

      UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

- **Components:**
  - Entities: `Person(User)`.

### 12. Mindmaps
- **Example:**


```mermaid
mindmap
    root((^o^))
        Tools
            Pen and paper
            Mermaid
        Origins))Oh<br/>マイゴッド((
            SubOrigin1
                Long history
                ::icon(fa fa-book)
            SubOrigin2
                Popularisation
                    British popular psychology author Tony Buzan
        Research
            On effectiveness<br/>and features
            On Automatic creation
                Uses
                    Creative techniques
                    Strategic planning
                    Argument mapping
```

- **Components:**
  - Root and Nodes: `root`, `child1`.

### 13. Timeline
- **Example:**
```mermaid
timeline
    title Timeline
    A: task 1
```
- **Components:**
  - Events: `A: task 1`.

### 14. ZenUML
- **Example:**
```mermaid
zenuml
    title Demo
    Alice->John: Hello John, how are you?
    John->Alice: Great!
    Alice->John: See you later!
```

- **Components:**
  - Actions: `Alice -> Bob`.

### 15. Sankey
- **Example:**
```mermaid
sankey
    A[Source] --> B[Target]
```
- **Components:**
  - Flows: `A --> B`.

### 16. XY Chart
- **Example:**
```mermaid
xyChart
    x: 1, y: 2
```
- **Components:**
  - Points: `x`, `y` values.

### 17. Block Diagram
- **Example:**
```mermaid
blockDiagram
    block main {
    }
```
- **Components:**
  - Blocks: Defined regions.

### 18. Packet
- **Example:**
```mermaid
packet
    packet data {
    }
```
- **Components:**
  - Packets: Logical groupings.

### 19. Kanban
- **Example:**
```mermaid
kanban
    section To Do
```
- **Components:**
  - Sections: `To Do`, `In Progress`.

### 20. Architecture
- **Example:**
```mermaid
architecture
    system A
```
- **Components:**
  - Systems: Logical units.

