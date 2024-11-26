INSERT INTO `customer_payment_method` (`customer_payment_method_id`, `customer_id`, `payment_method_id`, `creditcard`) VALUES
(UUID_TO_BIN(UUID()), 1, 1, UNHEX('4111111111111111')),  -- John Doe, Tarjeta de Crédito Visa
(UUID_TO_BIN(UUID()), 2, 2, UNHEX('5105105105105100')),  -- Alice Smith, Tarjeta de Crédito MasterCard
(UUID_TO_BIN(UUID()), 3, 3, NULL),  -- Mike Brown, PayPal (sin tarjeta)
(UUID_TO_BIN(UUID()), 4, 4, NULL),  -- Jane White, Transferencia Bancaria (sin tarjeta)
(UUID_TO_BIN(UUID()), 5, 5, UNHEX('4111111111111111')),  -- Tony Lee, Tarjeta de Crédito Visa
(UUID_TO_BIN(UUID()), 6, 1, UNHEX('5105105105105100')),  -- Kathy Chan, Tarjeta de Crédito MasterCard
(UUID_TO_BIN(UUID()), 7, 2, UNHEX('4111111111111111')),  -- Paul Moore, Tarjeta de Crédito Visa
(UUID_TO_BIN(UUID()), 8, 3, NULL),  -- Betty Thompson, PayPal (sin tarjeta)
(UUID_TO_BIN(UUID()), 9, 4, NULL),  -- Rachel Jones, Transferencia Bancaria (sin tarjeta)
(UUID_TO_BIN(UUID()), 10, 5, UNHEX('5105105105105100')),  -- Michael Clark, Tarjeta de Crédito MasterCard
(UUID_TO_BIN(UUID()), 11, 1, UNHEX('4111111111111111')), -- José López, Tarjeta de Crédito Visa
(UUID_TO_BIN(UUID()), 12, 2, UNHEX('5105105105105100')), -- Ana Méndez, Tarjeta de Crédito MasterCard
(UUID_TO_BIN(UUID()), 13, 3, NULL), -- Miguel García, PayPal (sin tarjeta)
(UUID_TO_BIN(UUID()), 14, 4, NULL), -- Juana Martínez, Transferencia Bancaria (sin tarjeta)
(UUID_TO_BIN(UUID()), 15, 5, UNHEX('4111111111111111')), -- Tomas Parra, Tarjeta de Crédito Visa
(UUID_TO_BIN(UUID()), 16, 1, UNHEX('5105105105105100')), -- Karina Ramírez, Tarjeta de Crédito MasterCard
(UUID_TO_BIN(UUID()), 17, 2, UNHEX('4111111111111111')), -- Pablo Castillo, Tarjeta de Crédito Visa
(UUID_TO_BIN(UUID()), 18, 3, NULL), -- Beatriz Fernández, PayPal (sin tarjeta)
(UUID_TO_BIN(UUID()), 19, 4, NULL), -- Roberto Ortiz, Transferencia Bancaria (sin tarjeta)
(UUID_TO_BIN(UUID()), 20, 5, UNHEX('5105105105105100')); -- María Ramírez, Tarjeta de Crédito MasterCard


