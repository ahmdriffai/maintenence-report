import { fail, success } from "@/lib/apiResponse";
import prisma from "@/lib/prisma";
import { RegisterUserSchema } from "@/schema/userSchema";
import bcrypt from "bcrypt";
import { NextApiRequest, NextApiResponse } from "next";
import z from "zod";

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== "POST") return res.status(405).end();

  try {
    // validate request
    const body = RegisterUserSchema.parse(req.body);

    // check user alredy exist?
    const findUser = await prisma.user.findUnique({
      where: { username: body.username },
    });
    if (findUser) {
      return res.status(400).json(fail("user already exist"));
    }

    // hash password
    const hashed = await bcrypt.hash(body.password, 10);

    const user = await prisma.user.create({
      data: {
        fullname: body.fullname,
        username: body.username,
        role: body.role,
        password: hashed,
      },
    });

    res.status(200).json(success(user, "user successfully regsitered"));
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({
        success: false,
        message: "Validasi gagal",
        errors: error.flatten().fieldErrors,
      });
    }
    res.status(500).json(fail("terjadi kesalahan server"));
  }
}
