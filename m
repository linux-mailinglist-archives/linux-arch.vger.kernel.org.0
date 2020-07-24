Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E5B22C60F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 15:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGXNOp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgGXNOm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 09:14:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A56C0619D3;
        Fri, 24 Jul 2020 06:14:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so4416185plk.1;
        Fri, 24 Jul 2020 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kVR8dpc50ysMIxQqSwuiTqzeI4YP5E2Ddp3+XJfYGg=;
        b=sqxzgb7opVJpqkTP//ZlqsIRD4fKl8hWlOQ1iA3Df02waiSmGM1mmDdm+e8ka1/1mP
         kiWZvwxr98CH6Xr2XdEm7k7js/gVG3Vh4GK3sNC8KQbYQw04wHKaMo4OLwyLZiWOOYaE
         OBrUj4w6MrhBKScRRjr2ldae6JdXochR+jrX+sZVjSyrWj/55KpbagaXgig3t20v7JfP
         jCfA1yGhSsRgL4OMmSn9ze8Lbs6mD6D3431BOObaRSjfHEJWwUww7AmKlvaQBxqIcdCl
         t5C8eKYwa6ZP9jZMNXUzNAuJjWg0TF/fWmiX7cJYXiRGMp3FgXDkFQH4wR7ASXSBOEi/
         t5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kVR8dpc50ysMIxQqSwuiTqzeI4YP5E2Ddp3+XJfYGg=;
        b=aWjosuRbRY64KSpR17DT5qkjDKefr4N6fIphJ/Sau8jxMtamn70F7GWaX67xIFDmwn
         fSC6BUaj7Q5V6+Yymm+8iTAenQc0lfPeiVVpzh7rdhEamjyJdDx0NlbQ4CfcVFIpqXSn
         yT6LUN5phw/i2pwMIHVXFeimPN3+t5kPbYCWkRm5flbYWsgRov12qJr+vxEGoD40DqXN
         iC15yt2xBJ5I3wVWapP8XUtukJ/qxq21DueqXxUIcWFrYE5DaDmg13+POSgnSwWrV+xn
         1G43uCjH6HONgHXhAhP0agHKqMyD2mnBAJNQqh0RGibuQ9jBnn3RP8twcISfNmonBwm7
         VLtw==
X-Gm-Message-State: AOAM530gTaGj1+aAN41xbZ5ShUwM3u1I7ROxeivzRkFHEUjh59F5QxmV
        V31RVRsddcAtDK61H6wt/70=
X-Google-Smtp-Source: ABdhPJwZT1wR4LaafRQIYtvkhAEiiC1v3dDk5trVpmTzdqzVW4G7zNyw5wB5pFFpSG/t6k8+IXpsPw==
X-Received: by 2002:a17:902:a9c1:: with SMTP id b1mr8349193plr.234.1595596482001;
        Fri, 24 Jul 2020 06:14:42 -0700 (PDT)
Received: from bobo.ibm.com (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id az16sm5871998pjb.7.2020.07.24.06.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 06:14:41 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v4 1/6] powerpc/pseries: move some PAPR paravirt functions to their own file
Date:   Fri, 24 Jul 2020 23:14:18 +1000
Message-Id: <20200724131423.1362108-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200724131423.1362108-1-npiggin@gmail.com>
References: <20200724131423.1362108-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These functions will be used by queued spinlock implementation,
and may be useful elsewhere too, so move them out of spinlock.h.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/paravirt.h | 59 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/spinlock.h | 24 +-----------
 arch/powerpc/lib/locks.c            | 12 +++---
 3 files changed, 66 insertions(+), 29 deletions(-)
 create mode 100644 arch/powerpc/include/asm/paravirt.h

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
new file mode 100644
index 000000000000..339e8533464b
--- /dev/null
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _ASM_POWERPC_PARAVIRT_H
+#define _ASM_POWERPC_PARAVIRT_H
+
+#include <linux/jump_label.h>
+#include <asm/smp.h>
+#ifdef CONFIG_PPC64
+#include <asm/paca.h>
+#include <asm/hvcall.h>
+#endif
+
+#ifdef CONFIG_PPC_SPLPAR
+DECLARE_STATIC_KEY_FALSE(shared_processor);
+
+static inline bool is_shared_processor(void)
+{
+	return static_branch_unlikely(&shared_processor);
+}
+
+/* If bit 0 is set, the cpu has been preempted */
+static inline u32 yield_count_of(int cpu)
+{
+	__be32 yield_count = READ_ONCE(lppaca_of(cpu).yield_count);
+	return be32_to_cpu(yield_count);
+}
+
+static inline void yield_to_preempted(int cpu, u32 yield_count)
+{
+	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(cpu), yield_count);
+}
+#else
+static inline bool is_shared_processor(void)
+{
+	return false;
+}
+
+static inline u32 yield_count_of(int cpu)
+{
+	return 0;
+}
+
+extern void ___bad_yield_to_preempted(void);
+static inline void yield_to_preempted(int cpu, u32 yield_count)
+{
+	___bad_yield_to_preempted(); /* This would be a bug */
+}
+#endif
+
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	if (!is_shared_processor())
+		return false;
+	if (yield_count_of(cpu) & 1)
+		return true;
+	return false;
+}
+
+#endif /* _ASM_POWERPC_PARAVIRT_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 2d620896cdae..79be9bb10bbb 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -15,11 +15,10 @@
  *
  * (the type definitions are in asm/spinlock_types.h)
  */
-#include <linux/jump_label.h>
 #include <linux/irqflags.h>
+#include <asm/paravirt.h>
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
-#include <asm/hvcall.h>
 #endif
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
@@ -35,18 +34,6 @@
 #define LOCK_TOKEN	1
 #endif
 
-#ifdef CONFIG_PPC_PSERIES
-DECLARE_STATIC_KEY_FALSE(shared_processor);
-
-#define vcpu_is_preempted vcpu_is_preempted
-static inline bool vcpu_is_preempted(int cpu)
-{
-	if (!static_branch_unlikely(&shared_processor))
-		return false;
-	return !!(be32_to_cpu(lppaca_of(cpu).yield_count) & 1);
-}
-#endif
-
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
@@ -110,15 +97,6 @@ static inline void splpar_spin_yield(arch_spinlock_t *lock) {};
 static inline void splpar_rw_yield(arch_rwlock_t *lock) {};
 #endif
 
-static inline bool is_shared_processor(void)
-{
-#ifdef CONFIG_PPC_SPLPAR
-	return static_branch_unlikely(&shared_processor);
-#else
-	return false;
-#endif
-}
-
 static inline void spin_yield(arch_spinlock_t *lock)
 {
 	if (is_shared_processor())
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 6440d5943c00..04165b7a163f 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -27,14 +27,14 @@ void splpar_spin_yield(arch_spinlock_t *lock)
 		return;
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
-	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+
+	yield_count = yield_count_of(holder_cpu);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
 	if (lock->slock != lock_value)
 		return;		/* something has changed */
-	plpar_hcall_norets(H_CONFER,
-		get_hard_smp_processor_id(holder_cpu), yield_count);
+	yield_to_preempted(holder_cpu, yield_count);
 }
 EXPORT_SYMBOL_GPL(splpar_spin_yield);
 
@@ -53,13 +53,13 @@ void splpar_rw_yield(arch_rwlock_t *rw)
 		return;		/* no write lock at present */
 	holder_cpu = lock_value & 0xffff;
 	BUG_ON(holder_cpu >= NR_CPUS);
-	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+
+	yield_count = yield_count_of(holder_cpu);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
 	rmb();
 	if (rw->lock != lock_value)
 		return;		/* something has changed */
-	plpar_hcall_norets(H_CONFER,
-		get_hard_smp_processor_id(holder_cpu), yield_count);
+	yield_to_preempted(holder_cpu, yield_count);
 }
 #endif
-- 
2.23.0

