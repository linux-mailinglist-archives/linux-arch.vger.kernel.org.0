Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCF12CD93
	for <lists+linux-arch@lfdr.de>; Mon, 30 Dec 2019 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfL3IX7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Dec 2019 03:23:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfL3IX7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Dec 2019 03:23:59 -0500
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C0F207FF;
        Mon, 30 Dec 2019 08:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577694238;
        bh=Biwwd4LtakB9FdBdd5i14+uCUU5zhzHTcRb4d34SM+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7Ha0AenroDw3q4MNiJZlXZl2f7iSDn4SeashT61kvkX3BXy/sUAAxkVAJNf8q4Y7
         snqFyYwhLWsS4OLzQPaYPRhMXbuDvHhEJaNlyrEp0RcZCMnFQPosDsqVEgJhW0fOpw
         gU8t3sZzpB5aKBwF71+BOVmU79ZHajwYyDiWIHy4=
From:   guoren@kernel.org
To:     linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, Mao Han <han_mao@c-sky.com>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH 2/5] csky: Initial stack protector support
Date:   Mon, 30 Dec 2019 16:23:28 +0800
Message-Id: <20191230082331.30976-2-guoren@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191230082331.30976-1-guoren@kernel.org>
References: <20191230082331.30976-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mao Han <han_mao@c-sky.com>

This is a basic -fstack-protector support without per-task canary
switching. The protector will report something like when stack
corruption is detected:

It's tested with strcpy local array overflow in sys_kill and get:
stack-protector: Kernel stack is corrupted in: sys_kill+0x23c/0x23c

TODO:
 - Support task switch for different cannary

Signed-off-by: Mao Han <han_mao@c-sky.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig                      |  1 +
 arch/csky/include/asm/stackprotector.h | 29 ++++++++++++++++++++++++++
 arch/csky/kernel/process.c             |  6 ++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/csky/include/asm/stackprotector.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847b5f42..285234300740 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
diff --git a/arch/csky/include/asm/stackprotector.h b/arch/csky/include/asm/stackprotector.h
new file mode 100644
index 000000000000..d7cd4e51edd9
--- /dev/null
+++ b/arch/csky/include/asm/stackprotector.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif /* __ASM_SH_STACKPROTECTOR_H */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f320d9248a22..5349cd8c0f30 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -16,6 +16,12 @@
 
 struct cpuinfo_csky cpu_data[NR_CPUS];
 
+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-- 
2.17.0

