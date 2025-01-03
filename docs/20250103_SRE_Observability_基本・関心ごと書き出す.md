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
