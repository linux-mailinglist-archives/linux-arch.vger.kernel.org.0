Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8753B6CE
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jun 2022 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiFBKT3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jun 2022 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiFBKT2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2022 06:19:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D33D297507;
        Thu,  2 Jun 2022 03:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8E98B80AE8;
        Thu,  2 Jun 2022 10:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CF2C385A5;
        Thu,  2 Jun 2022 10:19:19 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Huacai Chen <chenhuacai@loongson.cn>,
        WANG Xuerui <git@xen0n.name>
Subject: [PATCH V13 01/24] irqchip: Adjust Kconfig for Loongson
Date:   Thu,  2 Jun 2022 18:19:26 +0800
Message-Id: <20220602101949.3873682-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220602101949.3873682-1-chenhuacai@loongson.cn>
References: <20220602101949.3873682-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

HTVEC will be shared by both MIPS-based and LoongArch-based Loongson
processors (not only Loongson-3), so we adjust its description. HTPIC is
only used by MIPS-based Loongson, so we add a MIPS dependency.

Reviewed-by: WANG Xuerui <git@xen0n.name>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 44fb8843e80e..1cb3967fe798 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -557,7 +557,7 @@ config LOONGSON_LIOINTC
 
 config LOONGSON_HTPIC
 	bool "Loongson3 HyperTransport PIC Controller"
-	depends on MACH_LOONGSON64
+	depends on (MACH_LOONGSON64 && MIPS)
 	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
@@ -565,12 +565,12 @@ config LOONGSON_HTPIC
 	  Support for the Loongson-3 HyperTransport PIC Controller.
 
 config LOONGSON_HTVEC
-	bool "Loongson3 HyperTransport Interrupt Vector Controller"
+	bool "Loongson HyperTransport Interrupt Vector Controller"
 	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help
-	  Support for the Loongson3 HyperTransport Interrupt Vector Controller.
+	  Support for the Loongson HyperTransport Interrupt Vector Controller.
 
 config LOONGSON_PCH_PIC
 	bool "Loongson PCH PIC Controller"
-- 
2.27.0

