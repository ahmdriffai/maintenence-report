-- CreateTable
CREATE TABLE "spareparts" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "unit" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "stock_quantity" INTEGER NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "spareparts_pkey" PRIMARY KEY ("id")
);
