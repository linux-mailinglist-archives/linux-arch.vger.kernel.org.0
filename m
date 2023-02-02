Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F396877B8
	for <lists+linux-arch@lfdr.de>; Thu,  2 Feb 2023 09:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBBImn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Feb 2023 03:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBBImm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2023 03:42:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA37DBF1;
        Thu,  2 Feb 2023 00:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4BE2B8253F;
        Thu,  2 Feb 2023 08:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B26C433D2;
        Thu,  2 Feb 2023 08:42:35 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Make -mstrict-align be configurable
Date:   Thu,  2 Feb 2023 16:42:38 +0800
Message-Id: <20230202084238.2408516-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce Kconfig option ARCH_STRICT_ALIGN to make -mstrict-align be
configurable.

Not all LoongArch cores support h/w unaligned access, we can use the
-mstrict-align build parameter to prevent unaligned accesses.

This option is disabled by default to optimise for performance, but you
can enabled it manually if you want to run kernel on systems without h/w
unaligned access support.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig  | 10 ++++++++++
 arch/loongarch/Makefile |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9cc8b84f7eb0..7470dcfb32f0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -441,6 +441,16 @@ config ARCH_IOREMAP
 	  protection support. However, you can enable LoongArch DMW-based
 	  ioremap() for better performance.
 
+config ARCH_STRICT_ALIGN
+	bool "Enable -mstrict-align to prevent unaligned accesses"
+	help
+	  Not all LoongArch cores support h/w unaligned access, we can use
+	  -mstrict-align build parameter to prevent unaligned accesses.
+
+	  This is disabled by default to optimise for performance, you can
+	  enabled it manually if you want to run kernel on systems without
+	  h/w unaligned access support.
+
 config KEXEC
 	bool "Kexec system call"
 	select KEXEC_CORE
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4402387d2755..ccfb52700237 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -91,10 +91,12 @@ KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
 # instead of .eh_frame so we don't discard them.
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
+ifdef CONFIG_ARCH_STRICT_ALIGN
 # Don't emit unaligned accesses.
 # Not all LoongArch cores support unaligned access, and as kernel we can't
 # rely on others to provide emulation for these accesses.
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+endif
 
 KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
 
-- 
2.39.0

