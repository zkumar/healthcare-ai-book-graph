# Healthcare AI Book — Knowledge Graph

Interactive knowledge graph of a 21-chapter book on healthcare AI. Nodes are concepts, frameworks, regulatory bodies, and chapter references; edges are relationships extracted from the prose (cited, conceptually related, semantically similar).

**Live:** https://zkumar.github.io/healthcare-ai-book-graph/

## How to read it

- **Node color** — community (Leiden clustering by edge density). 26 named communities + a few singletons.
- **Node size** — degree (more connections = bigger). The big nodes are the structural backbone of the book.
- **Edge between two clusters** — a cross-chapter bridge, often where the most interesting ideas live.

## Generated with

[graphify](https://github.com/safishamsi/graphify) — runs the full extraction pipeline on a folder of `.docx` chapters.

## Updating

After re-running `/graphify .` in the book folder:

```bash
./update-graph.sh
```

Pushes the latest `graph.html` and the GitHub Pages site updates within ~30 seconds.
