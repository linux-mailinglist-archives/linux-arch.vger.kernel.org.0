Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2961E5AB46D
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 16:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiIBO4i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiIBOze (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 10:55:34 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C67474C3;
        Fri,  2 Sep 2022 07:20:28 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MJyHX0zHDz9sl9;
        Fri,  2 Sep 2022 14:42:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hzoaqTT0Wt8f; Fri,  2 Sep 2022 14:42:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MJyHS0LG7z9slc;
        Fri,  2 Sep 2022 14:42:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E83AB8B799;
        Fri,  2 Sep 2022 14:42:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Uvqvxmj-dpQb; Fri,  2 Sep 2022 14:42:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.39])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD1168B78C;
        Fri,  2 Sep 2022 14:42:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 282CgXQX2141503
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 14:42:33 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 282CgXPR2141491;
        Fri, 2 Sep 2022 14:42:33 +0200
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
Subject: [PATCH v2 2/9] gpio: aggregator: Stop using ARCH_NR_GPIOS
Date:   Fri,  2 Sep 2022 14:42:02 +0200
Message-Id: <80c5cc7d6e4ece80bc04624d0ffb0baaf4c60fd1.1662116601.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1662116601.git.christophe.leroy@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662122526; l=1933; s=20211009; h=from:subject:message-id; bh=SvXFfJQUTO5F5t8Z8RW4iYV2wYbc1i6KFaZMIt1jCf8=; b=7GOMICCCRbK3VzGpu98z1JNJ/vUBCu03igIs5nPyEHfSFh10WagCzkLboqRfpUgNt432RwACW709 DcKm0/GWBIJEcf3X8czamy4jfI3pKnonHQXa++/rYOmCdZFhSsrV
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v2: Moved AGGREGATOR_MAX_GPIOS before code
---
 drivers/gpio/gpio-aggregator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 0cb2664085cf..6d17d262ad91 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/string.h>
 
+#define AGGREGATOR_MAX_GPIOS 512
 
 /*
  * GPIO Aggregator sysfs interface
@@ -64,7 +65,7 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 	unsigned int i, n = 0;
 	int error = 0;
 
-	bitmap = bitmap_alloc(ARCH_NR_GPIOS, GFP_KERNEL);
+	bitmap = bitmap_alloc(AGGREGATOR_MAX_GPIOS, GFP_KERNEL);
 	if (!bitmap)
 		return -ENOMEM;
 
@@ -84,13 +85,13 @@ static int aggr_parse(struct gpio_aggregator *aggr)
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

