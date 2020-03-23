Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458AB18F4D5
	for <lists+linux-arch@lfdr.de>; Mon, 23 Mar 2020 13:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgCWMlZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Mar 2020 08:41:25 -0400
Received: from foss.arm.com ([217.140.110.172]:48488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728105AbgCWMlZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Mar 2020 08:41:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7261FB;
        Mon, 23 Mar 2020 05:41:24 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94B8A3F52E;
        Mon, 23 Mar 2020 05:41:23 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH] um: Fix header inclusion
Date:   Mon, 23 Mar 2020 12:41:09 +0000
Message-Id: <20200323124109.7104-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

User Mode is a flavor of x86 that from the vDSO prospective always falls
back on system calls. This implies that it does not require any of the
unified vDSO definitions and their inclusion causes side effects like
the one reported below:

In file included from include/vdso/processor.h:10:0,
                    from include/vdso/datapage.h:17,
                    from arch/x86/include/asm/vgtod.h:7,
                    from arch/x86/um/../kernel/sys_ia32.c:49:
>> arch/x86/include/asm/vdso/processor.h:11:29: error: redefinition of 'rep_nop'
    static __always_inline void rep_nop(void)
                                ^~~~~~~
   In file included from include/linux/rcupdate.h:30:0,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/x86/um/../kernel/sys_ia32.c:25:
   arch/x86/um/asm/processor.h:24:20: note: previous definition of 'rep_nop' was here
    static inline void rep_nop(void)

Make sure that the unnecessary headers are not included when um is built
to address the problem.

Fixes: abc22418db02 ("x86/vdso: Enable x86 to use common headers")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
Rebased on tip/master

 arch/x86/include/asm/vgtod.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fc8e4cd342cc..7aa38b2ad8a9 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -2,6 +2,11 @@
 #ifndef _ASM_X86_VGTOD_H
 #define _ASM_X86_VGTOD_H
 
+/*
+ * This check is required to prevent ARCH=um to include
+ * unwanted headers.
+ */
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 #include <linux/compiler.h>
 #include <asm/clocksource.h>
 #include <vdso/datapage.h>
@@ -14,5 +19,6 @@ typedef u64 gtod_long_t;
 #else
 typedef unsigned long gtod_long_t;
 #endif
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 #endif /* _ASM_X86_VGTOD_H */
-- 
2.25.2

