#!/bin/bash
set -e

REPO="/Users/clairedebadts/kaggle/Playground_Series/S6/Predicting_Irrigation/predicting-irrigation"
cd "$REPO"

# ── Additional folders ──
mkdir -p notebook models submissions

# ── .gitignore ──
cat << 'GITIGNORE' > .gitignore
# Data (too large for git)
Data/train.csv
Data/test.csv

# Keep sample_submission.csv (small, useful reference)

# Jupyter checkpoints
.ipynb_checkpoints/
**/.ipynb_checkpoints/

# Python
__pycache__/
*.py[cod]
*.egg-info/
.env
venv/
.venv/

# macOS
.DS_Store

# Kaggle credentials
kaggle.json
GITIGNORE

# ── README ──
cat << 'README' > README.md
# Predicting Irrigation Need
**Kaggle Playground Series S6E4**

Predict irrigation need (Low / Medium / High) for agricultural fields.  
Metric: Balanced Accuracy

## Key insight
A community member reverse-engineered the exact generative formula from the original dataset.  
The formula perfectly separates all 10k original rows (BA = 1.0) using just 6 features:
- `Soil_Moisture` < 25
- `Rainfall_mm` < 300
- `Temperature_C` > 30
- `Wind_Speed_kmh` > 10
- `Crop_Growth_Stage` (Harvest / Sowing → low irrigation need)
- `Mulching_Used` (Yes → lower need)

## Notebooks
| # | Notebook | Description |
|---|----------|-------------|
| 01 | `01_EDA.ipynb` | Exploratory data analysis |
| 02 | `02_Cleaning_Rebalancing.ipynb` | Cleaning, feature engineering, rebalancing |
| 03 | `03_Model_LightGBM.ipynb` | LightGBM + Optuna |
| 04 | `04_Model_XGBoost.ipynb` | XGBoost + Optuna |
| 05 | `05_Model_CatBoost.ipynb` | CatBoost + Optuna |
| 06 | `06_Ensemble.ipynb` | Stacking / blending |

## Structure
```
├── Data/
│   ├── train.csv              # gitignored (large)
│   ├── test.csv               # gitignored (large)
│   └── sample_submission.csv
├── notebook/
│   └── 01_EDA.ipynb
├── models/                    # saved model artefacts
├── submissions/               # submission CSVs
└── README.md
```

## Setup
```bash
pip install numpy pandas matplotlib seaborn scipy scikit-learn lightgbm xgboost catboost optuna
```

## Results
| Model | CV Balanced Accuracy | LB Score |
|-------|---------------------|----------|
| Formula baseline | - | - |
| LightGBM | - | - |
| XGBoost | - | - |
| CatBoost | - | - |
| Ensemble | - | - |
README

# ── Gitkeep files so empty folders are tracked ──
touch models/.gitkeep submissions/.gitkeep

# ── Commit and push ──
git add .
git commit -m "chore: repo structure, README, .gitignore

- README with formula insight, notebook index, results table
- .gitignore: large CSVs excluded, sample_submission kept
- models/ and submissions/ folders with .gitkeep
- notebook/ already contains 01_EDA.ipynb"

git push origin main
echo ""
echo "Done. Final structure:"
tree .
