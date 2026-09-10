# daniil00d.github.io

Личный блог на [Hugo](https://gohugo.io/) + тема [PaperMod](https://github.com/adityatelange/hugo-PaperMod).
Публикуется на <https://daniil00d.github.io> автоматически через GitHub Actions при пуше в `main`.

## Установка (Windows)

Hugo (extended) уже лежит в `C:\Users\Daniil\bin\hugo.exe` и в PATH. Проверка:

```bash
hugo version
```

Тема подключена как git submodule. После свежего клона:

```bash
git submodule update --init --recursive
```

## Новая статья

```powershell
./scripts/new-post.ps1 "Заголовок статьи" -Slug "english-slug"
```

Заголовок — на любом языке, **slug (имя файла и URL) — латиницей**. Скрипт создаст
`content/posts/<slug>.md`. Если заголовок и так на латинице, `-Slug` можно не
указывать. Либо вручную:

```bash
hugo new content posts/english-slug.md
```

В front matter выставьте `draft = false`, когда статья готова.

## Локальный предпросмотр

```bash
hugo server -D
```

<http://localhost:1313> — черновики видны с флагом `-D`.

## Публикация

```bash
git add -A && git commit -m "новая статья" && git push
```

Workflow `.github/workflows/hugo.yml` соберёт и задеплоит сайт.

> Один раз в настройках репозитория: **Settings → Pages → Build and deployment → Source → GitHub Actions**.

## Структура

| Путь | Назначение |
|------|-----------|
| `content/posts/` | статьи в Markdown |
| `content/search.md`, `content/archives.md`, `content/about.md` | страницы поиска, архива и «О проекте» |
| `archetypes/posts.md` | шаблон новой статьи |
| `assets/css/extended/custom.css` | локальные правки стилей темы |
| `static/` | статика как есть (напр. `static/new_year/`) |
| `hugo.toml` | конфигурация сайта |
| `themes/PaperMod/` | тема (submodule) |

## Цикл статей

Посты одной серии связываются через `categories` во front matter (напр.
`categories = ["Язык для данных"]`) и общий тег. Все посты серии — на
`/tags/<тег>/`.
