Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6443858D78B
	for <lists+linux-arch@lfdr.de>; Tue,  9 Aug 2022 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbiHIKlr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242671AbiHIKlp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 06:41:45 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F3F240B0;
        Tue,  9 Aug 2022 03:41:42 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4M28kq4Mkpz9sj9;
        Tue,  9 Aug 2022 12:41:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bwunTC9zQdnT; Tue,  9 Aug 2022 12:41:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4M28kq3KFwz9sTf;
        Tue,  9 Aug 2022 12:41:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 618598B778;
        Tue,  9 Aug 2022 12:41:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OgfyrO3Jg3AT; Tue,  9 Aug 2022 12:41:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.234.255])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1C0FF8B763;
        Tue,  9 Aug 2022 12:41:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 279AfUiP098284
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 9 Aug 2022 12:41:30 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 279AfSLO098283;
        Tue, 9 Aug 2022 12:41:28 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Date:   Tue,  9 Aug 2022 12:40:38 +0200
Message-Id: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1660041632; l=4893; s=20211009; h=from:subject:message-id; bh=ejR9oy9Pzrb8cgNZizsVlepvN45Ei2h0wt6+agIKtnw=; b=iINNvBE7QtjOKvB5PfN++erBtPsIhPMmqt/Z3lpvNjlBik2I3AaHxITPd0hsvJrpISp2eGMVSXs7 k8V7YsxYANQW8OT/GDp2OZUhMBB4TXFze5pWuYa7YMXL3wOm+uOE
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

At the time being, the default maximum number of GPIOs is set to 512
and can only get customised via an architecture specific
CONFIG_ARCH_NR_GPIO.

The maximum number of GPIOs might be dependent on the number of
interface boards and is somewhat independent of architecture.

Allow the user to select that maximum number outside of any
architecture configuration. To enable that, re-define a
core CONFIG_ARCH_NR_GPIO for architectures which don't already
define one. Guard it with a new hidden CONFIG_ARCH_HAS_NR_GPIO.

Only two architectures will need CONFIG_ARCH_HAS_NR_GPIO: x86 and arm.

On arm, do like x86 and set 512 as the default instead of 0, that
allows simplifying the logic in asm-generic/gpio.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/driver-api/gpio/legacy.rst |  2 +-
 arch/arm/Kconfig                         |  3 ++-
 arch/arm/include/asm/gpio.h              |  1 -
 arch/x86/Kconfig                         |  1 +
 drivers/gpio/Kconfig                     | 14 ++++++++++++++
 include/asm-generic/gpio.h               |  6 ------
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index 9b12eeb89170..566b06a584cf 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -558,7 +558,7 @@ Platform Support
 To force-enable this framework, a platform's Kconfig will "select" GPIOLIB,
 else it is up to the user to configure support for GPIO.
 
-It may also provide a custom value for ARCH_NR_GPIOS, so that it better
+It may also provide a custom value for CONFIG_ARCH_NR_GPIO, so that it better
 reflects the number of GPIOs in actual use on that platform, without
 wasting static table space.  (It should count both built-in/SoC GPIOs and
 also ones on GPIO expanders.
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 53e6a1da9af5..e55b6560fe4f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -14,6 +14,7 @@ config ARM
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	select ARCH_HAS_NR_GPIO
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
 	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SETUP_DMA_OPS
@@ -1243,7 +1244,7 @@ config ARCH_NR_GPIO
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_ROCKCHIP
 	default 264 if MACH_H4700
-	default 0
+	default 512
 	help
 	  Maximum number of GPIOs in the system.
 
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
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..a8c956abc21e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -82,6 +82,7 @@ config X86
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	select ARCH_HAS_NR_GPIO
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0642f579196f..250b50ed44e1 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -11,6 +11,9 @@ config ARCH_HAVE_CUSTOM_GPIO_H
 	  overriding the default implementations.  New uses of this are
 	  strongly discouraged.
 
+config ARCH_HAS_NR_GPIO
+	bool
+
 menuconfig GPIOLIB
 	bool "GPIO Support"
 	help
@@ -22,6 +25,17 @@ menuconfig GPIOLIB
 
 if GPIOLIB
 
+config ARCH_NR_GPIO
+	int "Maximum number of GPIOs" if EXPERT
+	depends on !ARCH_HAS_NR_GPIO
+	default 512
+	help
+	  This allows the user to select the maximum number of GPIOs the
+	  kernel must support. When the architecture defines a number
+	  through CONFIG_ARCH_NR_GPIO, that value is taken and the user
+	  cannot change it. Otherwise it defaults to 512 and the user
+	  can change it when CONFIG_EXPERT is set.
+
 config GPIOLIB_FASTPATH_LIMIT
 	int "Maximum number of GPIOs for fast path"
 	range 32 512
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index aea9aee1f3e9..ee090f534ab8 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -24,13 +24,7 @@
  * actually an estimate of a board-specific value.
  */
 
-#ifndef ARCH_NR_GPIOS
-#if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
 #define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
-#else
-#define ARCH_NR_GPIOS		512
-#endif
-#endif
 
 /*
  * "valid" GPIO numbers are nonnegative and may be passed to
-- 
2.37.1

