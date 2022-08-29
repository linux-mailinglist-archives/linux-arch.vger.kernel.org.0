Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0D5A514A
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiH2QQX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiH2QQI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 12:16:08 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C97645B;
        Mon, 29 Aug 2022 09:15:59 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MGbC90pVxz9spL;
        Mon, 29 Aug 2022 18:15:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X22319V_UsBk; Mon, 29 Aug 2022 18:15:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MGbC82Pyzz9spN;
        Mon, 29 Aug 2022 18:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 413488B773;
        Mon, 29 Aug 2022 18:15:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZCZdDdl47GHh; Mon, 29 Aug 2022 18:15:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EB8B8B76E;
        Mon, 29 Aug 2022 18:15:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27TGFdHc988587
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:15:39 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27TGFUXl988578;
        Mon, 29 Aug 2022 18:15:30 +0200
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
Subject: [PATCH v1 2/8] gpio: davinci: Stop using ARCH_NR_GPIOS
Date:   Mon, 29 Aug 2022 18:15:04 +0200
Message-Id: <6171392f1c2f7afc1c96d4b3ef8cf8d25cb416d2.1661789204.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661789204.git.christophe.leroy@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661789704; l=849; s=20211009; h=from:subject:message-id; bh=MrjhcGYG3GBrnA/rIL0UMYJ3d0nDdyDpMdW1OdYtYF8=; b=W4TtWUe0wWs6b75aFeemf1jQ1dauVnRgTKVt4APrmabGyg97l1mCkPZYFLQJFkDombgLJCYcxEtd bcwtYb2mDQCEIJiHJzJnv/JacqvQI75LAzIIgO6t0XFQMBd2rqv6
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
there is no global limitation anymore on the number of GPIOs in
the system so don't clamp the number of GPIOs with ARCH_NR_GPIOS.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/gpio/gpio-davinci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 59c4c48d8296..1018860c83c2 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -217,9 +217,6 @@ static int davinci_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (WARN_ON(ARCH_NR_GPIOS < ngpio))
-		ngpio = ARCH_NR_GPIOS;
-
 	/*
 	 * If there are unbanked interrupts then the number of
 	 * interrupts is equal to number of gpios else all are banked so
-- 
2.37.1

