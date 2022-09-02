Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A875AB1EE
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbiIBNpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 09:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiIBNpS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 09:45:18 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566C612D515;
        Fri,  2 Sep 2022 06:21:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJyHb0wlzz9slp;
        Fri,  2 Sep 2022 14:42:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t6fBFsb4UbyX; Fri,  2 Sep 2022 14:42:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJyHS0zPBz9sls;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C99A8B78C;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TIqipSHIuhEZ; Fri,  2 Sep 2022 14:42:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.39])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CDF5D8B78D;
        Fri,  2 Sep 2022 14:42:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 282CgYdb2141515
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 14:42:34 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 282CgY0K2141514;
        Fri, 2 Sep 2022 14:42:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Davide Ciminaghi <ciminaghi@gnudd.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 5/9] gpiolib: Get rid of ARCH_NR_GPIOS
Date:   Fri,  2 Sep 2022 14:42:05 +0200
Message-Id: <97011204619556ecb3d8c9aaff2b58c28790fe8a.1662116601.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662116601.git.christophe.leroy@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662122527; l=5608; s=20211009; h=from:subject:message-id; bh=627tvaA946/n4BKkAs3Ap6n2Spr0bzlnkVDrEw1Weh4=; b=oK8L6x4YO0/Tfv1rrveqxWyPzUigpLkkcs3kpG/V0GCD1hH9rQwWg26uIXH5pm4hEOPy17HUWSCs RlrtLGZNAGwtNu+GH+gFces0cecHaH5Rk0+Fg/FbRiFpz6clOxDG
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit 14e85c0e69d5 ("gpio: remove gpio_descs global array")
there is no limitation on the number of GPIOs that can be allocated
in the system since the allocation is fully dynamic.

ARCH_NR_GPIOS is today only used in order to provide downwards
gpiobase allocation from that value, while static allocation is
performed upwards from 0. However that has the disadvantage of
limiting the number of GPIOs that can be registered in the system.

To overcome this limitation without requiring each and every
platform to provide its 'best-guess' maximum number, rework the
allocation to allocate upwards, allowing approx 2 millions of
GPIOs.

In order to still allow static allocation for legacy drivers, define
GPIO_DYNAMIC_BASE with the value 512 as the start for dynamic
allocation. The 512 value is chosen because it is the end of
the current default range so all current static allocations are
expected to be below that value. Of course that's just a rough
estimate based on the default value, but assuming static
allocations come first, even if there are more static allocations
it should fit under the 512 value.

In the future, it is expected that all static allocations go away
and then dynamic allocation will be patched to start at 0.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Enhanced commit description and change from 256 to 512.
---
 arch/arm/include/asm/gpio.h |  1 -
 drivers/gpio/gpiolib.c      | 10 +++----
 include/asm-generic/gpio.h  | 55 ++++++++++++++-----------------------
 3 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index f3bb8a2bf788..4ebbb58f06ea 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -2,7 +2,6 @@
 #ifndef _ARCH_ARM_GPIO_H
 #define _ARCH_ARM_GPIO_H
 
-/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
 #include <asm-generic/gpio.h>
 
 /* The trivial gpiolib dispatchers */
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4e2fcb7b0a01..1846f24971e3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -183,14 +183,14 @@ EXPORT_SYMBOL_GPL(gpiod_to_chip);
 static int gpiochip_find_base(int ngpio)
 {
 	struct gpio_device *gdev;
-	int base = ARCH_NR_GPIOS - ngpio;
+	int base = GPIO_DYNAMIC_BASE;
 
-	list_for_each_entry_reverse(gdev, &gpio_devices, list) {
+	list_for_each_entry(gdev, &gpio_devices, list) {
 		/* found a free space? */
-		if (gdev->base + gdev->ngpio <= base)
+		if (gdev->base >= base + ngpio)
 			break;
-		/* nope, check the space right before the chip */
-		base = gdev->base - ngpio;
+		/* nope, check the space right after the chip */
+		base = gdev->base + gdev->ngpio;
 	}
 
 	if (gpio_is_valid(base)) {
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index aea9aee1f3e9..a7752cf152ce 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -11,40 +11,18 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 
-/* Platforms may implement their GPIO interface with library code,
+/*
+ * Platforms may implement their GPIO interface with library code,
  * at a small performance cost for non-inlined operations and some
  * extra memory (for code and for per-GPIO table entries).
- *
- * While the GPIO programming interface defines valid GPIO numbers
- * to be in the range 0..MAX_INT, this library restricts them to the
- * smaller range 0..ARCH_NR_GPIOS-1.
- *
- * ARCH_NR_GPIOS is somewhat arbitrary; it usually reflects the sum of
- * builtin/SoC GPIOs plus a number of GPIOs on expanders; the latter is
- * actually an estimate of a board-specific value.
  */
 
-#ifndef ARCH_NR_GPIOS
-#if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
-#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
-#else
-#define ARCH_NR_GPIOS		512
-#endif
-#endif
-
 /*
- * "valid" GPIO numbers are nonnegative and may be passed to
- * setup routines like gpio_request().  only some valid numbers
- * can successfully be requested and used.
- *
- * Invalid GPIO numbers are useful for indicating no-such-GPIO in
- * platform data and other tables.
+ * At the end we want all GPIOs to be dynamically allocated from 0.
+ * However, some legacy drivers still perform fixed allocation.
+ * Until they are all fixed, leave 0-512 space for them.
  */
-
-static inline bool gpio_is_valid(int number)
-{
-	return number >= 0 && number < ARCH_NR_GPIOS;
-}
+#define GPIO_DYNAMIC_BASE	512
 
 struct device;
 struct gpio;
@@ -140,12 +118,6 @@ static inline void gpio_unexport(unsigned gpio)
 
 #include <linux/kernel.h>
 
-static inline bool gpio_is_valid(int number)
-{
-	/* only non-negative numbers are valid */
-	return number >= 0;
-}
-
 /* platforms that don't directly support access to GPIOs through I2C, SPI,
  * or other blocking infrastructure can use these wrappers.
  */
@@ -169,4 +141,19 @@ static inline void gpio_set_value_cansleep(unsigned gpio, int value)
 
 #endif /* !CONFIG_GPIOLIB */
 
+/*
+ * "valid" GPIO numbers are nonnegative and may be passed to
+ * setup routines like gpio_request().  only some valid numbers
+ * can successfully be requested and used.
+ *
+ * Invalid GPIO numbers are useful for indicating no-such-GPIO in
+ * platform data and other tables.
+ */
+
+static inline bool gpio_is_valid(int number)
+{
+	/* only non-negative numbers are valid */
+	return number >= 0;
+}
+
 #endif /* _ASM_GENERIC_GPIO_H */
-- 
2.37.1

