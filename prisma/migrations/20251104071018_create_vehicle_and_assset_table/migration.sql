-- CreateEnum
CREATE TYPE "AssetType" AS ENUM ('VEHICLE', 'CHASSIS', 'EQUIPMENT', 'OFFICE_TOOL');

-- CreateTable
CREATE TABLE "assets" (
    "id" UUID NOT NULL,
    "asset_code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "asset_type" "AssetType" NOT NULL,
    "brand" TEXT,
    "model" TEXT,
    "serrial_number" TEXT,
    "purchase_date" TIMESTAMP(3),
    "purchase_price" BIGINT,
    "is_active" BOOLEAN NOT NULL,

    CONSTRAINT "assets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "vehicles" (
    "id" UUID NOT NULL,
    "license_plate" TEXT,
    "color" TEXT,
    "year" INTEGER,
    "engine_number" TEXT,
    "frame_number" TEXT,
    "no_kir" TEXT,
    "kir_due_date" TIMESTAMP(3),
    "stnk_due_date" TIMESTAMP(3),
    "notes" TEXT,
    "asset_id" UUID NOT NULL,

    CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "vehicles" ADD CONSTRAINT "vehicles_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "assets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
