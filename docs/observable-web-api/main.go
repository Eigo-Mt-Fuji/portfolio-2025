package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp"
	semconv "go.opentelemetry.io/otel/semconv/v1.24.0"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp" // 追加
	"go.opentelemetry.io/otel/sdk/resource"
	"go.opentelemetry.io/otel/sdk/trace"
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
		// Get tracer from global provider
		tracer := otel.Tracer("example-server")
		_, span := tracer.Start(r.Context(), "root-handler")
		defer span.End()

		// Add some attributes to the span
		span.SetAttributes(
			semconv.HTTPMethodKey.String("GET"),
			semconv.HTTPRouteKey.String("/"),
		)

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
	// Jaegerエクスポーターを削除し、OTLP HTTPエクスポーターに置き換え
	// Package otlptracehttp provides an OTLP span exporter using HTTP with protobuf payloads. By default the telemetry is sent to https://localhost:4318/v1/traces.
	// https://pkg.go.dev/go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp@v1.33.0
	exp, err := otlptracehttp.New(context.Background(),

		otlptracehttp.WithEndpointURL(os.Getenv("JAEGER_ENDPOINT")),
		otlptracehttp.WithInsecure(),
	)
	if err != nil {
		return nil, err
	}

	// Create tracer provider
	tp := trace.NewTracerProvider(
		trace.WithBatcher(exp),
		trace.WithResource(resource.NewWithAttributes(
			semconv.SchemaURL, // スキーマURLを追加
			semconv.ServiceNameKey.String("example-service"),
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
