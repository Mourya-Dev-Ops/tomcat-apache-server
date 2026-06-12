<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DevOps CI/CD Demo</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    background:#0f172a;
    font-family:Arial,sans-serif;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    color:white;
}

.card{
    width:700px;
    background:#1e293b;
    padding:40px;
    border-radius:20px;
    text-align:center;
    box-shadow:0 0 30px rgba(0,255,255,0.3);
}

h1{
    color:#38bdf8;
    margin-bottom:20px;
}

.status{
    color:#22c55e;
    font-size:28px;
    font-weight:bold;
    margin-bottom:20px;
}

h2{
    margin-bottom:20px;
}

p{
    font-size:22px;
    line-height:1.6;
}

.footer{
    margin-top:30px;
    color:#94a3b8;
    font-size:18px;
}
</style>
</head>

<body>

<div class="card">

<h1>DEVOPS CI/CD PIPELINE SUCCESS</h1>

<div class="status">
DEPLOYMENT SUCCESSFUL
</div>

<h2>Pewwwww! It Worked</h2>

<p>
Testing Team Mates,<br>
Jenkins → Maven → WAR → Tomcat Pipeline is Working Successfully.
</p>

<div class="footer">
Built by Vikky using GitHub, Jenkins, Maven & Apache Tomcat
</div>

</div>

</body>
</html>
