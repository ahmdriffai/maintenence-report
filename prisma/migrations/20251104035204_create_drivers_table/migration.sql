-- CreateTable
CREATE TABLE "drivers" (
    "id" UUID NOT NULL,
    "driver_number" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "notes" TEXT,
    "is_active" BOOLEAN NOT NULL,

    CONSTRAINT "drivers_pkey" PRIMARY KEY ("id")
);
