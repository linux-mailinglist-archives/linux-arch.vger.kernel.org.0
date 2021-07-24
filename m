Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0263D47A5
	for <lists+linux-arch@lfdr.de>; Sat, 24 Jul 2021 14:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGXLzY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 24 Jul 2021 07:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231511AbhGXLzX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 24 Jul 2021 07:55:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 841BB60F25;
        Sat, 24 Jul 2021 12:35:52 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org, Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Date:   Sat, 24 Jul 2021 20:36:16 +0800
Message-Id: <20210724123617.3525377-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
has hardware sub-word xchg/cmpxchg support. This option will be used as
an indicator to select the bit-field definition in the qspinlock data
structure.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/Kconfig       | 4 ++++
 arch/arm/Kconfig   | 1 +
 arch/arm64/Kconfig | 1 +
 arch/ia64/Kconfig  | 1 +
 arch/m68k/Kconfig  | 1 +
 arch/x86/Kconfig   | 1 +
 6 files changed, 9 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 129df498a8e1..ba5ed867b813 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
 	  An architecture should select this when it can successfully
 	  build and run with CONFIG_FORTIFY_SOURCE.
 
+# Select if arch has hardware sub-word xchg/cmpxchg support
+config ARCH_HAS_HW_XCHG_SMALL
+	bool
+
 #
 # Select if the arch provides a historic keepinit alias for the retain_initrd
 # command line option
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 82f908fa5676..fc374ab3b5c7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -8,6 +8,7 @@ config ARM
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
+	select ARCH_HAS_HW_XCHG_SMALL
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5b13a932561..393cbe1a6d85 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -25,6 +25,7 @@ config ARM64
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_HW_XCHG_SMALL
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index cf425c2c63af..a0a31fd8d9be 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -9,6 +9,7 @@ menu "Processor type and features"
 config IA64
 	bool
 	select ARCH_HAS_DMA_MARK_CLEAN
+	select ARCH_HAS_HW_XCHG_SMALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select ACPI
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 96989ad46f66..324c2a42ec00 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -5,6 +5,7 @@ config M68K
 	select ARCH_32BIT_OFF_T
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
+	select ARCH_HAS_HW_XCHG_SMALL
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 49270655e827..0f3f24502c70 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -77,6 +77,7 @@ config X86
 	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_HW_XCHG_SMALL
 	select ARCH_HAS_KCOV			if X86_64 && STACK_VALIDATION
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
-- 
2.27.0

