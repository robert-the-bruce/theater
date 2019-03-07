<?php
/**
 * Created by PhpStorm.
 * User: Salchegger Robert
 * Date: 17.01.2019
 * Time: 08:08
 */
echo '<h2>Willkommen im Theater der Zukunft</h2>';


?>

<div class="theater" id="theater">
    <div class="container">
        <div class="row">
            <div class="theaterliste">
                <h4>Wir zeigen und zeigten</h4>
                <?php

                $query = 'select dra_id as "Nr.", gen_name as "Genre", dra_name as "Name des Stücks", concat_ws(" ", per_vName, per_nName) as "Autor", eve_termin as "Erstaufführung" 
                 from drama
                 left join genre using(gen_id)
                 left join dramaevent using (dra_id)
                 left join crew using(eve_id)
                 left join person on drama.autor_id = person.per_id
                 left join rolle using(rol_id)
                 group by dra_id
                 order by eve_termin desc
                 ;';

                try
                {
                    $stmt = $con->GetStatement($query);

                    $con->PrintTable($stmt);

                } catch(Exception $e)
                {
                    require_once 'exception_handling.php';
                    echo $e->getMessage();
                }

                ?>

            </div>
        </div>
    </div>
</div>

</html>