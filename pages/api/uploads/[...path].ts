import fs from "fs";
import { NextApiRequest, NextApiResponse } from "next";
import path from "path";

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  const filePath = path.join(
    process.cwd(),
    "storage/uploads",
    ...(req.query.path as string[])
  );

  if (!fs.existsSync(filePath)) {
    return res.status(404).send("File not found");
  }

  const stream = fs.createReadStream(filePath);
  stream.pipe(res);
}
