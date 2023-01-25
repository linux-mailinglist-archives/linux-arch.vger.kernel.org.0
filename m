Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36167BC4C
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbjAYUKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjAYUKs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:10:48 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC45D11A;
        Wed, 25 Jan 2023 12:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674677418; x=1706213418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWptUuAvNZS0kbLHRKn6oORyrZ25KQvA1dzBPjHWj5Y=;
  b=W2j+5NCuuX9pBpvjyjnweD+WaROJFjF8T0ZucJZB2nuFzVfah4nYli2y
   FPmk1UyN5rMTibZfXz7K+D0gWnLpf26Yo7fa/GwuYjU+KsnrmyDXsW0GW
   JyHz8mPoX3IR9+ZKGXEMo4aGxYYRXgcaVD9dHcYpfwaMulEfQdLSGPbrQ
   uVdqXRkC33Vo59KxgO0yEOOh+3iDItsHD79IPj1MuA5Ga5kSEu6cbfuss
   sOL7wYnOek1Q0ZbY4Du8LnDMN/j99/ARG3138/bvpsrHsT456z3yXPRHB
   NbD3Rjk94XR9hPO4yYSIjjeFtdpctugJt3N3E8RXu0z8BJBu9Ix11rVu2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326694750"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326694750"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770871658"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770871658"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 12:09:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3ABE992; Wed, 25 Jan 2023 22:10:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is disabled
Date:   Wed, 25 Jan 2023 22:10:16 +0200
Message-Id: <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
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

From: Pierluigi Passaro <pierluigi.p@variscite.com>

Both the functions gpiochip_request_own_desc and
gpiochip_free_own_desc are exported from
    drivers/gpio/gpiolib.c
but this file is compiled only when CONFIG_GPIOLIB is enabled.
Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
reasonable definitions and includes in the "#else" branch.

Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declarations")
Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/driver.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 26a808fb8a25..67990908a040 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -751,6 +751,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
 
 #endif /* CONFIG_PINCTRL */
 
+#ifdef CONFIG_GPIOLIB
+
 struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    unsigned int hwnum,
 					    const char *label,
@@ -758,8 +760,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
 					    enum gpiod_flags dflags);
 void gpiochip_free_own_desc(struct gpio_desc *desc);
 
-#ifdef CONFIG_GPIOLIB
-
 /* lock/unlock as IRQ */
 int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
@@ -769,6 +769,25 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 
 #else /* CONFIG_GPIOLIB */
 
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+
+static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
+					    unsigned int hwnum,
+					    const char *label,
+					    enum gpio_lookup_flags lflags,
+					    enum gpiod_flags dflags)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(1);
+	return ERR_PTR(-ENODEV);
+}
+
+static inline void gpiochip_free_own_desc(struct gpio_desc *desc)
+{
+	WARN_ON(1);
+}
+
 static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.39.0

