Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A851F211D6A
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGBHtV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBHtU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 03:49:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0241AC08C5C1;
        Thu,  2 Jul 2020 00:49:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so2689067pgv.9;
        Thu, 02 Jul 2020 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQD911N1OirjA6dQWnorGvys5+1kn+3MUQKX5XOw8zE=;
        b=G6pnBvOVHdWam68jActENnVnHw3vwiygfcyv1fzpJYKUMAKwJol+9WclROicfZfAj5
         U4hPsVPtNHrwTdu0U7lHNtsQu0EQYvVRBLH8YD/4lyGfy2Fe41+7LZHx7p0Rlz2FGJ5U
         dRhD29upezXn1llhh5uERPtFLxrZO6hi3qY6AhTwaIEP+UpWJ7u2n/NfIfUUkLAOK4Mw
         GFQivb1+EAh1uQdcN0hIdeoH5V7pvyzY9ue4NXkAIEbnojh6Y0aaAD7jkOyyxVfZWfIC
         t9ZgiwpSnfFi7B2mdHeABGM6Z5yLP3N+5tfPJ4XEUSH26lxUgAmAHHeRAWs7GpHEQdYy
         amrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQD911N1OirjA6dQWnorGvys5+1kn+3MUQKX5XOw8zE=;
        b=iTPczjLXKcZzyOr72xCU4PnD7tnq4w+/Es1Wx8654Sex1YNGQNQr+cDYq7h9J0es5R
         X7IqZUDIbwqaqV50ztMKVsOqmtZw7z74jEpBs21aYzMS6BmYNxBD6sbFu0FGcsvgAtQ9
         PY58Qar73nha1HIpjC99BNA1P3xW9QxVyLMaIgmp9F3kjK/xzHksTRi1FdmYKByqbowS
         pPDrKeRKHIwH377YPdqC/9fYlZT13UuSklwOqTkOVmV8wckMoZkjcIwHk0o3UbomTMM4
         YB+0aQljKsM6M8I1pYH4F7LUdIOd1oPkCLG83X+RaUlf4my8ikyaz95Jum9eTX0l35H0
         62eg==
X-Gm-Message-State: AOAM5323zNJKQyXJSuXgbBo+jmi23phCrw5x2qXNR/ui4Vdr74W+hPI/
        aZxsAM+8G1o7zqc31luStHM=
X-Google-Smtp-Source: ABdhPJwk332+lHS3BBrZ6qIQL0gRTtBCD7Sux5ILRg4+f+M5YN36mn7IqydqIQj2tH8ktyacmzXeug==
X-Received: by 2002:a05:6a00:1346:: with SMTP id k6mr11368466pfu.116.1593676159569;
        Thu, 02 Jul 2020 00:49:19 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id 17sm6001953pfv.16.2020.07.02.00.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:49:19 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
Date:   Thu,  2 Jul 2020 17:48:36 +1000
Message-Id: <20200702074839.1057733-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These have shown significantly improved performance and fairness when
spinlock contention is moderate to high on very large systems.

 [ Numbers hopefully forthcoming after more testing, but initial
   results look good ]

Thanks to the fast path, single threaded performance is not noticably
hurt.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                      | 13 +++++++++++++
 arch/powerpc/include/asm/Kbuild           |  2 ++
 arch/powerpc/include/asm/qspinlock.h      | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/spinlock.h       |  5 +++++
 arch/powerpc/include/asm/spinlock_types.h |  5 +++++
 arch/powerpc/lib/Makefile                 |  3 +++
 include/asm-generic/qspinlock.h           |  2 ++
 7 files changed, 50 insertions(+)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..b17575109876 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -145,6 +145,8 @@ config PPC
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
+	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
@@ -490,6 +492,17 @@ config HOTPLUG_CPU
 
 	  Say N if you are unsure.
 
+config PPC_QUEUED_SPINLOCKS
+	bool "Queued spinlocks"
+	depends on SMP
+	default "y" if PPC_BOOK3S_64
+	help
+	  Say Y here to use to use queued spinlocks which are more complex
+	  but give better salability and fairness on large SMP and NUMA
+	  systems.
+
+	  If unsure, say "Y" if you have lots of cores, otherwise "N".
+
 config ARCH_CPU_PROBE_RELEASE
 	def_bool y
 	depends on HOTPLUG_CPU
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index dadbcf3a0b1e..1dd8b6adff5e 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -6,5 +6,7 @@ generated-y += syscall_table_spu.h
 generic-y += export.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
+generic-y += qrwlock.h
+generic-y += qspinlock.h
 generic-y += vtime.h
 generic-y += early_ioremap.h
diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
new file mode 100644
index 000000000000..f84da77b6bb7
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_QSPINLOCK_H
+#define _ASM_POWERPC_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+
+#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
+
+#define smp_mb__after_spinlock()   smp_mb()
+
+static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
+{
+	smp_mb();
+	return atomic_read(&lock->val);
+}
+#define queued_spin_is_locked queued_spin_is_locked
+
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_POWERPC_QSPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 21357fe05fe0..434615f1d761 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -3,7 +3,12 @@
 #define __ASM_SPINLOCK_H
 #ifdef __KERNEL__
 
+#ifdef CONFIG_PPC_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+#else
 #include <asm/simple_spinlock.h>
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/include/asm/spinlock_types.h
index 3906f52dae65..c5d742f18021 100644
--- a/arch/powerpc/include/asm/spinlock_types.h
+++ b/arch/powerpc/include/asm/spinlock_types.h
@@ -6,6 +6,11 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_PPC_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+#else
 #include <asm/simple_spinlock_types.h>
+#endif
 
 #endif
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 5e994cda8e40..d66a645503eb 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -41,7 +41,10 @@ obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
 obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
 	   memcpy_64.o memcpy_mcsafe_64.o
 
+ifndef CONFIG_PPC_QUEUED_SPINLOCKS
 obj64-$(CONFIG_SMP)	+= locks.o
+endif
+
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 obj64-$(CONFIG_KPROBES_SANITY_TEST)	+= test_emulate_step.o \
 					   test_emulate_step_exec_instr.o
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index fde943d180e0..fb0a814d4395 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -12,6 +12,7 @@
 
 #include <asm-generic/qspinlock_types.h>
 
+#ifndef queued_spin_is_locked
 /**
  * queued_spin_is_locked - is the spinlock locked?
  * @lock: Pointer to queued spinlock structure
@@ -25,6 +26,7 @@ static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 	 */
 	return atomic_read(&lock->val);
 }
+#endif
 
 /**
  * queued_spin_value_unlocked - is the spinlock structure unlocked?
-- 
2.23.0

