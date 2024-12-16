Return-Path: <linux-arch+bounces-9398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065A9F329B
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 15:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4391694A4
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2024 14:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01E207A18;
	Mon, 16 Dec 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCrWR+s6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8+p5Z2LK"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEFF207A20;
	Mon, 16 Dec 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358259; cv=none; b=f6R7+QEB5EF89TgjpICHz5w/Xh4C2pLdT28pxfjVyUfciODUnOxnO7cIhszhIw0HXd9CWQXXcFki7yTutPXrdg1lDOhGediQMbFKuRTAcoQ3pOQ7b9KxfD/OtvHE+aFIIC8e7oA1E13V9vJ0avGo2LIsxtUbOzw768uhbFxngyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358259; c=relaxed/simple;
	bh=1JfcNRBN31T16h/FySfjXsHOUPI+cqgR61pBaoeiy2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkYUoug2ebXhTgoLUqBAkXsjMsdo+wR/h+Fb+77XL5OpV3SLx7WhV0NyUV3mCZhfRzrNO0ySozi3AVfkCcNNNj+g/Wr8j9/jrDz+HvdrcUysm+ev79gsy4DU1jAoy3NpKm60oRtKrMb1YiVdO3B3vjx5/zKcGpYc2omqYRfTnX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCrWR+s6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8+p5Z2LK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734358253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N50oiaH5NKHF/dGDm4wkuhXe1OR6bWZJX5Stqs/cTIw=;
	b=aCrWR+s6wRokELQB59JYh71GR2O5x3Q64inZNTzhAqbptc707U8NPjUgp8o1r/8sE7YE/k
	2DMlf+YlxInCTNI2uFV5Y+I4jEa0DN4LvADOowuCrKn9mKy8UQBM5Aq3bZp96INIDcJvCr
	eNwVWCbm6JkmtRp3+EXuNpsrlw/JPPg4qN3ibTPLzCtRmNWhBnL0PDZtoeqKwon3wOHX0T
	D1dng8iCAwE1sf3aCP92skbkU24lMNmEnih1ZTr0fOOHbQtn1kPqIcgXkR1DIn71EW29PG
	1OiMYHj7Daz2n+YA7Xrank1xIc94s/YYyaunq4PVkHk4f59S/HslitQ5JT/Naw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734358253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N50oiaH5NKHF/dGDm4wkuhXe1OR6bWZJX5Stqs/cTIw=;
	b=8+p5Z2LKgGqmmLfwG75iw3tr/Gv/u91O0Qs238ZJMXUSZESX05G86M/BIp6Sb1Al/JsG+h
	Kay6axPrj4uQ/sDA==
Date: Mon, 16 Dec 2024 15:10:01 +0100
Subject: [PATCH 05/17] vdso: Add generic architecture-specific data storage
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-vdso-store-rng-v1-5-f7aed1bdb3b2@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734358247; l=5490;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1JfcNRBN31T16h/FySfjXsHOUPI+cqgR61pBaoeiy2g=;
 b=zloDZDsCdkCnNQAVAi7v19Z7KYMR15mdzSloDWxF1efHDX8XfsZFdqZnsCgUXcipRRrinwiil
 rZgOsm8e4zFDRRx+qhkQxIVSFTfIayv2LzJu53PZM2IJX6HNKiLABFk
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some architectures need to architecture-specific data to the vDSO.
Enable the generic vDSO storage mechanism to both store and map this
data. Some architectures require more than a single page, like
LoongArch, so prepare for that usecase, too.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/Kconfig                |  4 ++++
 include/vdso/datapage.h     | 32 ++++++++++++++++++++++++++++++++
 lib/vdso_kernel/datastore.c | 14 ++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6682b2a53e342cbacc05b70ef99cb1c47efe55e8..48f37e6c00674f433a0d6e6e05ce72c27cf000b7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1576,6 +1576,10 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
+config ARCH_HAS_VDSO_ARCH_DATA
+	depends on GENERIC_VDSO_DATA_STORE
+	bool
+
 config ARCH_HAS_VDSO_TIME_DATA
 	bool
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5ce322422fcb7ba77aeafddbf132fd3e5dbc5a0c..b3227f1cf62895aa60ce0ca96afa42259f4771f9 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -9,11 +9,13 @@
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
 
+#include <vdso/align.h>
 #include <vdso/bits.h>
 #include <vdso/clocksource.h>
 #include <vdso/ktime.h>
 #include <vdso/limits.h>
 #include <vdso/math64.h>
+#include <vdso/page.h>
 #include <vdso/processor.h>
 #include <vdso/time.h>
 #include <vdso/time32.h>
@@ -25,6 +27,15 @@
 struct arch_vdso_time_data {};
 #endif
 
+#if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
+#include <asm/vdso/arch_data.h>
+#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+struct vdso_arch_data {
+	/* Needed for the generic code, never actually used at runtime */
+	char __unused;
+};
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -146,9 +157,11 @@ extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")))
 extern const struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
 extern const struct vdso_time_data vdso_u_timens_data[CS_BASES] __attribute__((visibility("hidden")));
 extern const struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
+extern const struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hidden")));
 
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
+extern struct vdso_arch_data *vdso_k_arch_data;
 #endif
 
 /**
@@ -161,10 +174,15 @@ union vdso_data_store {
 
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 
+#define VDSO_ARCH_DATA_SIZE ALIGN(sizeof(struct vdso_arch_data), PAGE_SIZE)
+#define VDSO_ARCH_DATA_PAGES (VDSO_ARCH_DATA_SIZE >> PAGE_SHIFT)
+
 enum vdso_pages {
 	VDSO_TIME_PAGE_OFFSET,
 	VDSO_TIMENS_PAGE_OFFSET,
 	VDSO_RNG_PAGE_OFFSET,
+	VDSO_ARCH_PAGES_START,
+	VDSO_ARCH_PAGES_END = VDSO_ARCH_PAGES_START + VDSO_ARCH_DATA_PAGES - 1,
 	VDSO_NR_PAGES
 };
 
@@ -204,6 +222,13 @@ static __always_inline struct vdso_rng_data *__arch_get_vdso_k_rng_data(void)
 
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+static __always_inline const struct vdso_arch_data *__arch_get_vdso_u_arch_data(void)
+{
+	return &vdso_u_arch_data;
+}
+#endif /* CONFIG_ARCH_HAS_VDSO_ARCH_DATA */
+
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
@@ -234,11 +259,18 @@ static __always_inline struct vdso_rng_data *__arch_get_vdso_k_rng_data(void)
 #define __vdso_u_rng_data
 #endif
 
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+#define __vdso_u_arch_data	PROVIDE(vdso_u_arch_data = vdso_u_data + 3 * PAGE_SIZE);
+#else
+#define __vdso_u_arch_data
+#endif
+
 #define VDSO_VVAR_SYMS						\
 	PROVIDE(vdso_u_data = . - __VDSO_PAGES * PAGE_SIZE);	\
 	PROVIDE(vdso_u_time_data = vdso_u_data);		\
 	__vdso_u_timens_data					\
 	__vdso_u_rng_data					\
+	__vdso_u_arch_data					\
 
 
 #endif /* !__ASSEMBLY__ */
diff --git a/lib/vdso_kernel/datastore.c b/lib/vdso_kernel/datastore.c
index 0d4f5317b508a54b4f3295f0335d1eefce74d78c..668cac8c4f80ac71d3f6de71e98e963bc65a1c15 100644
--- a/lib/vdso_kernel/datastore.c
+++ b/lib/vdso_kernel/datastore.c
@@ -24,6 +24,14 @@ struct vdso_rng_data *vdso_k_rng_data = &vdso_rng_data_store.data;
 static_assert(sizeof(vdso_rng_data_store) == PAGE_SIZE);
 #endif /* CONFIG_VDSO_GETRANDOM */
 
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+static union {
+	struct vdso_arch_data	data;
+	u8			page[VDSO_ARCH_DATA_SIZE];
+} vdso_arch_data_store __page_aligned_data;
+struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -63,6 +71,12 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			return VM_FAULT_SIGBUS;
 		pfn = __phys_to_pfn(__pa_symbol(vdso_k_rng_data));
 		break;
+	case VDSO_ARCH_PAGES_START ... VDSO_ARCH_PAGES_END:
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_VDSO_ARCH_DATA))
+			return VM_FAULT_SIGBUS;
+		pfn = __phys_to_pfn(__pa_symbol(vdso_k_arch_data)) +
+			vmf->pgoff - VDSO_ARCH_PAGES_START;
+		break;
 	default:
 		return VM_FAULT_SIGBUS;
 	}

-- 
2.47.1


