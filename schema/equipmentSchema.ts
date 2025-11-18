import z from "zod";
import { CreateAssetSchema } from "./assetSchema";

export const CreateEquipementSchema = z.object({
  // asset
  asset: CreateAssetSchema,

  // vehicle
  equipment_code: z.string(),
  equipment_type: z.string(),
  specification: z.string(),
  condition: z.string(),
});

export const UpdateEquipementSchema = z.object({
  // asset
  asset_code: z.string(),
  name: z.string(),
  brand: z.string().optional(),
  model: z.string().optional(),
  serial_number: z.string().optional(),
  purchase_date: z
    .preprocess(
      (val) =>
        typeof val === "string" || val instanceof Date
          ? new Date(val)
          : undefined,
      z.date()
    )
    .optional(),
  purchase_price: z.number().optional(),
  // vehicle
  equipment_code: z.string(),
  equipment_type: z.string(),
  specification: z.string(),
  condition: z.string(),
});
