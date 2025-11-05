/* eslint-disable @typescript-eslint/no-explicit-any */
export type ApiResponse<T = any> = {
  success: boolean;
  message: string;
  data?: T;
  error?: string | string[];
  statusCode?: number;
};

export const success = <T>(data: T, message = "Success"): ApiResponse<T> => ({
  success: true,
  message,
  data,
});

export const fail = (
  message = "Failed",
  error?: string | string[]
): ApiResponse => ({
  success: false,
  message,
  error,
});
