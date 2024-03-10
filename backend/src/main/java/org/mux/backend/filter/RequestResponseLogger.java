//package org.mux.backend.filter;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import jakarta.servlet.*;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.mux.backend.authentication.model.LoginDto;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.core.annotation.Order;
//import org.springframework.stereotype.Component;
//import org.springframework.web.filter.OncePerRequestFilter;
//import org.springframework.web.util.ContentCachingRequestWrapper;
//import org.springframework.web.util.ContentCachingResponseWrapper;
//
//import java.io.IOException;
//import java.io.UnsupportedEncodingException;
//
//@Component
//@Order(1)
//public class RequestResponseLogger implements Filter {
//    private static final Logger LOGGER = LoggerFactory.getLogger(RequestResponseLogger.class);
//    private final ObjectMapper objectMapper;
//
//    public RequestResponseLogger(ObjectMapper objectMapper) {
//        this.objectMapper = objectMapper;
//    }
//
//    private String getStringValue(byte[] contentAsByteArray, String characterEncoding) {
//        try {
//            return new String(contentAsByteArray, 0, contentAsByteArray.length, characterEncoding);
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
//        return "";
//    }
////    @Override
//    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
//        ContentCachingRequestWrapper requestWrapper = new ContentCachingRequestWrapper(request);
//        ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper(response);
//        String requestBody = getStringValue(requestWrapper.getContentAsByteArray(),
//                request.getCharacterEncoding());
//        LOGGER.info("REQUEST: METHOD={}; REQUEST URI={}, REQUEST PAYLOAD={}",
//                request.getMethod(), request.getRequestURI(), objectMapper.writeValueAsString(requestWrapper.getContentAsByteArray()));
//        long startTime = System.currentTimeMillis();
//        filterChain.doFilter(requestWrapper, responseWrapper);
//        long timeTaken = System.currentTimeMillis() - startTime;
//
//        String responseBody = getStringValue(responseWrapper.getContentAsByteArray(),
//                response.getCharacterEncoding());
//
//        LOGGER.info(
//                "RESPONSE : RESPONSE CODE={}; RESPONSE={}; TIM TAKEN={}",
//                response.getStatus(), responseBody,
//                timeTaken);
//        responseWrapper.copyBodyToResponse();
//    }
//
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
//        ContentCachingRequestWrapper requestWrapper = new ContentCachingRequestWrapper(servletRequest.);
//        ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper(servletResponse);
//        filterChain.doFilter(servletRequest, servletResponse);
//    }
//}
