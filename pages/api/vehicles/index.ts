/* eslint-disable @typescript-eslint/no-explicit-any */
import { fail, success } from "@/lib/apiResponse";
import prisma from "@/lib/prisma";
import { verifyToken } from "@/pages/api-middleware/auth";
import { CreateVehicleSchema } from "@/schema/vehicleSchema";
import { NextApiRequest, NextApiResponse } from "next";
import z from "zod";

async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method === "POST") {
    try {
      const body = CreateVehicleSchema.parse(req.body);

      const vehicle = await prisma.vehicle.create({
        data: {
          asset: {
            create: {
              asset_code: body.asset_code,
              is_active: true,
              asset_type: "VEHICLE",
              name: body.name,
              brand: body.brand,
              model: body.model,
              purchase_date: body.purchase_date,
              purchase_price: body.purchase_price,
              serrial_number: body.serial_number,
            },
          },
          color: body.color,
          engine_number: body.engine_number,
          frame_number: body.frame_number,
          kir_due_date: body.kir_due_date,
          license_plate: body.license_plate,
          no_kir: body.no_kir,
          stnk_due_date: body.stnk_due_date,
          year: body.year,
          notes: body.notes,
        },
        include: {
          asset: true,
        },
      });

      res.status(201).json(success(vehicle));
    } catch (error: any) {
      if (error instanceof z.ZodError) {
        return res.status(400).json({
          success: false,
          message: "Validasi gagal",
          errors: error.flatten().fieldErrors,
        });
      }
      console.log(error);
      res.status(500).json(fail("terjadi kesalahan server"));
    }
  }

  if (req.method === "GET") {
    try {
      const drivers = await prisma.vehicle.findMany({
        include: {
          asset: true,
        },
      });

      res.status(200).json(success(drivers));
    } catch (error: any) {
      res.status(500).json(fail("terjadi kesalahan server", error.message));
    }
  }
}

export default verifyToken(handler);
