# queryBuilder

## ❱ Description

Permet de déclarer une nouvelle instance d'un **QueryBuilder**.

## ❱ Syntaxe

{% code-tabs %}
{% code-tabs-item title="server" %}
```lua
queryBuilder()
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## ❱ Retours

| Type | Description |
| :--- | :--- |
| `QueryBuilder` | Nouvelle instance de QueryBuilder |

##  ❱ Exemples

```lua
local database = ImportPackage( 'orf_database' )
local builder = database.queryBuilder()
```

