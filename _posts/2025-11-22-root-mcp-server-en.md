---
layout: post
title: "Announcement: new development — root_mcp_server"
date: 2025-11-22 10:00:00 +0000
categories: [Announcements, ROOT]
tags: [ROOT, MCP, server]
featured: /img/posts/ROOT.png
---
 
I am announcing a new development related to ROOT: the repository
<a href="https://github.com/omazapa/root_mcp_server">root_mcp_server</a>.

This project implements an MCP (Model-Context-Protocol) server that allows executing
ROOT code (both Python and C++) inside a ROOT process via the MCP protocol.
Unlike a simple HTTP API, MCP provides a protocol for sending code snippets, invoking
ROOT functionality, and receiving structured results — enabling interactive
execution of analysis tasks within a controlled ROOT runtime.