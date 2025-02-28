-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS `user_table` (
  `id` varchar(191) NOT NULL,
  `display_name` longtext DEFAULT NULL,
  `photo_url` longtext DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- +goose StatementEnd

-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS `project_table` (
  `id` varchar(191) NOT NULL,
  `user_id` varchar(191) NOT NULL,
  `title` longtext NOT NULL,
  `image_url` longtext DEFAULT NULL,
  `colors` json DEFAULT NULL,
  `knitting_type` longtext DEFAULT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `fk_user_table_user_id` 
    FOREIGN KEY `fk_user_id` (`user_id`)
    REFERENCES `user_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS `user_table`;
-- +goose StatementEnd

-- +goose StatementBegin
DROP TABLE IF EXISTS `project_table`;
-- +goose StatementEnd
