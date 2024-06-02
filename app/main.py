import asyncio
import uvicorn


if __name__ == "__main__":
    try:
        asyncio.set_event_loop_policy(asyncio.WindowsProactorEventLoopPolicy())
        uvicorn.run("app:app", host="127.0.0.1", port=8000)
    except KeyboardInterrupt:
        print("Received exit signal (Ctrl+C), shutting down gracefully...")
        