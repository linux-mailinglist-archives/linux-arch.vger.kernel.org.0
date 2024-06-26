Return-Path: <linux-arch+bounces-5150-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1AE918219
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 15:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA451C23211
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2024 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384D181CE6;
	Wed, 26 Jun 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qQ9btSJa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3518133E
	for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407648; cv=none; b=J6ykcy2KyDZ/dS1dgyhGEpcDM0U8HFLMjGHmrdUITtIUcJFYnHwkq+oOL5v0BL/wHWwuuCAGg0D3FBe+XAN1wnYrnTByNY03OAzzDD8uICcqQOPR2LwotB4w4PxDCYnXNZTz7E/fGmxPqYj7iDG/7BsNZexti+/3NySHTUhOKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407648; c=relaxed/simple;
	bh=WJzmcNKgP91/NW9Lm2Szmfl2fT7kxLzlx0yDm8NC/UM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpUHKJ7/lQRBVjhxa/AN61W0tybaVPO6epfbXOyN1AW60Zdur8GrYbMd7CTN4Gibu6VBHTh2yF7wzkMSNf7JnUsUxRWWLiaqluN+xhAHe+yajfqQQGDD2T6oPa2M58U5FRfw4oXdRhwzleirPoeISxL1TqxwTsQcTp59/d5vgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qQ9btSJa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42561715d41so1646765e9.0
        for <linux-arch@vger.kernel.org>; Wed, 26 Jun 2024 06:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407644; x=1720012444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+w80jGsiG4VGpCQ7hPsjWSfG61Mxqook1j9XdvlA9Tw=;
        b=qQ9btSJaS5kVBsiJFE1QOc/WDo6W4RVwAXEkdfLO48CLYPKZjwuReHGTsXe3Ib0fSi
         HYnbzCzxvtKjj9oeMxPX5rT53aZxdHCwg7pp+hs69NDDzMSNeDHCloeCSIGw6E4KZke7
         9PFUQ8AYyY0cNa37r5mEyQlG3xe+TxNsXAG7MgwlNI2BHwRGdAtwasbNaq9xBKCrA8Lv
         TE7VmHgfoIxRea7xnAOOVY/8W9NZTwiPKJ4eLwRHdjg0bZrN/kctBN4ntbCZFq2lAd5Z
         e2mwKSfhSzqco7JGxzoWf80WiHMkxlyj6R0Kx1uxMTB2MQfPllTfzdeevaDacgZGCiTt
         X6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407644; x=1720012444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+w80jGsiG4VGpCQ7hPsjWSfG61Mxqook1j9XdvlA9Tw=;
        b=cBbf95TmYP5KzhxN8neHWgH0FP3bVG1Cx/qwDB34uSMK3mB2qvK85MAcdWvF4oAwh/
         nGlpydZmkzNLOMvBaCk7XpSbEEECH8y1mMfMt192lEQCKkihcnowI3m+m4XANjDIWDAk
         8xvi4DIZG/2hwhjF79OipFeCbmlixpNL0KmqeAUa5GzqmjfsjcRMvjpCbfwwWY3bdF/+
         k3jFJyVwtxH+xOX/GjJuPkMZZv8SIis+Oi266jdRzU8Ro9rZZE//BoARwolHAxk6r0ii
         SDlCSwI7wzADgzvpuDiQR0aDnByLeG4x6i9JOZ43VptKp8lzWgp/hvC3N/y+Vk5fGBr/
         eAjw==
X-Forwarded-Encrypted: i=1; AJvYcCW+fm1kYq/fK/QN5Fzd0obcYpLMNZDkwvCnXdWd1Hv5jWxdnmchf3VWe82+rEywzHyMNB6vU5wpatQptOxQm8RJQklKYBXYA5xVZA==
X-Gm-Message-State: AOJu0YwFkPJN6fhemVeJ37VTCf1MqcTxvbIAtIxp7+NQ5GM2yr2AH/13
	cHfKsSIARoEsaYaOP7hqX7MLUbABt4kQd1TeH9sIDOmEJ4Ys3NwNspdikQyMqiI=
X-Google-Smtp-Source: AGHT+IFllg3IYaHR+yNuwabvI2Esa87l1QM3SHNcpI6URxgMur8IwZXQjkTo3wIWV+d+Qukem0mG5Q==
X-Received: by 2002:a05:600c:1d29:b0:424:86aa:b7e7 with SMTP id 5b1f17b1804b1-424893f767amr108722745e9.9.1719407643561;
        Wed, 26 Jun 2024 06:14:03 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c825d8a4sm25617795e9.19.2024.06.26.06.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:14:03 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 10/10] riscv: Add qspinlock support based on Zabha extension
Date: Wed, 26 Jun 2024 15:03:47 +0200
Message-Id: <20240626130347.520750-11-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to produce a generic kernel, a user can select
CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
spinlock implementation if Zabha is not present.

Note that we can't use alternatives here because the discovery of
extensions is done too late and we need to start with the qspinlock
implementation because the ticket spinlock implementation would pollute
the spinlock value, so let's use static keys.

This is largely based on Guo's work and Leonardo reviews at [1].

Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 .../locking/queued-spinlocks/arch-support.txt |  2 +-
 arch/riscv/Kconfig                            | 10 +++++
 arch/riscv/include/asm/Kbuild                 |  4 +-
 arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
 arch/riscv/kernel/setup.c                     | 21 ++++++++++
 include/asm-generic/qspinlock.h               |  2 +
 include/asm-generic/ticket_spinlock.h         |  2 +
 7 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/asm/spinlock.h

diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 22f2990392ff..cf26042480e2 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -20,7 +20,7 @@
     |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0bbaec0444d0..c2ba673e58ca 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -72,6 +72,7 @@ config RISCV
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
 	select CLINT_TIMER if RISCV_M_MODE
@@ -482,6 +483,15 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config RISCV_COMBO_SPINLOCKS
+	bool "Using combo spinlock"
+	depends on SMP && MMU && TOOLCHAIN_HAS_ZABHA
+	select ARCH_USE_QUEUED_SPINLOCKS
+	default y
+	help
+	  Embed both queued spinlock and ticket lock so that the spinlock
+	  implementation can be chosen at runtime.
+
 config RISCV_ALTERNATIVE
 	bool
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 504f8b7e72d4..ad72f2bd4cc9 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,10 +2,12 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
-generic-y += spinlock.h
 generic-y += spinlock_types.h
+generic-y += ticket_spinlock.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
+generic-y += qspinlock.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
new file mode 100644
index 000000000000..4856d50006f2
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_RISCV_SPINLOCK_H
+#define __ASM_RISCV_SPINLOCK_H
+
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+#define _Q_PENDING_LOOPS	(1 << 9)
+
+#define __no_arch_spinlock_redefine
+#include <asm/ticket_spinlock.h>
+#include <asm/qspinlock.h>
+#include <asm/alternative.h>
+
+DECLARE_STATIC_KEY_TRUE(qspinlock_key);
+
+#define SPINLOCK_BASE_DECLARE(op, type, type_lock)			\
+static __always_inline type arch_spin_##op(type_lock lock)		\
+{									\
+	if (static_branch_unlikely(&qspinlock_key))			\
+		return queued_spin_##op(lock);				\
+	return ticket_spin_##op(lock);					\
+}
+
+SPINLOCK_BASE_DECLARE(lock, void, arch_spinlock_t *)
+SPINLOCK_BASE_DECLARE(unlock, void, arch_spinlock_t *)
+SPINLOCK_BASE_DECLARE(is_locked, int, arch_spinlock_t *)
+SPINLOCK_BASE_DECLARE(is_contended, int, arch_spinlock_t *)
+SPINLOCK_BASE_DECLARE(trylock, bool, arch_spinlock_t *)
+SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
+
+#else
+
+#include <asm/ticket_spinlock.h>
+
+#endif
+
+#include <asm/qrwlock.h>
+
+#endif /* __ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4f73c0ae44b2..929bccd4c9e5 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -244,6 +244,26 @@ static void __init parse_dtb(void)
 #endif
 }
 
+DEFINE_STATIC_KEY_TRUE(qspinlock_key);
+EXPORT_SYMBOL(qspinlock_key);
+
+static void __init riscv_spinlock_init(void)
+{
+	asm goto(ALTERNATIVE("j %[no_zacas]", "nop", 0, RISCV_ISA_EXT_ZACAS, 1)
+		 : : : : no_zacas);
+	asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
+		 : : : : qspinlock);
+
+no_zacas:
+	static_branch_disable(&qspinlock_key);
+	pr_info("Ticket spinlock: enabled\n");
+
+	return;
+
+qspinlock:
+	pr_info("Queued spinlock: enabled\n");
+}
+
 extern void __init init_rt_signal_env(void);
 
 void __init setup_arch(char **cmdline_p)
@@ -295,6 +315,7 @@ void __init setup_arch(char **cmdline_p)
 	riscv_set_dma_cache_alignment();
 
 	riscv_user_isa_enable();
+	riscv_spinlock_init();
 }
 
 bool arch_cpu_is_hotpluggable(int cpu)
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 0655aa5b57b2..bf47cca2c375 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
 }
 #endif
 
+#ifndef __no_arch_spinlock_redefine
 /*
  * Remapping spinlock architecture specific functions to the corresponding
  * queued spinlock functions.
@@ -146,5 +147,6 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
 #define arch_spin_lock(l)		queued_spin_lock(l)
 #define arch_spin_trylock(l)		queued_spin_trylock(l)
 #define arch_spin_unlock(l)		queued_spin_unlock(l)
+#endif
 
 #endif /* __ASM_GENERIC_QSPINLOCK_H */
diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
index cfcff22b37b3..325779970d8a 100644
--- a/include/asm-generic/ticket_spinlock.h
+++ b/include/asm-generic/ticket_spinlock.h
@@ -89,6 +89,7 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
 	return (s16)((val >> 16) - (val & 0xffff)) > 1;
 }
 
+#ifndef __no_arch_spinlock_redefine
 /*
  * Remapping spinlock architecture specific functions to the corresponding
  * ticket spinlock functions.
@@ -99,5 +100,6 @@ static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
 #define arch_spin_lock(l)		ticket_spin_lock(l)
 #define arch_spin_trylock(l)		ticket_spin_trylock(l)
 #define arch_spin_unlock(l)		ticket_spin_unlock(l)
+#endif
 
 #endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */
-- 
2.39.2


