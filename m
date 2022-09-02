Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C785AB470
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiIBO4j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 10:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiIBOzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 10:55:35 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9123A57E14;
        Fri,  2 Sep 2022 07:20:31 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJyHZ1C1yz9sm3;
        Fri,  2 Sep 2022 14:42:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L2tYFm1Unf53; Fri,  2 Sep 2022 14:42:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJyHS0hWBz9slp;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 033DD8B788;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BNAXGiHZikYS; Fri,  2 Sep 2022 14:42:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.39])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D04698B78F;
        Fri,  2 Sep 2022 14:42:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 282CgZ762141527
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 14:42:35 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 282CgZce2141526;
        Fri, 2 Sep 2022 14:42:35 +0200
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
        linux-doc@vger.kernel.org, x86@kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 8/9] arm: Remove CONFIG_ARCH_NR_GPIO
Date:   Fri,  2 Sep 2022 14:42:08 +0200
Message-Id: <2dc6d379a45e2c64642ce3f8d7162ac5ce33de20.1662116601.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662116601.git.christophe.leroy@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662122527; l=1330; s=20211009; h=from:subject:message-id; bh=1BVt9i5DavOPBO7XM1LUtmD7lStTF/PpXMrVJD/owUY=; b=OCqif6hODZW8iskcBDkbz8RY/1Q6JSXxS6ldvyLaOvRo/SyKIN86ebVN/h+F4fqI54QzFWG59EuF 8UUkUuxoABGIGx7CYQtL+wucugpmmMM1b7Zr9D+T5FwWGuThwJRh
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

CONFIG_ARCH_NR_GPIO is not used anymore, remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/Kconfig | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..5bfdb78a2d82 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1227,27 +1227,6 @@ config ARM_PSCI
 	  0022A ("Power State Coordination Interface System Software on
 	  ARM processors").
 
-# The GPIO number here must be sorted by descending number. In case of
-# a multiplatform kernel, we just want the highest value required by the
-# selected platforms.
-config ARCH_NR_GPIO
-	int
-	default 2048 if ARCH_INTEL_SOCFPGA
-	default 1024 if ARCH_BRCMSTB || ARCH_RENESAS || ARCH_TEGRA || \
-		ARCH_ZYNQ || ARCH_ASPEED
-	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
-		SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
-	default 416 if ARCH_SUNXI
-	default 392 if ARCH_U8500
-	default 352 if ARCH_VT8500
-	default 288 if ARCH_ROCKCHIP
-	default 264 if MACH_H4700
-	default 0
-	help
-	  Maximum number of GPIOs in the system.
-
-	  If unsure, leave the default value.
-
 config HZ_FIXED
 	int
 	default 128 if SOC_AT91RM9200
-- 
2.37.1

