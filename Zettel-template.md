```yaml
---
# Version: 2024.02.25.1
# This self-documenting Zettel template specifies the format of 
# a Zettel suitable for a digital Zettelkasten. The Zettel is
# organized as a Markdown file, beginning with this YAML 
# frontmatter followed by self-documenting Markdown sections 
# in the order of presentation. The YAML frontmatter contains
# commands to Zettlr, Pandoc, and Obsidian and includes, 
# at minimum, the following variables: `title:` and 
# `reference-section-title:` 

title: "immutableID Zettel Template title"

# The value of the `title:` variable is a quoted string, 
# consisting of a unique, immutable ID, in this case 
# `immutableID`, followed by the Zettel title, in this case
# "Zettel Template title" Immutable, unique IDs may have 
# different formats, according to personal perference. 
# Timestamps are a popular choice, followed by Folgezettel. 

reference-section-title: References

# The `reference-section-title:` variable is a command to Pandoc.
# If Zettel is exported through Pandoc and the Zettel 
# body includes Pandoc-style citations, the 
# `reference-section-title:` variable will cause a 
# References section with citations to appear at the 
# end of the document. 
---
```

# \# immutableID  Zettel title

This section is the H1 header, combining an immutable, unique ID followed by the Zettel title. The title should reflect the single focus of the Zettel. Titles aren't immutable, unlike IDs. 

NOTE: The Zettel body begins with the H1 header and ends immediately before the **SEE ALSO** section, below.

## Zettel body sub-section

The body of a Zettel should adhere to the following three principles.

1. **Single-focus principle**: A Zettel must maintain a single focus.
2. **WikiLinks usage**: WikiLinks indicate shifts in focus between different Zettels. WikiLinks in the body of the Zettel should be annotated to motivate or explain the shift in focus.
3. **Future self orientation**: Zettels should be crafted with the author's future self in mind, prioritizing clarity and utility over general consumption.

### A subsection of the Zetttl body

To keep the explanatoty text within the Zettel body, we describe the remaining sections: **SEE ALSO** and **References**.

- **SEE ALSO.** This section guides readers to related content, further contextualizing the Zettel focus without cluttering the body of the note. It includes an indented list of hashtags, WikiLinks to related Zettels, and one or more index Zettels. Hashtags and WikiLinks placed under the **SEE ALSO** section heading are self-explanatory. WikiLinks under **SEE ALSO** should include the Zettel title, but no additional annotation.
     - In the **SEE ALSO** section below, I include the WikiLink and title `[[ZKID.0.23.0225]] ID Format`, which describes my choice of ID formats. Note that since the preceding WikiLink appears in the Zettel body, it is annotated with additional explanation, whereas under the **SEE ALSO** section, it is annotated only with the Zettel title "ID Format." 
     - Next is the complete list of my index Zettels, which take advantage of the Related files pane of  Zettlr, and likewise with Obsidian. If the user navigates to an index Zettel, the Zettels that link to that index Zettel will appear in the "Related files" pane of Zettlr. This feature creates an alphabetical index for free. You need not use my indexing system.
- **References.**  If there are Pandoc style references present in the body of the Zettel, such as `[@ahrensHowTakeSmart2017]`, the  `reference-section-title:` field in the YAML frontmatter will direct Pandoc to generate a References section at the end of the exported document. Otherwise, the References section can be added by hand or omitted if there are no citations.

## SEE ALSO

 #this #section #contains #hashtags #then #wikilinks #with #titles #only

[[ZKID.0.23.0225]] ID Format  
[[0000.0000.0000]] INDEX  
[[0000.0000.0ABC]] A-B-C  
[[0000.0000.0DEF]] D-E-F  
[[0000.0000.0GHI]] G-H-I  
[[0000.0000.0JKL]] J-K-L  
[[0000.0000.0MNO]] M-N-O  
[[0000.0000.0PQR]] P-Q-R  
[[0000.0000.0STU]] S-T-U  
[[0000.0000.0VWX]] V-W-X  
[[0000.0000.00YZ]] Y-Z  
[[0000.0000.0009]] 0-9  

## References

- Ahrens, Sönke. 2017. _How to take smart notes_. North Charleston, SC: CreateSpace.
- Doctorow, Cory. 2009. “Writing in the Age of Distraction.” [Link](http://www.locusmag.com/Features/2009/01/cory-doctorow-writing-in-age-of.html)
- Fast, Sascha. 2018. “The Difference Between Good and Bad Tags.” [Zettelkasten.de](https://zettelkasten.de/posts/object-tags-vs-topic-tags)
