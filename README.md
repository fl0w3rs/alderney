# Alderney

Система онлайн-тестирования для игрового сообщества: вступительные тесты, экзамены для фракций, проверка знания правил. Вход через аккаунт форума, доступ к тестам по группам, ручная проверка ответов и уведомления о результатах в Discord. Сделана в 2021 году для проекта Lost.

![Вопрос теста](docs/screenshots/03-question.png)

## Скриншоты

### Участник

| | |
|---|---|
| ![Вход](docs/screenshots/01-login.png) Вход через форум | ![Тесты](docs/screenshots/02-home.png) Доступные тесты |

### Админка

| | |
|---|---|
| ![Тесты](docs/screenshots/08-tests.png) Список тестов | ![Вопросы](docs/screenshots/09-questions.png) Вопросы теста |
| ![Тест](docs/screenshots/06-test-edit.png) Настройки теста | ![Вопрос](docs/screenshots/07-question-edit.png) Редактор вопроса |
| ![Результаты](docs/screenshots/04-results.png) Результаты участников | ![Разбор](docs/screenshots/05-result-review.png) Разбор ответов с ручной проверкой |

## Возможности

- **Тесты** — лимит времени, случайная выборка вопросов, проходной процент, доступ по группам форума, открытие и закрытие теста.
- **Типы вопросов** — один ответ, несколько ответов, свободный текст.
- **Контроль прохождения** — таймер на сервере и keepalive-запросы. Если участник закрывает страницу во время теста, попытка сразу завершается и подсчитывается.
- **Проверка** — список попыток, разбор каждого ответа, ручная отметка ответа как правильного (для вопросов со свободным ответом), пересдача.
- **Роли** — администратор редактирует тесты и вопросы, тренер проверяет результаты. Роли и доступ берутся из групп форума IPS4.
- **Discord** — уведомления о сдаче, провале и закрытии страницы через вебхук.

## Стек

PHP 7.4, [FastRoute](https://github.com/nikic/FastRoute), [Twig](https://twig.symfony.com/), [RedBeanPHP](https://redbeanphp.com/), [Rakit Validation](https://github.com/rakit/validation), MySQL, jQuery, axios, MDBootstrap, Laravel Mix.

## Структура

```
database.sql           схема базы
public/                document root: index.php с маршрутами, собранные ассеты в dist/
core/
  config.php           настройки (базы, адрес сайта, вебхук Discord)
  controllers/         страницы и API: тесты, прохождение, админка
  facades/             авторизация через форум, логика тестов, Discord
  views/               Twig-шаблоны
assets/                исходники стилей и JS (собираются в public/dist)
```

## Запуск

1. Создать базу и импортировать `database.sql`. Для входа нужна база форума IPS4: используются таблицы `core_members`, `core_members_known_devices`, `core_groups` и `core_sys_lang_words`.
2. Заполнить `core/config.php`: доступы к обеим базам, `base_link` (полный адрес сайта), группы администраторов и тренеров, вебхук Discord (можно оставить пустым).
3. Установить зависимости и собрать фронт (Node.js 18+, именно Yarn: версия webpack закреплена через `resolutions`):
   ```
   composer install
   yarn install
   yarn production
   ```
4. Отдавать `public/` через Apache с `mod_rewrite` по адресу `/alderney`. `RewriteBase` в `public/.htaccess` должен совпадать с этим путём.
