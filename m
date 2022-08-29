Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E785A5163
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiH2QRX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiH2QQs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 12:16:48 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17500985BD;
        Mon, 29 Aug 2022 09:16:29 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MGbCN0lFsz9spX;
        Mon, 29 Aug 2022 18:16:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id urKz4fLWFaye; Mon, 29 Aug 2022 18:16:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MGbCK3kVYz9spT;
        Mon, 29 Aug 2022 18:15:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66E3B8B776;
        Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id z8RIyjpSPjfA; Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D6868B770;
        Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27TGFmN0988634
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:15:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27TGFmZk988633;
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
Subject: [PATCH v1 5/8] Documentation: gpio: Remove text about ARCH_NR_GPIOS
Date:   Mon, 29 Aug 2022 18:15:07 +0200
Message-Id: <e29d05f84a2826f66fc467602872d353e3b80f2d.1661789204.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661789204.git.christophe.leroy@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661789704; l=1417; s=20211009; h=from:subject:message-id; bh=zlMFz7Ikp5uNHPeHN9zI8vyXZjlKiXLyAd53uhcgXjo=; b=SdKOqgLtoGtJOUNuZ2GOpaqrMtK2IAX/He/VVNWdYgG93Jo95Rx2D3L4ZJsiYI7ws2XbPLOHXkbW LlGg3sLDAFQybDWdkBgzRUe+iYAkcUZyfWaQEQVObnRueY+obm1F
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

ARCH_NR_GPIOS have been removed, clean up the documentation.

After this patch, the only place when ARCH_NR_GPIOS remains is in
translations/zh_CN/gpio.txt and translations/zh_TW/gpio.txt.
I don't have the skills to update that, anyway those two files are
already out of sync as they are still mentionning ARCH_REQUIRE_GPIOLIB
which was removed by commit 65053e1a7743 ("gpio: delete
ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/driver-api/gpio/legacy.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index 9b12eeb89170..e17910cc3271 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -558,11 +558,6 @@ Platform Support
 To force-enable this framework, a platform's Kconfig will "select" GPIOLIB,
 else it is up to the user to configure support for GPIO.
 
-It may also provide a custom value for ARCH_NR_GPIOS, so that it better
-reflects the number of GPIOs in actual use on that platform, without
-wasting static table space.  (It should count both built-in/SoC GPIOs and
-also ones on GPIO expanders.
-
 If neither of these options are selected, the platform does not support
 GPIOs through GPIO-lib and the code cannot be enabled by the user.
 
-- 
2.37.1

