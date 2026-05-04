FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

WORKDIR /app
ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    PATH="/app/.venv/bin:$PATH"

# ODBC Driver 17 para SQL Server
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl gnupg ca-certificates iputils-ping \
 && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
 && echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/microsoft-prod.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install -y --no-install-recommends msodbcsql17 unixodbc \
 && ls /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17*.so* \
 && apt-get purge -y curl gnupg \
 && rm -rf /var/lib/apt/lists/*

COPY app/pyproject.toml ./
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --no-install-project

COPY app/ ./

EXPOSE 5000
CMD ["waitress-serve", "--listen=0.0.0.0:5000", "app:app"]
