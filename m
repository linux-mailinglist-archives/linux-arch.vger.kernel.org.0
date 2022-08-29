Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2A5A515A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiH2QQs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiH2QQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 12:16:21 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADA479A49;
        Mon, 29 Aug 2022 09:16:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MGbCL12CMz9spN;
        Mon, 29 Aug 2022 18:15:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n4IE7qcjxmat; Mon, 29 Aug 2022 18:15:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MGbCK3pBWz9spV;
        Mon, 29 Aug 2022 18:15:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69B9C8B778;
        Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fXwjJX_PKphO; Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 105488B773;
        Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27TGFmFP988643
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:15:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27TGFmJv988642;
        Mon, 29 Aug 2022 18:15:48 +0200
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
        Will Deacon <will@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 7/8] arm: Remove CONFIG_ARCH_NR_GPIO
Date:   Mon, 29 Aug 2022 18:15:09 +0200
Message-Id: <fa2251b4ff61de6682dd5855fa2ffc0cf726c0fb.1661789204.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661789204.git.christophe.leroy@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661789704; l=1272; s=20211009; h=from:subject:message-id; bh=bRbrUxt54GZjMd4kfaNKUVtccdxc8LDM5pjgR4yc3v8=; b=ZTpipPj88Elbqs1fwiV4+eOPRZOqWuJ/Vru8UMumQaMt/sbuJuDTgcZxxJsG0Xm2/GAb6CH/5bFb +wBWtDRmCCdp+Ac8RirU76aoIR7SE9uiHuFHEGUfkrWrAucR/71V
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

