---
layout: post
title:  "From Notion to Ghost"
date:   2023-10-03 20:47:36 +0100
categories: howto
headshot: notion-to-ghost.png
---

I’ve tried running a few blogs in my time. I’m still not quite settled on a platform I like using but I thought it might be nice to share what I’m doing right now.

Mostly because I had to write a block of code to do it and it’s overcomplicated and I’ll forget!

A productivity tip I almost-remember from a book, who’s name I can’t fathom and I’m sure I’ll misquote went along the lines of

> ‘try to minimise the number of in boxes you have’.
>

The author meant the number of places you have information. Emails, magazines, news websites, to-do lists, etc… Any place you retain information, or add a task to. Additionally, most well-designed, cross-platform, writing apps I’ve come across charge a monthly subscription or to publish to another platform. (Fair enough! The developers deserve the money.) So I wanted to use something I have already and like: [Notion](https://notion.so). I know it’s not everyone’s cup of tea but I enjoy it. And importantly, if I want to keep blogging I want to try and make it as frictionless for me as possible!

However, Notion does not support posting to Ghost.

I’ve used other blog software. Jekyll and GitHub pages just never clicked. Writing Markdown was cumbersome (I know, I know it’s designed to be inline) but I prefer the WYSIWYG editors. I sponsored Ghost back in the day when they ran their Kickstarter campaign and things have certainly changed since then! So I thought it was worth giving it another go.

I also enjoy self-hosting things. That way I get to learn more about how software works with the OS, containerisation, networking with the added bonus is that the data is all mine and mostly in my control. I’ve chosen to use [Activepieces](https://www.activepieces.com) to stitch a workflow together. Consider it a self-hosted version of Zapier or IFTTT.

The workflow I have is not perfect. Right now I’m moderately sure… definitely sure it doesn’t support images but it does support Notion, Ghost and I can tamper with the data/middle bits as I want. Good enough for today.

The current Notion integration only supports Databases, not Pages. Right now I have a what-I-call ‘Draft’ and ‘Published’ databases. When a new item is added the the Published database (Activepieces checks every 5 minutes on the self-hosted version by default) the workflow will run and be sent to my Drafts in Ghost (so I can check it!).

However, the database only returns the attributes on the table, not sub pages. Try writing something long, and raw HTML formatted in that space on Notion’s UI. Awful. It’s not designed for that.

With some API wizardry, we can take the Database’s item UUID we’ve just created, fetch the sub-page’s Blocks (each paragraph is a Block, and it the unit Notion charges for) and then wrangle all the raw text back into HTML and send it to Ghost.

## Getting set up

I won’t cover installing Activepieces or connecting it to Notion or Ghost. But this method does require a custom Notion Integration [which you can set up over at their API](https://developers.notion.com). We need a Integration Key to make a HTTP request later. Also make sure to share the Published database with your Integration or you’ll see lots of `404 - Not Found` errors in the API call.

In Activepieces, create a new workflow. I’ve used four stages.

1) **the trigger** Notion when a new item in the database is created.

2) A HTML request I use to then fetch the information on the sub-page

3) A code block to transform the resulting JSON into a string of HTML

4) Post a new article to Ghost CMS

## The Notion API

Make a request to `GET https://api.notion.com/v1/blocks/<UUID of the Page from the first step>/children` also including the Authorisation and Notion-Version headers as noted in the API docs.

This returns a JSON blob. We’re interested in the `results` array which is passed to the code block via. a parameter. so inputs.results is something we can use in the Code step without having to worry about the very top-level information we already have in the initial request to Notion.

My code block looks like this. It maps each Block in the Notion page. Each block can have multiple text sections. For example, a link will break up a block and count as another text section. This is why it’s horrible to write it all in a Notion database attribute.

The only setup in the Code block is passing in the results array from the earlier call. I will admit I used ChatGPT here to help me understand how to concatenate each text chunk inside the Block. And it’s not perfect, I needed something which would wrangle a jumble of JSON.

```jsx
// We use this later to get the content of the text and any of the
// formatting stored in the annotations section.
function applyAnnotations(textElement) {
  let content = textElement.text.content;
  const annotations = textElement.annotations;

  // Wrap links as required
  if (textElement.text.link) {
    content = `<a href="${textElement.text.link.url}">${content}</a>`
  }

	// Run through the annotations section to get the formatting
	// and sandwich the content in appropriate tags
  if (annotations.code) {
    content = `<code>${content}</code>`;
		// we don't want the extra formatting in a code block
  } else {
    // Seperate ifs for multiple attributes
    if (annotations.bold) {
      content = `<strong>${content}</strong>`;
    }
    if (annotations.italic) {
      content = `<em>${content}</em>`;
    }
    if (annotations.underline) {
      content = `<u>${content}</u>`;
    }
    if (annotations.strikethrough) {
      content = `<del>${content}</del>`;
    }

    // Handle other annotations as needed

    }
    return content;
};

// This is the main function. Activepieces requires an exported constant
// called `code` which it can run.
export const code = async (inputs) => {
  const jsonResponse = inputs.results

  function wrapRichTextInHTML(blocks) {
    let htmlOutput = '';

		// Loop through the blocks and apply the formatting to each of their
		// text elements. I'm sure this could bt DRYer, but at least unsupported
    // blocks fall through the if/else statements
    blocks.forEach(block => {
      if (block.type === 'paragraph') {
        const richText = block.paragraph.rich_text.map(textElement => {
            return applyAnnotations(textElement)
        }).join('');
        htmlOutput += `<p>${richText}</p>`;

      } else if (block.type === 'quote') {
        const richText = block.quote.rich_text.map(textElement => {
            return applyAnnotations(textElement)
        }).join('');
        htmlOutput += `<blockquote>${richText}</blockquote>`;

      } else if (block.type === 'code') {
        const richText = block.code.rich_text.map(textElement => {
            return applyAnnotations(textElement)
        }).join('');
        htmlOutput += `<pre><code>${richText}</code></pre>`;

      } else if (block.type === 'heading_1') {
        const richText = block.heading_1.rich_text.map(textElement => {
            return applyAnnotations(textElement)
        }).join('');
        htmlOutput += `<h1>${richText}</h1>`;

      } else if (block.type === 'heading_2') {
        const richText = block.heading_2.rich_text.map(textElement => {
            return applyAnnotations(textElement)
        }).join('');
        htmlOutput += `<h2>${richText}</h2>`;

      } else if (block.type === 'heading_3') {
        const richText = block.heading_3.rich_text.map(textElement => {
            return applyAnnotations(textElement)
        }).join('');
        htmlOutput += `<h3>${richText}</h3>`;
      }
        // Handle other block types if needed (e.g., headings, etc.)
        // This is where I'll add image support some day...
    });
    return htmlOutput;
    }

  // Usage
  const generatedHTML = wrapRichTextInHTML(jsonResponse);
  return generatedHTML
};
```