Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9ED15C7EA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgBMQRG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:17:06 -0500
Received: from foss.arm.com ([217.140.110.172]:49922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbgBMQRF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE8CC106F;
        Thu, 13 Feb 2020 08:17:04 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D74E3F6CF;
        Thu, 13 Feb 2020 08:17:02 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 08/19] linux/jiffies.h: Extract common header for vDSO
Date:   Thu, 13 Feb 2020 16:16:03 +0000
Message-Id: <20200213161614.23246-9-vincenzo.frascino@arm.com>
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

Split jiffies.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/common/jiffies.h | 11 +++++++++++
 include/linux/jiffies.h  |  4 +---
 2 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 include/common/jiffies.h

diff --git a/include/common/jiffies.h b/include/common/jiffies.h
new file mode 100644
index 000000000000..ff0207f00550
--- /dev/null
+++ b/include/common/jiffies.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COMMON_JIFFIES_H
+#define __COMMON_JIFFIES_H
+
+#include <asm/param.h>			/* for HZ */
+#include <common/time64.h>
+
+/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
+#define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
+
+#endif /* __COMMON_JIFFIES_H */
diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index e3279ef24d28..710539d1e39b 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <common/jiffies.h>
 #include <asm/param.h>			/* for HZ */
 #include <generated/timeconst.h>
 
@@ -59,9 +60,6 @@
 
 extern int register_refined_jiffies(long clock_tick_rate);
 
-/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
-#define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
-
 /* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
 
-- 
2.25.0

