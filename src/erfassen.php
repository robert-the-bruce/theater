<?php
/**
 * Created by PhpStorm.
 * User: Salchegger Robert
 * Date: 17.01.2019
 * Time: 08:08
 */
?>

<div class="erfassen" id="erfassen">
    <div class="container">
        <div class="row">
            <div class="four columns">

            </div>
            <div class="erfassen">
                <div class="eight columns">
                <h2>Theaterstück erfassen</h2>
                <?php

                //$con = new DBUsage('localhost', 'root', '', 'theater');


                if(isset($_POST['speichern'])){

                    echo "FORMULARDATEN WERDEN VERARBEITET!<br>";

                    $titel = $_POST['titel'];
                    $autor = $_POST['autor'];
                    $genre = $_POST['genre'];
                    $date = $_POST['datum'];



                  //  $insert1 = 'INSERT INTO DRAMA (dra_id, dra_name, gen_id, autor_id) VALUES (NULL, ?, ?, ?);';
                    $insert1 = 'INSERT INTO DRAMA (dra_name, gen_id, autor_id) VALUES (?, ?, ?);';
                    //echo  "INSERT INTO DRAMA (dra_name, gen_id, autor_id) VALUES (\"$_POST[titel]\", $_POST[genre], $_POST[autor])<br>";


                    try {

                        $bindArray1 = [
                            '0' => $_POST['titel'],
                            '1' => $_POST['genre'],
                            '2' => $_POST['autor']
                        ];

                        print_r($bindArray1);



                        $con->GetStatement($insert1, $bindArray1);



                        } catch(Exception $e)
                        {
                            require_once 'exception_handling.php';
                            echo $e->getMessage();
                        }

                } else {


                    $genre = 'select * from genre;';

                    $stmt_genre = $con->GetStatement($genre);

                    $autor = 'select per_id, rol_id, concat_ws(" ", per_vName, per_nName) from person left join rolle using(rol_id) where rol_id = 4 ;';

                    $stmt_rolle = $con->GetStatement($autor);
                    ?>

                    <form method="post">
                        <div class="form-group">
                          <label class="control-label col-md-3" for="titel">Titel des Stücks:</label><input type="text" name="titel" id="titel" required><br>
                          <label class="control-label col-md-3" for="autor">Autor</label>
                            <select name="autor" >
                                <?php

                                while($row = $stmt_rolle->fetch(PDO::FETCH_NUM)){
                                    echo '<option value="' . $row[0] .'">' . $row[2] . '</option>';
                                }
                                ?>
                            </select>
                            <label class="control-label col-md-3" for="genre">Genre:</label>
                            <select name="genre" >
                                <?php

                                while($row = $stmt_genre->fetch(PDO::FETCH_NUM)){
                                    echo '<option value="' . $row[0] .'">' . $row[1] . '</option>';
                                }
                                ?>
                            </select>

                          <label class="control-label col-md-3" for="datum">Erstaufführung:</label><input type="date"  min="1900-01-01" name="datum" id="datum" required><br>

                            <input class="control-label col-md-3" type="submit" name="speichern" value="speichern" />
                        </div>
                    </form>
                <?php
                }
                ?>
                </div>
            </div>
        </div>
    </div>         
</div>

</html>
