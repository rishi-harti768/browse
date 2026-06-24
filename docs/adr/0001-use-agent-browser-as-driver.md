# ADR 0001: Use agent-browser as the Primary Driver

## Status
Accepted

## Context
Assignment 04 specifies building an intelligent browser automation agent using standard automation libraries like Playwright or Puppeteer in any programming language. 
However, standard libraries are Node-based or Python-based and require processing massive raw DOM trees, which:
1. Consumes extremely large amounts of context tokens.
2. Leads to element identification hallucination or selector staleness.
3. Is non-trivial to bundle into lightweight, portable CLI plugins for Antigravity CLI.

## Decision
We will use **Vercel's `agent-browser`** as our primary browser automation engine and driver. 

`agent-browser` is a native Rust-based CLI that utilizes direct Chrome DevTools Protocol (CDP) and features a revolutionary **snapshot-and-reference** pattern. Instead of digesting raw DOMs, it produces compact accessibility trees where each interactive node is marked with a stable reference (e.g., `@e1`, `@e2`).

## Consequences
- **Pros**:
  - Highly token-efficient and fully AI-native.
  - Native integration as an Antigravity plugin and embedded skill.
  - Fast execution and self-healing.
  - Eliminates heavy local Node.js compilation or complex Playwright setups.
- **Cons**:
  - Departs from the explicit "Playwright/Puppeteer" suggestion in `ASSIGNMENT.md`. However, since `agent-browser` manages Chromium via CDP directly, it meets and exceeds the technical criteria of visual automation, headed debugging, and intelligent element identification.
