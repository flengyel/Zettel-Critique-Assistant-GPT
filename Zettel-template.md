# Zettel template

The template specifies the format of a Zettel in the order that sections occur. Each section is preceded with a brief explanation, followed by an example.

## YAML frontmatter

YAML frontmatterZettel metadata reside in the YAML frontmatter, which provides Zettlr and Obsidian compatibilty and facilitates automatic processing. Keeping metadata and content separate has a cost: the value of the `tags:`, `context:`, and `index:` variables must be YAML arrays with quoted strings, and the `title:` variable should be quoted to avoid clashing with YAML syntax.

Example YAML frontmatter

```yaml  
---
title: "UniqueImmutableID Your title goes here"
reference-section-title: References
context:
  - "[[ZKID.0.23.0225]] ID Format"
  - "[[ZKM.4d.0.23.1007]] Zettel Template 5.0"
tags:
  - "#replace"
  - "#these"
  - "#hashtags"
index:
  - "[[0000.0000.00YZ]] Y-Z"                                                                                           
---
```

## H1 Header: Unique, Immutable ID and Title

The next section is the H1 header, combining an immutable, unique ID followed by a title. The title should reflect the single focus of the Zettel. Titles aren't immutable, unlike IDs.

Example H1 Header

```markdown
# ZKM.0.2024.02.24 Zettel Template
```

## Body

The body of a Zettel should adhere to the following three principles.

- **Single-focus principle**: A Zettel must maintain a single focus.
- **WikiLinks usage**: Use WikiLinks to indicate shifts in focus between different Zettels. WikiLinks should be annotated to motivate or explain the shift in focus.
- **Future self orientation**: Zettels should be crafted with the author's future self in mind, prioritizing clarity and utility over general consumption.

### Example body

See the preceding subsection.

## 3. References

If there are Pandoc style references present in the body of the Zettel, the  `reference-section-title:` field in the YAML header will direct Pandoc to generate the following References section when the Zettel is exported.  Otherwise, the References section can be added by hand.

### Example references format

## References
- Ahrens, Sönke. 2017. _How to take smart notes_. North Charleston, SC: CreateSpace.
- Doctorow, Cory. 2009. “Writing in the Age of Distraction.” [Link](http://www.locusmag.com/Features/2009/01/cory-doctorow-writing-in-age-of.html)
- Fast, Sascha. 2018. “The Difference Between Good and Bad Tags.” [Zettelkasten.de](https://zettelkasten.de/posts/object-tags-vs-topic-tags)
```
