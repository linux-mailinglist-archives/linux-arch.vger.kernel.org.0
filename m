Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6817BECF
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 14:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCFNda (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 08:33:30 -0500
Received: from foss.arm.com ([217.140.110.172]:33666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgCFNda (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 08:33:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A91361063;
        Fri,  6 Mar 2020 05:33:29 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD8843F6CF;
        Fri,  6 Mar 2020 05:33:26 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 12/20] arm64: Introduce asm/common/processor.h
Date:   Fri,  6 Mar 2020 13:32:34 +0000
Message-Id: <20200306133242.26279-13-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306133242.26279-1-vincenzo.frascino@arm.com>
References: <20200306133242.26279-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Introduce asm/common/processor.h to contain all the arm64 specific
functions that are suitable for vDSO inclusion.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/common/processor.h | 31 +++++++++++++++++++++++
 arch/arm64/include/asm/processor.h        | 16 ++----------
 2 files changed, 33 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/include/asm/common/processor.h

diff --git a/arch/arm64/include/asm/common/processor.h b/arch/arm64/include/asm/common/processor.h
new file mode 100644
index 000000000000..d02b0f392923
--- /dev/null
+++ b/arch/arm64/include/asm/common/processor.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_COMMON_PROCESSOR_H
+#define __ASM_COMMON_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/page-def.h>
+
+#ifdef CONFIG_COMPAT
+#if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
+/*
+ * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
+ * by the compat vectors page.
+ */
+#define TASK_SIZE_32		UL(0x100000000)
+#else
+#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
+#endif /* CONFIG_ARM64_64K_PAGES */
+#endif /* CONFIG_COMPAT */
+
+static inline void cpu_relax(void)
+{
+	asm volatile("yield" ::: "memory");
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_COMMON_PROCESSOR_H */
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 5ba63204d078..2866afc33f24 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -28,6 +28,8 @@
 #include <linux/string.h>
 #include <linux/thread_info.h>
 
+#include <common/processor.h>
+
 #include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/hw_breakpoint.h>
@@ -47,15 +49,6 @@
 #define TASK_SIZE_64		(UL(1) << vabits_actual)
 
 #ifdef CONFIG_COMPAT
-#if defined(CONFIG_ARM64_64K_PAGES) && defined(CONFIG_KUSER_HELPERS)
-/*
- * With CONFIG_ARM64_64K_PAGES enabled, the last page is occupied
- * by the compat vectors page.
- */
-#define TASK_SIZE_32		UL(0x100000000)
-#else
-#define TASK_SIZE_32		(UL(0x100000000) - PAGE_SIZE)
-#endif /* CONFIG_ARM64_64K_PAGES */
 #define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
@@ -256,11 +249,6 @@ extern void release_thread(struct task_struct *);
 
 unsigned long get_wchan(struct task_struct *p);
 
-static inline void cpu_relax(void)
-{
-	asm volatile("yield" ::: "memory");
-}
-
 /* Thread switching */
 extern struct task_struct *cpu_switch_to(struct task_struct *prev,
 					 struct task_struct *next);
-- 
2.25.1

