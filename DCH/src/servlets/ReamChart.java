package servlets;
import java.awt.Color;

import java.io.IOException;

import java.io.OutputStream;
import java.sql.*;



import javax.servlet.ServletException;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;



import org.jfree.chart.ChartFactory;

import org.jfree.chart.ChartUtilities;

import org.jfree.chart.JFreeChart;

import org.jfree.chart.labels.StandardCategoryToolTipGenerator;

import org.jfree.chart.plot.CategoryPlot;

import org.jfree.chart.plot.PlotOrientation;

import org.jfree.chart.renderer.category.CategoryItemRenderer;

import org.jfree.chart.urls.StandardCategoryURLGenerator;

import org.jfree.data.category.DefaultCategoryDataset;





public class ReamChart extends HttpServlet {
      public void doGet(HttpServletRequest req,HttpServletResponse resp)

            throws ServletException, IOException {

            genGraph(req, resp);      }



      public void doPost(HttpServletRequest req,

                         HttpServletResponse resp)

            throws ServletException, IOException {

            genGraph(req, resp);

      }



      public void genGraph(HttpServletRequest req,

                           HttpServletResponse resp) {

      try {

            OutputStream out = resp.getOutputStream();

            // Create a simple Bar chart
            String text = req.getParameter("limit");
            System.out.println("Setting dataset values");
            try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();

                            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost/ibra19_dch?user=ibra19_permisml&password=permisml123");
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            ResultSet rs=st.executeQuery("Select * from reamquant");

            DefaultCategoryDataset dataset = new DefaultCategoryDataset();
            int wid=0;
            while(rs.next()){
            //ResultSet rs1=st1.executeQuery("Select * from rulling where id="+rs.getString("rulling"));
            //rs1.next();
                if(rs.getInt("quantity")<Integer.parseInt(text)){
            dataset.setValue(rs.getInt("quantity"), "Available", rs.getString("quality"));
                }else{
                dataset.setValue(rs.getInt("quantity"), "Short", rs.getString("quality"));
                }
                }
                wid=700*dataset.getRowCount();

            JFreeChart chart =

            ChartFactory.createBarChart3D(

            "Available Reams",

            "Cover Types",

            "Nos Available",

            dataset,

            PlotOrientation.VERTICAL,

            true,

            true,

            false);

      chart.setBackgroundPaint(Color.white);



      // Set the background colour of the chart

      chart.getTitle().setPaint(Color.blue);



      // Adjust the colour of the title

      CategoryPlot plot = chart.getCategoryPlot();



      // Get the Plot object for a bar graph



      plot.setBackgroundPaint(Color.white);      plot.setRangeGridlinePaint(Color.red);

      CategoryItemRenderer renderer = plot.getRenderer();

      renderer.setSeriesPaint(1, Color.red);

      renderer.setSeriesPaint(0, Color.green);

      renderer.setItemURLGenerator(



      new StandardCategoryURLGenerator(

            "index1.html",

            "series",

            "section"));

      renderer.setToolTipGenerator(

            new StandardCategoryToolTipGenerator());



      resp.setContentType("image/png");

      ChartUtilities.writeChartAsPNG(out, chart, 1200, 650);
            } catch (Exception ex) {
                 System.out.println(ex);
                        }
      } catch (Exception e) {

      System.err.println(

      "Problem occurred creating chart." + e.getMessage());

            }

      }



}