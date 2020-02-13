Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD2F15C803
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgBMQR1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:17:27 -0500
Received: from foss.arm.com ([217.140.110.172]:50184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730465AbgBMQR1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E21A9328;
        Thu, 13 Feb 2020 08:17:26 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9E03F6CF;
        Thu, 13 Feb 2020 08:17:24 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 16/19] x86: vdso: Enable x86 to use common headers
Date:   Thu, 13 Feb 2020 16:16:11 +0000
Message-Id: <20200213161614.23246-17-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Enable x86 to use only the common headers in the implementation
of the vDSO library.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/include/asm/common/processor.h | 23 +++++++++++++++++++++++
 arch/x86/include/asm/processor.h        | 12 +-----------
 2 files changed, 24 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/include/asm/common/processor.h

diff --git a/arch/x86/include/asm/common/processor.h b/arch/x86/include/asm/common/processor.h
new file mode 100644
index 000000000000..60ca2ee6e672
--- /dev/null
+++ b/arch/x86/include/asm/common/processor.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_COMMON_PROCESSOR_H
+#define __ASM_COMMON_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
+static __always_inline void rep_nop(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
+static __always_inline void cpu_relax(void)
+{
+	rep_nop();
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_COMMON_PROCESSOR_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 09705ccc393c..d66c5dd42cff 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -26,6 +26,7 @@ struct vm86;
 #include <asm/fpu/types.h>
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
+#include <asm/common/processor.h>
 
 #include <linux/personality.h>
 #include <linux/cache.h>
@@ -677,17 +678,6 @@ static inline unsigned int cpuid_edx(unsigned int op)
 	return edx;
 }
 
-/* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
-static __always_inline void rep_nop(void)
-{
-	asm volatile("rep; nop" ::: "memory");
-}
-
-static __always_inline void cpu_relax(void)
-{
-	rep_nop();
-}
-
 /*
  * This function forces the icache and prefetched instruction stream to
  * catch up with reality in two very specific cases:
-- 
2.25.0

