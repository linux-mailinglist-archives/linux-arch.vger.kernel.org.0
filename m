Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8708A18D1EC
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgCTOz3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 10:55:29 -0400
Received: from foss.arm.com ([217.140.110.172]:50430 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgCTOzZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:55:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EE891FB;
        Fri, 20 Mar 2020 07:55:25 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A87E3F792;
        Fri, 20 Mar 2020 07:55:22 -0700 (PDT)
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
Subject: [PATCH v5 13/26] linux/jiffies.h: Extract common header for vDSO
Date:   Fri, 20 Mar 2020 14:53:38 +0000
Message-Id: <20200320145351.32292-14-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320145351.32292-1-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
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

Split jiffies.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/jiffies.h |  4 +---
 include/vdso/jiffies.h  | 11 +++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 include/vdso/jiffies.h

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index e3279ef24d28..fed6ba96c527 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <vdso/jiffies.h>
 #include <asm/param.h>			/* for HZ */
 #include <generated/timeconst.h>
 
@@ -59,9 +60,6 @@
 
 extern int register_refined_jiffies(long clock_tick_rate);
 
-/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
-#define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
-
 /* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
 
diff --git a/include/vdso/jiffies.h b/include/vdso/jiffies.h
new file mode 100644
index 000000000000..2f9d596c8b29
--- /dev/null
+++ b/include/vdso/jiffies.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_JIFFIES_H
+#define __VDSO_JIFFIES_H
+
+#include <asm/param.h>			/* for HZ */
+#include <vdso/time64.h>
+
+/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
+#define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
+
+#endif /* __VDSO_JIFFIES_H */
-- 
2.25.1

