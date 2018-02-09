package com.web.obs.exception;

public class OnlineBankingException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public OnlineBankingException() {
		super();
	}

	public OnlineBankingException(String message, Throwable cause,
			boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public OnlineBankingException(String message, Throwable cause) {
		super(message, cause);
	}

	public OnlineBankingException(String message) {
		super(message);
	}

	public OnlineBankingException(Throwable cause) {
		super(cause);
	}
	
	

	
}
