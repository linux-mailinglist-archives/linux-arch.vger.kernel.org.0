Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BBC6AAE4D
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 06:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCEF2r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 00:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEF2q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 00:28:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A8B45C;
        Sat,  4 Mar 2023 21:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD276B808D5;
        Sun,  5 Mar 2023 05:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093DFC433EF;
        Sun,  5 Mar 2023 05:28:39 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Provide kernel fpu functions
Date:   Sun,  5 Mar 2023 13:28:18 +0800
Message-Id: <20230305052818.4030447-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
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

Provide kernel_fpu_begin()/kernel_fpu_end() to let the kernel use fpu
itself. They can be used by AMDGPU graphic driver for DCN.

Reported-by: Xuerui Wang <kernel@xen0n.name>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/fpu.h |  3 +++
 arch/loongarch/kernel/Makefile   |  2 +-
 arch/loongarch/kernel/kfpu.c     | 41 ++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kfpu.c

diff --git a/arch/loongarch/include/asm/fpu.h b/arch/loongarch/include/asm/fpu.h
index 358b254d9c1d..192f8e35d912 100644
--- a/arch/loongarch/include/asm/fpu.h
+++ b/arch/loongarch/include/asm/fpu.h
@@ -21,6 +21,9 @@
 
 struct sigcontext;
 
+extern void kernel_fpu_begin(void);
+extern void kernel_fpu_end(void);
+
 extern void _init_fpu(unsigned int);
 extern void _save_fp(struct loongarch_fpu *);
 extern void _restore_fp(struct loongarch_fpu *);
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 78d4e3384305..9a72d91cd104 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -13,7 +13,7 @@ obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_EFI) 		+= efi.o
 
-obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
+obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o kfpu.o
 
 obj-$(CONFIG_ARCH_STRICT_ALIGN)	+= unaligned.o
 
diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
new file mode 100644
index 000000000000..cd2a18fecdcc
--- /dev/null
+++ b/arch/loongarch/kernel/kfpu.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ */
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <asm/fpu.h>
+#include <asm/smp.h>
+
+static DEFINE_PER_CPU(bool, in_kernel_fpu);
+
+void kernel_fpu_begin(void)
+{
+	if(this_cpu_read(in_kernel_fpu))
+		return;
+
+	preempt_disable();
+	this_cpu_write(in_kernel_fpu, true);
+
+	if (!is_fpu_owner())
+		enable_fpu();
+	else
+		_save_fp(&current->thread.fpu);
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	if(!this_cpu_read(in_kernel_fpu))
+		return;
+
+	if (!is_fpu_owner())
+		disable_fpu();
+	else
+		_restore_fp(&current->thread.fpu);
+
+	this_cpu_write(in_kernel_fpu, false);
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
-- 
2.39.1

