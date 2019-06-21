Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BD4E51F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFUJxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:53:11 -0400
Received: from foss.arm.com ([217.140.110.172]:55122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfFUJxK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBA4B1478;
        Fri, 21 Jun 2019 02:53:09 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4246B3F246;
        Fri, 21 Jun 2019 02:53:07 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v7 01/25] kernel: Standardize vdso_datapage
Date:   Fri, 21 Jun 2019 10:52:28 +0100
Message-Id: <20190621095252.32307-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In an effort to unify the common code for managing the vdso library in
between all the architectures that support it, this patch tries to
provide a common format for the vdso datapage.

As a result of this, this patch generalized the data structures in vgtod.h
from x86 private includes to general includes (include/vdso).

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 include/vdso/datapage.h | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 include/vdso/datapage.h

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
new file mode 100644
index 000000000000..770f40254b08
--- /dev/null
+++ b/include/vdso/datapage.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_DATAPAGE_H
+#define __VDSO_DATAPAGE_H
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bits.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define VDSO_BASES	(CLOCK_TAI + 1)
+#define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
+			 BIT(CLOCK_MONOTONIC)		| \
+			 BIT(CLOCK_BOOTTIME)		| \
+			 BIT(CLOCK_TAI))
+#define VDSO_COARSE	(BIT(CLOCK_REALTIME_COARSE)	| \
+			 BIT(CLOCK_MONOTONIC_COARSE))
+#define VDSO_RAW	(BIT(CLOCK_MONOTONIC_RAW))
+
+#define CS_HRES_COARSE	0
+#define CS_RAW		1
+#define CS_BASES	(CS_RAW + 1)
+
+/**
+ * struct vdso_timestamp - basetime per clock_id
+ * @sec: seconds
+ * @nsec: nanoseconds
+ *
+ * There is one vdso_timestamp object in vvar for each vDSO-accelerated
+ * clock_id. For high-resolution clocks, this encodes the time
+ * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * the actual time.
+ *
+ * To be noticed that for highres clocks nsec is left-shifted by
+ * vdso_data.cs[x].shift.
+ */
+struct vdso_timestamp {
+	u64	sec;
+	u64	nsec;
+};
+
+/**
+ * struct vdso_data - vdso datapage representation
+ * @seq: timebase sequence counter
+ * @clock_mode: clock mode
+ * @cycle_last: timebase at clocksource init
+ * @mask: clocksource mask
+ * @mult: clocksource multiplier
+ * @shift: clocksource shift
+ * @basetime[clock_id]: basetime per clock_id
+ * @tz_minuteswest: minutes west of Greenwich
+ * @tz_dsttime: type of DST correction
+ * @hrtimer_res: hrtimer resolution
+ * @__unused: unused
+ *
+ * vdso_data will be accessed by 64 bit and compat code at the same time
+ * so we should be careful before modifying this structure.
+ */
+struct vdso_data {
+	u32			seq;
+
+	s32			clock_mode;
+	u64			cycle_last;
+	u64			mask;
+	u32			mult;
+	u32			shift;
+
+	struct vdso_timestamp	basetime[VDSO_BASES];
+
+	s32			tz_minuteswest;
+	s32			tz_dsttime;
+	u32			hrtimer_res;
+	u32			__unused;
+};
+
+/*
+ * We use the hidden visibility to prevent the compiler from generating a GOT
+ * relocation. Not only is going through a GOT useless (the entry couldn't and
+ * must not be overridden by another library), it does not even work: the linker
+ * cannot generate an absolute address to the data page.
+ *
+ * With the hidden visibility, the compiler simply generates a PC-relative
+ * relocation, and this is what we need.
+ */
+extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __VDSO_DATAPAGE_H */
-- 
2.21.0

