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
./scripts/new-post.ps1 "Заголовок статьи"
```

Скрипт сделает slug (транслит с русского) и создаст `content/posts/<slug>.md`.
Либо вручную:

```bash
hugo new content posts/moya-statya.md
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
| `content/search.md`, `content/archives.md` | страницы поиска и архива |
| `archetypes/posts.md` | шаблон новой статьи |
| `static/` | статика как есть (напр. `static/new_year/`) |
| `hugo.toml` | конфигурация сайта |
| `themes/PaperMod/` | тема (submodule) |
