/* eslint-disable @typescript-eslint/no-explicit-any */
import { fail, success } from "@/lib/apiResponse";
import prisma from "@/lib/prisma";
import { verifyToken } from "@/pages/api-middleware/auth";
import { UpdateChessisSchema } from "@/schema/chassisSchema";
import { NextApiRequest, NextApiResponse } from "next";
import z from "zod";

async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { id } = req.query;
  const idStr = Array.isArray(id) ? id[0] : id;

  if (req.method === "GET") {
    try {
      const chassis = await prisma.chassis.findUnique({
        where: { id: idStr },
      });

      res.status(200).json(success(chassis));
    } catch (error: any) {
      res.status(500).json(fail("terjadi kesalahan server", error.message));
    }
  }

  if (req.method === "DELETE") {
    try {
      await prisma.chassis.delete({
        where: { id: idStr },
      });

      res.status(200).json(success(null));
    } catch (error: any) {
      res.status(500).json(fail("terjadi kesalahan server", error.message));
    }
  }

  if (req.method === "PATCH") {
    try {
      const body = UpdateChessisSchema.parse(req.body);

      const user = await prisma.chassis.update({
        where: {
          id: idStr,
        },
        data: body,
      });

      res.status(200).json(success(user));
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
}

export default verifyToken(handler);
