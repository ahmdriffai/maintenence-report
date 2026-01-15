/* eslint-disable @typescript-eslint/no-explicit-any */
import { fail, success } from "@/lib/apiResponse";
import { verifyToken } from "@/lib/auth";
import prisma from "@/lib/prisma";
import { DeleteVehicleBulkSchema } from "@/schema/vehicleSchema";
import { NextApiRequest, NextApiResponse } from "next";
import z from "zod";

async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== "POST") {
    return res.status(405).json(fail("Method not allowed"));
  }

  try {
    const { ids } = DeleteVehicleBulkSchema.parse(req.body);

    // OPTIONAL: pastikan semua vehicles ada
    const existing = await prisma.vehicle.count({
      where: { id: { in: ids } },
    });

    if (existing === 0) {
      return res.status(404).json(fail("Vehicle not found"));
    }

    // ✅ SAMA dengan delete satuan → hanya delete vehicle
    const deleted = await prisma.vehicle.deleteMany({
      where: {
        id: { in: ids },
      },
    });

    return res.status(200).json(
      success({
        deletedCount: deleted.count,
      })
    );
  } catch (error: any) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        message: "Validasi gagal",
        errors: error.flatten().fieldErrors,
      });
    }

    console.error("Bulk delete error:", error);
    return res
      .status(500)
      .json(fail("Terjadi kesalahan server", error.message));
  }
}

export default verifyToken(handler);
