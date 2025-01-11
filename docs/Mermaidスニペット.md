## mindmap

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

## flowchart 

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

- orientation: LR,TB

- arrow style

```
    ---
    -.-
    -->
    --o
    --x
    <-->
    o--o
    x--x
```

- text label

    ```
    [ラベル]
    -->|矢印テキスト|
    {分岐}
    ```

- arrow length

   ```
    -->
    ---->
    ----->
    -.->
    -...->
    -....->
   ```

- subgraph
- click
- comment: `%% this is a comment A -- text --> B{node}`
- Expanded Node Shapes in Mermaid Flowcharts (v11.3.0+)
  - Mermaid introduces 30 new shapes to enhance the flexibility and precision of flowchart creation. 

```mermaid
flowchart RL
    A-->B
    A@{ shape: manual-file, label: "File Handling"}
```
