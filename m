Return-Path: <linux-arch+bounces-13280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8505FB35428
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C557684DC9
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7722F745C;
	Tue, 26 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CffaJqA5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6BWF05Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DD2F60DF;
	Tue, 26 Aug 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189105; cv=none; b=VfspYlJoYhArJhuUueHW0LbB6qIsOac4slm8tGLz1PPVGPKUpL81XeTx0kgjlo5r6QvlNZ3Z3EVt0sgv1JVJfS95BZvGHVO0V8mWulbtWjJNaCzYH7lohuYqyM2ATkUgcyPURtF1LHjWOpMTl982CoSOc2/JnHRjGmyyiFnBAf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189105; c=relaxed/simple;
	bh=2HUR3b3XiF14rTZqp00VBNDZFgL9jjx0Ea79UoT5jM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjb2+gWXhipaQyTzPH64KUdx/0M+1nCNLUkb7DmmUltIsxRSP7wZBPeVCpufwnK+uHTFlTZ7CBFCT45T1f0p3Wigz259KUGGi3FlHV8MG/OxPtW5dHUu6UC+0zsRLT1K4InzYpI7cEEKNucdyO0O0KNk5TZPehj037Z5hfY5/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CffaJqA5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6BWF05Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfAvYUxv3s9XKBImIakj8GXd2hgk5QRNQQC7FW4cjt4=;
	b=CffaJqA5rsLpXWqtw3f39vxIq72rtPSbTis/OEKKsYWwPUec05NUKa0lPRbguDeq+uu38S
	3NFM99Ki94UQstG1VMY2CGSg+hq7AbvA6zg+C+bP9sSvPb/lmNV1XcXNvGv4NO+gdCJiTJ
	F0vKD5/RKqooZcBm5Qr6sSNWUp0GY9+7LT/fLhaBiLyT/PbkrhazJkqrptqY/TUmuaFrPv
	yHOJtuEeTW57C+suLl7kDyfOZdwa3rDWpoG7e4q0vO2W/nJMjiWimAX/qJJmgt1JVY6+EN
	ys8w+2HNfxqGMLJZbQv/ICj0IcuRaCHeepjdlNgKkGD66gzUFpCGgSG9JqosYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfAvYUxv3s9XKBImIakj8GXd2hgk5QRNQQC7FW4cjt4=;
	b=q6BWF05Q67M+a3SeKYmCy1eWKcKb5dNs+NjtEBA+0XviDim16s93yYLfPQLe33toJrC2Vy
	I8vMrv/opXDeLlCw==
Date: Tue, 26 Aug 2025 08:17:09 +0200
Subject: [PATCH 06/11] riscv: vdso: Untangle kconfig logic
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-6-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
In-Reply-To: <20250826-vdso-cleanups-v1-0-d9b65750e49f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Nam Cao <namcao@linutronix.de>, 
 Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=2848;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=2HUR3b3XiF14rTZqp00VBNDZFgL9jjx0Ea79UoT5jM0=;
 b=2hMcbjqMUE+qJLwmgpoY1wgcMoYGpME1ZDwZAE0d5fqg8MI8j+0QAYV7x68fNUjZIXMNYkZj3
 Hx9qICkN7nyDHu5XdS8/Dovk5FCyrPAbpK6r8pqP2D3CWdV/qVtsIiM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

On riscv32 the generic vDSO infrastructure is used but without its
time-related functionality. The kconfig logic to implement this
treats HAVE_GENERIC_VDSO as a synonym for GENERIC_GETTIMEOFDAY.
This works today due to some underlying issues in how the generic vDSO
library works. Some future cleanups will break this logic.

Restructure the kconfig logic, so HAVE_GENERIC_VDSO refers to the generic
library in general and GENERIC_GETTIMEOFDAY refers to its time-related
functionality.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/riscv/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a0659ed80c0eb6b118ea8c8db81ed3fdba..e4ac0e833ecfdb976134e9009a2cdfdea789f13d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -52,7 +52,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_ARCH_DATA if GENERIC_VDSO_DATA_STORE
+	select ARCH_HAS_VDSO_ARCH_DATA if HAVE_GENERIC_VDSO
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -107,7 +107,7 @@ config RISCV
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
-	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
+	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO && 64BIT
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IOREMAP if MMU
 	select GENERIC_IRQ_IPI if SMP
@@ -120,9 +120,9 @@ config RISCV
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
-	select GENERIC_VDSO_DATA_STORE if MMU
-	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
+	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE if HAVE_GENERIC_VDSO
+	select GENERIC_VDSO_TIME_NS if GENERIC_GETTIMEOFDAY
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
 	select HAVE_ALIGNED_STRUCT_PAGE
@@ -165,7 +165,7 @@ config RISCV
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_VDSO if MMU && 64BIT
+	select HAVE_GENERIC_VDSO if MMU
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
@@ -221,7 +221,7 @@ config RISCV
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select UACCESS_MEMCPY if !MMU
-	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO
+	select VDSO_GETRANDOM if HAVE_GENERIC_VDSO && 64BIT
 	select USER_STACKTRACE_SUPPORT
 	select ZONE_DMA32 if 64BIT
 

-- 
2.50.1


