Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B88CB15C7ED
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgBMQRJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:17:09 -0500
Received: from foss.arm.com ([217.140.110.172]:49954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgBMQRI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0142328;
        Thu, 13 Feb 2020 08:17:07 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5E43F6CF;
        Thu, 13 Feb 2020 08:17:05 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 09/19] linux/ktime.h: Extract common header for vDSO
Date:   Thu, 13 Feb 2020 16:16:04 +0000
Message-Id: <20200213161614.23246-10-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
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

Split ktime.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/common/ktime.h | 16 ++++++++++++++++
 include/linux/ktime.h  |  9 +--------
 2 files changed, 17 insertions(+), 8 deletions(-)
 create mode 100644 include/common/ktime.h

diff --git a/include/common/ktime.h b/include/common/ktime.h
new file mode 100644
index 000000000000..4dd6c6762ad4
--- /dev/null
+++ b/include/common/ktime.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COMMON_KTIME_H
+#define __COMMON_KTIME_H
+
+#include <common/jiffies.h>
+
+/*
+ * The resolution of the clocks. The resolution value is returned in
+ * the clock_getres() system call to give application programmers an
+ * idea of the (in)accuracy of timers. Timer values are rounded up to
+ * this resolution values.
+ */
+#define LOW_RES_NSEC		TICK_NSEC
+#define KTIME_LOW_RES		(LOW_RES_NSEC)
+
+#endif /* __COMMON_KTIME_H */
diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index b2bb44f87f5a..0e1fadeb23c3 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -253,14 +253,7 @@ static inline __must_check bool ktime_to_timespec64_cond(const ktime_t kt,
 	}
 }
 
-/*
- * The resolution of the clocks. The resolution value is returned in
- * the clock_getres() system call to give application programmers an
- * idea of the (in)accuracy of timers. Timer values are rounded up to
- * this resolution values.
- */
-#define LOW_RES_NSEC		TICK_NSEC
-#define KTIME_LOW_RES		(LOW_RES_NSEC)
+#include <common/ktime.h>
 
 static inline ktime_t ns_to_ktime(u64 ns)
 {
-- 
2.25.0

