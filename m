Return-Path: <linux-arch+bounces-8808-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED349BA648
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 16:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448E31F217E5
	for <lists+linux-arch@lfdr.de>; Sun,  3 Nov 2024 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E61865E7;
	Sun,  3 Nov 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LSvZRAni"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0471C2FB
	for <linux-arch@vger.kernel.org>; Sun,  3 Nov 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646318; cv=none; b=SPrdoE7xqTN//EyWqoKRyPZFF46hHtSVFcCSKjzU5xIuK6W117YhldRPgsSyGgZb3OMxVLfboeT/8eCN/sDG2eV6T4mYLCvUfuhMjNGrBVqvZ0GfDOoNVviAoRVPdifQBYPFujaXEO2Y6dwp4EFVDp4jbFx3ZnedkmsTlrvXLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646318; c=relaxed/simple;
	bh=5uZKIfy4UVr5gXxfmoEq12WZA8O8TUbAyVEPjJGGnOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rJadOGO26TTF8LMZxCFrxNnRxvir6Y0dJgeFE2fxM1+tG/ee5bKJ3yKSGlovcB6H6Z4FD+tLbX+HOn78jhAW55+9FWl6lBATWRU+/TM6RXj7NO4hHq04NDzhWqFnlyEuktVWX1OhbPlj7lWQ8upleTLvh+DKAw2bzx8ax+5A+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LSvZRAni; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso27749225e9.0
        for <linux-arch@vger.kernel.org>; Sun, 03 Nov 2024 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730646313; x=1731251113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aY9phw0h9f3xNjCboMfKLftvRP8BQ6/29lVmcfPzaI=;
        b=LSvZRAnimy5AsgqwT1+zLdQl/yj4bkLr361Lvj6oSCqG8JRjADXgj2IurXaCjjpl/I
         vtodkR5q9/ZyyMWTbepicr4x3WJ7vognpL7LCr8NAmAMfDDhXNdvU+cJk99MeG8/ngkf
         N6QDo2ohlMgnlEb/O3j8Ms15KcqFtU/sPCxsUElhWlmvDue9Xhf7Qmn21akV0spzcKMw
         aMJf7ZG5huvqo22ZdSLZkMZNU8Kb3kOgrUO5f52N1p/DhjbdDnsM1VwP7QxiwBCozsYB
         YntZ3KABpwki4yxV2q3MeT9bwfadFPc7s/pGp6ZVHPXWhv+IDKLLbEVTLMl/rOjEY7U7
         jcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730646313; x=1731251113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aY9phw0h9f3xNjCboMfKLftvRP8BQ6/29lVmcfPzaI=;
        b=PHbZ4tZDrcb9Y1/Q/2UavWbHfWf+8BItVqh3CFeUwrm85rUkveDg0jIkuc5z1tBYqG
         PJ6YKz4eqmmWLt0la7JgwjJf7XeMTQvziGaoVaJHTWURo7l3ydsSGjIXREyeVb0S2DvN
         cfQ6RlLJ9syMT3jyX23CDaBv9226GhM+jGCuiMqeWPCvS27cOhC/nuG8PxUIHmByOoYz
         LSiVv/tmGeRuW+X2Tb6dP42V9Odn/r5DAZmVa6NzS/pSCc9isluSku00jI/fuf/FuITT
         QOFLb/IM3vuuK81efmsImFZyFHm1VMObTBjXAOxaZvgB3CJxXZoQqs0pPUlg9PWDYL5C
         dQdw==
X-Forwarded-Encrypted: i=1; AJvYcCUDBs8+ROp1zSggrM5dM9PdSO65eQnT18CU4jPCS/QMtArwuROXDB1JMe7WLA1y4qLkVn7OWY5NRKyI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6prPuLm8njaJduSUMJCQ7y6XzcJn2C4AFta7RSMKzmOfee98L
	rGxy+0xUwdlBVG7cZgtIbRlXDBgPxXeZEENwWYdsNDuw5QpMTUaCUej9KQfkpJ4=
X-Google-Smtp-Source: AGHT+IHPZiSZzcaPz06TDTdXTUesvEzSWH1SxGmB9LrKBfkdnmynnmf9paGsFdY/fWwSFbEmyLWwew==
X-Received: by 2002:a05:600c:45cd:b0:431:5eeb:2214 with SMTP id 5b1f17b1804b1-4319ad363eamr237927625e9.33.1730646313170;
        Sun, 03 Nov 2024 07:05:13 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e89csm10899063f8f.74.2024.11.03.07.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:05:12 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v6 13/13] riscv: Add qspinlock support
Date: Sun,  3 Nov 2024 15:51:53 +0100
Message-Id: <20241103145153.105097-14-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to produce a generic kernel, a user can select
CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
spinlock implementation if Zabha or Ziccrse are not present.

Note that we can't use alternatives here because the discovery of
extensions is done too late and we need to start with the qspinlock
implementation because the ticket spinlock implementation would pollute
the spinlock value, so let's use static keys.

This is largely based on Guo's work and Leonardo reviews at [1].

Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren@kernel.org/ [1]
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 .../locking/queued-spinlocks/arch-support.txt |  2 +-
 arch/riscv/Kconfig                            | 34 ++++++++++++++
 arch/riscv/include/asm/Kbuild                 |  4 +-
 arch/riscv/include/asm/spinlock.h             | 47 +++++++++++++++++++
 arch/riscv/kernel/setup.c                     | 37 +++++++++++++++
 include/asm-generic/qspinlock.h               |  2 +
 include/asm-generic/ticket_spinlock.h         |  2 +
 7 files changed, 126 insertions(+), 2 deletions(-)
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
index 093ee6537331..f5698ecc5ccc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -82,6 +82,7 @@ config RISCV
 	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
+	select ARCH_WEAK_RELEASE_ACQUIRE if ARCH_USE_QUEUED_SPINLOCKS
 	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
 	select BUILDTIME_TABLE_SORT if MMU
 	select CLINT_TIMER if RISCV_M_MODE
@@ -507,6 +508,39 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+choice
+	prompt "RISC-V spinlock type"
+	default RISCV_COMBO_SPINLOCKS
+
+config RISCV_TICKET_SPINLOCKS
+	bool "Using ticket spinlock"
+
+config RISCV_QUEUED_SPINLOCKS
+	bool "Using queued spinlock"
+	depends on SMP && MMU && NONPORTABLE
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  The queued spinlock implementation requires the forward progress
+	  guarantee of cmpxchg()/xchg() atomic operations: CAS with Zabha or
+	  LR/SC with Ziccrse provide such guarantee.
+
+	  Select this if and only if Zabha or Ziccrse is available on your
+	  platform, RISCV_QUEUED_SPINLOCKS must not be selected for platforms
+	  without one of those extensions.
+
+	  If unsure, select RISCV_COMBO_SPINLOCKS, which will use qspinlocks
+	  when supported and otherwise ticket spinlocks.
+
+config RISCV_COMBO_SPINLOCKS
+	bool "Using combo spinlock"
+	depends on SMP && MMU
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  Embed both queued spinlock and ticket lock so that the spinlock
+	  implementation can be chosen at runtime.
+
+endchoice
+
 config RISCV_ALTERNATIVE
 	bool
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 1461af12da6e..de13d5a234f8 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -6,10 +6,12 @@ generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
 generic-y += mmzone.h
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
index 000000000000..e5121b89acea
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,47 @@
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
+#include <asm/jump_label.h>
+
+/*
+ * TODO: Use an alternative instead of a static key when we are able to parse
+ * the extensions string earlier in the boot process.
+ */
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
+#elif defined(CONFIG_RISCV_QUEUED_SPINLOCKS)
+
+#include <asm/qspinlock.h>
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
index a2cde65b69e9..438e4f6ad2ad 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -244,6 +244,42 @@ static void __init parse_dtb(void)
 #endif
 }
 
+#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
+DEFINE_STATIC_KEY_TRUE(qspinlock_key);
+EXPORT_SYMBOL(qspinlock_key);
+#endif
+
+static void __init riscv_spinlock_init(void)
+{
+	char *using_ext = NULL;
+
+	if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
+		pr_info("Ticket spinlock: enabled\n");
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
+	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
+	    riscv_isa_extension_available(NULL, ZABHA) &&
+	    riscv_isa_extension_available(NULL, ZACAS)) {
+		using_ext = "using Zabha";
+	} else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
+		using_ext = "using Ziccrse";
+	}
+#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
+	else {
+		static_branch_disable(&qspinlock_key);
+		pr_info("Ticket spinlock: enabled\n");
+		return;
+	}
+#endif
+
+	if (!using_ext)
+		pr_err("Queued spinlock without Zabha or Ziccrse");
+	else
+		pr_info("Queued spinlock %s: enabled\n", using_ext);
+}
+
 extern void __init init_rt_signal_env(void);
 
 void __init setup_arch(char **cmdline_p)
@@ -297,6 +333,7 @@ void __init setup_arch(char **cmdline_p)
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


