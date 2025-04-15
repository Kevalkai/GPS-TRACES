# Use an official Python runtime as a parent image.
FROM python:3.10-slim

# Set environment variables to prevent Python from writing .pyc files and buffering stdout/stderr.
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies for geospatial packages.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gdal-bin \
    libgdal-dev \
    libgeos-dev \
    libspatialindex-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container.
WORKDIR /app

# Copy the requirements file into the container at /app.
COPY requirements.txt .

# Upgrade pip and install Python dependencies.
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Copy your notebook and any additional files into the container.
COPY "traces_analysis.ipynb" .

# Expose port 8888 for Jupyter Notebook (adjust if you plan to use another port, e.g., if running a FastAPI server).
EXPOSE 8888

# Define environment variable to allow Jupyter Notebook to be run as root (if needed).
ENV JUPYTER_ENABLE_LAB=yes

# Command to run Jupyter Notebook.
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
