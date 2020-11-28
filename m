Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F052C7293
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbgK1VuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729592AbgK1S16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:27:58 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BBC0258F1;
        Sat, 28 Nov 2020 08:02:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so7095573pfd.5;
        Sat, 28 Nov 2020 08:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqskVFo4rCcY4G7AX3q/Z2vOLhCcdMU13oOzjm6oOQI=;
        b=hAkQC7bxM/rt+UgL+n2DK2GVPrv7Fvv8VOFfmVyChH9mG2M8V1dhWuexs7FMt4k/VH
         00X2IJnPJZxukN07v+6IUoaQEfrLRCAqYOOlZ5fq8l1BvW7IrGtlw1huOZSLzz2y0SZx
         3ChCeIKf/3CDuf5o8vxiVXRbP+dl0i3USN+GGPFeVf1n0aup+2heHkiGuTtTAlOIHxup
         yVXQkUUka7ppthU1cQ04gq4WktB3u20vnaqT8BvQDxOruSqzz3f4f2+uoHUVHCc17E5Q
         QRBdGNwQLOrc1P3jbriPiXC3R/Y7g87L4RcqcZA6HPgDlB6tEXZDAiIKBbkorJcDGkrE
         lHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqskVFo4rCcY4G7AX3q/Z2vOLhCcdMU13oOzjm6oOQI=;
        b=Xh8eG8cCm0GD3YosyqgkZOkQW0n7cXe/feI3DqhyA1gkJuNSNlJ3koyKsuiB28O2KR
         EtwkY6UF4BjhHpqAopqRw0tIjgsCm2Mph4RJh8buMr6J6wtCF/khAlYDl0UlNLj9Ez6w
         dOxp3uKaN+rPaxyHi/G0JaseArVwS5qNhdHcbFVLxIdmiS22dYSZSjkT0Ravmwhb0DiN
         59cvrvwAry0eRuJgYkXiqF+wCoVRIiKjcIBnmtsl6re8+cFxEXd/rUfeDb4eiVrm53zP
         8MmsVcFjFLuMNYGQHaWlsdXdn6yvaqkKCFDS9BRWVBXVOMB8QHz7tV08Csohv/bpn86C
         BQ/w==
X-Gm-Message-State: AOAM533YXSTWFCiA1jPKOt1qNwIn545R62/sAF4KEhdOL6kw2bkikvcq
        zdooPW6EMf+gZtV+siOUPJNxU1CE0Ng=
X-Google-Smtp-Source: ABdhPJzGaihamaR9rIxqQPEuAuhYCkZ5jY/oI8W/R+Ypcsv9gPzHWmICwyEssj9w/cCRebDK8ONgCg==
X-Received: by 2002:a17:90a:f0d4:: with SMTP id fa20mr13620976pjb.129.1606579324386;
        Sat, 28 Nov 2020 08:02:04 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:02:04 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 3/8] x86: remove ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
Date:   Sun, 29 Nov 2020 02:01:36 +1000
Message-Id: <20201128160141.1003903-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Switch remaining x86-specific users to asm/sync_core.h, remove the
linux/sync_core.h header and ARCH_ option.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/x86/Kconfig                    |  1 -
 arch/x86/kernel/alternative.c       |  2 +-
 arch/x86/kernel/cpu/mce/core.c      |  2 +-
 drivers/misc/sgi-gru/grufault.c     |  2 +-
 drivers/misc/sgi-gru/gruhandles.c   |  2 +-
 drivers/misc/sgi-gru/grukservices.c |  2 +-
 include/linux/sync_core.h           | 21 ---------------------
 init/Kconfig                        |  3 ---
 8 files changed, 5 insertions(+), 30 deletions(-)
 delete mode 100644 include/linux/sync_core.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..160d3ad90507 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -80,7 +80,6 @@ config X86
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
-	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_DEBUG_WX
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2400ad62f330..9a7ab08f4157 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -17,7 +17,7 @@
 #include <linux/kprobes.h>
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
-#include <linux/sync_core.h>
+#include <asm/sync_core.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..282ea9942829 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -41,12 +41,12 @@
 #include <linux/irq_work.h>
 #include <linux/export.h>
 #include <linux/set_memory.h>
-#include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
+#include <asm/sync_core.h>
 #include <asm/traps.h>
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 723825524ea0..48fd5b101de1 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -20,8 +20,8 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
-#include <linux/sync_core.h>
 #include <linux/prefetch.h>
+#include <asm/sync_core.h>
 #include "gru.h"
 #include "grutables.h"
 #include "grulib.h"
diff --git a/drivers/misc/sgi-gru/gruhandles.c b/drivers/misc/sgi-gru/gruhandles.c
index 1d75d5e540bc..c8cba1c1b00f 100644
--- a/drivers/misc/sgi-gru/gruhandles.c
+++ b/drivers/misc/sgi-gru/gruhandles.c
@@ -16,7 +16,7 @@
 #define GRU_OPERATION_TIMEOUT	(((cycles_t) local_cpu_data->itc_freq)*10)
 #define CLKS2NSEC(c)		((c) *1000000000 / local_cpu_data->itc_freq)
 #else
-#include <linux/sync_core.h>
+#include <asm/sync_core.h>
 #include <asm/tsc.h>
 #define GRU_OPERATION_TIMEOUT	((cycles_t) tsc_khz*10*1000)
 #define CLKS2NSEC(c)		((c) * 1000000 / tsc_khz)
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 0ea923fe6371..860aea9deb45 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -16,11 +16,11 @@
 #include <linux/miscdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
-#include <linux/sync_core.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <asm/io_apic.h>
+#include <asm/sync_core.h>
 #include "gru.h"
 #include "grulib.h"
 #include "grutables.h"
diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
deleted file mode 100644
index 013da4b8b327..000000000000
--- a/include/linux/sync_core.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_SYNC_CORE_H
-#define _LINUX_SYNC_CORE_H
-
-#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
-#include <asm/sync_core.h>
-#else
-/*
- * This is a dummy sync_core_before_usermode() implementation that can be used
- * on all architectures which return to user-space through core serializing
- * instructions.
- * If your architecture returns to user-space through non-core-serializing
- * instructions, you need to write your own functions.
- */
-static inline void sync_core_before_usermode(void)
-{
-}
-#endif
-
-#endif /* _LINUX_SYNC_CORE_H */
-
diff --git a/init/Kconfig b/init/Kconfig
index 02d13ae27abb..82f9b5c937cb 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2334,9 +2334,6 @@ source "kernel/Kconfig.locks"
 config ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	bool
 
-config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
-	bool
-
 # It may be useful for an architecture to override the definitions of the
 # SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>
 # and the COMPAT_ variants in <linux/compat.h>, in particular to use a
-- 
2.23.0

