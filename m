Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727985A5158
	for <lists+linux-arch@lfdr.de>; Mon, 29 Aug 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiH2QQb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Aug 2022 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiH2QQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Aug 2022 12:16:11 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680D8B9A9;
        Mon, 29 Aug 2022 09:16:05 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MGbCK4QSCz9spb;
        Mon, 29 Aug 2022 18:15:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dY2tXF9cT81y; Mon, 29 Aug 2022 18:15:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MGbCK3dszz9spN;
        Mon, 29 Aug 2022 18:15:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62F788B775;
        Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v_8kNT6KfVa8; Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08E0E8B76E;
        Mon, 29 Aug 2022 18:15:52 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27TGFmvL988638
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 18:15:48 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27TGFmqg988637;
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
Subject: [PATCH v1 6/8] x86: Remove CONFIG_ARCH_NR_GPIO
Date:   Mon, 29 Aug 2022 18:15:08 +0200
Message-Id: <a9005637159a08570c42a2aedda50892d96ef026.1661789204.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1661789204.git.christophe.leroy@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661789704; l=560; s=20211009; h=from:subject:message-id; bh=TvWhCixrZ8WORiyAwZk1xm+dh9qTTeOKVQqhZ1W6Lx8=; b=kCCBbNktOxWJKc3IDB37a1HEDxNwe1lIEvED2sErpMqD3v1dsJ/IDRhG4xBgfjwV9IbdCdA453YE W1dQ55trAFMYOiLUaPCgHuKr7C7yG5GOHNTWgcckO3BpRmW3QIdK
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
 arch/x86/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..0385d5273e37 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -345,11 +345,6 @@ config ARCH_HAS_CPU_RELAX
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
-config ARCH_NR_GPIO
-	int
-	default 1024 if X86_64
-	default 512
-
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
-- 
2.37.1

