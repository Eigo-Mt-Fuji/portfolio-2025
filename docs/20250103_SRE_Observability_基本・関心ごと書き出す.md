# SRE x Observability 基本・関心・現状の書き出し

## 時間

- 1/1 - 1/3(12h)

## 詳細
  
### DevOpsの今どんな計装に注目が集まっているか

- AI x SRE
    - CloudWatch 標準の新機能「異常検知(Anomaly Detection)」
        - CloudWatchが、過去のデータに機械学習アルゴリズムを適用して、メトリクスの想定値のモデルを作成。最大 2 週間分のメトリクスデータをトレーニングする。
        - CloudWatch の異常検出はモデルを継続的に評価し、調整する（デプロイまたは他の異常なイベントが使用されないようにしたり、特定の期間を除外したり、季節的、スパイク、スパースなメトリクスのモデルを改善する）
    - 遅延や障害の原因の特定・推定（難易度が高くノウハウ共有や連携が難しい業務を生成 AI を使って支援する）
    - 去年学んだエンジニアリングへの生成AI活用プラクティス https://docs.google.com/spreadsheets/d/1RGwIqkopaNy7DPLZ85MrhCCkH21jjSwrYSv60IWMqC8/edit?hl=ja&gid=0#gid=0
- OpenTelemetryと分散TracingとObservability - https://aws.amazon.com/jp/blogs/news/awsobservabilityfes2024autumn/
    - AWS での負荷試験における分析の速度と品質を向上させるための Observability アセット
        - CloudWatch Container Insights
        - Amazon TimeStream for InfluxDB
        - Amazon DevOps Guru
### そもそも分散トレーシングとは?(分散トレーシングの役割)

- 一般的には３種類の機能で構成される。リクエストフローの追跡、スパンの記録、依存関係の可視化。
### そもそもテレメトリデータとは?(OpenTelemetryの Telemetry)
- 一般的には３種類。メトリクス（Metrics）＝定量的な数値データ、ログ（Logs）＝イベントの記録、トレース（Traces）＝分散システム内のリクエストフローの記録
### 分散トレーシングのユースケースは？分散トレーシング,テレメトリデータ収集はサービスレベル改善にどう関係する？
- パフォーマンス、遅延やエラーが発生している個所の特定、処理時間やメタデータを記録（例: HTTPリクエストの詳細、データベースクエリの遅延）することで、サービスの改善に繋げる
### 分散トレーシング（Distributed Tracing） と Observability（可観測性） の関係は？
- Observabilityは、システムの内部状態を外部から推論できる能力
    - システムの振る舞いを追跡（トレース）し問題を理解・対策するためのデータ収集と分析
- Observabilityを実現するための主要な要素の1つが分散トレーシング
### 分散トレーシングのマネージドサービスの具体例
- AWSでは、AWS X-Rayが分散トレーシング機能を提供する
- Cloudflareには、AWS X-Rayのように完全な分散トレーシング機能はない(イベントログやメトリクスなどテレメトリデータを収集する機能はある)
- Azure（Application Insights）とGCP（Cloud Trace）は、AWS X-Rayに匹敵する分散トレーシング機能を提供しています
- Datadog, New Relic
  - Datadogは今まさに仕事で使っている。そういえば、2018年時点でもNewRelic使っていたな。
### マネージドサービス以外も含めて、分散トレーシングのためのテレメトリデータ収集システム（バックエンド・ストレージ）を実現するための具体的な選択肢
- Datadog, NewRelic, AWS X-Ray, GCP Cloud Trace, Azure Application Insights
- Jaeger, SigNoz, Prometheus, Uptrace, Zipkin
  - 特に気になるのは、JaegerとSigNoz
    - Jaeger: https://www.jaegertracing.io/
      - Distributed tracing observability platforms, such as Jaeger, are essential for modern software applications that are architected as microservices. Jaeger maps the flow of requests and data as they traverse a distributed system. These requests may make calls to multiple services, which may introduce their own delays or errors. Jaeger connects the dots between these disparate components, helping to identify performance bottlenecks, troubleshoot errors, and improve overall application reliability.
      - マイクロサービス(相互接続されたソフトウェアコンポーネント)の問題をモニタリングおよびトラブルシューティングするために使用できるソフトウェア
    - SigNoz: オープンソースのDatadog/New Relic代替と言われている。APM。ログ基盤、外形監視としても使える。ClickHouseというオープンソースのカラム型データベース管理システムに基づいている。ホスティング型のSaaSモデルとエンタープライズ向けのオンプレミス展開を提供
    - Prometheus: Prometheus, a Cloud Native Computing Foundation project, is a systems and service monitoring system. It collects metrics from configured targets at given intervals, evaluates rule expressions, displays the results, and can trigger alerts when specified conditions are observed. https://github.com/prometheus/prometheus
      - While Jaeger is an end-to-end distributed tracing tool, Prometheus is used as a time-series database for monitoring metrics
    - Grafana: データ可視化ツール「Grafana」可視化プラットフォームとして大きな広がりを見せつつある。リアルタイムのデータを統合し、実用的な成果を実現。あなたに合ったオブザーバビリティ。
### テレメトリデータ収集システムの構築と運用を設計するためのメッセージングシステムとデータベースシステム
  - メッセージングシステムとデータベースシステムに関する一定の理解と特徴に基づいた選択、設計、オペレーションが必要
    - メッセージ伝送に適したシステムとはどのような役割をもち、何の機能を持たないことを選択しているか
      - 例えば、Jaegerは分散キューシステムであるKafkaを使って、テレメトリデータをストレージ保存する機能の信頼性とパフォーマンスを調節する手段を提供している
        - https://www.jaegertracing.io/docs/2.1/architecture/#via-kafka
　  - テレメトリデータに適したデータベース
      - GCPのBigQueryやAWS Redshift, ClickHouseなどのカラム型DBを使って仕組み化するのが主流
      - 同一種類の属性をカラム型DBに保存することで、圧縮効率、分析トランザクションの処理効率が高くなる
### 選択肢を踏まえ、設計ポイントを考えてみる
- テレメトリデータの保存・収集装置は、自己管理 か マネージドか(どこまでが自己管理か)
- 構築・運用の持続性課題への対策
- トレースデータの耐久性/保存期間（法律、経営・マネジメント、システム運用）
- テレメトリデータ収集によるパフォーマンスへの影響の推定
    - 非同期バッチ送信を利用し、アプリケーションのレスポンスタイムへの影響を最小化
    - データ転送サイズ、計算量
- データ分析要件（マイクロサービス間で一貫したトレースIDを使用して、分散トレーシングを正確に行う、リアルタイム分析、履歴分析）
    - トレースデータの属性
        リソース属性
            サービス全体で一貫している情報（例: サービス名、バージョン、環境）を設定。
        スパン属性
            各操作やリクエストの詳細情報（例: HTTPリクエスト、エラーコード）を設定
- 費用対効果（コスト観点）とデータ活用の観点から収集するテレメトリデータ（ログ、メトリクス、スパン）選択
- アプリケーションでspanデータ型の定義 と spanデータ送信処理を実装する
  - データ型の要素属性(網羅性)、情報サイズ, 計算量(CPU, メモリ)
  - spanデータ送信SDKの呼び出し、送信成功・失敗の判定、送信失敗時の制御（リトライ・２次保存）
  - 部品種類, ファイル・関数・型の命名、コメント
  - 計測対象とする区間
    - 全てのAPI, 特定のAPIのみ選択, 特性のAPIのみ除外
    - APIの開始ー終了, API処理内の部分処理
- AWS上でのシステム構成について検討
  - 例えば、AWS ECSのタスク内にAWS X-Rayデーモンのコンテナを起動しておけば、アプリケーションからOpenTelemetryのライブラリ経由でトレースデータをAWS X-Rayに送信できる(X-Rayの機能での分析が可能になる)
    - AWS X-RayのSegment構造定義 https://docs.aws.amazon.com/xray/latest/devguide/xray-api-segmentdocuments.html
        - 必須のセグメントフィールド
  - AWS X-Rayデーモンを使う場合でも、AWS X-Ray SDKを使わずに、OpenTelemetryを利用してトレースデータをAWS X-Rayに送信することが可能です。この方法を選ぶことで、柔軟性と拡張性を高めることができます。
  - AWS X-Ray, Aurora, Lambda, EC2/ECS
### OpenTelemetryを使ったトレースの基本的な流れ / Go言語とgo-chiフレームワークでOpenTelemetryを使用した簡単な実装

```golang
package main

import (
    "context"
    "log"
    "net/http"
    "time"

    "github.com/go-chi/chi/v5"
    "github.com/go-chi/chi/v5/middleware"
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/exporters/jaeger"
    "go.opentelemetry.io/otel/sdk/resource"
    "go.opentelemetry.io/otel/sdk/trace"
    "go.opentelemetry.io/otel/trace"
    "go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"
)

func main() {
    // Initialize OpenTelemetry
    tp, err := initTracer()
    if err != nil {
        log.Fatalf("failed to initialize tracer: %v", err)
    }
    defer func() {
        if err := tp.Shutdown(context.Background()); err != nil {
            log.Fatalf("failed to shut down tracer: %v", err)
        }
    }()

    // Create router
    r := chi.NewRouter()
    r.Use(middleware.Logger) // Basic logging middleware
    r.Use(otelMiddleware)    // OpenTelemetry middleware

    // Define routes
    r.Get("/", func(w http.ResponseWriter, r *http.Request) {
        _, span := otel.Tracer("example-server").Start(r.Context(), "HandleRoot")
        defer span.End()

        time.Sleep(100 * time.Millisecond) // Simulate some processing
        w.Write([]byte("Hello, OpenTelemetry with go-chi!"))
    })

    // Start server
    log.Println("Starting server on :8080")
    if err := http.ListenAndServe(":8080", r); err != nil {
        log.Fatalf("failed to start server: %v", err)
    }
}

func initTracer() (*trace.TracerProvider, error) {
    // Create Jaeger exporter
    exp, err := jaeger.New(jaeger.WithCollectorEndpoint(jaeger.WithEndpoint("http://localhost:14268/api/traces")))
    if err != nil {
        return nil, err
    }

    // Create tracer provider
    tp := trace.NewTracerProvider(
        trace.WithBatcher(exp),
        trace.WithResource(resource.NewWithAttributes(
            otel.ServiceNameKey.String("example-service"),
        )),
    )

    // Set global tracer provider
    otel.SetTracerProvider(tp)

    return tp, nil
}

// OpenTelemetry middleware for go-chi
func otelMiddleware(next http.Handler) http.Handler {
    return otelhttp.NewHandler(next, "HTTP Server")
}
```

### ちなみに分散トレーシングが必要とされるのはマイクロサービスだから?(それ以外の場合は不要?)

- コンポーネントの数が限定的なマイクロサービス、もっと率直にモノリシックなアプリケーションの場合、あるいはWEBじゃなくオフライン前提の業務用システムの場合、テレメトリデータや分散トレーシングの概念は無用の長物になるか？
  - 仮説: 一理あるが基本的にはNo。ログの記録は行う。メトリクスも、既知の未知を効率的に検知する目的で活用するので、テレメトリデータのうち、ログとメトリクスはほぼ必須。スパンのデータを収集するかは、費用対効果次第（≒やらないの）では？
    - 実際は、他人が作ったシステムで、パフォーマンスの問題や不具合の原因特定をするのは大変難しい場合があるから、取れるデータは全て撮りたい。スパンデータは単にAPIが実行された時間帯と応答ステータスがわかるだけではなく、クエリやHTTPリクエストなど処理の内訳も明かにしてくれる
    - なので、むしろ生成AIを使って作られたシステムが登場するとニーズが増えると思った方が良いくらいでは？

### 今現在のアプローチ。DatadogとFluentbit
  - Datadogメトリクスの運用モニタリング活用 https://docs.datadoghq.com/ja/metrics/types/?tab=rate#metric-types
    - COUNT: ある時間間隔内のイベント発生の合計数
        リクエスト数、エラー数、データベース接続数など
    - RATE: ある時間間隔の 1 秒あたりのイベント発生の合計数
        秒間リクエスト数、
    - GAUGE: ある時間間隔のイベントのスナップショットを表します。この代表的なスナップショット値は、時間間隔中に Agent に送信された最後の値. GAUGE を使用して、使用可能なディスク容量や使用中のメモリなど、継続的にレポートする何かの測定を行うことができます
        使用可能なディスク容量や使用中のメモリなど
    - DISTRIBUTION: ある時間間隔内に計算された一連の値のグローバルな統計分布を表します。DISTRIBUTION は、基底のホストから独立してサービスなどの論理オブジェクトをインスツルメントするために使用できます
        分布。データセット。離散か連続かは気にしていない。
        DISTRIBUTIONタイプメトリクスのの平均, 最大, 最小を計算した結果はGAUGE, percentile aggregations (p50, p75, p90, p95, p99) もGAUGE, 分布の合計はCOUNT。
        平均・最大・最小・９５パーセンタイル
  - Fluent Bitを使ったログ収集
    - Fluent Bitを使ったテレメトリ収集のユースケース
      - 費用対効果（コスト観点）とデータ活用の観点から収集するテレメトリデータをログに限定した場合の一般的な手段の１つ
      - 豊富なプラグインや最新版で提供されているWASM拡張を利用して、複数の出力先を想定した柔軟なカスタマイズも可能
      - 送信元アプリケーションから処理を切り離してテレメトリ収集の仕様を制御できる
    - アプリケーションログの収集と解析
      - 収集対象: アプリケーションが生成するログファイルや標準出力
      - 出力先: Elasticsearch, Grafana Lokiなどの分析ツール。
    - 分散トレーシングの補完
      - Fluent Bitを使ってトレースログを収集し、OpenTelemetryやAWS X-Rayに統合。
    - メトリクスデータの収集
      - Prometheus Exporterを使い、システムやアプリケーションのパフォーマンスメトリクスを収集。
    - クラウド監視ツールとの連携
      - Fluent Bitを使ってAWS CloudWatch、Google Cloud Logging、Azure Monitorなどにデータを送信。


```
統合（マージ）前のプライベートビルドは モダンなソースコード管理ツールにすでに付随している。Github Workflow、Gitlab MergeRequestの自動CI
    言葉を知っているだけでなく、計測するための条件をどの解像度で理解しているか、そして何を実践し、良い影響をその環境に残せるかが重要。
        定義と計測
            ４つのキーメトリクス
                開発のスループット（CIパイプライン上で起きることに基づく。リーンの文脈のサイクルタイムやリードタイムと混同しないでください）
                    デプロイの頻度
                        
                    変更のリードタイム
                        完成させたコードや設定の変更がパイプラインを通って本番環境に到達するまでにかかる時間
                サービスの安定性（サービスの停止と復旧を追跡する必要がある）
                    変更時の障害率
                        障害の定義
                            障害＝ユーザの作業を中断させるもの
                    サービスの復旧時間
            パイプライン
                ・単一E2Eパイプライン
                    ・サービスに１つしかパイプラインが存在しないモデル
                        ・コードや設定の変更を検知し、コンパイルや自動テスト、パッケージ化などのアクションを実行し、結果を本番環境にデプロイする\
                ・複数E2Eパイプライン
                    ・マイクロサービスのように、リポジトリごとにパイプラインがあるモデル
                ・ファンインパイプライン
                ・計装点コミットタイムスタンプとデプロイタイムスタンプ
    このように強く意識して再学習することに価値はあるか。
        普段無意識に使っている仕組みはたくさんある。GithubもGitlabもGCP BigQueryも便利。あえてこれらの存在を認識する必要があるのは、新規システム構築、組織構造の変換期、モダンな環境への移行完了前か、仕組みが機能しなくなった場合とか？考えてみると意外とある。

- DevOpsの今どんな計装に注目が集まっているか
  - AI x SRE
    - SREとは
      - ソフトウェアツールを使用して、システム管理やアプリケーション監視などのITインフラストラクチャタスクを自動化する方法
    - 生成AIの活用
      - https://docs.google.com/spreadsheets/d/1RGwIqkopaNy7DPLZ85MrhCCkH21jjSwrYSv60IWMqC8/edit?hl=ja&gid=0#gid=0
  - OpenTelemetry
    - なぜ「ABEMA」は「OpenTelemetry」を採用
      - https://logmi.jp/main/technology/328569
        - パブリッククラウドとかインフラを管理しているCloud Platformチームと、アプリケーション側の実装というかたちでCloud Platformチームが協力して進める
        - 「GCP」だけじゃなく「AWS」とかも使っています。トレーシングするにあたってAWSやGCPなどを複数で使う場合があります。そう考えた時に、将来的にはトレーシング情報などをきちんと一元管理したい
        - トレーシングするにあたってAWSやGCPなどを複数で使う場合
        - 選択肢としては、「Datadog」とか「New Relic」みたいなサービスがあると思いますが、そこらへんも鑑みて。コストの問題
        - OpenTelemetryを使ったほうが将来的に実現したいことに直結するだろう
        - 負荷試験をしている段階でトレーシング導入したいサービスが見えていた
    - AWS x Golangの計装 どんなメトリクスを
  - Observability
    - https://aws.amazon.com/jp/blogs/news/awsobservabilityfes2024autumn/
      - AWS での負荷試験における分析の速度と品質を向上させるための Observability アセット
        - CloudWatch Container Insights
        - Amazon TimeStream for InfluxDB
        - Amazon DevOps Guru
    - 運用イベント対応への生成AIの活用 with Failure Analysis Assistant
        - 障害原因の特定
          - 難易度が高くノウハウ共有や連携が難しい業務
          - 生成 AI を使って支援する
        - CloudWatch 標準の新機能
          - セッション資料 1: ログ異常検出
          - 有効にする
        - 異常検出は、AWS Management Console、AWS CLI、AWS CloudFormation または AWS SDK を使用して有効にする
          - 検出の対象選択
            - AWS から提供されるメトリクスおよびカスタムメトリクスに対して有効にする
            - AVG 統計を使用してメトリクスの異常検出を有効
        - 異常検出に基づいて CloudWatch アラームを作成
          - 仕組み
            - CloudWatchが、過去のデータに機械学習アルゴリズムを適用して、
            - メトリクスの想定値のモデルを作成
            - 機械学習モデルの作成単位
            - 機械学習モデルは、メトリクスと統計に固有 
            - 例えば、AVG 統計を使用してメトリクスの異常検出を有効
        - 初回のトレーニング
          - アルゴリズムは最大 2 週間分のメトリクスデータをトレーニングします
          - CloudWatch が AWS サービスから多くの一般的なメトリクスのモデルを作成する場合
          - バンドが論理値の外に拡張されないようにします
        - 例えば、EC2 インスタンスの MemoryUtilization のバンドは 0 から 100 の間で維持（負にならない、１００を超えないように）
          - CloudFront Requests は、追跡するバンドはゼロを下回ることはない
          - 継続的なトレーニング
            - モデルを作成した後、CloudWatch の異常検出はモデルを継続的に評価し、調整を行って、可能な限り正確であることを確認します
            - メトリクス値が時間の経過とともに変化するか、突然変化するかを調整するためのモデルの再トレーニングが含まれます
            - 季節的、スパイク、スパースなメトリクスのモデルを改善するための予測変数も含まれます
            - 特定の期間を除外
            - モデルのトレーニングにデプロイまたは他の異常なイベントが使用されないように除外
                料金
                    Alarms are billed based on the number of metrics per alarm

                    If you enable Amazon CloudWatch Anomaly Detection on 
                        10 standard resolution metrics per month 
                        only want to alarm on 5 of those metrics
                    you will create 
                        5 standard resolution anomaly detection alarms
                        Your monthly bill is calculated as follows:
                            Total number of standard resolution anomaly detection alarms
                                = 5    
                        For every anomaly detection alarm,
                            there are three standard resolution metrics per alarm.
                                One is the actual metric being evaluated, 
                                the second is the upper bound of expected behavior, 
                                and 
                                the third is the lower bound of the expected behavior.

                            One standard resolution anomaly detection alarm 
                                = $0.10 * 3 
                                standard resolution metrics per alarm 
                                = $0.30 per month
                            Five standard resolution anomaly detection alarms 
                                = $0.30 per standard resolution anomaly detection alarm * 5 alarms 
                                = $1.50 per month
                            異常検出を有効にしたアラーム数 x 1アラームで評価するメトリクス数 x 料金単価
                                Standard Resolution Metrics Alarm
                                    Cost for metrics listed directly(/alarm/month)	$0.10 per alarm metric
                - CloudWatchカスタムメトリクス First 10,000 metrics	$0.30Cost (metric/month)
                  - CloudWatch Logs
                        Collect (Data Ingestion)
                            Standard $0.76 per GB ( シンガポール: 8%オフ, バージニア: 35%オフ )
                                100GB のデータをインジェストすると $76.00 かかる
                            Infrequent Access $0.38 per GB
                        Query (Logs Insights)
                        Data Transfer OUT from CloudWatch Logs
                            $0.0076 per GB of data scanned

                            Pricing values displayed here are based on US East Regions. Please refer to pricing tabs for most current pricing information for your respective region(s). Anomaly Detection is currently available in all commercial AWS Regions.

- そもそも分散トレーシングとは?(分散トレーシングの役割)
    - リクエストフローの追跡:
        - サービス間を横断するリクエストの流れを追跡し、どこで遅延やエラーが発生しているかを特定。
    - スパンの記録:
        - 各サービスや操作ごとの処理時間やメタデータを記録（例: HTTPリクエストの詳細、データベースクエリの遅延）。
    - 依存関係の可視化:
        - サービス間の依存関係とパフォーマンスを視覚的に把握
- そもそもテレメトリデータとは?(OpenTelemetryの Telemetry)
    - メトリクス（Metrics）:
        - 定量的な数値データ
        - 例: CPU使用率、メモリ使用量、リクエストレイテンシ。
        - 目的: パフォーマンスや健全性を測定
    - ログ（Logs）:
        - イベントの記録。
        - 例: アプリケーションエラー、デバッグ情報、状態変更。
        - 目的: 問題発生時の詳細な情報を確認。
    - トレース（Traces）:
        - 分散システム内のリクエストフローの記録。
        - 例: サービスA → サービスB → データベース のリクエストルートと遅延。
        - 目的: リクエストの流れを可視化し、遅延や障害箇所を特定。

- Datadogのメトリクスタイプ
  - Datadog https://docs.datadoghq.com/ja/metrics/types/?tab=rate#metric-types
    - COUNT: ある時間間隔内のイベント発生の合計数
        リクエスト数、エラー数、データベース接続数など
    - RATE: ある時間間隔の 1 秒あたりのイベント発生の合計数
        秒間リクエスト数、
    - GAUGE: ある時間間隔のイベントのスナップショットを表します。この代表的なスナップショット値は、時間間隔中に Agent に送信された最後の値. GAUGE を使用して、使用可能なディスク容量や使用中のメモリなど、継続的にレポートする何かの測定を行うことができます
        使用可能なディスク容量や使用中のメモリなど
    - DISTRIBUTION: ある時間間隔内に計算された一連の値のグローバルな統計分布を表します。DISTRIBUTION は、基底のホストから独立してサービスなどの論理オブジェクトをインスツルメントするために使用できます
        分布。データセット。離散か連続かは気にしていない。
        DISTRIBUTIONタイプメトリクスのの平均, 最大, 最小を計算した結果はGAUGE, percentile aggregations (p50, p75, p90, p95, p99) もGAUGE, 分布の合計はCOUNT。
        平均・最大・最小・９５パーセンタイル

- 分散トレーシングのユースケースは？分散トレーシング,テレメトリデータ収集はサービスレベル改善にどう関係する？
    - 分散トレーシングのユースケース
      - パフォーマンスボトルネックの特定:
        - サービス間でどの箇所が遅延の原因となっているかを特定。
      - 障害の診断:
        - リクエストが失敗した場合、どのサービスや操作で問題が発生したかを確認。
      - 依存関係の把握:
        - システム全体のアーキテクチャと相互作用を理解。

- 分散トレーシング（Distributed Tracing） と Observability（可観測性） の関係は？
    - Observabilityは、システムの内部状態を外部から推論できる能力
        - システムの振る舞いを追跡（トレース）し問題を理解・対策するためのデータ収集と分析
    - Observabilityを実現するための主要な要素の1つが分散トレーシング

- 分散トレーシングのマネージドサービスの具体例
    - AWSでは、AWS X-Rayが分散トレーシング機能を提供する
        - 自分が使おうと考えたAWS X-Rayが何なのか、機能を理解する. Xxにも分散トレーシング機能やテレメトリ収集のサービスある？
        - X-Ray利用してトレースデータを収集する場合の課題
            - １つのスパンが1回のAPIリクエストや1回のジョブの実行に対応させた場合、X-Rayが収集するスパンデータに加えて、ログの収集を行うことは、必要な機能的補完と言える。
            - 収集するログをCloudWatch Logsに送信することで、X-Rayのログデータと連携できる一方
            - コスト観点では、CloudWatch Logs1GBあたりの料金が1GB0.76USD/monthと、大規模なシステムでは割高になることがネックとなる。
            - この仮説は適切なのか？というと実際は、X-Rayでは、サブセグメントを使うことで、X-Ray上でスパンに関連づけて複数のログに相当する属性を保存することはできるとされている。
            - https://docs.aws.amazon.com/xray/latest/devguide/xray-api-segmentdocuments.html
            - 仮に、仮説が間違っている前提でX-Rayのトレースデータの管理を設計するとどのような問題があるか考えるべき
            - コスト観点で捉えていたが、お金の問題以前にそもそも、実際は、コスト以前に、どの区間をトレースすれば良いのかが不明なところから始まるのでは？（新たな設計コスト、導入ボトルネック）
            - 時系列の分析が前提なので、普遍的で長期的な証跡の管理には割高になるのでは（やはりコスト観点で捉えるべき要素がある可能性）
            - なんでも詰め込むとノイズが増えて分析しづらくなる（蒸留装置の必要性はないか）
            - シンプルに同期APIを考える。RDS, DynamoDB、認証を使うやつで、マイクロサービスを２つ連携させ、X-Rayでトレースする。いくら金がかかり、どこに課題があるか。お題は、提案させるか。ChatGPTに。
    - Cloudflareには、AWS X-Rayのように完全な分散トレーシング機能はないが、イベントログやメトリクスなどテレメトリデータを収集する機能はある
        - Azure（Application Insights）とGCP（Cloud Trace）は、AWS X-Rayに匹敵する分散トレーシング機能を提供しています
        - アプリケーションがAzure App Service、Azure Functions、Azure Kubernetes Service（AKS）で動作している場合。
            - 他のAzure Monitorの機能（ログ分析、アラート）と連携したい場合。
        - アプリケーションがGCPサービス（GKE、Cloud Run、Cloud Functions）で動作している場合。
            - Cloud LoggingやCloud Monitoringと統合して、メトリクス、ログ、トレースを一元管理したい場合。
        - OpenTelemetryを利用して、トレースデータを柔軟に収集したい場合
            - サードパーティツール（Grafana、Datadog）と連携してトレーシングデータを可視化したい場合。

- マネージドサービス以外も含めて、分散トレーシングのためのテレメトリデータ収集システム（バックエンド・ストレージ）を実現するための具体的な選択肢
  - そもそもどこに収集できるのか、選択肢をしる。
  - セルフホストする必要はある？
    - システムは１台のサーバか。複数か、なんの機能が必要？
  - いや、セルフホストが必要かどうか、という問題ではない。セルフホストしないなら、どこにデータを集めているか
    - 集める時も、集めたデータを出力するにも、データを処理して分析するにも、金を取られる。収集したデータを管理するシステムと組織の継続性に依存する。
    - セルフホストする場合、OpenTelemetryのバックエンドの選択肢の中から、OSSとして提供されているものを選んで、サーバを構築するということ？
    - OpenTelemetryプロトコルに従ってデータ取得する機能を持ったSDK
        - Feature Set. Evaluate the metrics, traces, and logs offered by each backend. Consider if the backend meets your monitoring and observability needs, including distributed tracing, metric aggregation, anomaly detection, and log analysis capabilities.
        - Data storage. Telemetry data generated by applications can be voluminous, especially in large-scale distributed systems. Storing this data efficiently and reliably requires a dedicated backend system that can handle the data volume and provide the necessary durability.
        - Querying and analysis. Evaluate the backend's query and analysis capabilities. Look for features that allow you to perform complex queries, aggregations, and filtering on the telemetry data. Consider whether the backend supports your organization's specific analysis and visualization requirements.
        - Visualization and alerting. A backend system usually offers visualization and dashboarding features to present telemetry data in a clear and actionable way. This allows you to monitor application performance, track health metrics, and set alerts based on predefined thresholds or conditions.
        - Integrations and plugins. In many cases, you may already have existing monitoring, logging, or analytics systems in your infrastructure. The backend system can integrate with these tools, allowing you to consolidate telemetry data with other observability data sources and leverage existing workflows and processes

        Jaeger
            https://www.jaegertracing.io/
                マイクロサービスと呼ばれる相互接続されたソフトウェアコンポーネントの問題をモニタリングおよびトラブルシューティングするために使用できるソフトウェア
                Distributed tracing observability platforms, such as Jaeger, are essential for modern software applications that are architected as microservices. Jaeger maps the flow of requests and data as they traverse a distributed system. These requests may make calls to multiple services, which may introduce their own delays or errors. Jaeger connects the dots between these disparate components, helping to identify performance bottlenecks, troubleshoot errors, and improve overall application reliability. Jaeger is 100% open source, cloud native, and infinitely scalable.
                    All-in-one Docker
                        docker run --rm --name jaeger \
                        -p 16686:16686 \
                        -p 4317:4317 \
                        -p 4318:4318 \
                        -p 5778:5778 \
                        -p 9411:9411 \
                        jaegertracing/jaeger:2.1.0
                Jaeger v2 is designed to be a versatile and flexible tracing platform. 
                It can be deployed as a single binary that can be configured to perform different roles within the Jaeger architecture, 
                such as:
                    collector: Receives incoming trace data from applications and writes it into a storage backend.
                        application -(trace data)-> collector -(trace data)-> storage backend
                    ingester: Ingests spans from Kafka and writes them into a storage backend; useful when running in a split collector-Kafka-ingester configuration.
                        kafka - (spans) -> ingester -> storage backend
                            when running in a split collector-Kafka-ingester configuration
                        application -> (spans) -> kafka - (spans) -> ingester(1..N) -> storage backend
                            The collectors are configured with Kafka exporters
                                collectors has two main setting exporters and receivers.
                            Kafka can be used as an intermediary, persistent queue
                                To prevent data loss between collectors and storage
                            An additional component, ingester, needs to be deployed
                                ingester is very similar to a collector
                                only configured with a Kafka receiver instead of RPC-based receivers.
                            ストリーミングデータをリアルタイムで取り込んで処理するために最適化された分散データストア
                            リアルタイムストリーミングデータパイプラインとリアルタイムストリーミングアプリケーションの構築に使用
                            データパイプラインは、データを確実に処理してあるシステムから別のシステムに移動
                    agent: A host agent or a sidecar that runs next to the application and forwards trace data to the collector. While Jaeger can be configured for this role, we recommend using the standard OpenTelemetry Collector instead because you may likely need it to process other types of telemetry (metrics & logs).
                    query: Serves the APIs and the user interface for querying and visualizing traces.
                    all-in-one: Collector and query roles in a single process.
        Prometheus
            Prometheus, a Cloud Native Computing Foundation project, is a systems and service monitoring system. It collects metrics from configured targets at given intervals, evaluates rule expressions, displays the results, and can trigger alerts when specified conditions are observed.
                https://github.com/prometheus/prometheus
                    While Jaeger is an end-to-end distributed tracing tool, Prometheus is used as a time-series database for monitoring metrics
                    The collected metrics can be viewed inside Prometheus's expression browser or transferred to external systems via its HTTP API
                    Prometheus is an infrastructure monitoring tool created by SoundCloud but is now an open-source project hosted on GitHub
        Grafana
            データ可視化ツール「Grafana」
            可視化プラットフォームとして大きな広がりを見せつつあるGrafana
            Grafanaを使えば10種類のデータソースから情報を収集し、ダッシュボードで一元管理できます
                GrafanaはREST API経由でデータを取得しダッシュボードによる可視化が可能
            Grafana Cloudは、Grafanaの主要なオープンソースソフトウェアに基づいて構築されています
            リアルタイムのデータを統合し、実用的な成果を実現。あなたに合ったオブザーバビリティ

        SigNoz
            オープンソースのDatadog/New Relic代替と言われている。APM。ログ基盤、外形監視としても使える
            ホスティング型のSaaSモデルとエンタープライズ向けのオンプレミス展開を提供
            ClickHouseというオープンソースのカラム型データベース管理システムに基づいている。これにより、データをカラム単位で格納することで圧縮が可能となり、ディスクのI/O処理も最適化される。これにより、より効率的で費用対効果の高いソリューションが実現されるElasticsearch
                「カラム型DB」はリレーショナルデータベース（RDB）の一種。 データを「ロー（行）」ではなく、「カラム（列）」単位
                    「来店日時別の売り上げ集計」といった処理を高速にこなせる
                    カラム型DBについて解説して。
                    ・データを「ロー（行）」ではなく、「カラム（列）」単位で管理すること、
                    ・データをカラム単位で格納することで圧縮が可能
                    ・例えば「来店日時別の売り上げ集計」といった処理を高速にこなせる
                    ・これにより、効率的で費用対効果の高いソリューションが実現される、ディスクのI/O処理も最適化される
                    など特徴とメリットが解説されているのを見かけました。
                    カラム型というのは、データベース内のデータ管理がカラムを軸にして行われるってこと？
                    行指向、カラム指向でそれぞれ管理すると、具体的にどう違いが現れる？データベースシステム内でファイルに保存するときに違いが出るの？
                    カラム型だと、行のまとまりはなくなるということ？なくなるわけではないのであれば、どうデータとして表現される？（行のまとまりは例えば、1回の購入につき、購入のID、購入した日付、購入した商品、金額、購入した顧客のIDがあったとすると、これらを１セットとする考え）
                    カラム型のデメリットはある？
            より分散型かつ柔軟性のあるソリューションを提供することを目指している
                ・今後注力する予定
                    ・製品の成熟化
                    ・OpenTelemetryネイティブの機能の追加
                    ・クラウドおよびエンタープライズ向けのオファリングの拡充
        SigNoz vs Uptrace
            Uptrace is an open source APM that supports distributed tracing, metrics, and logs. You can use it to monitor applications aJaeger
        Datadog 

- テレメトリデータ収集システムの構築と運用を設計するためのメッセージングシステムとデータベースシステム
  - メッセージングシステムとデータベースシステムに関する一定の理解と特徴に基づいた選択、設計、オペレーションが必要
    - メッセージ伝送に適したシステムとはどのような役割をもち、何の機能を持たないことを選択しているか
      - 安価で持続可能な計算資源で
      - メンテナンスしやすい
      - 高いパフォーマンス、信頼性
      - 機能
        - Communication Patterns: Support a variety of patterns, 
            - publish/subscribe
            - message queues
            - allowing the construction of complex, distributed systems.
        - Delivery Guarantees:
            - Offer different levels of message delivery assurance, ensuring that messages reach their destination as needed.
        - Optional Persistence: Some messages can be persistent, allowing their retrieval in case of failures
      - JaegerはKafkaを使って分散トレーシングデータを収集する仕組みを提供している(それだけではない)
　  - テレメトリデータに適したデータベース
      - GCPのBigQueryやAWS Redshift, ClickHouseなどのカラム型DBを使って仕組み化するのが主流
      - 同一種類の属性をカラム型DBに保存することで、圧縮効率、分析トランザクションの処理効率が高くなる
      - 分散トレーシングのユースケースから、業務の中心がOLAPになることを前提にしていそう
        - パフォーマンスボトルネックの特定:
            - サービス間でどの箇所が遅延の原因となっているかを特定。
        - 障害の診断:
            - リクエストが失敗した場合、どのサービスや操作で問題が発生したかを確認。
        - 依存関係の把握:
            - システム全体のアーキテクチャと相互作用を理解。
      - スパンデータは有向非循環グラフだという説明を見かけたが、グラフデータベースではなく、カラム型DBに保存するのはなぜ？
      - ストレージに保存するデータは、大きく分けて、トレースデータとメトリクスデータとログデータの３種類。ログは、イベントログと通常ログなど細かい分類がある。メトリクスも、分布、レート（割合）。ディストリビューションは、他のメトリクスタイプ (カウント、レート、ゲージ、ヒストグラム) では提供されない、強化されたクエリー機能および構成オプション
        - OSSの分散トレーシングプラットフォームであるSigNozは、ClickHouseというオープンソースのカラム型データベース管理システムに基づいている。これにより、データをカラム単位で格納することで圧縮が可能となり、ディスクのI/O処理も最適化される。これにより、より効率的で費用対効果の高いソリューションが実現されるElasticsearch
            「カラム型DB」はリレーショナルデータベース（RDB）の一種。 データを「ロー（行）」ではなく、「カラム（列）」単位
                「来店日時別の売り上げ集計」といった処理を高速にこなせる
                カラム型DBについて解説して。
                ・データを「ロー（行）」ではなく、「カラム（列）」単位で管理すること、
                ・データをカラム単位で格納することで圧縮が可能
                ・例えば「来店日時別の売り上げ集計」といった処理を高速にこなせる
                ・これにより、効率的で費用対効果の高いソリューションが実現される、ディスクのI/O処理も最適化される
                など特徴とメリットが解説されているのを見かけました。
                カラム型というのは、データベース内のデータ管理がカラムを軸にして行われるってこと？
                行指向、カラム指向でそれぞれ管理すると、具体的にどう違いが現れる？データベースシステム内でファイルに保存するときに違いが出るの？
                カラム型だと、行のまとまりはなくなるということ？なくなるわけではないのであれば、どうデータとして表現される？（行のまとまりは例えば、1回の購入につき、購入のID、購入した日付、購入した商品、金額、購入した顧客のIDがあったとすると、これらを１セットとする考え）
                カラム型のデメリットはある？

- AWS X-Ray SDKを使ったトレースの基本的な流れと設計ポイントを考えてみる
  - 設計ポイント
    - データストレージ要件
      - トレースデータの保存場所
                自己管理
                    Jaeger: オープンソースの分散トレーシングシステム。DockerやKubernetesで簡単にデプロイ可能。
                    Zipkin: もう一つのオープンソースの分散トレーシングシステム。シンプルで軽量。
                商用
                    Datadog: トレース、メトリクス、ログを統合して分析可能。
                    AWS X-Ray: AWSサービスとシームレスに統合された分散トレーシングツール。
                    New Relic, Dynatrace: 高機能な監視とトレーシングを提供                
      - トレースデータの耐久性/保存期間
                短期保存
                    最近のトレースデータはメモリや高性能なストレージに保存してクエリ速度を向上。
                長期保存
                    データ量が膨大になるため、S3やRedshift、Elasticsearchなどのコスト効率が高いストレージを使用。
                        
      - コスト対策
                必要に応じてデータを圧縮して保存、または低頻度のトレース収集を設定
                    データ量の管理
                        DatadogやAWS X-Rayはトレースデータ量に応じて課金されるため、サンプリングポリシーを適切に設定
      - データ分析要件
            マイクロサービス間で一貫したトレースIDを使用して、分散トレーシングを正確に行う
                分析の目的
                    リアルタイム分析
                        ユーザーのリクエストフローやパフォーマンスを即座に可視化。
                    履歴分析
                        過去のトレースを参照して障害の傾向や頻度を特定
      - トレースデータの属性
            リソース属性
                サービス全体で一貫している情報（例: サービス名、バージョン、環境）を設定。
            スパン属性
                各操作やリクエストの詳細情報（例: HTTPリクエスト、エラーコード）を設定
        - パフォーマンスへの影響
          - 非同期バッチ送信を利用し、アプリケーションのレスポンスタイムへの影響を最小化

- AWS上でのシステム構成について検討
  - 例えば、AWS ECSのタスク内にAWS X-Rayデーモンのコンテナを起動しておけば、アプリケーションからOpenTelemetryのライブラリ経由でトレースデータをAWS X-Rayに送信できる(X-Rayの機能での分析が可能になる)
  - AWS X-Rayデーモンを使う場合でも、AWS X-Ray SDKを使わずに、OpenTelemetryを利用してトレースデータをAWS X-Rayに送信することが可能です。この方法を選ぶことで、柔軟性と拡張性を高めることができます。
  - AWS X-Ray, Aurora, Lambda, EC2/ECS

- OpenTelemetryを使ったトレースの基本的な流れ / Go言語とgo-chiフレームワークでOpenTelemetryを使用した簡単な実装
  - ライブラリのインストール
    - go get go.opentelemetry.io/otel
    - go get go.opentelemetry.io/otel/trace
    - go get go.opentelemetry.io/otel/sdk/trace
    - go get go.opentelemetry.io/otel/sdk/resource
    - go get go.opentelemetry.io/otel/exporters/jaeger
    - go get go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp
    - go get github.com/go-chi/chi/v5
  - アプリケーション実装
    - トレーサの初期化
      - Jaeger exporter
    - トレースデータの送信
      - リクエストハンドラから送信
        - spanの開始・終了・属性の追加
          - _, span := otel.Tracer("example-server").Start(r.Context(), "HandleRoot")
            - トレーサー名: example-server
            - スパン名: HandleRoot
          - defer span.End()
        - スパン属性の追加
            - span.SetAttributes(
                attribute.String("http.method", "GET"),
                attribute.String("http.url", "https://example.com"),
                attribute.Int("http.status_code", 200),
            )
        - 実装サンプル(go-chi middlewareから送信)
                package main

                import (
                    "context"
                    "log"
                    "net/http"
                    "time"

                    "github.com/go-chi/chi/v5"
                    "github.com/go-chi/chi/v5/middleware"
                    "go.opentelemetry.io/otel"
                    "go.opentelemetry.io/otel/exporters/jaeger"
                    "go.opentelemetry.io/otel/sdk/resource"
                    "go.opentelemetry.io/otel/sdk/trace"
                    "go.opentelemetry.io/otel/trace"
                    "go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"
                )

                func main() {
                    // Initialize OpenTelemetry
                    tp, err := initTracer()
                    if err != nil {
                        log.Fatalf("failed to initialize tracer: %v", err)
                    }
                    defer func() {
                        if err := tp.Shutdown(context.Background()); err != nil {
                            log.Fatalf("failed to shut down tracer: %v", err)
                        }
                    }()

                    // Create router
                    r := chi.NewRouter()
                    r.Use(middleware.Logger) // Basic logging middleware
                    r.Use(otelMiddleware)    // OpenTelemetry middleware

                    // Define routes
                    r.Get("/", func(w http.ResponseWriter, r *http.Request) {
                        _, span := otel.Tracer("example-server").Start(r.Context(), "HandleRoot")
                        defer span.End()

                        time.Sleep(100 * time.Millisecond) // Simulate some processing
                        w.Write([]byte("Hello, OpenTelemetry with go-chi!"))
                    })

                    // Start server
                    log.Println("Starting server on :8080")
                    if err := http.ListenAndServe(":8080", r); err != nil {
                        log.Fatalf("failed to start server: %v", err)
                    }
                }

                func initTracer() (*trace.TracerProvider, error) {
                    // Create Jaeger exporter
                    exp, err := jaeger.New(jaeger.WithCollectorEndpoint(jaeger.WithEndpoint("http://localhost:14268/api/traces")))
                    if err != nil {
                        return nil, err
                    }

                    // Create tracer provider
                    tp := trace.NewTracerProvider(
                        trace.WithBatcher(exp),
                        trace.WithResource(resource.NewWithAttributes(
                            otel.ServiceNameKey.String("example-service"),
                        )),
                    )

                    // Set global tracer provider
                    otel.SetTracerProvider(tp)

                    return tp, nil
                }

                // OpenTelemetry middleware for go-chi
                func otelMiddleware(next http.Handler) http.Handler {
                    return otelhttp.NewHandler(next, "HTTP Server")
                }

  - Go言語とgo-chiフレームワークでOpenTelemetryを使用した簡単な実装
    ・Goで収集するときの具体的なアプリケーション設計を考える
        ・トレースデータって型の管理はどうなる？
        ・コンポーネントとか関数設計的には、どう分割するべき？
        ・あと、何を気にしながらアプリケーション設計したら良いかも考えてみる。
            ・エラー制御とか。拾えなかったらとか？実
        ・具体的な実装をできるようになりたい

- Fluent Bitを使ったテレメトリ収集のユースケース
  - アプリケーションログの収集と解析
    - 収集対象: アプリケーションが生成するログファイルや標準出力
    - 出力先: Elasticsearch, Grafana Lokiなどの分析ツール。
  - 分散トレーシングの補完
    - Fluent Bitを使ってトレースログを収集し、OpenTelemetryやAWS X-Rayに統合。
  - メトリクスデータの収集
    - Prometheus Exporterを使い、システムやアプリケーションのパフォーマンスメトリクスを収集。
  - クラウド監視ツールとの連携
    - Fluent Bitを使ってAWS CloudWatch、Google Cloud Logging、Azure Monitorなどにデータを送信。

- AWS X-RayのSegment構造定義 https://docs.aws.amazon.com/xray/latest/devguide/xray-api-segmentdocuments.html
    - 必須のセグメントフィールド
        - name – リクエストを処理したサービスの論理名 (最大 200 文字)。たとえば、アプリケーション名やドメイン名です。名前には、Unicode 文字、数字、空白、および次の記号を含めることができます: _､.､:､/､%､&､#､=､+､\､-､@
        - id – セグメントの 64 ビット識別子。16 進数の数字であり、同じトレース内のセグメント間で一意です。
        - trace_id – 1 つのクライアントリクエストから送信されるすべてのセグメントとサブセグメントに接続する一意の識別子です。X-Ray トレース ID 形式
            - X-Ray trace_id は、ハイフンで区切られた 3 つの数字で構成されています。例えば、1-58406520-a006649127e371903a2de979 と指定します。これには、以下のものが含まれます：
            - バージョン番号(1で固定) + 元のリクエストの時刻(8桁,16進数, Unix エポックタイム, 例: 58406520 = 1480615200秒 = 2016 年 12 月 1 日午前 10:00 PST のエポックタイム) + トレース識別子(24桁 16進数)
                - 関連: OpenTelemetry で生成したW3C トレース IDをAWS X-Ray に送信するには、フォーマットを変換する必要がある
                - W3C トレース ID 4efaaf4d1e8720b39541901950019ee5
                - X-Ray に送信する trace_id 1-4efaaf4d-1e8720b39541901950019ee5
        - start_time 
            – セグメントが作成された時間の数値 (エポック時間の浮動小数点で表した秒数)。
            - 例えば、1480615200.010、1.480615200010E9 などです。必要なだけ桁数を使用します。
            利用できる場合は、マイクロ秒の精度をお勧めします
        - end_time 
            – セグメントが切断された時間を表す数値。例えば、1480615200.090、1.480615200090E9 などです。
            - end_time または in_progress のどちらかを指定します。
        - in_progress 
            – end_time ではなく in_progress = trueを設定して、開始されたが完了していないセグメントを記録
                - アプリケーションが処理に時間がかかるリクエストを受信したときに
                - 進行中のセグメントを送信して、リクエストの受信を追跡
                - レスポンスが送信されると
                - 完了したセグメントが送信され進行中のセグメントを上書き
                - リクエストごとに、1 つの完全なセグメントと、1 つまたは 0 個の進行中のセグメントのみを送信します
    - オプションのセグメントフィールド
        - service – アプリケーションに関する情報を含むオブジェクト。
        - version – リクエストに対応したアプリケーションのバージョンを識別する文字列。
        - user – リクエストを送信したユーザーを識別する文字列。
        - origin 
            – アプリケーションを実行している AWS リソースのタイプ。
            - サポートされる値
                - AWS::EC2::Instance – Amazon EC2 インスタンス。
                - AWS::ECS::Container – Amazon ECS コンテナ。
                - AWS::ElasticBeanstalk::Environment – Elastic Beanstalk 環境
            - 複数の値をアプリケーションに適用する場合
                - 最も具体的な値を使用します。たとえば、複数コンテナの Docker Elastic Beanstalk の環境では、Amazon ECS コンテナでアプリケーションが実行され、そのコンテナは Amazon EC2 インスタンスで実行されます。この場合、環境は他の 2 つのリソースの親として、オリジンを AWS::ElasticBeanstalk::Environment に設定します。
        - parent_id 
            – 計測したアプリケーションからリクエストが発信された場合に指定するサブセグメント ID。
            - X-Ray SDK は親サブセグメント ID をダウンストリーム HTTP 呼び出しのトレースヘッダーに追加します。
            - ネストされたサブセグメントの場合、サブセグメントは親としてセグメントまたはサブセグメントを持つことができます。
        - http – 元の HTTP リクエストに関する情報を含むhttpオブジェクト。
        - aws – アプリケーションがリクエストを処理した AWS リソースに関する情報を含む aws オブジェクト。
        - error、throttle、fault、cause 
            – エラーが発生したことを示し、エラーの原因となった例外に関する情報を含む error フィールド。
        - annotations – X-Ray で検索用にインデックスを作成するキーと値のペアを含むannotationsオブジェクト。
        - metadata – セグメントに保存する追加のデータを含むmetadataオブジェクト。
        - subsegments – オブジェクトの配列subsegment。
            - サブセグメントを作成して、
            - AWS SDK で行った AWS のサービス およびリソースへの呼び出し
            - 内部または外部の HTTP ウェブ APIsへの呼び出し、
            - または SQL データベースクエリを記録できます。
            - また、サブセグメントを作成して
            - アプリケーションでコードブロックをデバッグしたり
            - 注釈を付けたりできます。
            - サブセグメントには他のサブセグメントを含めることができる
            - ため
            - 内部関数呼び出しに関するメタデータを記録するカスタムサブセグメントには
            - 他のカスタムサブセグメントおよびダウンストリーム呼び出し用のサブセグメントを含めることができます。
            - サブセグメントは、ダウンストリーム呼び出しを、それを呼び出したサービスの視点から記録します。X-Ray はサブセグメントを使用して、セグメントを送信しないダウンストリームサービスを識別し、そのエントリをサービスグラフに作成します。
            - サブセグメントはフルセグメントドキュメントに埋め込むことも、個別に送信することもできます。サブセグメントを個別に送信して、長期実行されているリクエストのダウンストリーム呼び出しを非同期でトレースしたり、セグメントドキュメントの最大サイズを超えないようにしたりできます。

- アプリケーションでspanデータ型の定義 と spanデータ送信処理を実装する
  - データ型の要素属性(網羅性)、情報サイズ, 計算量(CPU, メモリ)
  - spanデータ送信SDKの呼び出し、送信成功・失敗の判定、送信失敗時の制御（リトライ・２次保存）
  - 部品種類, ファイル・関数・型の命名、コメント
  - 計測対象とする区間
    - 全てのAPI, 特定のAPIのみ選択, 特性のAPIのみ除外
    - APIの開始ー終了, API処理内の部分処理
```

