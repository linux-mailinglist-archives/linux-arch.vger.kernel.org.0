Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F25C18D1E1
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCTOz6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 10:55:58 -0400
Received: from foss.arm.com ([217.140.110.172]:50772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgCTOz5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:55:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 661A71045;
        Fri, 20 Mar 2020 07:55:57 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F4D13F792;
        Fri, 20 Mar 2020 07:55:54 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: [PATCH v5 23/26] x86: vdso: Enable x86 to use common headers
Date:   Fri, 20 Mar 2020 14:53:48 +0000
Message-Id: <20200320145351.32292-24-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320145351.32292-1-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
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
 arch/x86/include/asm/processor.h      | 12 +-----------
 arch/x86/include/asm/vdso/processor.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 11 deletions(-)
 create mode 100644 arch/x86/include/asm/vdso/processor.h

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 09705ccc393c..94789db550df 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -26,6 +26,7 @@ struct vm86;
 #include <asm/fpu/types.h>
 #include <asm/unwind_hints.h>
 #include <asm/vmxfeatures.h>
+#include <asm/vdso/processor.h>
 
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
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..57b1a7034c64
--- /dev/null
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 ARM Ltd.
+ */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
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
+#endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.25.1

