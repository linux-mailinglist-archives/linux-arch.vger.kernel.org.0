Return-Path: <linux-arch+bounces-9409-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0E9F32C9
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 15:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365F018806F3
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E524E20C464;
	Mon, 16 Dec 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EjoICeHS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KECvIYz+"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92B20ADE4;
	Mon, 16 Dec 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358267; cv=none; b=K1q1IpSnwT5/iIyVFa97IR4wuMmTZkt27T9177T6+Yx6cX7wqLqgznDcoluDgXn9FVhBcEzNLz/BwoXO4Y9ImEBz9iD8lNcP9cBkoDquAxs76iMWo0Ew3fbn4KqQ47Lc52AGQGTWUd26zUqt79ooVeMdZGiPZkOW0Del1YvTo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358267; c=relaxed/simple;
	bh=B3Pxps8DfM8WSROY05rM3B3CvxrQAIRj6LTHSkhSnYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FG3Pm7K2/E7xRJVTQVZz/RX4uy2sExDLlrHgaiHjrScKwspgdwm68sLVGvUskW7XKssOsMgPhNwLYBGaPgYl+kvT4gBHjLl/yd81KZ9T3PvrLf/XgrGpJVepUli7b9gbKAe3snx0PEgCl33dWZCqajNHIy4jyMomQt4Nx9qyKM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EjoICeHS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KECvIYz+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734358262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bePNlp/p1MKrXnwHvq18neFXwP/Nn0Iwf/MlDsyNHuc=;
	b=EjoICeHSoeCF4ZnBJ9XgtzZV1pN3f1QjAeD7QCf+3aVhPiz8k0cI5OYvMb9at3m1YoQo00
	QxcgRU9yQlcCvRqMGy9YtWGoy8DednXn8akTfqVDPVDM9naMl7lJyC6TGs2tra4zlGN/y4
	8Q9grBYJTiSl1VryvOrnh5vQH+Vi8EYxI4aAIzgV1zv9ZQKcvu4egNauUDGhI+gBR7wUr9
	a4X6yi4tRfusEBVw0KvWPmt9fjCvaCOpNZAfAxNmbOIOZjb6a92iKI2uIwT27MTd4Vsyew
	igUOaIXKIt+iqcFyXmAXRY93TD8fWsJMg0igtK7/UWXWxz55MthMdrKziRYp1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734358262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bePNlp/p1MKrXnwHvq18neFXwP/Nn0Iwf/MlDsyNHuc=;
	b=KECvIYz+QDi1Lg1U24XopJRnWfCqmvgh/zHf4Hm2lwuMnEcD35EWrMTHJZbh80gEuxbyHo
	NOPMwX89Q3TYBNDw==
Date: Mon, 16 Dec 2024 15:10:13 +0100
Subject: [PATCH 17/17] vdso: Remove kconfig symbol GENERIC_VDSO_DATA_STORE
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-vdso-store-rng-v1-17-f7aed1bdb3b2@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
In-Reply-To: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734358247; l=7961;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=B3Pxps8DfM8WSROY05rM3B3CvxrQAIRj6LTHSkhSnYg=;
 b=Oujw7cI/7WlZWvTQ3ZWZntnrNHHoMDU1Q/wYpvdHfSwL0otiu725rLX1pEEaqlUNfNxVHLwj8
 lafYlnufGXFCYaPDDreGNGBiZeZ6bE4uQeNdj0LLpThLGExnnWj8LPu
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All users of HAVE_GENERIC_VDSO have been switched over to the generic
storage logic. The dedicated kconfig symbol can be removed and replaced
by HAVE_GENERIC_VDSO.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/Kconfig             | 2 +-
 arch/arm/mm/Kconfig      | 1 -
 arch/arm64/Kconfig       | 1 -
 arch/loongarch/Kconfig   | 1 -
 arch/mips/Kconfig        | 1 -
 arch/powerpc/Kconfig     | 1 -
 arch/riscv/Kconfig       | 1 -
 arch/s390/Kconfig        | 1 -
 arch/x86/Kconfig         | 1 -
 include/vdso/datapage.h  | 8 +-------
 lib/Kconfig              | 1 -
 lib/vdso_kernel/Kconfig  | 7 -------
 lib/vdso_kernel/Makefile | 2 +-
 13 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 48f37e6c00674f433a0d6e6e05ce72c27cf000b7..63e20e5e779d5c6d786b90ccb139e16a23445fcb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1577,7 +1577,7 @@ config HAVE_SPARSE_SYSCALL_NR
 	  related optimizations for a given architecture.
 
 config ARCH_HAS_VDSO_ARCH_DATA
-	depends on GENERIC_VDSO_DATA_STORE
+	depends on HAVE_GENERIC_VDSO
 	bool
 
 config ARCH_HAS_VDSO_TIME_DATA
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5c1023a6d78c1b4db67b2d62b71af5a79b7e701f..2b6f50dd547840adecbe08e684ed8f1a032cd7c2 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -928,7 +928,6 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1a4a78ec593328d6e6bceacc1abb0821eab988ca..100570a048c5e8892c0112704f9ca74c4fc55b27 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -159,7 +159,6 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 6ec7ef705199fdd4039afd23ec9050a28aa894eb..4dffb5ccd46397eedd27870183a105688ab23c5e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -105,7 +105,6 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 94fae59589ae80d590ac250b52ba30e9dd6eda32..467b10f4361aeb7aad0121f334eaa5d23351010c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -49,7 +49,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 600fa3b917ee902d016f2a04376950a9dc49074f..744c09813c43736089e69d06541a7a7d48a4d6da 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -207,7 +207,6 @@ config PPC
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a42d74aa53fe7c18e76820499d0ae43cd3b0c0bd..25023e4bc41b2aa02242ed1fe31caa3031a3edd5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -115,7 +115,6 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
-	select GENERIC_VDSO_DATA_STORE if HAVE_GENERIC_VDSO
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 6472eb4c210f378eaa61ddff04a6abc2f4aa2940..0077969170e8b4ca4c99e87ec75f6ea94f3e8e00 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -158,7 +158,6 @@ config S390
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e3d7f17dc414ca93d6e746dbc7f02afd2bc043a8..9d7bd0ae48c4260f4abb6dbedc696e3915c230ea 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -177,7 +177,6 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index fe2368d9ae6a759101de80b1746f5cc221d7d142..49b23b35df5fc0699ac7f34693b7de1201aa4486 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -29,7 +29,7 @@ struct arch_vdso_time_data {};
 
 #if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
 #include <asm/vdso/arch_data.h>
-#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+#else
 struct vdso_arch_data {
 	/* Needed for the generic code, never actually used at runtime */
 	char __unused;
@@ -147,7 +147,6 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 extern const struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
 extern const struct vdso_time_data vdso_u_timens_data[CS_BASES] __attribute__((visibility("hidden")));
 extern const struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
@@ -156,9 +155,6 @@ extern const struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("h
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
 extern struct vdso_arch_data *vdso_k_arch_data;
-#endif
-
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 
 #define VDSO_ARCH_DATA_SIZE ALIGN(sizeof(struct vdso_arch_data), PAGE_SIZE)
 #define VDSO_ARCH_DATA_PAGES (VDSO_ARCH_DATA_SIZE >> PAGE_SHIFT)
@@ -191,8 +187,6 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(vo
 }
 #endif /* CONFIG_VDSO_GETRANDOM */
 
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 #ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
 static __always_inline const struct vdso_arch_data *__arch_get_vdso_u_arch_data(void)
 {
diff --git a/lib/Kconfig b/lib/Kconfig
index 7d59b2c10ce5ffab03378ead254d9f9017a4482f..5a318f753b2f44cb0a7905cc0092e81c133bc112 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -659,7 +659,6 @@ config UCS2_STRING
 # generic vdso
 #
 source "lib/vdso/Kconfig"
-source "lib/vdso_kernel/Kconfig"
 
 source "lib/fonts/Kconfig"
 
diff --git a/lib/vdso_kernel/Kconfig b/lib/vdso_kernel/Kconfig
deleted file mode 100644
index 0c7ade9b3ece67c0c0ca892544b9e29e53c860c4..0000000000000000000000000000000000000000
--- a/lib/vdso_kernel/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-
-config GENERIC_VDSO_DATA_STORE
-	bool
-	depends on HAVE_GENERIC_VDSO
-	help
-	  Selected by architectures that use the generic vDSO data store.
diff --git a/lib/vdso_kernel/Makefile b/lib/vdso_kernel/Makefile
index 4826e49f9edbdb48506b50957584ed89bde5f37f..aadc987caa434ef99c1420c62bb71fde04a07603 100644
--- a/lib/vdso_kernel/Makefile
+++ b/lib/vdso_kernel/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) += datastore.o
+obj-$(CONFIG_HAVE_GENERIC_VDSO) += datastore.o

-- 
2.47.1


