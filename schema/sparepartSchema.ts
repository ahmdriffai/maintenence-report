import z from "zod";

export const CreateSparepartSchema = z.object({
  code: z.string(),
  name: z.string(),
  unit: z.string(),
  price: z.number(),
  stock_quantity: z.number(),
  description: z.string(),
});

export const UpdateSparepartSchema = z.object({
  code: z.string(),
  name: z.string(),
  unit: z.string(),
  price: z.number(),
  stock_quantity: z.number(),
  description: z.string(),
});
