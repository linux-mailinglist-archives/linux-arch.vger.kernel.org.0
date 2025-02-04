Return-Path: <linux-arch+bounces-9991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0346A27158
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 13:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F83118824C5
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1221481D;
	Tue,  4 Feb 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEXuPSFJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JWZ2VRs+"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C632144C1;
	Tue,  4 Feb 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670775; cv=none; b=afyxRoXd+AHI/oxavppXIcNFmOqKOW8SUyg6ILqxB84nUmpHjQpYwsCb63QKOUjJCCM2EqFWOLd4UlRyY5zfnwap+wfubiJPgZkmSx0goaXeomIPSiKfxXzNWOAbQ/QGEXC3RZ51QfCskTainB357ciZpQb1MC0wSElH5hHPVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670775; c=relaxed/simple;
	bh=hqYzcPXwdjmayHj4U7VVt9y+emzZQxkmpVtEmg40Qdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8RaiMAmn3gDgKNsbxMkxj8zDH4uxuhFyU5u9RXJ44iclfLXgZBM00Rcty6busn1GQcWLWmpPv4WrMauWky8eOFydpC0VArYHVCGfA+J+6TcF356OgoHd/WV3rVN7U1QGQMpcAXvfswRbW4ByvMqTZ/DdWdFyY/goSsB45i1NYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oEXuPSFJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JWZ2VRs+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAOVW8H/jmZUurJoSsBqrn657OqlOYnQawrkcGFYNtg=;
	b=oEXuPSFJw3vOyfHksK8gvKbLrFFkz0qxmosTiczrxSReVtw/8Ch595sZtd44xx2JO9t/e6
	HIgrZyL10KywpVcEq5/M7tlolFDd3E/UBCv2USw56HpQP9iQuPRJPc5cgMmRcecQPAWUgU
	BfNGUOwJxXyKERem6dKoQSgxYlWE5pF+AdZuEFLEIawoURCs/ls98rDZE3JSP828TH6Kbv
	LzzqiR/Fu2Wo/uifYNdGYju1bziKAy6XnLpBi+I9QBPRDLqlnhF7T1fc3T3b+vRwZxk+L6
	zZk8QFrgh72taIf2qRAvrIDKsQWI4B/eg+pDubW5ET5z5JUZXmAvpQpNcr4DyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAOVW8H/jmZUurJoSsBqrn657OqlOYnQawrkcGFYNtg=;
	b=JWZ2VRs+cdR71gOVuHVaODZFDW60BiYqFTQqa41rwfR9c+wkqnBvPnlxsY3xKO44U64EDJ
	Y8GIGe1DjznazdBQ==
Date: Tue, 04 Feb 2025 13:05:39 +0100
Subject: [PATCH v3 07/18] vdso: Add generic architecture-specific data
 storage
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-vdso-store-rng-v3-7-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
In-Reply-To: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
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
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
 Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-csky@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=4823;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hqYzcPXwdjmayHj4U7VVt9y+emzZQxkmpVtEmg40Qdg=;
 b=eT418J3Cm/UT46u3wK7qwnCsDxT/tmxu49usXJsjpoj8C3SYD1MzSQXHqYZhez8ul/Cc3g2m6
 Bz3DxyokUDfAL/pz7NPVpBrIIDX51xI7KrQDJQFryKy2sECT03IsTYB
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some architectures need to architecture-specific data to the vDSO.
Enable the generic vDSO storage mechanism to both store and map this
data. Some architectures require more than a single page, like
LoongArch, so prepare for that usecase, too.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/Kconfig            |  4 ++++
 include/vdso/datapage.h | 25 +++++++++++++++++++++++++
 lib/vdso/datastore.c    | 14 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index b8a4ff36558228240080a5677f702d37f4f8d547..9f6eb09ef12d76e755c0fd2df71ba703c251052f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1584,6 +1584,10 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
+config ARCH_HAS_VDSO_ARCH_DATA
+	depends on GENERIC_VDSO_DATA_STORE
+	bool
+
 config ARCH_HAS_VDSO_TIME_DATA
 	bool
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7dbc8797e3b8923c06f4b6b34790766e68b2abd2..46658b39c28250e977f5a3454224c3ed0fb4c81d 100644
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
@@ -145,9 +156,11 @@ extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")))
 #else
 extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
+extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hidden")));
 
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
+extern struct vdso_arch_data *vdso_k_arch_data;
 #endif
 
 /**
@@ -160,10 +173,15 @@ union vdso_data_store {
 
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
 
@@ -193,10 +211,17 @@ enum vdso_pages {
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
 	__vdso_u_rng_data					\
+	__vdso_u_arch_data					\
 
 
 #endif /* !__ASSEMBLY__ */
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 9260b00dc8520af109bd9dd05ac7f7504eafbea0..0959d62d78586ef458eb5f7c1e152f6b5d4cbf85 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -26,6 +26,14 @@ struct vdso_rng_data *vdso_k_rng_data = &vdso_rng_data_store.data;
 static_assert(sizeof(vdso_rng_data_store) == PAGE_SIZE);
 #endif /* CONFIG_VDSO_GETRANDOM */
 
+#ifdef CONFIG_ARCH_HAS_VDSO_ARCH_DATA
+static union {
+	struct vdso_arch_data	data;
+	u8			page[VDSO_ARCH_DATA_SIZE];
+} vdso_arch_data_store __page_aligned_data;
+struct vdso_arch_data *vdso_k_arch_data = &vdso_arch_data_store.data;
+#endif /* CONFIG_ARCH_HAS_VDSO_ARCH_DATA */
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -67,6 +75,12 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
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
2.48.1


