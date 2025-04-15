# 🚗 GPS Trace Analysis & Stop Detection

This project performs rule-based and clustering-based stop detection from raw GPS traces. It includes:

- Data exploration with KDE heatmaps  
- Feature engineering (distance, speed, acceleration)  
- Rule-based stop detection based on distance and duration thresholds  
- DBSCAN-based stop clustering using haversine distance  
- Interactive FastAPI backend served directly from the notebook  
- Visualizations of individual traces with detected stops  
- Containerized with Docker for reproducibility  

---

## 📂 Project Structure

- **`traces_analysis.ipynb`**: The main notebook containing the full pipeline — including data processing, FastAPI server, and visualizations  
- **`requirements.txt`**: Python dependencies required to run the notebook and FastAPI server  
- **`Dockerfile`**: Containerizes the notebook and exposes the FastAPI server for reproducible deployments  
- **`output/`**: Auto-generated folder that contains:
  - CSV files of detected stops  
  - PNG visualizations of GPS traces and stops  

---

## 🧠 Assumptions

- GPS data contains a `geom_wkt` column for raw geometry, as well as `ts`, `device_id`, and `trace_number`  
- Each GPS trace represents a single journey for one device  
- Kalman filter is used to smooth noisy GPS points before computing movement features  
- Stops are defined as periods where the vehicle remained within 30 meters for at least 60 seconds  
- DBSCAN clustering is applied **per trace**, preventing GPS points from different trajectories from mixing  

---

## 🚀 How to Run

## ⚙️ How to Run

### 1. Run via Jupyter Notebook

```bash
# Install dependencies
pip install -r requirements.txt

# Open notebook
jupyter notebook traces_analysis.ipynb

## 📊 Outputs

After uploading a CSV, the pipeline generates:

- Two CSV files with detected stops:
  - `rule_based_stops_output.csv`
  - `dbscan_stops_output.csv`
- Visual plots (one per trace) showing trajectories and detected stops, saved in:
  - `./output/rule_based_stops_output/`
  - `./output/dbscan_stops_output/`


## ✅ Example Input Format

CSV with the following structure:

```csv
ts,geom_wkt,device_id,trace_number
2023-01-01 08:00:00,POINT (4.3517 50.8503),1,1
2023-01-01 08:00:05,POINT (4.3518 50.8504),1,1
```

---

## 📬 API Endpoint

**POST** `/upload_csv/`

- Accepts: a `.csv` file with GPS traces  
- Returns: JSON containing:
  - Paths to rule-based stop outputs  
  - Paths to DBSCAN-based stop outputs  
  - Paths to corresponding visualizations  

---

## 🙌 Credits

Kevin Al-KAI
