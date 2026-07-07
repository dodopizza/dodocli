# Команда: releases

Выводит список компонентов DodoAppService с образом и версией конфигов. Версия конфигов читается из аннотации `last-applied-configs`; если отсутствует, выводится `-`. Аналог `/yunga releases`

## Использование

```bash
dodo app releases [service] [flags]
```

## Флаги

| Флаг | Сокращение | Тип | Описание |
| :--- | :--- | :--- | :--- |
| --namespace | -n | string | Неймспейс приложения. |
| --context | -c | string | Kubernetes context. |
| --all | -a | bool | Искать сервис во всех неймспейсах. |

## Примеры

```bash
# В конкретном неймспейсе
dodo app releases my-service -n my-namespace -c p-yandex

# Во всех неймспейсах
dodo app releases my-service -a -c p-yandex
```

## Вывод

```
+------------+----------------+-----------+-----------------------------------------+---------+
| SERVICE    | NAMESPACE      | COMPONENT | IMAGE                                   | CONFIGS |
+------------+----------------+-----------+-----------------------------------------+---------+
| my-service | my-namespace   | app       | registry.io/my-service:main-abc1234     | 1.0.0   |
| my-service | my-namespace-2 | app       | registry.io/my-service:main-abc1234     | 1.0.1   |
+------------+----------------+-----------+-----------------------------------------+---------+
```
