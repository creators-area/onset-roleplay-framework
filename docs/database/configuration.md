# ◾ Configuration

## ❱ Renseignez vos identifiants

Pour saisir vos identifiants de connexion au moteur de base de donnée. Il suffit de vous rendre dans le dossier `packages/orf_database/config.json` et d'ouvrir ce fichier. Vous trouverez toutes les informations à modifier.

{% code-tabs %}
{% code-tabs-item title="packages/orf\_database/config.json" %}
```text
{
    "database":{
        "host":"localhost",
        "port":3306,
        "user":"your_user",
        "password":"your_password",
        "db_name":"onset",
        "charset":"utf8mb4",
        "log_level":"debug"
    }
}

```
{% endcode-tabs-item %}
{% endcode-tabs %}

