<?php
/**
 * Created by PhpStorm.
 * User: Salchegger Robert
 * Date: 17.01.2019
 * Time: 08:08
 */





if(isset($_POST['search']))
{
    echo '<h2>Nach Stück suchen</h2>';
    try {
        $name = $_POST['name'];
        echo '<h4>Gesucht wurde nach: '.$name.'</h4>';
        $query = 'select * from drama where dra_name like ?';
        $name = '%'.$name.'%';
        $namearray = array($name);
        $stmt = $con->GetStatement($query, $namearray);
        $count = $stmt->rowCount();

        if($count == null) throw new Exception('<h4>Die Suchanfrage brachte keine Ergebnisse</h4>');
        ?>

        <form method="post">
            <div class="table">
                <div class="tr">
                    <div class="th">
                        <label for="suche">Ergebnisliste der Suche:</label>
                    </div>
                    <div class="td">

                        <select name="draid">
                        <?php

                        while($row = $stmt->fetch(PDO::FETCH_NUM))
                        {
                            echo '<option value="'.$row[0].'">'.$row[1];
                        }
                        ?>
                        </select>

                    </div>
                </div>
                <div class="tr">
                    <div class="td">
                        <input type="submit" name="show" value="anzeigen">
                    </div>
                </div>
            </div>
        </form>
        <?php


    } catch (Exception $e)
    {
        echo $e->getMessage();
    }
} else if(isset($_POST['show'])) {

    try {
        $dra_id = $_POST['draid'];
        $dra_id_suche = array($dra_id);
        $query2 = 'select dra_name from drama where dra_id=?';
        $stmt = $con->GetStatement( $query2, $dra_id_suche);
        $name = $stmt->fetch();


        $query = 'select dra_name as Drama, gen_name as Genre, concat_ws(" ", per_vName, per_nName) as "Autor", eve_termin as "Erstaufführung"
                  from drama 
                  left join genre using(gen_id)
                  left join dramaevent using (dra_id)
                  left join crew using(eve_id)
                  left join person on drama.autor_id = person.per_id
                  where dra_id=?
                  order by dra_id;';

        $stmt = $con->GetStatement($query, $dra_id_suche);

        echo '<br><h4>Alle Ergebnisse für '.$name[0].':</h4>';
        $con->PrintTable($stmt);


    } catch (Exception $e)
    {
        require_once 'exception_handling.php';
        echo $e->getMessage();
    }

}else
{

    ?>
    <br>
    <h3>Nach Theaterstück suchen</h3>
    <form method="post">
        <div class="table">
            <div class="tr">
                <div class="th">
                    <label for="suche">Theaterstück suchen (auch Wortteil möglich):</label>
                </div>
                <div class="td">
                    <input class="textonly" id="suche" type="text" name="name" placeholder="z.B. romeo">
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <input type="submit" name="search" value="suchen">
                </div>
            </div>
        </div>
    </form>
    <?php
}
