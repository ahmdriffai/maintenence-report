/* eslint-disable @typescript-eslint/no-explicit-any */
import { fail, success } from "@/lib/apiResponse";
import prisma from "@/lib/prisma";
import { verifyToken } from "@/pages/api-middleware/auth";
import { CreateEquipementSchema } from "@/schema/equipmentSchema";
import { NextApiRequest, NextApiResponse } from "next";
import z from "zod";

async function handler(req: NextApiRequest, res: NextApiResponse) {
  try {
    switch (req.method) {
      case "GET": {
        const equipments = await prisma.equipment.findMany();
        return res.status(200).json(success(equipments));
      }
      case "POST": {
        const body = CreateEquipementSchema.parse(req.body);

        const vehicle = await prisma.equipment.create({
          data: {
            asset: {
              create: {
                asset_code: body.asset_code,
                is_active: true,
                asset_type: "EQUIPMENT",
                name: body.name,
                brand: body.brand,
                model: body.model,
                purchase_date: body.purchase_date,
                purchase_price: body.purchase_price,
                serrial_number: body.serial_number,
              },
            },
            condition: body.condition,
            equipment_code: body.equipment_code,
            equipment_type: body.equipment_type,
            specification: body.specification,
          },
          include: {
            asset: true,
          },
        });

        return res.status(201).json(success(vehicle));
      }
      default:
        return res.status(405).json(fail("Method not allowed"));
    }
  } catch (error: any) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        message: "Validasi gagal",
        errors: error.flatten().fieldErrors,
      });
    }

    console.error("API error:", error);
    return res
      .status(500)
      .json(fail("Terjadi kesalahan server", error.message));
  }
}

export default verifyToken(handler);
