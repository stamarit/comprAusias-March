
<%@ page import="net.daw.helper.Contexto"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="net.daw.bean.ProductoBean"%>
<%
    Contexto oContexto = (Contexto) request.getAttribute("contexto");
    ArrayList<Object> alObjetoParametro = (ArrayList<Object>) oContexto.getParametro();
    ArrayList<ProductoBean> alPagina = (ArrayList<ProductoBean>) alObjetoParametro.get(0);
    Iterator<ProductoBean> oIterador = alPagina.listIterator();
%>
<div class="row-fluid">
    <div class="span9">
        <h1>Listado de productos</h1>
        <%
            if (!oIterador.hasNext()) {
                out.print("<h4>Listado vac�o</h4>");
            } else {
        %>
        <%
            if (oContexto.getHmOrder() != null) {
                out.print("<p>Listado ordenado por " + oContexto.getHmOrder().keySet().toArray()[0].toString() + "    ");
                out.print("<a href=\"Controller?" + oContexto.getSerializedParamsExceptOrder() + "\">(Quitar orden)</a></p>");
            } else {
                out.print("<p>Sin ordenar</p>");
            }
        %>
        <%
            if (oContexto.getHmFilter() != null) {
                out.print("<p>Listado filtrado por " + oContexto.getHmFilter().keySet().toArray()[0].toString() + "    ");
                out.print("<a href=\"Controller?" + oContexto.getSerializedParamsExceptFilter() + "\">(Quitar filtro)</a></p>");
            } else {
                out.print("<p>Sin filtrar</p>");
            }
        %>      
        <%
            ArrayList<String> paginacion = (ArrayList<String>) alObjetoParametro.get(1);
            Iterator<String> iterador2 = paginacion.listIterator();
            while (iterador2.hasNext()) {
                String o = iterador2.next();
                out.print(o);
            }
        %>
    </div>
    <div class="span3">
        <div class="text-right">
            <legend>Filtro de producto</legend> 
            <form class="navbar-form pull-right" action="Controller" method="post" id="clienteForm">
                <fieldset>                                               
                    <%=oContexto.getSerializedParamsExceptFilterFormFormat()%>       
                    <span>
                        <select id="filter" name="filter" width="80" style="width: 80px">
                            <option>id</option>
                            <option>codigo</option>
                            <option>descripcion</option>
                            <option>precio</option>
                            <option>id_tipoproducto</option>                            
                        </select>                        
                        <input id="filtervalue" name="filtervalue" type="text" size="20" maxlength="50" value=""  width="100" style="width: 100px"/>
                    </span>
                    <span>
                        <input type="submit" name="enviar" value="Filtrar" />
                    </span>
                </fieldset>
        </div>
    </div>
</div>
<table class="table table-hover table-condensed">
    <tr>
        <th>id
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=id&ordervalue=asc"><i class="icon-arrow-up"></i></a>
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=id&ordervalue=desc"><i class="icon-arrow-down"></i></a>        
        </th>
        <th>c�digo
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=codigo&ordervalue=asc"><i class="icon-arrow-up"></i></a>
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=codigo&ordervalue=desc"><i class="icon-arrow-down"></i></a>        
        </th>
        <th>descripci�n
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=descripcion&ordervalue=asc"><i class="icon-arrow-up"></i></a>
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=descripcion&ordervalue=desc"><i class="icon-arrow-down"></i></a>        
        </th>
        <th>precio
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=precio&ordervalue=asc"><i class="icon-arrow-up"></i></a>
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=precio&ordervalue=desc"><i class="icon-arrow-down"></i></a>                
        </th>
        <th>tipo de producto
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=id_tipoproducto&ordervalue=asc"><i class="icon-arrow-up"></i></a>
            <a href="Controller?<%=oContexto.getSerializedParamsExceptOrder()%>&order=id_tipoproducto&ordervalue=desc"><i class="icon-arrow-down"></i></a>                            
        </th>
        <th>Operaciones</th>
    </tr>
    <%
        while (oIterador.hasNext()) {
            ProductoBean oProductoBEAN = oIterador.next();
    %>
    <tr>
        <td><%=oProductoBEAN.getId()%></td>
        <td><%=oProductoBEAN.getCodigo()%></td>
        <td><%=oProductoBEAN.getDescripcion()%></td>
        <td><%=oProductoBEAN.getPrecio()%>&euro;</td>
        <td>
            <%=oProductoBEAN.getTipoProducto().getDescripcion()%>
            <div class="btn-group">
                <a class="btn btn-mini" href="Controller?class=tipoproducto&method=selectone&id=<%=oProductoBEAN.getId()%>&selectonetable=producto&selectonefield=id_tipoproducto"><i class="icon-search"></i></a>                                        
            </div>
        </td>
        <td>
            <div class="btn-toolbar">
                <div class="btn-group">
                    <a class="btn btn-mini" href="Controller?class=producto&method=view&id=<%=oProductoBEAN.getId()%>"><i class="icon-eye-open"></i></a>                    
                    <a class="btn btn-mini" href="Controller?class=producto&method=update&id=<%=oProductoBEAN.getId()%>"><i class="icon-pencil"></i></a>           
                    <a class="btn btn-mini" href="Controller?class=producto&method=remove&id=<%=oProductoBEAN.getId()%>"><i class="icon-trash"></i></a>            
                </div>
            </div>
        </td>
    </tr>
    <%
        }
    %>
</table>
<%
    }
%>
