---
layout: page
permalink: /publications/
title: Publications
description: Here you can find my machine learning research papers, MSc thesis, and EngD thesis.
years: [2023, 2021, 2019, 2018]
nav: true
nav_order: 1
---
<!-- _pages/publications.md -->
<div class="publications">

{%- for y in page.years %}
  <h2 class="year">{{y}}</h2>
  {% bibliography -f papers -q @*[year={{y}}]* %}
{% endfor %}

</div>
