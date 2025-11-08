-- CreateTable
CREATE TABLE `users` (
    `id` CHAR(36) NOT NULL,
    `fullname` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `role` ENUM('USER', 'ADMIN') NOT NULL DEFAULT 'USER',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `users_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `drivers` (
    `id` CHAR(36) NOT NULL,
    `driver_number` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `notes` VARCHAR(191) NULL,
    `is_active` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `assets` (
    `id` CHAR(36) NOT NULL,
    `asset_code` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `asset_type` ENUM('VEHICLE', 'CHASSIS', 'EQUIPMENT', 'OFFICE_TOOL') NOT NULL,
    `brand` VARCHAR(191) NULL,
    `model` VARCHAR(191) NULL,
    `serrial_number` VARCHAR(191) NULL,
    `purchase_date` DATETIME(3) NULL,
    `purchase_price` INTEGER NULL,
    `is_active` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vehicles` (
    `id` CHAR(36) NOT NULL,
    `license_plate` VARCHAR(191) NULL,
    `color` VARCHAR(191) NULL,
    `year` INTEGER NULL,
    `engine_number` VARCHAR(191) NULL,
    `frame_number` VARCHAR(191) NULL,
    `no_kir` VARCHAR(191) NULL,
    `kir_due_date` DATETIME(3) NULL,
    `stnk_due_date` DATETIME(3) NULL,
    `notes` VARCHAR(191) NULL,
    `asset_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `vehicles_asset_id_key`(`asset_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `chassises` (
    `id` CHAR(36) NOT NULL,
    `chassis_number` VARCHAR(191) NOT NULL,
    `chassis_type` ENUM('RANGKA', 'FLATBED') NOT NULL,
    `chassis_category` VARCHAR(191) NOT NULL,
    `axle_count` INTEGER NOT NULL,
    `no_kir` VARCHAR(191) NULL,
    `kir_due_date` DATETIME(3) NULL,
    `notes` VARCHAR(191) NULL,
    `asset_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `chassises_asset_id_key`(`asset_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipments` (
    `id` CHAR(36) NOT NULL,
    `equipment_code` VARCHAR(191) NOT NULL,
    `equipment_type` VARCHAR(191) NOT NULL,
    `specification` VARCHAR(191) NOT NULL,
    `condition` VARCHAR(191) NOT NULL,
    `asset_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `equipments_asset_id_key`(`asset_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `spareparts` (
    `id` CHAR(36) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `unit` VARCHAR(191) NOT NULL,
    `price` INTEGER NOT NULL,
    `stock_quantity` INTEGER NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maintenences` (
    `id` CHAR(36) NOT NULL,
    `record_number` VARCHAR(191) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `complaint` VARCHAR(191) NOT NULL,
    `repair_notes` VARCHAR(191) NOT NULL,
    `driver_id` CHAR(36) NOT NULL,
    `asset_id` CHAR(36) NOT NULL,
    `km_asset` INTEGER NOT NULL,
    `total_cost` INTEGER NOT NULL,
    `labor_cost` INTEGER NOT NULL,
    `spareparts_cost` INTEGER NOT NULL,
    `asset_image_url` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `images` (
    `id` CHAR(36) NOT NULL,
    `url` VARCHAR(191) NOT NULL,
    `alt` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maintenence_images` (
    `id` CHAR(36) NOT NULL,
    `maintenence_id` CHAR(36) NOT NULL,
    `image_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `maintenence_images_maintenence_id_image_id_key`(`maintenence_id`, `image_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `maintenence_spareparts` (
    `id` CHAR(36) NOT NULL,
    `maintenence_id` CHAR(36) NOT NULL,
    `sparepart_id` CHAR(36) NOT NULL,

    UNIQUE INDEX `maintenence_spareparts_maintenence_id_sparepart_id_key`(`maintenence_id`, `sparepart_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `vehicles` ADD CONSTRAINT `vehicles_asset_id_fkey` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `chassises` ADD CONSTRAINT `chassises_asset_id_fkey` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `equipments` ADD CONSTRAINT `equipments_asset_id_fkey` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenences` ADD CONSTRAINT `maintenences_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenences` ADD CONSTRAINT `maintenences_driver_id_fkey` FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenences` ADD CONSTRAINT `maintenences_asset_id_fkey` FOREIGN KEY (`asset_id`) REFERENCES `assets`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenence_images` ADD CONSTRAINT `maintenence_images_maintenence_id_fkey` FOREIGN KEY (`maintenence_id`) REFERENCES `maintenences`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenence_images` ADD CONSTRAINT `maintenence_images_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `images`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenence_spareparts` ADD CONSTRAINT `maintenence_spareparts_maintenence_id_fkey` FOREIGN KEY (`maintenence_id`) REFERENCES `maintenences`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `maintenence_spareparts` ADD CONSTRAINT `maintenence_spareparts_sparepart_id_fkey` FOREIGN KEY (`sparepart_id`) REFERENCES `spareparts`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
