+++
title = "Привет, мир"
date = 2026-09-10T12:00:00+03:00
draft = false
tags = ["разное"]
summary = "Первая запись в блоге и краткая инструкция, как писать статьи."
+++

Это первая статья в блоге, собранном на [Hugo](https://gohugo.io/) с темой
[PaperMod](https://github.com/adityatelange/hugo-PaperMod).

## Как добавить новую статью

```bash
hugo new content posts/moya-statya.md
```

Файл появится в `content/posts/`. Откройте его, впишите текст в Markdown,
поставьте `draft = false` — и статья готова к публикации.

## Локальный предпросмотр

```bash
hugo server -D
```

Откройте <http://localhost:1313>. Сервер сам перезагружает страницу при
сохранении файла.

## Публикация

Просто закоммитьте и запушьте в ветку `main`. GitHub Actions соберёт сайт
и выложит его на <https://daniil00d.github.io>.
