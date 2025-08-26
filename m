Return-Path: <linux-arch+bounces-13283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B6FB35441
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 08:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F4E1899EE9
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 06:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53512F998A;
	Tue, 26 Aug 2025 06:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jz0/7pLP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IynN0/8e"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63F2F744D;
	Tue, 26 Aug 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189108; cv=none; b=AzCLYSAAbK3JQhnzCd8qRBmYmHtC8jZPIuQj6+GaQI/zmVac7EBzfzmD74/zmqGVqniQHHF8YKtcAxho8atg/x4QRuVT3C3d5yIbycMrq6jociAj9FmB8PnWCjBk8f7DswhJbsZY28vhF2RuH7T0d9TnJ6wlwKcSznIZhUJBG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189108; c=relaxed/simple;
	bh=Mt4fZFBjcLMXO0F8ah8zID6THO30anmEgiHd56j+zis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=naOEmzpCqWqVCASFuhK7yao/ofmRPHnW9WIbHgk+pXNiU6Bxtjeq7FHbTLFaEDctgixx74dbv3+xr/oIxXakm+GGtxl1p30tWMX/S9GtlARvylkCxQCCc8/2WOS+PHxUvNhne53mhlD1+JRJLB9/UdkJOJfX/RQY9mOzcgqdCW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jz0/7pLP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IynN0/8e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756189103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OtEk1IecNbh7fy3r1+1dTERhSAbGkHOFFco8iWvDGU=;
	b=Jz0/7pLPVA6zTJr44+7JKcHQ1ZYGzCOR7CQGhjrgoGn+b2ytjLetqmej/iodeZIjEy/33N
	9b1Et+STIN7uRBSe5+2toY2HvhJre1hCJZGNzQZhLIHrYSY42nMNsvBrGbRxyIAdETTr6D
	MVyY9KN5wboqgFCZeankdQ8USPZh2IjO6tRLRpgij2ooBa6GZnlU8Mufr+TV7cZnjLb6Gv
	JAXQEBpQpPP5q8bbs6/hPOqncMl5qelkhJSrLDFjkGUBBsKH/GmyEBByNk/XJgWRmOX/wr
	tG3yrWGvuihtC9Q0HNnPhd3N5co+HF+CCY20QMn9NYrLawXb7mW+nPlcYITeag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756189103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5OtEk1IecNbh7fy3r1+1dTERhSAbGkHOFFco8iWvDGU=;
	b=IynN0/8el+0iMcrk8BTz7Yksb+3BE1uv7jGvX/sOjzFgMyLE/sY4NtqO83An9rpWe0fISp
	UjNOZ2ZGQUB8vPDA==
Date: Tue, 26 Aug 2025 08:17:12 +0200
Subject: [PATCH 09/11] vdso: Drop kconfig GENERIC_VDSO_DATA_STORE
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250826-vdso-cleanups-v1-9-d9b65750e49f@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756189098; l=8644;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Mt4fZFBjcLMXO0F8ah8zID6THO30anmEgiHd56j+zis=;
 b=RxWXxc3dRqPKPPntkz/2f30QckYBpVilb0q6l8HqfYRltiodpUXYB+254fTb4rXIJCOgBLv8L
 YiC7Hx1FoE/Aj6tk9SK/IhWcmdOzvjMTDv/KH8LwWZecDFpO7islLzG
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All users of the generic vDSO library also use the generic vDSO datastore.

Remove the now unnecessary kconfig symbol.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/Kconfig                        | 2 +-
 arch/arm/mm/Kconfig                 | 1 -
 arch/arm64/Kconfig                  | 1 -
 arch/loongarch/Kconfig              | 1 -
 arch/mips/Kconfig                   | 1 -
 arch/powerpc/Kconfig                | 1 -
 arch/riscv/Kconfig                  | 1 -
 arch/s390/Kconfig                   | 1 -
 arch/x86/Kconfig                    | 1 -
 include/asm-generic/vdso/vsyscall.h | 4 ----
 include/vdso/datapage.h             | 5 +----
 lib/vdso/Kconfig                    | 5 -----
 lib/vdso/Makefile                   | 2 +-
 lib/vdso/gettimeofday.c             | 2 --
 14 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd6e085644defd780c1d3aaf6ac53a65055..f6ca7f3031726ee28ebdf9d7874184d7130afce5 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1609,7 +1609,7 @@ config HAVE_SPARSE_SYSCALL_NR
 	  related optimizations for a given architecture.
 
 config ARCH_HAS_VDSO_ARCH_DATA
-	depends on GENERIC_VDSO_DATA_STORE
+	depends on HAVE_GENERIC_VDSO
 	bool
 
 config ARCH_HAS_VDSO_TIME_DATA
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2347988cf6417b91d8d3580387b53e610ed49a00..7b27ee9482b3eb34286935eddda136affc5084a7 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -927,7 +927,6 @@ config VDSO
 	select HAVE_GENERIC_VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c61b19ea9c80559ca3c4d1aa0732c6126494cb0..b0f007b396c81906d3a0a66f8a240d97e0ae2d88 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,7 +162,6 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38c40ac9ea3026d8e19a851cd31bb5faa9f..d15b201d55f951d95435a38789cf47ea9f0adac9 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,7 +108,6 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index caf508f6e9ec8e725a73f2027d1fc29c8cf808a5..f7e6bbd755e0ed15e408e90a7974d3b161956446 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,7 +51,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1d9c9fc63e2795cf53c5acb248e0358591..78c82af955616c57ab38ea1241e3471eb8d0a65d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -207,7 +207,6 @@ config PPC
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e4ac0e833ecfdb976134e9009a2cdfdea789f13d..f6cf9180ccf2c9774248fea93a8276de3791ad71 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -121,7 +121,6 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE if HAVE_GENERIC_VDSO
 	select GENERIC_VDSO_TIME_NS if GENERIC_GETTIMEOFDAY
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c26a33cf7bef2ed5e25cabc061597c131b1..696d2243d64b04e77b9b4631fc8bc301916b48ae 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -167,7 +167,6 @@ config S390
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4f120070a51bd4e225256440649a2dae17025c41..1e74b2a356e42bdc0ede258f44e18ba29dd90174 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -181,7 +181,6 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 7fc0b560007dd8f09a2f24ace76ce68579ad17c1..5c6d9799f4e746cc9f0d46a0744c6dcc30fec587 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,8 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
-
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
 {
@@ -20,8 +18,6 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(vo
 }
 #endif
 
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 #ifndef __arch_update_vdso_clock
 static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 0b1982f15de427723c9ff8502ca1eaa195f9a6a1..23c39b96190fdfc2f31bf76a8614d69a3a98017c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -31,7 +31,7 @@ struct arch_vdso_time_data {};
 
 #if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
 #include <asm/vdso/arch_data.h>
-#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+#else
 struct vdso_arch_data {
 	/* Needed for the generic code, never actually used at runtime */
 	char __unused;
@@ -164,7 +164,6 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hidden")));
@@ -185,8 +184,6 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
 
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 2594dd7185be762a4a94aa38ecec5db016776f85..48ffb0f6fa413ea7da4e43c7f7a24cb232b38ea1 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -31,8 +31,3 @@ config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
-
-config GENERIC_VDSO_DATA_STORE
-	bool
-	help
-	  Selected by architectures that use the generic vDSO data store.
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index aedd40aaa950c86f1454d095d9d46992b0cc0abd..405f743253d72b8a40c45b7dc8bec347d9e5c8eb 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) += datastore.o
+obj-$(CONFIG_HAVE_GENERIC_VDSO) += datastore.o
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 1e2a40b8d2c6c2356cfc678a1ea441ec1bad181a..95df0153f05ab41c871755e005762f3442ff3ecd 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -108,13 +108,11 @@ bool vdso_get_timestamp(const struct vdso_time_data *vd, const struct vdso_clock
 	return true;
 }
 
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 static __always_inline
 const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_time_data *vd)
 {
 	return (void *)vd + PAGE_SIZE;
 }
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
 static __always_inline
 bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,

-- 
2.50.1


