CREATE TABLE IF NOT EXISTS `bakery_location` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `location_code` varchar(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `location_type` varchar(30) NOT NULL,
  `city` varchar(120) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `active_flag` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_location_code` (`location_code`),
  KEY `ix_bakery_location_type` (`location_type`),
  KEY `ix_bakery_location_city` (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_product_category` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `category_code` varchar(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 100,
  `active_flag` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_product_category_code` (`category_code`),
  KEY `ix_bakery_product_category_sort` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_product` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `product_code` varchar(60) NOT NULL,
  `name` varchar(160) NOT NULL,
  `category_oid` binary(16) NOT NULL,
  `unit` varchar(20) NOT NULL DEFAULT 'pcs',
  `shelf_life_hours` int(11) DEFAULT NULL,
  `bestseller_flag` tinyint(1) NOT NULL DEFAULT 0,
  `standard_batch_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `active_flag` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_product_code` (`product_code`),
  KEY `ix_bakery_product_category` (`category_oid`),
  KEY `ix_bakery_product_bestseller` (`bestseller_flag`),
  CONSTRAINT `fk_bakery_product_category` FOREIGN KEY (`category_oid`) REFERENCES `bakery_product_category` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_branch_inventory` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `location_oid` binary(16) NOT NULL,
  `product_oid` binary(16) NOT NULL,
  `stock_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `reserved_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `minimum_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `expected_demand_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `availability_status` varchar(30) NOT NULL DEFAULT 'OK',
  `last_update_on` datetime NOT NULL,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_branch_inventory` (`location_oid`,`product_oid`),
  KEY `ix_bakery_branch_inventory_product` (`product_oid`),
  KEY `ix_bakery_branch_inventory_status` (`availability_status`),
  CONSTRAINT `fk_bakery_branch_inventory_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_branch_inventory_product` FOREIGN KEY (`product_oid`) REFERENCES `bakery_product` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_demand_forecast` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `location_oid` binary(16) NOT NULL,
  `product_oid` binary(16) NOT NULL,
  `forecast_date` date NOT NULL,
  `forecast_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `recommended_bake_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `confidence_pct` decimal(5,2) DEFAULT NULL,
  `source` varchar(40) NOT NULL DEFAULT 'AI_MODEL',
  `reason_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_demand_forecast` (`location_oid`,`product_oid`,`forecast_date`,`source`),
  KEY `ix_bakery_demand_forecast_product` (`product_oid`),
  KEY `ix_bakery_demand_forecast_date` (`forecast_date`),
  CONSTRAINT `fk_bakery_demand_forecast_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_demand_forecast_product` FOREIGN KEY (`product_oid`) REFERENCES `bakery_product` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_demand_signal` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `location_oid` binary(16) NOT NULL,
  `product_oid` binary(16) NOT NULL,
  `signal_type` varchar(40) NOT NULL,
  `signal_strength_pct` decimal(6,2) NOT NULL DEFAULT 0,
  `observed_qty` decimal(12,3) DEFAULT NULL,
  `expected_qty` decimal(12,3) DEFAULT NULL,
  `detected_on` datetime NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'NEW',
  PRIMARY KEY (`oid`),
  KEY `ix_bakery_demand_signal_location` (`location_oid`),
  KEY `ix_bakery_demand_signal_product` (`product_oid`),
  KEY `ix_bakery_demand_signal_status` (`signal_type`,`status`,`detected_on`),
  CONSTRAINT `fk_bakery_demand_signal_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_demand_signal_product` FOREIGN KEY (`product_oid`) REFERENCES `bakery_product` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_raw_material` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `material_code` varchar(60) NOT NULL,
  `name` varchar(160) NOT NULL,
  `unit` varchar(20) NOT NULL DEFAULT 'kg',
  `current_stock_qty` decimal(14,3) NOT NULL DEFAULT 0,
  `minimum_stock_qty` decimal(14,3) NOT NULL DEFAULT 0,
  `active_flag` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_raw_material_code` (`material_code`),
  KEY `ix_bakery_raw_material_stock` (`current_stock_qty`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_supplier_delivery` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `raw_material_oid` binary(16) NOT NULL,
  `supplier_name` varchar(160) NOT NULL,
  `ordered_qty` decimal(14,3) NOT NULL DEFAULT 0,
  `planned_arrival_on` datetime NOT NULL,
  `eta_on` datetime DEFAULT NULL,
  `delay_minutes` int(11) NOT NULL DEFAULT 0,
  `status` varchar(30) NOT NULL DEFAULT 'PLANNED',
  `risk_level` varchar(20) NOT NULL DEFAULT 'LOW',
  PRIMARY KEY (`oid`),
  KEY `ix_bakery_supplier_delivery_material` (`raw_material_oid`),
  KEY `ix_bakery_supplier_delivery_status` (`status`,`risk_level`,`planned_arrival_on`),
  CONSTRAINT `fk_bakery_supplier_delivery_material` FOREIGN KEY (`raw_material_oid`) REFERENCES `bakery_raw_material` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_production_line` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `line_code` varchar(40) NOT NULL,
  `name` varchar(120) NOT NULL,
  `location_oid` binary(16) NOT NULL,
  `category_oid` binary(16) DEFAULT NULL,
  `capacity_units_per_hour` decimal(12,3) NOT NULL DEFAULT 0,
  `status` varchar(30) NOT NULL DEFAULT 'READY',
  `active_flag` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_production_line_code` (`line_code`),
  KEY `ix_bakery_production_line_location` (`location_oid`),
  KEY `ix_bakery_production_line_category` (`category_oid`),
  KEY `ix_bakery_production_line_status` (`status`),
  CONSTRAINT `fk_bakery_production_line_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_production_line_category` FOREIGN KEY (`category_oid`) REFERENCES `bakery_product_category` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_equipment` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `equipment_code` varchar(60) NOT NULL,
  `name` varchar(160) NOT NULL,
  `equipment_type` varchar(40) NOT NULL,
  `production_line_oid` binary(16) DEFAULT NULL,
  `location_oid` binary(16) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ONLINE',
  `min_temperature_c` decimal(6,2) DEFAULT NULL,
  `max_temperature_c` decimal(6,2) DEFAULT NULL,
  `active_flag` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_equipment_code` (`equipment_code`),
  KEY `ix_bakery_equipment_line` (`production_line_oid`),
  KEY `ix_bakery_equipment_location` (`location_oid`),
  KEY `ix_bakery_equipment_type_status` (`equipment_type`,`status`),
  CONSTRAINT `fk_bakery_equipment_line` FOREIGN KEY (`production_line_oid`) REFERENCES `bakery_production_line` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_equipment_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_equipment_telemetry` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `equipment_oid` binary(16) NOT NULL,
  `measured_on` datetime NOT NULL,
  `temperature_c` decimal(6,2) DEFAULT NULL,
  `energy_kwh` decimal(12,3) DEFAULT NULL,
  `co2_kg` decimal(12,3) DEFAULT NULL,
  `throughput_qty` decimal(12,3) DEFAULT NULL,
  `machine_status` varchar(30) NOT NULL DEFAULT 'ONLINE',
  `quality_status` varchar(30) NOT NULL DEFAULT 'OK',
  `error_code` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `ix_bakery_telemetry_equipment_time` (`equipment_oid`,`measured_on`),
  KEY `ix_bakery_telemetry_quality` (`quality_status`),
  CONSTRAINT `fk_bakery_telemetry_equipment` FOREIGN KEY (`equipment_oid`) REFERENCES `bakery_equipment` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_production_order` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `order_no` varchar(60) NOT NULL,
  `product_oid` binary(16) NOT NULL,
  `production_line_oid` binary(16) DEFAULT NULL,
  `planned_start_on` datetime NOT NULL,
  `planned_end_on` datetime NOT NULL,
  `actual_start_on` datetime DEFAULT NULL,
  `actual_end_on` datetime DEFAULT NULL,
  `planned_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `actual_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `waste_qty` decimal(12,3) NOT NULL DEFAULT 0,
  `priority` varchar(20) NOT NULL DEFAULT 'NORMAL',
  `status` varchar(30) NOT NULL DEFAULT 'PLANNED',
  `reschedule_reason` varchar(255) DEFAULT NULL,
  `energy_kwh` decimal(12,3) NOT NULL DEFAULT 0,
  `co2_kg` decimal(12,3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_production_order_no` (`order_no`),
  KEY `ix_bakery_production_order_product` (`product_oid`),
  KEY `ix_bakery_production_order_line` (`production_line_oid`),
  KEY `ix_bakery_production_order_status` (`status`,`priority`,`planned_start_on`),
  CONSTRAINT `fk_bakery_production_order_product` FOREIGN KEY (`product_oid`) REFERENCES `bakery_product` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_production_order_line` FOREIGN KEY (`production_line_oid`) REFERENCES `bakery_production_line` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_production_event` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `production_order_oid` binary(16) DEFAULT NULL,
  `production_line_oid` binary(16) DEFAULT NULL,
  `equipment_oid` binary(16) DEFAULT NULL,
  `event_type` varchar(40) NOT NULL,
  `severity` varchar(20) NOT NULL DEFAULT 'INFO',
  `event_on` datetime NOT NULL,
  `message` varchar(255) NOT NULL,
  `old_value` varchar(255) DEFAULT NULL,
  `new_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `ix_bakery_production_event_order` (`production_order_oid`),
  KEY `ix_bakery_production_event_line` (`production_line_oid`),
  KEY `ix_bakery_production_event_equipment` (`equipment_oid`),
  KEY `ix_bakery_production_event_type` (`event_type`,`severity`,`event_on`),
  CONSTRAINT `fk_bakery_production_event_order` FOREIGN KEY (`production_order_oid`) REFERENCES `bakery_production_order` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_production_event_line` FOREIGN KEY (`production_line_oid`) REFERENCES `bakery_production_line` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_production_event_equipment` FOREIGN KEY (`equipment_oid`) REFERENCES `bakery_equipment` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_delivery_route` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `route_no` varchar(60) NOT NULL,
  `departure_location_oid` binary(16) NOT NULL,
  `planned_departure_on` datetime NOT NULL,
  `actual_departure_on` datetime DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'PLANNED',
  `optimization_status` varchar(30) NOT NULL DEFAULT 'NOT_OPTIMIZED',
  `delay_minutes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_delivery_route_no` (`route_no`),
  KEY `ix_bakery_delivery_route_departure` (`departure_location_oid`),
  KEY `ix_bakery_delivery_route_status` (`status`,`planned_departure_on`),
  CONSTRAINT `fk_bakery_delivery_route_departure` FOREIGN KEY (`departure_location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_delivery_stop` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `delivery_route_oid` binary(16) NOT NULL,
  `location_oid` binary(16) NOT NULL,
  `stop_sequence` int(11) NOT NULL,
  `planned_arrival_on` datetime NOT NULL,
  `eta_on` datetime DEFAULT NULL,
  `actual_arrival_on` datetime DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'PLANNED',
  `on_time_flag` tinyint(1) DEFAULT NULL,
  `priority` varchar(20) NOT NULL DEFAULT 'NORMAL',
  PRIMARY KEY (`oid`),
  UNIQUE KEY `uq_bakery_delivery_stop_sequence` (`delivery_route_oid`,`stop_sequence`),
  KEY `ix_bakery_delivery_stop_location` (`location_oid`),
  KEY `ix_bakery_delivery_stop_status` (`status`,`planned_arrival_on`),
  CONSTRAINT `fk_bakery_delivery_stop_route` FOREIGN KEY (`delivery_route_oid`) REFERENCES `bakery_delivery_route` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_delivery_stop_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_alert_event` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `alert_type` varchar(50) NOT NULL,
  `severity` varchar(20) NOT NULL DEFAULT 'INFO',
  `status` varchar(30) NOT NULL DEFAULT 'OPEN',
  `title` varchar(160) NOT NULL,
  `message` text,
  `location_oid` binary(16) DEFAULT NULL,
  `product_oid` binary(16) DEFAULT NULL,
  `production_line_oid` binary(16) DEFAULT NULL,
  `equipment_oid` binary(16) DEFAULT NULL,
  `production_order_oid` binary(16) DEFAULT NULL,
  `detected_on` datetime NOT NULL,
  `acknowledged_on` datetime DEFAULT NULL,
  `resolved_on` datetime DEFAULT NULL,
  `simulation_flag` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`oid`),
  KEY `ix_bakery_alert_type_status` (`alert_type`,`severity`,`status`),
  KEY `ix_bakery_alert_detected` (`detected_on`),
  KEY `ix_bakery_alert_location` (`location_oid`),
  KEY `ix_bakery_alert_line` (`production_line_oid`),
  CONSTRAINT `fk_bakery_alert_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_alert_product` FOREIGN KEY (`product_oid`) REFERENCES `bakery_product` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_alert_line` FOREIGN KEY (`production_line_oid`) REFERENCES `bakery_production_line` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_alert_equipment` FOREIGN KEY (`equipment_oid`) REFERENCES `bakery_equipment` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_alert_order` FOREIGN KEY (`production_order_oid`) REFERENCES `bakery_production_order` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bakery_kpi_snapshot` (
  `oid` binary(16) NOT NULL,
  `created_on` datetime NOT NULL,
  `modified_on` datetime NOT NULL,
  `snapshot_date` date NOT NULL,
  `snapshot_level` varchar(30) NOT NULL DEFAULT 'GLOBAL',
  `kpi_code` varchar(60) NOT NULL,
  `kpi_name` varchar(160) NOT NULL,
  `value_num` decimal(14,4) NOT NULL DEFAULT 0,
  `unit` varchar(30) NOT NULL,
  `location_oid` binary(16) DEFAULT NULL,
  `production_line_oid` binary(16) DEFAULT NULL,
  `category_oid` binary(16) DEFAULT NULL,
  `product_oid` binary(16) DEFAULT NULL,
  `trend_direction` varchar(20) DEFAULT NULL,
  `target_value_num` decimal(14,4) DEFAULT NULL,
  PRIMARY KEY (`oid`),
  KEY `ix_bakery_kpi_snapshot_date` (`snapshot_date`),
  KEY `ix_bakery_kpi_snapshot_code` (`kpi_code`,`snapshot_level`),
  CONSTRAINT `fk_bakery_kpi_location` FOREIGN KEY (`location_oid`) REFERENCES `bakery_location` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_kpi_line` FOREIGN KEY (`production_line_oid`) REFERENCES `bakery_production_line` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_kpi_category` FOREIGN KEY (`category_oid`) REFERENCES `bakery_product_category` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `fk_bakery_kpi_product` FOREIGN KEY (`product_oid`) REFERENCES `bakery_product` (`oid`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `bakery_location` (`oid`, `created_on`, `modified_on`, `location_code`, `name`, `location_type`, `city`, `latitude`, `longitude`, `active_flag`) VALUES
  (UNHEX('BA000000000000000000000000000001'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PROD-01', 'Main Bakery Production', 'PRODUCTION', 'Wuerzburg', 49.7913000, 9.9534000, 1),
  (UNHEX('BA000000000000000000000000000002'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'WH-01', 'Central Flour Warehouse', 'WAREHOUSE', 'Wuerzburg', 49.7950000, 9.9400000, 1),
  (UNHEX('BA000000000000000000000000000003'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'DC-01', 'Morning Distribution Hub', 'DISTRIBUTION_CENTER', 'Wuerzburg', 49.7860000, 9.9600000, 1),
  (UNHEX('BA000000000000000000000000000004'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-101', 'Branch Market Square', 'BRANCH', 'Wuerzburg', 49.7939000, 9.9294000, 1),
  (UNHEX('BA000000000000000000000000000005'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-102', 'Branch University', 'BRANCH', 'Wuerzburg', 49.7809000, 9.9713000, 1),
  (UNHEX('BA000000000000000000000000000006'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-103', 'Branch Riverside', 'BRANCH', 'Wuerzburg', 49.8002000, 9.9251000, 1),
  (UNHEX('BA000000000000000000000000000007'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BR-104', 'Branch Station', 'BRANCH', 'Wuerzburg', 49.8011000, 9.9366000, 1);

INSERT INTO `bakery_product_category` (`oid`, `created_on`, `modified_on`, `category_code`, `name`, `sort_order`, `active_flag`) VALUES
  (UNHEX('BA000000000000000000000000000101'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BREAD', 'Bread', 10, 1),
  (UNHEX('BA000000000000000000000000000102'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'ROLLS', 'Rolls', 20, 1),
  (UNHEX('BA000000000000000000000000000103'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PASTRY', 'Pastry', 30, 1),
  (UNHEX('BA000000000000000000000000000104'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CAKE', 'Cake', 40, 1);

INSERT INTO `bakery_product` (`oid`, `created_on`, `modified_on`, `product_code`, `name`, `category_oid`, `unit`, `shelf_life_hours`, `bestseller_flag`, `standard_batch_qty`, `active_flag`) VALUES
  (UNHEX('BA000000000000000000000000000201'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BAGUETTE', 'Baguette', UNHEX('BA000000000000000000000000000101'), 'pcs', 18, 1, 160.000, 1),
  (UNHEX('BA000000000000000000000000000202'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'SOURDOUGH', 'Sourdough Bread', UNHEX('BA000000000000000000000000000101'), 'pcs', 36, 1, 120.000, 1),
  (UNHEX('BA000000000000000000000000000203'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PRETZEL_ROLL', 'Pretzel Roll', UNHEX('BA000000000000000000000000000102'), 'pcs', 12, 1, 420.000, 1),
  (UNHEX('BA000000000000000000000000000204'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CROISSANT', 'Croissant', UNHEX('BA000000000000000000000000000103'), 'pcs', 10, 1, 260.000, 1),
  (UNHEX('BA000000000000000000000000000205'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CINNAMON_BUN', 'Cinnamon Bun', UNHEX('BA000000000000000000000000000103'), 'pcs', 14, 0, 180.000, 1),
  (UNHEX('BA000000000000000000000000000206'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'CHEESECAKE_SLICE', 'Cheesecake Slice', UNHEX('BA000000000000000000000000000104'), 'pcs', 24, 0, 90.000, 1);

INSERT INTO `bakery_raw_material` (`oid`, `created_on`, `modified_on`, `material_code`, `name`, `unit`, `current_stock_qty`, `minimum_stock_qty`, `active_flag`) VALUES
  (UNHEX('BA000000000000000000000000000301'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'WHEAT_FLOUR', 'Wheat Flour', 'kg', 1450.000, 1200.000, 1),
  (UNHEX('BA000000000000000000000000000302'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'RYE_FLOUR', 'Rye Flour', 'kg', 620.000, 400.000, 1),
  (UNHEX('BA000000000000000000000000000303'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'YEAST', 'Yeast', 'kg', 85.000, 60.000, 1),
  (UNHEX('BA000000000000000000000000000304'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'BUTTER', 'Butter', 'kg', 210.000, 180.000, 1),
  (UNHEX('BA000000000000000000000000000305'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'PACKAGING', 'Paper Bags And Boxes', 'pcs', 8900.000, 5000.000, 1);

INSERT INTO `bakery_production_line` (`oid`, `created_on`, `modified_on`, `line_code`, `name`, `location_oid`, `category_oid`, `capacity_units_per_hour`, `status`, `active_flag`) VALUES
  (UNHEX('BA000000000000000000000000000401'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'LINE-BREAD-1', 'Bread Line 1', UNHEX('BA000000000000000000000000000001'), UNHEX('BA000000000000000000000000000101'), 280.000, 'RUNNING', 1),
  (UNHEX('BA000000000000000000000000000402'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'LINE-ROLLS-1', 'Rolls Line 1', UNHEX('BA000000000000000000000000000001'), UNHEX('BA000000000000000000000000000102'), 650.000, 'RUNNING', 1),
  (UNHEX('BA000000000000000000000000000403'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'LINE-PASTRY-1', 'Pastry Line 1', UNHEX('BA000000000000000000000000000001'), UNHEX('BA000000000000000000000000000103'), 320.000, 'READY', 1),
  (UNHEX('BA000000000000000000000000000404'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'LINE-CAKE-1', 'Cake Line 1', UNHEX('BA000000000000000000000000000001'), UNHEX('BA000000000000000000000000000104'), 140.000, 'MAINTENANCE', 1);

INSERT INTO `bakery_equipment` (`oid`, `created_on`, `modified_on`, `equipment_code`, `name`, `equipment_type`, `production_line_oid`, `location_oid`, `status`, `min_temperature_c`, `max_temperature_c`, `active_flag`) VALUES
  (UNHEX('BA000000000000000000000000000501'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'OVEN-BREAD-1', 'Bread Deck Oven 1', 'OVEN', UNHEX('BA000000000000000000000000000401'), UNHEX('BA000000000000000000000000000001'), 'ONLINE', 210.00, 245.00, 1),
  (UNHEX('BA000000000000000000000000000502'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'OVEN-ROLLS-1', 'Rolls Tunnel Oven 1', 'OVEN', UNHEX('BA000000000000000000000000000402'), UNHEX('BA000000000000000000000000000001'), 'WARNING', 190.00, 230.00, 1),
  (UNHEX('BA000000000000000000000000000503'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'MIXER-1', 'Dough Mixer 1', 'MIXER', UNHEX('BA000000000000000000000000000401'), UNHEX('BA000000000000000000000000000001'), 'ONLINE', NULL, NULL, 1),
  (UNHEX('BA000000000000000000000000000504'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'COOL-WH-1', 'Warehouse Cooling Zone 1', 'COOLING', NULL, UNHEX('BA000000000000000000000000000002'), 'WARNING', 2.00, 7.00, 1),
  (UNHEX('BA000000000000000000000000000505'), '2026-06-23 08:00:00', '2026-06-23 08:00:00', 'ENERGY-LINE-1', 'Energy Meter Bread Line', 'ENERGY_METER', UNHEX('BA000000000000000000000000000401'), UNHEX('BA000000000000000000000000000001'), 'ONLINE', NULL, NULL, 1);

INSERT INTO `bakery_branch_inventory` (`oid`, `created_on`, `modified_on`, `location_oid`, `product_oid`, `stock_qty`, `reserved_qty`, `minimum_qty`, `expected_demand_qty`, `availability_status`, `last_update_on`) VALUES
  (UNHEX('BA000000000000000000000000000601'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000201'), 22.000, 3.000, 20.000, 65.000, 'LOW', '2026-06-23 09:10:00'),
  (UNHEX('BA000000000000000000000000000602'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), 14.000, 2.000, 35.000, 120.000, 'OUT_OF_STOCK_RISK', '2026-06-23 09:12:00'),
  (UNHEX('BA000000000000000000000000000603'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000005'), UNHEX('BA000000000000000000000000000204'), 48.000, 4.000, 25.000, 90.000, 'OK', '2026-06-23 09:15:00'),
  (UNHEX('BA000000000000000000000000000604'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000006'), UNHEX('BA000000000000000000000000000202'), 9.000, 0.000, 18.000, 42.000, 'CRITICAL', '2026-06-23 09:20:00'),
  (UNHEX('BA000000000000000000000000000605'), '2026-06-23 08:05:00', '2026-06-23 08:05:00', UNHEX('BA000000000000000000000000000007'), UNHEX('BA000000000000000000000000000205'), 36.000, 2.000, 20.000, 44.000, 'OK', '2026-06-23 09:25:00');

INSERT INTO `bakery_demand_forecast` (`oid`, `created_on`, `modified_on`, `location_oid`, `product_oid`, `forecast_date`, `forecast_qty`, `recommended_bake_qty`, `confidence_pct`, `source`, `reason_text`) VALUES
  (UNHEX('BA000000000000000000000000000701'), '2026-06-23 08:10:00', '2026-06-23 08:10:00', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), '2026-06-24', 210.000, 260.000, 91.50, 'AI_MODEL', 'Morning commuter peak expected near market square'),
  (UNHEX('BA000000000000000000000000000702'), '2026-06-23 08:10:00', '2026-06-23 08:10:00', UNHEX('BA000000000000000000000000000005'), UNHEX('BA000000000000000000000000000204'), '2026-06-24', 145.000, 180.000, 87.20, 'AI_MODEL', 'University event increases pastry demand'),
  (UNHEX('BA000000000000000000000000000703'), '2026-06-23 08:10:00', '2026-06-23 08:10:00', UNHEX('BA000000000000000000000000000006'), UNHEX('BA000000000000000000000000000202'), '2026-06-24', 88.000, 110.000, 84.80, 'AI_MODEL', 'Rain forecast shifts demand to bread products'),
  (UNHEX('BA000000000000000000000000000704'), '2026-06-23 08:10:00', '2026-06-23 08:10:00', UNHEX('BA000000000000000000000000000007'), UNHEX('BA000000000000000000000000000205'), '2026-06-24', 74.000, 90.000, 79.10, 'SIMULATION', 'Weekend promotion test scenario');

INSERT INTO `bakery_demand_signal` (`oid`, `created_on`, `modified_on`, `location_oid`, `product_oid`, `signal_type`, `signal_strength_pct`, `observed_qty`, `expected_qty`, `detected_on`, `status`) VALUES
  (UNHEX('BA000000000000000000000000000801'), '2026-06-23 09:20:00', '2026-06-23 09:20:00', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), 'DEMAND_SPIKE', 42.50, 171.000, 120.000, '2026-06-23 09:20:00', 'NEW'),
  (UNHEX('BA000000000000000000000000000802'), '2026-06-23 09:25:00', '2026-06-23 09:25:00', UNHEX('BA000000000000000000000000000006'), UNHEX('BA000000000000000000000000000202'), 'BESTSELLER_SHORTAGE', 55.00, 33.000, 21.000, '2026-06-23 09:25:00', 'PLANNED');

INSERT INTO `bakery_supplier_delivery` (`oid`, `created_on`, `modified_on`, `raw_material_oid`, `supplier_name`, `ordered_qty`, `planned_arrival_on`, `eta_on`, `delay_minutes`, `status`, `risk_level`) VALUES
  (UNHEX('BA000000000000000000000000000901'), '2026-06-23 07:30:00', '2026-06-23 07:30:00', UNHEX('BA000000000000000000000000000301'), 'Franconia Mills', 2500.000, '2026-06-23 10:00:00', '2026-06-23 12:00:00', 120, 'DELAYED', 'HIGH'),
  (UNHEX('BA000000000000000000000000000902'), '2026-06-23 07:30:00', '2026-06-23 07:30:00', UNHEX('BA000000000000000000000000000304'), 'Dairy Partner West', 450.000, '2026-06-23 11:00:00', '2026-06-23 10:55:00', 0, 'IN_TRANSIT', 'LOW');

INSERT INTO `bakery_production_order` (`oid`, `created_on`, `modified_on`, `order_no`, `product_oid`, `production_line_oid`, `planned_start_on`, `planned_end_on`, `actual_start_on`, `actual_end_on`, `planned_qty`, `actual_qty`, `waste_qty`, `priority`, `status`, `reschedule_reason`, `energy_kwh`, `co2_kg`) VALUES
  (UNHEX('BA000000000000000000000000001001'), '2026-06-23 06:00:00', '2026-06-23 09:00:00', 'PO-20260623-001', UNHEX('BA000000000000000000000000000201'), UNHEX('BA000000000000000000000000000401'), '2026-06-23 06:30:00', '2026-06-23 08:30:00', '2026-06-23 06:35:00', '2026-06-23 08:25:00', 320.000, 315.000, 5.000, 'NORMAL', 'DONE', NULL, 86.500, 31.200),
  (UNHEX('BA000000000000000000000000001002'), '2026-06-23 07:00:00', '2026-06-23 09:15:00', 'PO-20260623-002', UNHEX('BA000000000000000000000000000203'), UNHEX('BA000000000000000000000000000402'), '2026-06-23 08:45:00', '2026-06-23 10:30:00', '2026-06-23 08:50:00', NULL, 680.000, 260.000, 8.000, 'URGENT', 'RUNNING', NULL, 72.400, 26.800),
  (UNHEX('BA000000000000000000000000001003'), '2026-06-23 08:00:00', '2026-06-23 09:30:00', 'PO-20260623-003', UNHEX('BA000000000000000000000000000204'), UNHEX('BA000000000000000000000000000403'), '2026-06-23 10:45:00', '2026-06-23 12:10:00', NULL, NULL, 360.000, 0.000, 0.000, 'HIGH', 'PLANNED', NULL, 0.000, 0.000),
  (UNHEX('BA000000000000000000000000001004'), '2026-06-23 08:30:00', '2026-06-23 09:40:00', 'PO-20260623-004', UNHEX('BA000000000000000000000000000202'), UNHEX('BA000000000000000000000000000401'), '2026-06-23 12:30:00', '2026-06-23 14:00:00', NULL, NULL, 180.000, 0.000, 0.000, 'HIGH', 'RESCHEDULED', 'Oven warning on rolls line moved bread buffer slot', 0.000, 0.000);

INSERT INTO `bakery_equipment_telemetry` (`oid`, `created_on`, `modified_on`, `equipment_oid`, `measured_on`, `temperature_c`, `energy_kwh`, `co2_kg`, `throughput_qty`, `machine_status`, `quality_status`, `error_code`) VALUES
  (UNHEX('BA000000000000000000000000001101'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', UNHEX('BA000000000000000000000000000501'), '2026-06-23 09:00:00', 224.50, 18.200, 6.600, 150.000, 'ONLINE', 'OK', NULL),
  (UNHEX('BA000000000000000000000000001102'), '2026-06-23 09:05:00', '2026-06-23 09:05:00', UNHEX('BA000000000000000000000000000502'), '2026-06-23 09:05:00', 236.40, 21.700, 7.900, 210.000, 'WARNING', 'WARNING', 'OVEN_TEMP_HIGH'),
  (UNHEX('BA000000000000000000000000001103'), '2026-06-23 09:10:00', '2026-06-23 09:10:00', UNHEX('BA000000000000000000000000000504'), '2026-06-23 09:10:00', 9.20, 4.800, 1.700, NULL, 'ONLINE', 'LIMIT_EXCEEDED', 'COOLING_LIMIT_HIGH');

INSERT INTO `bakery_production_event` (`oid`, `created_on`, `modified_on`, `production_order_oid`, `production_line_oid`, `equipment_oid`, `event_type`, `severity`, `event_on`, `message`, `old_value`, `new_value`) VALUES
  (UNHEX('BA000000000000000000000000001201'), '2026-06-23 09:05:00', '2026-06-23 09:05:00', UNHEX('BA000000000000000000000000001002'), UNHEX('BA000000000000000000000000000402'), UNHEX('BA000000000000000000000000000502'), 'OVEN_WARNING', 'WARNING', '2026-06-23 09:05:00', 'Rolls tunnel oven temperature above target range', 'ONLINE', 'WARNING'),
  (UNHEX('BA000000000000000000000000001202'), '2026-06-23 09:40:00', '2026-06-23 09:40:00', UNHEX('BA000000000000000000000000001004'), UNHEX('BA000000000000000000000000000401'), NULL, 'RESCHEDULE', 'INFO', '2026-06-23 09:40:00', 'Sourdough order moved into bread line buffer slot', 'PLANNED', 'RESCHEDULED');

INSERT INTO `bakery_delivery_route` (`oid`, `created_on`, `modified_on`, `route_no`, `departure_location_oid`, `planned_departure_on`, `actual_departure_on`, `status`, `optimization_status`, `delay_minutes`) VALUES
  (UNHEX('BA000000000000000000000000001301'), '2026-06-23 07:00:00', '2026-06-23 09:00:00', 'ROUTE-MORNING-01', UNHEX('BA000000000000000000000000000003'), '2026-06-23 09:30:00', NULL, 'LOADING', 'OPTIMIZED', 0),
  (UNHEX('BA000000000000000000000000001302'), '2026-06-23 07:00:00', '2026-06-23 09:00:00', 'ROUTE-MORNING-02', UNHEX('BA000000000000000000000000000003'), '2026-06-23 09:45:00', NULL, 'DELAYED', 'OPTIMIZED', 25);

INSERT INTO `bakery_delivery_stop` (`oid`, `created_on`, `modified_on`, `delivery_route_oid`, `location_oid`, `stop_sequence`, `planned_arrival_on`, `eta_on`, `actual_arrival_on`, `status`, `on_time_flag`, `priority`) VALUES
  (UNHEX('BA000000000000000000000000001401'), '2026-06-23 07:00:00', '2026-06-23 09:00:00', UNHEX('BA000000000000000000000000001301'), UNHEX('BA000000000000000000000000000004'), 1, '2026-06-23 10:00:00', '2026-06-23 09:58:00', NULL, 'PLANNED', NULL, 'URGENT'),
  (UNHEX('BA000000000000000000000000001402'), '2026-06-23 07:00:00', '2026-06-23 09:00:00', UNHEX('BA000000000000000000000000001301'), UNHEX('BA000000000000000000000000000005'), 2, '2026-06-23 10:25:00', '2026-06-23 10:22:00', NULL, 'PLANNED', NULL, 'NORMAL'),
  (UNHEX('BA000000000000000000000000001403'), '2026-06-23 07:00:00', '2026-06-23 09:00:00', UNHEX('BA000000000000000000000000001302'), UNHEX('BA000000000000000000000000000006'), 1, '2026-06-23 10:15:00', '2026-06-23 10:40:00', NULL, 'DELAYED', 0, 'HIGH');

INSERT INTO `bakery_alert_event` (`oid`, `created_on`, `modified_on`, `alert_type`, `severity`, `status`, `title`, `message`, `location_oid`, `product_oid`, `production_line_oid`, `equipment_oid`, `production_order_oid`, `detected_on`, `acknowledged_on`, `resolved_on`, `simulation_flag`) VALUES
  (UNHEX('BA000000000000000000000000001501'), '2026-06-23 09:05:00', '2026-06-23 09:05:00', 'OVEN_FAILURE', 'CRITICAL', 'OPEN', 'Rolls tunnel oven above safe range', 'Temperature drift on rolls line requires immediate replanning.', UNHEX('BA000000000000000000000000000001'), UNHEX('BA000000000000000000000000000203'), UNHEX('BA000000000000000000000000000402'), UNHEX('BA000000000000000000000000000502'), UNHEX('BA000000000000000000000000001002'), '2026-06-23 09:05:00', NULL, NULL, 1),
  (UNHEX('BA000000000000000000000000001502'), '2026-06-23 09:20:00', '2026-06-23 09:20:00', 'DEMAND_SPIKE', 'WARNING', 'OPEN', 'Pretzel roll demand spike', 'Market Square branch reports higher than expected demand.', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), NULL, NULL, NULL, '2026-06-23 09:20:00', NULL, NULL, 1),
  (UNHEX('BA000000000000000000000000001503'), '2026-06-23 09:30:00', '2026-06-23 09:30:00', 'RAW_MATERIAL_DELAY', 'WARNING', 'IN_PROGRESS', 'Wheat flour delivery delayed', 'Supplier ETA moved by 120 minutes.', UNHEX('BA000000000000000000000000000002'), NULL, NULL, NULL, NULL, '2026-06-23 09:30:00', '2026-06-23 09:35:00', NULL, 1),
  (UNHEX('BA000000000000000000000000001504'), '2026-06-23 09:10:00', '2026-06-23 09:10:00', 'COOLING_LIMIT', 'CRITICAL', 'OPEN', 'Warehouse cooling above limit', 'Cooling zone reached 9.2 C and exceeds the configured threshold.', UNHEX('BA000000000000000000000000000002'), NULL, NULL, UNHEX('BA000000000000000000000000000504'), NULL, '2026-06-23 09:10:00', NULL, NULL, 1),
  (UNHEX('BA000000000000000000000000001505'), '2026-06-23 09:12:00', '2026-06-23 09:12:00', 'BRANCH_STOCKOUT_RISK', 'WARNING', 'OPEN', 'Pretzel rolls at stockout risk', 'Branch Market Square may sell out before the next delivery.', UNHEX('BA000000000000000000000000000004'), UNHEX('BA000000000000000000000000000203'), NULL, NULL, NULL, '2026-06-23 09:12:00', NULL, NULL, 0);

INSERT INTO `bakery_kpi_snapshot` (`oid`, `created_on`, `modified_on`, `snapshot_date`, `snapshot_level`, `kpi_code`, `kpi_name`, `value_num`, `unit`, `location_oid`, `production_line_oid`, `category_oid`, `product_oid`, `trend_direction`, `target_value_num`) VALUES
  (UNHEX('BA000000000000000000000000001601'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'GLOBAL', 'FOOD_WASTE_PCT', 'Food Waste', 2.7000, '%', NULL, NULL, NULL, NULL, 'DOWN', 3.0000),
  (UNHEX('BA000000000000000000000000001602'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'LINE', 'LINE_UTILIZATION_PCT', 'Production Utilization', 86.4000, '%', NULL, UNHEX('BA000000000000000000000000000402'), NULL, NULL, 'UP', 82.0000),
  (UNHEX('BA000000000000000000000000001603'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'GLOBAL', 'ENERGY_KWH_PER_UNIT', 'Energy Per Production Unit', 0.1840, 'kWh/unit', NULL, NULL, NULL, NULL, 'STABLE', 0.1900),
  (UNHEX('BA000000000000000000000000001604'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'LOCATION', 'BRANCH_AVAILABILITY_PCT', 'Branch Availability', 93.5000, '%', UNHEX('BA000000000000000000000000000004'), NULL, NULL, NULL, 'DOWN', 97.0000),
  (UNHEX('BA000000000000000000000000001605'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'GLOBAL', 'DELIVERY_ON_TIME_PCT', 'Delivery On Time', 91.0000, '%', NULL, NULL, NULL, NULL, 'DOWN', 95.0000),
  (UNHEX('BA000000000000000000000000001606'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'CATEGORY', 'SALES_EUR', 'Sales Bread Category', 12850.0000, 'EUR', NULL, NULL, UNHEX('BA000000000000000000000000000101'), NULL, 'UP', 12000.0000),
  (UNHEX('BA000000000000000000000000001607'), '2026-06-23 09:00:00', '2026-06-23 09:00:00', '2026-06-23', 'LINE', 'CO2_KG_PER_UNIT', 'CO2 Per Unit Rolls Line', 0.0680, 'kg/unit', NULL, UNHEX('BA000000000000000000000000000402'), NULL, NULL, 'STABLE', 0.0700);
