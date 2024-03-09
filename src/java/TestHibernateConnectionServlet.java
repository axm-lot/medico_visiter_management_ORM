import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

@WebServlet(name = "TestHibernateConnectionServlet", urlPatterns = {"/test-connection"})
public class TestHibernateConnectionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Load the hibernate.cfg.xml file
            Configuration configuration = new Configuration().configure("hibernate.cfg.xml");

            // Create a SessionFactory
            SessionFactory sessionFactory = configuration.buildSessionFactory();

            // Open a session
            sessionFactory.openSession();

            String message = "Hibernate connected to the database successfully!";

            // Close the session and the SessionFactory
            sessionFactory.close();

            // Set the message as a request attribute
            request.setAttribute("message", message);

            // Forward to the JSP file for display
            request.getRequestDispatcher("WEB-INF/pages/patient.jsp").forward(request, response);

        } catch (Exception e) {
            String errorMessage = "Hibernate connection failed : " + e.getMessage();
            // Set the error message as a request attribute
            request.setAttribute("errorMessage", errorMessage);

            // Forward to an error JSP file for display
            request.getRequestDispatcher("WEB-INF/pages/error.jsp").forward(request, response);
        }
    }
}
