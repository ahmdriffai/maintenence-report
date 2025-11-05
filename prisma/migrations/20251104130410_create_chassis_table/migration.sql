/*
  Warnings:

  - You are about to alter the column `purchase_price` on the `assets` table. The data in that column could be lost. The data in that column will be cast from `BigInt` to `Integer`.

*/
-- CreateEnum
CREATE TYPE "ChassisType" AS ENUM ('RANGKA', 'FLATBED');

-- AlterTable
ALTER TABLE "assets" ALTER COLUMN "purchase_price" SET DATA TYPE INTEGER;

-- CreateTable
CREATE TABLE "chassises" (
    "id" UUID NOT NULL,
    "chassis_number" TEXT NOT NULL,
    "chassis_type" "ChassisType" NOT NULL,
    "chassis_category" TEXT NOT NULL,
    "axle_count" INTEGER NOT NULL,
    "no_kir" TEXT,
    "kir_due_date" TIMESTAMP(3),
    "notes" TEXT,
    "asset_id" UUID NOT NULL,

    CONSTRAINT "chassises_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "chassises" ADD CONSTRAINT "chassises_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "assets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
