Return-Path: <linux-arch+bounces-4562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E18D202D
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8031285BAB
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC9171081;
	Tue, 28 May 2024 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OGEX1ywC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA0171085
	for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909486; cv=none; b=M3NyAwavv5jM26XQdAnHjq2d+lgJk8mppGWzQrL9qPJN1Qe3JrNTMsHB8lD3yw6B0GW73IrGXhKL7KBFyAF2aJU3olOF7VFTpCUTYPfQjOt8M8GxyLCv5h+fOqibpuFkkIwX3XBpSOFWye3Q3TKWOfAjrjOWlb7mJm9GwnmlhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909486; c=relaxed/simple;
	bh=b/9Sq8q/PIexMlnwPbVCGIDCKB12/I67c0iNJhhRCS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pk3cEPm3Ue5PkzCQeLpiUzZmg3WQcjoW7qJ3+kZtllzOg6EbWOH1ztwQy9UfTeWq8Fqf9FJ+ScKGKt0aByhH0/vxWQoRuAJ4Kgi6BvPLMuWrJl5U3BollaSJ/D3rJOqBuXALQtj5+JLn+HadBN8DPadQGNKpT+aXcYG0Y4OGMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OGEX1ywC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-356c4e926a3so754699f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716909483; x=1717514283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wd7aXtixWAZ5JpuaJhpJ6SfusvaeWHbfBXwMoreMRYM=;
        b=OGEX1ywCRPn1PD3jpuGhq41pejL88gdHiFt6Bme1MFyJrijMMbzrxg1puzXMEfzmnm
         XwvMbLp4gdxzyEOv0ivmNNECcQ/2TGph0DddcXmmvABOJec/Sihb2/s3mjMO1tn8TImH
         qOIZBn2WGpUE2MKqHW22nYZZ0+uujwpEK8GyTUz+wYaFvmE+nLr3RkCZvSxAiPeZl9v3
         mX87SpFyv7cdOaar89a8DQgPDph1XARFhVGEpgdXyKpfoPGq4PK6BYX7jfuIXSmgBvp/
         hKhvFGcLAHMt82txTsEdhbmELK98fSp1udo1Wd4X78aOTBKNPDkl0+28VUsNf/pY5SN5
         fJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716909483; x=1717514283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wd7aXtixWAZ5JpuaJhpJ6SfusvaeWHbfBXwMoreMRYM=;
        b=ft3kTgeln+o44Ylkz/qgl+i838HnrjgYCaxfx6EReQcM2YvZ81HKpid4imgEJXtW4Z
         aZIdnOA+3T2FB+i9nSZ5D2Uzaq8c/E4BbBNxHyBI3XmqaqJ7ITywrpl8yl6K+Ba/pe2o
         mwpRoF7muHqm0CLXS1IzCq4Dz6Sfpy+KMLMEOipREZKFQh1Vy5m4UALZTx/3B7V+Ygyg
         jpsa0Xe/KGhsCmcy5b/S7r7iR+Qp5YfQ6rRWno9+fI6RBykOxGJQFP4xNvGberfuWFHB
         mqPRx//EGiAHbRGkE2nnLtrCDFc0n/tBoywFWHKqo5tB37hPpPygePNm1Rck/mduSRjC
         5bBg==
X-Forwarded-Encrypted: i=1; AJvYcCVgFL9m5cOQiJmR02grYO+5IeWT5uhB8d0+2rYn8uzTYbmWZucdgA6StOxQ+/Uv7D4Mke5zfLnxsxzVsUX+FbU9iaANOom7zqPLkQ==
X-Gm-Message-State: AOJu0Ywwq7qhtaD3fVicFNlmBLolTwXGA8TijfZarPklyXzsCD0w1b0X
	PstkOeNZqGUUztXH23keF4Gf1WhAadLjol2JJ+wTE0HySMQUlSHci6geF9N0Qu8=
X-Google-Smtp-Source: AGHT+IHP86jwpef2VrNTk/F/3m18C35oRI7S2uSuTicrM8OfB1hqEectxv7/nW7zcBNuEDulc3tp2A==
X-Received: by 2002:a05:6000:1e4b:b0:34f:7788:37ef with SMTP id ffacd0b85a97d-35526c69eecmr9262367f8f.29.1716909482640;
        Tue, 28 May 2024 08:18:02 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-357718907ddsm8997697f8f.69.2024.05.28.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:18:02 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Date: Tue, 28 May 2024 17:10:52 +0200
Message-Id: <20240528151052.313031-8-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528151052.313031-1-alexghiti@rivosinc.com>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to produce a generic kernel, a user can select
CONFIG_QUEUED_SPINLOCKS which will fallback at runtime to the ticket
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
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/Kbuild                 |  4 +-
 arch/riscv/include/asm/spinlock.h             | 39 +++++++++++++++++++
 arch/riscv/kernel/setup.c                     | 18 +++++++++
 include/asm-generic/qspinlock.h               |  2 +
 include/asm-generic/ticket_spinlock.h         |  2 +
 7 files changed, 66 insertions(+), 2 deletions(-)
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
index 184a9edb04e0..ccf1703edeb9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -59,6 +59,7 @@ config RISCV
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
 	select ARCH_USES_CFI_TRAPS if CFI_CLANG
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
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
index 000000000000..e00429ac20ed
--- /dev/null
+++ b/arch/riscv/include/asm/spinlock.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_RISCV_SPINLOCK_H
+#define __ASM_RISCV_SPINLOCK_H
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
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
index 4f73c0ae44b2..31ce75522fd4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -244,6 +244,23 @@ static void __init parse_dtb(void)
 #endif
 }
 
+DEFINE_STATIC_KEY_TRUE(qspinlock_key);
+EXPORT_SYMBOL(qspinlock_key);
+
+static void __init riscv_spinlock_init(void)
+{
+	asm goto(ALTERNATIVE("nop", "j %[qspinlock]", 0, RISCV_ISA_EXT_ZABHA, 1)
+		 : : : : qspinlock);
+
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
@@ -295,6 +312,7 @@ void __init setup_arch(char **cmdline_p)
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


