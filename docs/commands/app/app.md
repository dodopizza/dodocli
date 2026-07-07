# Команды App 📱

Группа команд для управления жизненным циклом и конфигурацией приложений (ресурсов `DodoAppService`) в Kubernetes.

## Доступные команды

| Команда | Описание | Документация |
| :--- | :--- | :---: |
| `canary` | Управление канареечными релизами (вес, заголовки, версии). | [README](canary.md) |
| `details` | Просмотр зависимостей и ресурсов приложения (Lineage). | [README](details.md) |
| `diagnose` | Диагностика подов (дампы памяти, трассировка) через Shovel. | [README](diagnose.md) |
| `list` | Список приложений (DodoAppService) в кластере. | [README](list.md) |
| `releases` | Список компонентов приложения (DodoAppService) с тегом образа и версией конфигов. Аналог `/yunga releases` | [README](releases.md) |
| `restart` | Перезапуск (Rolling Restart) деплойментов. | [README](restart.md) |
| `scale` | Управление количеством реплик (масштабирование). | [README](scale.md) |
| `secret` | Управление секретами (просмотр, пересинхронизация). | [README](secret.md) |
| `traffic` | Управление входящим трафиком (включение/отключение Ingress). | [README](traffic.md) |
