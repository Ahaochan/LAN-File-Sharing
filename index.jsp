<%@ page import="java.io.File" %>
<%@ page import="java.io.FilenameFilter" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.net.NetworkInterface" %>
<%@ page import="java.net.UnknownHostException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- metisMenu -->
    <link href="https://cdn.bootcss.com/metisMenu/2.7.0/metisMenu.min.css" rel="stylesheet">

    <!-- font-awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>
        .folder {

        }

        .folder, .folder ul {
            list-style: none;
        }

        .folder li {
            position: relative;
        }

        .folder li a {
            display: block;
            padding-top: 5px;
            padding-bottom: 5px;
            color: #333;
            text-decoration: none;
            outline: 0 none;
        }

        .folder ul:before {
            position: absolute;
            border-left: 1px dotted #333;
            content: "";
            width: 30px;
            top: 25px;
            left: 5px;
            bottom: 17px;
        }

        .folder ul > li:before {
            position: absolute;
            border-top: 1px dotted #333;
            content: "";
            width: 30px;
            top: 13px;
            left: -33px;
        }

        li.active > a > span.fa-folder-o:before {
            content: "\f115" !important;
        }
    </style>
</head>
<%
    String baseUrl = request.getScheme() + "://" + request.getLocalAddr() + ":" + request.getServerPort();
    String projectUrl = request.getServletContext().getContextPath();
    String path = application.getRealPath("/");
%>
<body>
<div id="wrapper">
    <div id="page-wrapper">
        <div class="container">
            <div class="jumbotron">
                <h1>文件共享局域网</h1>
                <%
                    try {
                        Enumeration<NetworkInterface> interfaces=null;
                        interfaces = NetworkInterface.getNetworkInterfaces();
                        while (interfaces.hasMoreElements()) {
                            NetworkInterface ni = interfaces.nextElement();
                            Enumeration<InetAddress> addresss = ni.getInetAddresses();
                            while(addresss.hasMoreElements())
                            {
                                InetAddress nextElement = addresss.nextElement();
                                String hostAddress = nextElement.getHostAddress();
                                System.out.println("本机IP地址为：" +hostAddress);
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
                <p>服务器地址: <%=baseUrl%>
                </p><br/>
                <div>
                    <%!
                        private List<String> getAllLocalHostIP() throws UnknownHostException {
                            List<String> result = new ArrayList<>();
                            /**获得主机名*/
                            String hostName = InetAddress.getLocalHost().getHostName();
                            if (hostName.length() > 0) {
                                /**在给定主机名的情况下，根据系统上配置的名称服务返回其 IP 地址所组成的数组。*/
                                InetAddress[] addrs = InetAddress.getAllByName(hostName);
                                if (addrs.length > 0) {
                                    for (InetAddress address : addrs) {
                                        /**.getHostAddress()   返回 IP 地址字符串（以文本表现形式）。*/
                                        if (!address.isSiteLocalAddress() || address.isLinkLocalAddress()) {
                                            continue;
                                        }
                                        result.add(address.getHostAddress());
                                    }
                                }
                            }

                            return result;
                        }
                    %>
                    服务器地址可能为:<br/>
                    <ul>
                        <%
                            List<String> localIP = getAllLocalHostIP();
                            for (String ip : localIP) {
                                String url = request.getScheme() + "://" +ip+ ":" + request.getServerPort()+projectUrl;
                                out.println("<li><a href=\""+url+"\">"+url+"</a></li>");
                            }
                        %>
                    </ul>
                </div>
                <div>
                    <button type="button" class="btn btn-primary btn-lg" data-toggle="modal"
                            data-target="#DescriptionModal">
                        说明文档
                    </button>
                    <div class="modal fade" id="DescriptionModal" tabindex="-1" role="dialog"
                         aria-labelledby="DescriptionLabel">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                            aria-hidden="true">&times;</span></button>
                                    <h4 class="modal-title" id="DescriptionLabel">说明文档</h4>
                                </div>
                                <div class="modal-body">
                                    <div>
                                        <span>本项目的主要用于手机访问电脑文件, 将需要访问的文件置于本项目下即可.</span><br/>
                                        <b style="color: red">(注意不可放入WEB-INF文件夹下)</b><br/>
                                        <span>通过DFS遍历<%=path%>下的所有文件.</span><br/>
                                        <span>主要用于手机在线播放电脑视频等大存储文件.</span><br/>
                                    </div>
                                    <div>
                                        <b>需要软件: </b>
                                        <ul>
                                            <li><a href="http://tomcat.apache.org/">Tomcat(服务器)</a></li>
                                            <li>
                                                <a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">Java环境(JDK)</a>
                                            </li>
                                            <li><a href="https://www.baidu.com/s?wd=MX Player">MX Player视频播放器</a></li>
                                        </ul>
                                    </div>
                                    <div>
                                        <b>使用说明: </b>
                                        <ul>
                                            <li><a href="https://www.baidu.com/s?wd=tomcat%20配置环境">配置环境</a></li>
                                            <li><a href="https://www.baidu.com/s?wd=关闭防火墙">关闭防火墙</a></li>
                                            <li>将要共享的文件放入<%=path%>
                                            </li>
                                            <li>运行Tomcat/bin目录下的startup.bat</li>
                                            <li>在地址栏输入本机局域网ip</li>
                                            <li>复制视频的链接到MX Player, 选择<b>网络流媒体</b>播放即可.</li>
                                        </ul>
                                    </div>
                                    <span>Github地址: <a href="#">Ahaochan</a></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <%!
                            private String dfs(String baseUrl, File root) {
                                StringBuilder html = new StringBuilder();
                                String name = root.getName();
                                if (root.isDirectory()) {
                                    html.append("<li><a><span class=\"fa fa-fw fa-folder-o\"></span>").append(name).append("</a>");
                                    File[] list = root.listFiles(new FilenameFilter() {
                                        @Override
                                        public boolean accept(File dir, String name1) {
                                            return !name1.equals("WEB-INF");
                                        }
                                    });
                                    if (list == null) {
                                        html.append("<li>");
                                        return html.toString();
                                    }
                                    html.append("<ul>");
                                    for (File file : list) {
                                        html.append(dfs(baseUrl + "/" + name, file));
                                    }
                                    html.append("</ul></li>");
                                } else {
                                    html.append("<li><a href=\"")
                                            .append(baseUrl).append("/").append(name)
                                            .append("\"><span class=\"fa fa-fw fa-file\"></span>")
                                            .append(name)
                                            .append("</a></li>");
                                }
                                return html.toString();
                            }
                        %>
                        <%
                            File root = new File(path);
                            out.println("<ul class=\"folder\">");
                            if (root.exists()) {
                                out.println(dfs(baseUrl, root));
                            }
                            out.println("</ul>");
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- metisMenu -->
<script src="https://cdn.bootcss.com/metisMenu/2.7.0/metisMenu.min.js"></script>
<script>
    $(document).ready(function () {
        $('.folder').metisMenu({
            toggle: false
        });

        $('a').attr('target', '_blank');
    })
</script>
</html>
