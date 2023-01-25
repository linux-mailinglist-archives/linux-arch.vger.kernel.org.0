Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EEB67BC5E
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjAYUMH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbjAYUMD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:12:03 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C795D90F;
        Wed, 25 Jan 2023 12:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674677495; x=1706213495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o+ZGOHz8ijK9H+L7WtFqSqHxlRgWx6avT4sRFNpRp9Y=;
  b=RYWrCao/9Oq9LHh3AJg9okif5Lrotr0WovidRrbRkOce7OtQiGQ4jC/5
   G3GZnikn7iSLe9bUfkY/It2CspXOLSg31uvWr3Tyv177gjb9qQ11wb2WG
   nQdHbNsJllmVSJy0Evu1hCjVOJpxHGSYc89FQAXqIafDt63rSHedTzdJi
   lDkZ+cfWypyJo1AD1sakfsJAENOVzjtM9EqFKpZPlKyt1/wjBQ3FZTB72
   9QwF5gTp6UvY8ybwRERvzJOBif/sWto5Kr45BiFQncB2X0sSJY8R6z9HT
   l19YpCXWo7pDTnjdxTDPnVnzTHRcmaomcDdVQ/4+vlkPsFIqiRV4fZH9f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326694799"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326694799"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:09:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770871663"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770871663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 12:09:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 57E9636E; Wed, 25 Jan 2023 22:10:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 5/5] gpio: Clean up headers
Date:   Wed, 25 Jan 2023 22:10:20 +0200
Message-Id: <20230125201020.10948-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is a few things done:
- include only the headers we are direct user of
- when pointer is in use, provide a forward declaration
- add missing headers
- group generic headers and subsystem headers
- sort each group alphabetically

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/asm-generic/gpio.h    |  8 --------
 include/linux/gpio.h          |  9 +++------
 include/linux/gpio/consumer.h | 14 ++++++++++----
 include/linux/gpio/driver.h   | 34 ++++++++++++++++++++++++----------
 4 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 22cb8c9efc1d..5d4d3529324c 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -3,11 +3,9 @@
 #define _ASM_GENERIC_GPIO_H
 
 #include <linux/types.h>
-#include <linux/errno.h>
 
 #ifdef CONFIG_GPIOLIB
 
-#include <linux/compiler.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 
@@ -24,12 +22,7 @@
  */
 #define GPIO_DYNAMIC_BASE	512
 
-struct device;
 struct gpio;
-struct seq_file;
-struct module;
-struct device_node;
-struct gpio_desc;
 
 /* Always use the library code for GPIO management calls,
  * or when sleeping may be involved.
@@ -60,7 +53,6 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
 	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
 }
 
-
 /* A platform's <asm/gpio.h> code may want to inline the I/O calls when
  * the GPIO is constant and refers to some always-present controller,
  * giving direct access to chip registers and tight bitbanging loops.
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 85beb236c925..cc28c8d5e93c 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -12,7 +12,7 @@
 #ifndef __LINUX_GPIO_H
 #define __LINUX_GPIO_H
 
-#include <linux/errno.h>
+struct device;
 
 /* see Documentation/driver-api/gpio/legacy.rst */
 
@@ -85,20 +85,17 @@ static inline int gpio_to_irq(unsigned int gpio)
 
 /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
 
-struct device;
-
 int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
 int devm_gpio_request_one(struct device *dev, unsigned gpio,
 			  unsigned long flags, const char *label);
 
 #else /* ! CONFIG_GPIOLIB */
 
-#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 
-struct device;
-struct gpio_chip;
+#include <asm/bug.h>
+#include <asm/errno.h>
 
 static inline bool gpio_is_valid(int number)
 {
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 5432e5d5fbfb..1c4385a00f88 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,15 +3,14 @@
 #define __LINUX_GPIO_CONSUMER_H
 
 #include <linux/bits.h>
-#include <linux/bug.h>
-#include <linux/compiler_types.h>
-#include <linux/err.h>
+#include <linux/types.h>
 
 struct acpi_device;
 struct device;
 struct fwnode_handle;
-struct gpio_desc;
+
 struct gpio_array;
+struct gpio_desc;
 
 /**
  * struct gpio_descs - Struct containing an array of descriptors that can be
@@ -185,8 +184,11 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 
 #else /* CONFIG_GPIOLIB */
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 
+#include <asm/bug.h>
+
 static inline int gpiod_count(struct device *dev, const char *con_id)
 {
 	return 0;
@@ -616,6 +618,8 @@ struct gpio_desc *acpi_get_and_request_gpiod(char *path, unsigned int pin, char
 
 #else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
 
+#include <linux/err.h>
+
 static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
 {
@@ -647,6 +651,8 @@ void gpiod_unexport(struct gpio_desc *desc);
 
 #else  /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
 
+#include <asm/errno.h>
+
 static inline int gpiod_export(struct gpio_desc *desc,
 			       bool direction_may_change)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index caf2376dd98b..208c7cfeadb2 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -2,26 +2,29 @@
 #ifndef __LINUX_GPIO_DRIVER_H
 #define __LINUX_GPIO_DRIVER_H
 
-#include <linux/device.h>
-#include <linux/irq.h>
-#include <linux/irqchip/chained_irq.h>
+#include <linux/bits.h>
 #include <linux/irqdomain.h>
+#include <linux/irqhandler.h>
 #include <linux/lockdep.h>
-#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/property.h>
+#include <linux/spinlock_types.h>
 #include <linux/types.h>
 
+#ifdef CONFIG_GENERIC_MSI_IRQ
 #include <asm/msi.h>
+#endif
 
-struct gpio_desc;
+struct device;
+struct irq_chip;
+struct irq_data;
+struct module;
 struct of_phandle_args;
+struct pinctrl_dev;
 struct seq_file;
-struct gpio_device;
-struct module;
-enum gpiod_flags;
-enum gpio_lookup_flags;
 
+struct gpio_desc;
+struct gpio_device;
 struct gpio_chip;
 
 union gpio_irq_fwspec {
@@ -691,6 +694,10 @@ bool gpiochip_irqchip_irq_valid(const struct gpio_chip *gc,
 int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 				struct irq_domain *domain);
 #else
+
+#include <asm/bug.h>
+#include <asm/errno.h>
+
 static inline int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 					      struct irq_domain *domain)
 {
@@ -752,6 +759,9 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
 
 #ifdef CONFIG_GPIOLIB
 
+enum gpiod_flags;
+enum gpio_lookup_flags;
+
 struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
 					    const char *label,
@@ -768,8 +778,12 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 
 #else /* CONFIG_GPIOLIB */
 
-#include <linux/gpio/machine.h>
+#include <linux/err.h>
+
+#include <asm/bug.h>
+
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 
 static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
-- 
2.39.0

