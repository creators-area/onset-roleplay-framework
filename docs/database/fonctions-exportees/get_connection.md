# get\_connection

## ❱ Description

Permet de récupérer l'identifiant de l'instance de connexion à la base de donnée.

## ❱ Syntaxe

{% code-tabs %}
{% code-tabs-item title="server" %}
```lua
get_connection()
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## ❱ Retours

| Type | Description |
| :--- | :--- |
| `int` | Identifiant de l'instance de connexion |

##  ❱ Exemples

```lua
local database = ImportPackage( 'orf_database' )
local handler_id = database.get_connection()
```

