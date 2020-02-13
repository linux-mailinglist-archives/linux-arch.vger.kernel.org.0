Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15615C7E1
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgBMQQ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:16:57 -0500
Received: from foss.arm.com ([217.140.110.172]:49822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgBMQQ5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:16:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0EB41063;
        Thu, 13 Feb 2020 08:16:56 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2028D3F6CF;
        Thu, 13 Feb 2020 08:16:54 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 05/19] linux/time.h: Extract common header for vDSO
Date:   Thu, 13 Feb 2020 16:16:00 +0000
Message-Id: <20200213161614.23246-6-vincenzo.frascino@arm.com>
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

Split time.h into linux and common headers to make the latter suitable
for inclusion in the vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/common/time.h | 12 ++++++++++++
 include/linux/time.h  |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 include/common/time.h

diff --git a/include/common/time.h b/include/common/time.h
new file mode 100644
index 000000000000..90eb9bdb40ec
--- /dev/null
+++ b/include/common/time.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __COMMON_TIME_H
+#define __COMMON_TIME_H
+
+#include <uapi/linux/types.h>
+
+struct timens_offset {
+	s64	sec;
+	u64	nsec;
+};
+
+#endif /* __COMMON_TIME_H */
diff --git a/include/linux/time.h b/include/linux/time.h
index 8ef5e5cc9f57..617a01e2c8bb 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -111,9 +111,6 @@ static inline bool itimerspec64_valid(const struct itimerspec64 *its)
  */
 #define time_between32(t, l, h) ((u32)(h) - (u32)(l) >= (u32)(t) - (u32)(l))
 
-struct timens_offset {
-	s64	sec;
-	u64	nsec;
-};
+# include <common/time.h>
 
 #endif
-- 
2.25.0

