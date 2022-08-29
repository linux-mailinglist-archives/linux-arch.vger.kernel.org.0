Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3805A5A5141
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 18:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiH2QPq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiH2QPj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 12:15:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58834D147;
        Mon, 29 Aug 2022 09:15:36 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MGbBt35PJz9spN;
        Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fo9r7bRubnDp; Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MGbBt1d9bz9smN;
        Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1FEB18B770;
        Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G8xiXSUm_EUb; Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E17AD8B76E;
        Mon, 29 Aug 2022 18:15:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27TGFO24988571
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:15:24 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27TGFMP7988534;
        Mon, 29 Aug 2022 18:15:22 +0200
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
Subject: [PATCH v1 0/8] gpio: Get rid of ARCH_NR_GPIOS (v1)
Date:   Mon, 29 Aug 2022 18:15:02 +0200
Message-Id: <cover.1661789204.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661789703; l=1865; s=20211009; h=from:subject:message-id; bh=Vl/sfiqqYCKPx5L5pTixiJLacXAAcuoC8yRZdP3eXxA=; b=9IH3swSm3id8KIsons/Q3yxValzSB+wJ/4C4y5L9EbH7Udj/av3v2DSHbVZID5OuRevIwV/lp66p WFgDODeFB04IIwVGsiAsAp4v5VACL5hz6QzPeEZcV1ZfsYRuYz/x
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
allocation to allocate from 256 upwards, allowing approx 2 millions
of GPIOs.

In the meantime, add a warning for drivers how are still doing
static allocation, so that in the future the static allocation gets
removed completely and dynamic allocation can start at base 0.

Christophe Leroy (8):
  gpio: aggregator: Stop using ARCH_NR_GPIOS
  gpio: davinci: Stop using ARCH_NR_GPIOS
  gpiolib: Warn on drivers still using static gpiobase allocation
  gpiolib: Get rid of ARCH_NR_GPIOS
  Documentation: gpio: Remove text about ARCH_NR_GPIOS
  x86: Remove CONFIG_ARCH_NR_GPIO
  arm: Remove CONFIG_ARCH_NR_GPIO
  arm64: Remove CONFIG_ARCH_NR_GPIO

 Documentation/driver-api/gpio/legacy.rst |  5 ---
 arch/arm/Kconfig                         | 21 ---------
 arch/arm/include/asm/gpio.h              |  1 -
 arch/arm64/Kconfig                       | 12 ------
 arch/x86/Kconfig                         |  5 ---
 drivers/gpio/gpio-aggregator.c           |  8 ++--
 drivers/gpio/gpio-davinci.c              |  3 --
 drivers/gpio/gpio-sta2x11.c              |  5 +--
 drivers/gpio/gpiolib.c                   | 13 +++---
 include/asm-generic/gpio.h               | 55 +++++++++---------------
 10 files changed, 36 insertions(+), 92 deletions(-)

-- 
2.37.1

