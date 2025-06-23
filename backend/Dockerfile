# --- Stage 1: Build Environment ---
FROM python:3.11-slim AS builder
WORKDIR /app
COPY backend/requirements.txt .
RUN pip install --upgrade pip && pip install --user -r requirements.txt

# --- Stage 2: Runtime Environment ---
FROM python:3.11-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH
COPY backend .
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

