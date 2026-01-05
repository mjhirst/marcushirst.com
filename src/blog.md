---
layout: page
title: Posts
---
<a class="btn" href="<%= relative_url '/feed.xml' %> target='_blank'"> RSS </a>

<ul>
  <% collections.posts.resources.each do |post| %>
    <li>
      <a href="<%= post.relative_url %>"><%= post.data.title %></a>
    </li>
  <% end %>
</ul>
