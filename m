Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03392151BF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgGFEgR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 00:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbgGFEgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2020 00:36:17 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3BC061794;
        Sun,  5 Jul 2020 21:36:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so40442295wml.3;
        Sun, 05 Jul 2020 21:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAjwhVmi7cXYyrcgTshEaU64UV7iDeQvtF4CQCRQOIA=;
        b=j6IY8Rk0l2kZ9V6bPbYFE3dgy3cWKRAhnZrdpapSkjFtfaFF/VDIiJx7WvLsLe/7Om
         czeGXECzjvvgKJbsZoY5WrhdNqtzgXQQI28eTXH7l0xO7ftSxDlC3cAwh1Znut9trpJC
         NH5yUM2AuSIKZGzkX+afPwlfmqWsnZO2mdPkm0DfAX+jr/J2jJjH3hTsrWiWK2XyjNMd
         Oluf8PeK1KKHz824rICvAyFAiMHuo3QD2OEOb4Kss28zzXO4qBis7qVL2shRtd/CW4d5
         jNirXSd5UYzXya8k0VAuDRJy/9aRxDN2/ro09JIOUMIpnmehbyDMTfruTdKf6qwG1mkb
         tqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAjwhVmi7cXYyrcgTshEaU64UV7iDeQvtF4CQCRQOIA=;
        b=a7jGZAtGzLqTElP+nUCLJ9SdD454nw/8ytVU7Q4XHtvDxTtpE6hNZDcG28PvQVEUSQ
         4xBYsgchsZJx9ad7NjnESdxSHjeGjaK4O0hh0EYC73+LgqJfaomN42BEWCCHs+LQEZml
         +M/FR4cJzQqRPPCRnpN5Xhv9CJe7vFnMmpgbyyMx6gYH0lHJGWskwMy5K94jMH5m1P5f
         Gl1vAhoTnmHKQmjUfL9OAErJOkNCp0AOsjM4ZKlpYCwP+DYrz6BFFPkordbyXA3fIAJI
         SgWHoVnRTUJhFflrNvJOTp2mdmYMEVhBwtw1SzzMKI9TaoBekFhOUsoeBLinkHHG4Teu
         XQPQ==
X-Gm-Message-State: AOAM5316zsk4WlPn3QJNJl9q2aw9YNOJK9Ffz40omQPr80yyd8EKKyhW
        oxXMTfVdCDHwPuQsQiJo5aUiJlNM
X-Google-Smtp-Source: ABdhPJwTeiPPSnkuCSlat5ePJOON53Vw2+uUpuZbetlhX9t8vi5LhOvMd7QHi9jBk9bAcLb69aeXuA==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr49005749wme.102.1594010175902;
        Sun, 05 Jul 2020 21:36:15 -0700 (PDT)
Received: from bobo.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id r10sm22202309wrm.17.2020.07.05.21.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 21:36:15 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 4/6] powerpc/64s: implement queued spinlocks and rwlocks
Date:   Mon,  6 Jul 2020 14:35:38 +1000
Message-Id: <20200706043540.1563616-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200706043540.1563616-1-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/powerpc/Kconfig                      | 13 ++++++++++++
 arch/powerpc/include/asm/Kbuild           |  2 ++
 arch/powerpc/include/asm/qspinlock.h      | 25 +++++++++++++++++++++++
 arch/powerpc/include/asm/spinlock.h       |  5 +++++
 arch/powerpc/include/asm/spinlock_types.h |  5 +++++
 arch/powerpc/lib/Makefile                 |  3 +++
 include/asm-generic/qspinlock.h           |  2 ++
 7 files changed, 55 insertions(+)
 create mode 100644 arch/powerpc/include/asm/qspinlock.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 24ac85c868db..17663ea57697 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -146,6 +146,8 @@ config PPC
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
+	select ARCH_USE_QUEUED_RWLOCKS		if PPC_QUEUED_SPINLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS	if PPC_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WEAK_RELEASE_ACQUIRE
 	select BINFMT_ELF
@@ -492,6 +494,17 @@ config HOTPLUG_CPU
 
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
index 000000000000..c49e33e24edd
--- /dev/null
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -0,0 +1,25 @@
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
+	/*
+	 * This barrier was added to simple spinlocks by commit 51d7d5205d338,
+	 * but it should now be possible to remove it, asm arm64 has done with
+	 * commit c6f5d02b6a0f.
+	 */
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

