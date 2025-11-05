-- CreateTable
CREATE TABLE "equipments" (
    "id" UUID NOT NULL,
    "equipment_code" TEXT NOT NULL,
    "equipment_type" TEXT NOT NULL,
    "specification" TEXT NOT NULL,
    "condition" TEXT NOT NULL,
    "asset_id" UUID NOT NULL,

    CONSTRAINT "equipments_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "equipments" ADD CONSTRAINT "equipments_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "assets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
