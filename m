Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B2E4E51B
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfFUJxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:53:17 -0400
Received: from foss.arm.com ([217.140.110.172]:55188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfFUJxQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6226E14F6;
        Fri, 21 Jun 2019 02:53:15 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCFF13F246;
        Fri, 21 Jun 2019 02:53:12 -0700 (PDT)
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
Subject: [PATCH v7 03/25] kernel: Unify update_vsyscall implementation
Date:   Fri, 21 Jun 2019 10:52:30 +0100
Message-Id: <20190621095252.32307-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the definition of the unified vDSO library the implementations of
update_vsyscall and update_vsyscall_tz became quite similar across
architectures.

Define a unified implementation of these two functions in kernel/vdso
and provide the bindings that can be implemented by every architecture
that takes advantage of the unified vDSO library.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
---
 include/asm-generic/vdso/vsyscall.h |  56 ++++++++++++
 include/linux/timekeeper_internal.h |   9 ++
 include/vdso/vsyscall.h             |  11 +++
 kernel/Makefile                     |   1 +
 kernel/vdso/Makefile                |   2 +
 kernel/vdso/vsyscall.c              | 131 ++++++++++++++++++++++++++++
 6 files changed, 210 insertions(+)
 create mode 100644 include/asm-generic/vdso/vsyscall.h
 create mode 100644 include/vdso/vsyscall.h
 create mode 100644 kernel/vdso/Makefile
 create mode 100644 kernel/vdso/vsyscall.c

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
new file mode 100644
index 000000000000..9a4b9fbcc9b6
--- /dev/null
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_VSYSCALL_H
+#define __ASM_GENERIC_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#ifndef __arch_get_k_vdso_data
+static __always_inline
+struct vdso_data *__arch_get_k_vdso_data(void)
+{
+	return NULL;
+}
+#endif /* __arch_get_k_vdso_data */
+
+#ifndef __arch_update_vdso_data
+static __always_inline
+int __arch_update_vdso_data(void)
+{
+	return 0;
+}
+#endif /* __arch_update_vdso_data */
+
+#ifndef __arch_get_clock_mode
+static __always_inline
+int __arch_get_clock_mode(struct timekeeper *tk)
+{
+	return 0;
+}
+#endif /* __arch_get_clock_mode */
+
+#ifndef __arch_use_vsyscall
+static __always_inline
+int __arch_use_vsyscall(struct vdso_data *vdata)
+{
+	return 1;
+}
+#endif /* __arch_use_vsyscall */
+
+#ifndef __arch_update_vsyscall
+static __always_inline
+void __arch_update_vsyscall(struct vdso_data *vdata,
+			    struct timekeeper *tk)
+{
+}
+#endif /* __arch_update_vsyscall */
+
+#ifndef __arch_sync_vdso_data
+static __always_inline
+void __arch_sync_vdso_data(struct vdso_data *vdata)
+{
+}
+#endif /* __arch_sync_vdso_data */
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_GENERIC_VSYSCALL_H */
diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 7acb953298a7..8177e75a71eb 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -135,9 +135,18 @@ struct timekeeper {
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
 
+#ifdef CONFIG_HAVE_GENERIC_VDSO
+
+void update_vsyscall(struct timekeeper *tk);
+void update_vsyscall_tz(void);
+
+#else
+
 extern void update_vsyscall(struct timekeeper *tk);
 extern void update_vsyscall_tz(void);
 
+#endif /* CONFIG_HAVE_GENERIC_VDSO */
+
 #else
 
 static inline void update_vsyscall(struct timekeeper *tk)
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
new file mode 100644
index 000000000000..2c6134e0c23d
--- /dev/null
+++ b/include/vdso/vsyscall.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_VSYSCALL_H
+#define __VDSO_VSYSCALL_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/vdso/vsyscall.h>
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VDSO_VSYSCALL_H */
diff --git a/kernel/Makefile b/kernel/Makefile
index 33824f0385b3..56a98ebb7772 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
 obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-$(CONFIG_HAVE_GENERIC_VDSO) += vdso/
 obj-y += time/
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff --git a/kernel/vdso/Makefile b/kernel/vdso/Makefile
new file mode 100644
index 000000000000..ad0d3b1a475c
--- /dev/null
+++ b/kernel/vdso/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
diff --git a/kernel/vdso/vsyscall.c b/kernel/vdso/vsyscall.c
new file mode 100644
index 000000000000..d1e8074e3d10
--- /dev/null
+++ b/kernel/vdso/vsyscall.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 ARM Ltd.
+ *
+ * Generic implementation of update_vsyscall and update_vsyscall_tz.
+ */
+
+#include <linux/hrtimer.h>
+#include <linux/timekeeper_internal.h>
+#include <vdso/datapage.h>
+#include <vdso/helpers.h>
+#include <vdso/vsyscall.h>
+
+static inline void update_vdso_data(struct vdso_data *vdata,
+				    struct timekeeper *tk)
+{
+	struct vdso_timestamp *vdso_ts;
+	u64 nsec;
+
+	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
+	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
+	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
+	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
+	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
+	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
+	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
+	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
+
+	/* CLOCK_REALTIME */
+	vdso_ts		=  &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
+	vdso_ts->sec	= tk->xtime_sec;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
+
+	/* CLOCK_MONOTONIC */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec += ((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec	= nsec;
+
+	/* CLOCK_MONOTONIC_RAW */
+	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts->sec	= tk->raw_sec;
+	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
+
+	/* CLOCK_BOOTTIME */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec = tk->tkr_mono.xtime_nsec;
+	nsec += ((u64)(tk->wall_to_monotonic.tv_nsec +
+		       ktime_to_ns(tk->offs_boot)) << tk->tkr_mono.shift);
+	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
+		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec	= nsec;
+
+	/* CLOCK_TAI */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
+	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
+
+	/*
+	 * Read without the seqlock held by clock_getres().
+	 * Note: No need to have a second copy.
+	 */
+	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+}
+
+void update_vsyscall(struct timekeeper *tk)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	struct vdso_timestamp *vdso_ts;
+	u64 nsec;
+
+	if (__arch_update_vdso_data()) {
+		/*
+		 * Some architectures might want to skip the update of the
+		 * data page.
+		 */
+		return;
+	}
+
+	/* copy vsyscall data */
+	vdso_write_begin(vdata);
+
+	vdata[CS_HRES_COARSE].clock_mode	= __arch_get_clock_mode(tk);
+	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
+
+	/* CLOCK_REALTIME_COARSE */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
+	vdso_ts->sec	= tk->xtime_sec;
+	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+
+	/* CLOCK_MONOTONIC_COARSE */
+	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
+	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
+	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
+	while (nsec >= NSEC_PER_SEC) {
+		nsec = nsec - NSEC_PER_SEC;
+		vdso_ts->sec++;
+	}
+	vdso_ts->nsec	= nsec;
+
+	if (__arch_use_vsyscall(vdata))
+		update_vdso_data(vdata, tk);
+
+	__arch_update_vsyscall(vdata, tk);
+
+	vdso_write_end(vdata);
+
+	__arch_sync_vdso_data(vdata);
+}
+
+void update_vsyscall_tz(void)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	if (__arch_use_vsyscall(vdata)) {
+		vdata[CS_HRES_COARSE].tz_minuteswest = sys_tz.tz_minuteswest;
+		vdata[CS_HRES_COARSE].tz_dsttime = sys_tz.tz_dsttime;
+	}
+
+	__arch_sync_vdso_data(vdata);
+}
-- 
2.21.0

