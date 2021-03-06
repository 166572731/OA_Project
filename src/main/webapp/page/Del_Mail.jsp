<%--
  Created by IntelliJ IDEA.
  User: ChenLei
  Date: 2019/5/15
  Time: 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
	<meta name="keywords"
		  content="admin, dashboard, bootstrap, template, flat, modern, theme, responsive, fluid, retina, backend, html5, css, css3">
	<meta name="description" content="">
	<meta name="author" content="ThemeBucket">
	<link rel="shortcut icon" href="#" type="../image/png">
	<title>OA办公自动化系统</title>
	<!--common-->
	<link href="../layui/css/layui.css" rel="stylesheet">
	<link href="../css/style.css" rel="stylesheet">
	<link href="../css/style-responsive.css" rel="stylesheet">
<body style="background: #fafbff;">
<h1 style="font-size:35px;text-align:center;" class="layui-bg-red"    >回收站</h1>

<table id="demo" lay-filter="demo"></table>



<!-- 将js放在文档的末尾，以便页面加载速度更快。 -->
<script src="../js/jquery-1.10.2.min.js"></script>
<script src="../js/jquery-ui-1.9.2.custom.min.js"></script>
<script src="../js/jquery-migrate-1.2.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/modernizr.min.js"></script>
<script src="../js/jquery.nicescroll.js"></script>
<script src="../layui/layui.js"></script>

<script>
    var table;
    layui.use('table', function(){
        table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 430
            ,url: '../hsz.do' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'TypeID', title: '类型', width:80,  fixed: 'left'}
                ,{field: 'fk_Account', title: '发件人', width:80}
                ,{field: 'Subject', title: '主题', width:120}
                ,{field: 'SentDate', title: '时间', width:180,templet:function (d) {
                        return layui.util.toDateString(d.SentDate,'yyyy-MM-dd HH:mm:ss');
                    }}

                ,{field: 'wealth', title: '操作', width: 200,toolbar: '#barDemo'}
            ]]
        });

        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                layer.confirm('是否彻底删除（无法恢复）', function(index){
                    obj.del();
                    layer.close(index);
                    $.post('../cdDelete.do',{'meilid':data.pk_Mail}, function(str) {
                        layer.msg("删除成功")
                    });
                });

            } else if(obj.event === 'del'){
                layer.confirm('是否确定恢复', function(index){
                    obj.del();
                    layer.close(index);
                    $.post('../hfu.do',{'meilid':data.pk_Mail}, function(str) {
                        layer.msg("恢复成功")
                    });
                });
            }

        });

    });

</script>

<script id="barDemo" type="text/html">
	<a class="layui-btn layui-btn-xs layui-btn-warm" lay-event="del">恢复</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="detail">彻底删除</a>
</script>
<!--所有页面的通用脚本-->
<script src="../js/scripts.js"></script>
<script type="text/javascript">
    layui.use(['layer'], function () {
        var layer = layui.layer;
    });
</script>
</body>
</html>
