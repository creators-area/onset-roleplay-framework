# new

## ❱ Description

Permet de déclarer une nouvelle instance d'un **QueryBuilder**.

{% hint style="danger" %}
Cette méthode ne peut être appelée que si vous vous trouvez à l'intérieur du package `orf_database`. Dans le cas contraire veuillez utiliser la méthode [`queryBuilder()`](../fonctions-exportees/querybuilder.md)\`\`
{% endhint %}

## ❱ Syntaxe

{% code-tabs %}
{% code-tabs-item title="server" %}
```lua
local query = querybuilder:new()
```
{% endcode-tabs-item %}
{% endcode-tabs %}

## ❱ Paramètres

| Argument | Type | Description |
| :--- | :--- | :--- |
|  |  |  |

## ❱ Retours

| Type | Description |
| :--- | :--- |
| `QueryBuilder` | Nouvelle instance de QueryBuilder |

##  ❱ Exemples

