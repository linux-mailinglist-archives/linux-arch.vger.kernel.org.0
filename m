Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD945A5145
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiH2QQA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiH2QPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 12:15:51 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E561726A5;
        Mon, 29 Aug 2022 09:15:41 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MGbBv2W8wz9smN;
        Mon, 29 Aug 2022 18:15:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fyvpOMQr2YQu; Mon, 29 Aug 2022 18:15:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MGbBt1vglz9spL;
        Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 288A08B76E;
        Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T3Pct2zvm3IF; Mon, 29 Aug 2022 18:15:34 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E073D8B763;
        Mon, 29 Aug 2022 18:15:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27TGFOdw988575
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:15:24 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27TGFOqA988574;
        Mon, 29 Aug 2022 18:15:24 +0200
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
Subject: [PATCH v1 1/8] gpio: aggregator: Stop using ARCH_NR_GPIOS
Date:   Mon, 29 Aug 2022 18:15:03 +0200
Message-Id: <621cf12492b03bb251d30078ae1594788d74529f.1661789204.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661789204.git.christophe.leroy@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661789703; l=1856; s=20211009; h=from:subject:message-id; bh=mAoWl25B3NuoJhgxA5kBIzV7/ujMf4v5EXVlGSN+yyo=; b=sL8rE6JkU7Q/FqyK2x6JmBMkSXsEFaXr+hMd0tkqCYsVEunrCpCfe24L5VDrMCQbso19lxLNaAHO oIpKQcfIDvVLVHRbJeUq6hf96QhQPh5hlupBd0mUuIcGO7qDB91F
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

ARCH_NR_GPIOS is used locally in aggr_parse() as the maximum number
of GPIOs to be aggregated together by the driver since
commit ec75039d5550 ("gpio: aggregator: Use bitmap_parselist() for
parsing GPIO offsets").

Don't rely on the total possible number of GPIOs in the system but
define a local arbitrary macro for that, set to 512 which should be
large enough as it is also the default value for ARCH_NR_GPIOS.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/gpio/gpio-aggregator.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 0cb2664085cf..4548da542ad2 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -56,6 +56,8 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
 	return 0;
 }
 
+#define AGGREGATOR_MAX_GPIOS 512
+
 static int aggr_parse(struct gpio_aggregator *aggr)
 {
 	char *args = skip_spaces(aggr->args);
@@ -64,7 +66,7 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 	unsigned int i, n = 0;
 	int error = 0;
 
-	bitmap = bitmap_alloc(ARCH_NR_GPIOS, GFP_KERNEL);
+	bitmap = bitmap_alloc(AGGREGATOR_MAX_GPIOS, GFP_KERNEL);
 	if (!bitmap)
 		return -ENOMEM;
 
@@ -84,13 +86,13 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		}
 
 		/* GPIO chip + offset(s) */
-		error = bitmap_parselist(offsets, bitmap, ARCH_NR_GPIOS);
+		error = bitmap_parselist(offsets, bitmap, AGGREGATOR_MAX_GPIOS);
 		if (error) {
 			pr_err("Cannot parse %s: %d\n", offsets, error);
 			goto free_bitmap;
 		}
 
-		for_each_set_bit(i, bitmap, ARCH_NR_GPIOS) {
+		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
 			error = aggr_add_gpio(aggr, name, i, &n);
 			if (error)
 				goto free_bitmap;
-- 
2.37.1

