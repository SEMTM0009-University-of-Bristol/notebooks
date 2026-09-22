# SEMTM0009 — worksheet notebooks

Computational templates for **SEMTM0009, Mathematical Modelling in Biology,
Medicine and Public Health** (University of Bristol).

This repository holds only the notebooks you fill in. Lectures, worksheets and
solutions are on Blackboard.

| Week | Notebook | Open in Colab |
|---|---|---|
| 1 | `Week1/week1_template.ipynb` | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/SEMTM0009-University-of-Bristol/notebooks/blob/main/Week1/week1_template.ipynb) |

## Running a notebook in Google Colab

1. Click the **Open in Colab** badge above. It opens in your browser; nothing to
   install.
2. Click **Copy to Drive** (top left). **Do this first.** Until you do, Colab
   will not save anything you type, and closing the tab loses your work.
3. Work through the notebook. The scaffolding is written; the lines you supply
   are marked `# TODO`. Run a cell with **Shift+Enter**.

Every `# TODO` returns `np.nan` until you fill it in, so the notebook runs from
top to bottom at any stage — **a blank or flat plot means an unfilled cell, not
a bug.**

Colab needs a Google account. If you would rather not use one, the notebook is
an ordinary `.ipynb`: download it from the green **Code** button above and run
it in Jupyter, VS Code or Anaconda with `numpy`, `scipy` and `matplotlib`.
Week 1 also ships `week1_template.m`, the same exercise in MATLAB — use
whichever you prefer.
