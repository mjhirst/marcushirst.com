---
layout: post
title:  "Using LLMs for Purposeful Conversations"
date:   2023-10-23 20:47:36 +0100
categories: longform lecture
headshot: 0A21C064-C681-47BE-AC3B-B8B8F5ED8678.jpg
---

I’ve just attended a talk at the British Computing Society (BCS) given by Phillip Greenwood and Prof. Mark Woodman on the titular topic.

I’m feeling galvanised partly because I understood most of the topic matter - although the pair giving the speech were lecturers, or at least, subtly selling their platform to the room.

One demonstration that got me in particular was around creating your own dataset for LLM Inference. It didn’t appear that hard in terms of process (a fancy term for a large language model to train itself on your own dataset by trying to predict patterns). I did clock the amount of prompt engineering it took and the errors it spewed. The result was still pretty amazing, it had taken a PDF and produced a graph of terms for the rules of tennis. I’ve been working with neo4j for a year now and it still baffles me.

The PDF had its text extracted. It was then fed to the LLM. I suppose you could use GPT-4 or similar (in fact, I’m unsure if they were running a homebrew LLM) and ask it to build a query. They gave it some syntax in the prompt of what the language should look like - in this case it was Cypher for Neo4J - and then gave it a hook somewhere to execute it.

This was a demo of a retrieval augmented-generation (RAG) to improve an LLM but the same process could be applied to a CRM type of system. They suggested not building a graph for this sort of data, but just get the LLM to build the queries and turn the responses back into natural language.

the second point on conversations was fascinating too. Turns out a chat is just a chat, but a conversation leads to an action.

My running theme is that the magic sauce is all their proprietary tech.

But they had reverse-engineered a conversation around ‘how to pick a career’. Working from a well-known framework which helps people select careers; if you like what you do you’ll typically have a better time; and worked backwards, quite a few different steps and prompts later to reach the start.

Their tool was plugged into Slack, we could see the sentiment analysis live and the classification of where the LLM at the time thought the conversation should go next by using classification.

These are both applicable to (different) projects I’m working on at the moment and definitely want to give these a try! Ultimately it seems to be an easier way to get AI to help you around data. Get the AI to produce the queries on top of your data by giving it a bit of context around your models.

AI is trained on human data, and it does make mistakes. We still expect it to be perfect even though humans aren’t perfect. We (I’m) so used to getting a computer to produce the same, correct output each time and any deviation is a bug. The host of the event at the BCS (asked me to read a Google definition of what Conversational AI is at the beginning of the talk, no stage-fright for me!) ended with a thought if we held ourselves to the standard we hold AI to.