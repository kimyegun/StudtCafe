package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDao;
import model.User;



@WebServlet("/member/*")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDao dao;   
	
    public UserController() {
        super();
    }
    
	@Override
	public void init() throws ServletException {
		
		dao = new UserDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String nextPage = null;
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");

		String action = request.getPathInfo();		
		
		if(action == null || "login.do".equals(action))
		{
			List<User> memList = dao.selectAll();
			request.setAttribute("memList", memList);
			nextPage = "/view/member.jsp";
			
		} else if (action.equals("/add.do")){
			User vo = new User();

			

			nextPage = "/member/list.do";
			
		} else if(action.equals("/memberForm.do")) {
			nextPage = "/view/memberForm.jsp";
			
		}else if(action.equals("/modForm.do")) {
			String id = request.getParameter("id");
			User vo = dao.selectById(id);
			request.setAttribute("info", vo);
			nextPage = "/view/modMemberForm.jsp";
		} else if(action.equals("/mod.do")) {
			User vo = new User();

			dao.update(vo);
			nextPage = "/member/list.do";			
		} else if(action.equals("/del.do")) {
			String id = request.getParameter("id");
			User vo = dao.selectById(id);
			request.setAttribute("msg", "del");
			nextPage = "/member/list.do";			
		} else if("/login.do".equals(action)){
	        String userID = request.getParameter("userID");
	        String userPW = request.getParameter("userPW");
	        
	        // 로그인 처리
	        boolean isAuthenticated = dao.authenticateUser(userID, userPW);
	        
	        if (isAuthenticated) {
	            // 로그인 성공
	            request.getSession().setAttribute("userID", userID);
	            response.sendRedirect(request.getContextPath() + "/main/main.do");
	            nextPage="/main/main.do";

	        } else {
	            // 로그인 실패
	            request.setAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
	            
	            PrintWriter pw = response.getWriter();
	            pw.print("<script> alert('아이디 또는 비밀번호가 올바르지 않습니다.')  </script>"); 
	            
	            nextPage="/view/login.jsp";
	        }
		}
		else {
			List<User> memList = dao.selectAll();
			request.setAttribute("memList", memList);
			nextPage = "/view/member.jsp";
			
		}

		RequestDispatcher dis = request.getRequestDispatcher(nextPage);
		dis.forward(request, response);

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
}



