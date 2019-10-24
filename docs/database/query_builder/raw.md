# raw

## ❱ Description

Permet d’exécuter une requête SQL sans passer par la QueryBuilder. Les requêtes sont préparées.

## ❱ Syntax

{% code-tabs %}
{% code-tabs-item title="server" %}
```lua
query:raw( string query, varargs ... )
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## ❱ Paramètres

| Argument | Type | Description |
| :--- | :--- | :--- |
| `query` | string | Requête SQL préparée à l'aide d'emplacement anonyme \( = ? \) |
| `...` | varargs | Paramètres remplaçant les emplacements anonymes |

## ❱ Retours

| Type | Description |
| :--- | :--- |
| [QueryBuilder](./) | L'instance **QueryBuilder** courrante |

## ❱ Exemples

```lua
query:raw( 'SELECT * FROM `accounts` WHERE `id` = ?', 10 )
-- Will produce: SELECT * FROM `accounts` WHERE `id` = 10
```

