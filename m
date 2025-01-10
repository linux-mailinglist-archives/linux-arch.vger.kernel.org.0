Return-Path: <linux-arch+bounces-9667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F0BA09547
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 16:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16BC3AA6F5
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2025 15:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05515212D8A;
	Fri, 10 Jan 2025 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zb3nq64x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aSE6g2U4"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B0211A24;
	Fri, 10 Jan 2025 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522640; cv=none; b=f7kqqdcX4P+HdLFsxPBKaLdiPUHaHIa2+Zhf83wAi308dCXxXNC0cBXTGN1t2BY5r74DvCWcHpwryBCoRVhET/m+BoXlULnCD6Kn0/nuv4s0hVjtXoxeuuSQLbv0skqaB7NnFxp0szLRdgjrgV5asPksiBQbo+27+8fOU/sONqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522640; c=relaxed/simple;
	bh=AtwuuB/oDez/zTH4AnlgJMeYoMjPvn/M7i4Uvo3MuCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWvDK6r9PO+zzk5ruJMDt9QWIGrEkQz9fqGqDF9IKu1qEIsv9Da5ku+I7SNZ4k0atcaCI5nFMlNwSeVxKP0ag9uGXX4iTPxD0a/xUtuwB54ensxusSIA/4sk2DrD+Y5KVgMLGZwpTgr6XtZwh8JRX52a1acA3eqN9sY6DdW7MHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zb3nq64x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aSE6g2U4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736522634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq275xUXsX65s6DxMvIf1lM6Qa9KmyDATkVniLpqGNI=;
	b=zb3nq64xnbqQDCLJNq0XD3sBpQ1ZRzn8LmBeAuzUHcG75rJls1cF2A0pzl9b7fAAFkSKTB
	HJNkhsALtf/oZEa4iu6gr8HsgUXUgkYqjSSTyhzRy7BjM6bHIO91ttcdIjPHGeXfBdKauP
	/FORnJXZChtVvo2gtl2IbFi5jtdXrn7xFWEm5NQh9KKGarSc/rIUyfEkSOPPGEYG+NvqRb
	I3jo3h+dbC+sooYtl0OnvYRhK2v/w6QAdBV1IAVlQ2gobsPZ/OL4NVC5GUMQaougjY7fGU
	XupRUT0Y5NGzm/2hqBKVvuhJI1xkGW7/LsQ1SG+CVUEyl+uv1tJorgfnhqRHIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736522634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq275xUXsX65s6DxMvIf1lM6Qa9KmyDATkVniLpqGNI=;
	b=aSE6g2U4OdbIGzQFZfTyCvU9XlTRTETuot1tSyIfGQKo37UhxLTKYANqcH4eTajyTtK3Gm
	Iya5NqyGiAFwmSDA==
Date: Fri, 10 Jan 2025 16:23:44 +0100
Subject: [PATCH v2 05/18] vdso: Add generic time data storage
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-vdso-store-rng-v2-5-350c9179bbf1@linutronix.de>
References: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
In-Reply-To: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736522629; l=16601;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=AtwuuB/oDez/zTH4AnlgJMeYoMjPvn/M7i4Uvo3MuCQ=;
 b=ZuT/iY5r3G4qR47cVMqlkcm7cLp5ezbRcZSsp2thj3cW3IGsggc3QkCpxa5xtvFdDyjqy9wLB
 FI3I1SRk65HA9+4ikM8Tutep1pXf+zdeknfTSa306WiyZSvpLvCdBAI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Historically each architecture defined their own way to store the vDSO
data page. Add a generic mechanism to provide storage for that page.

Furthermore this generic storage will be extended to also provide
uniform storage for *non*-time-related data, like the random state or
architecture-specific data. These will have their own pages and data
structures, so rename 'vdso_data' into 'vdso_time_data' to make that
split clear from the name.

Also introduce a new consistent naming scheme for the symbols related to
the vDSO, which makes it clear if the symbol is accessible from
userspace or kernel space and the type of data behind the symbol.

The generic fault handler contains an optimization to prefault the vvar
page when the timens page is accessed. This was lifted from s390 and x86.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h |  16 ++++++
 include/linux/time_namespace.h      |   1 +
 include/linux/vdso_datastore.h      |  10 ++++
 include/vdso/datapage.h             |  41 +++++++++++---
 kernel/time/vsyscall.c              |   8 +--
 lib/Makefile                        |   2 +-
 lib/vdso/Kconfig                    |   5 ++
 lib/vdso/Makefile                   |   3 ++
 lib/vdso/datastore.c                | 103 ++++++++++++++++++++++++++++++++++++
 lib/vdso/gettimeofday.c             |  25 ++++++---
 10 files changed, 195 insertions(+), 19 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 01dafd604188fb0512d21c4ce4b027f7da54f5a0..ac5b93b91993224da245e80031b9f51e0c083f3c 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,12 +4,28 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+
+#ifndef __arch_get_vdso_u_time_data
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
+{
+	return vdso_u_time_data;
+}
+#endif
+
+#else  /* !CONFIG_GENERIC_VDSO_DATA_STORE */
+
 #ifndef __arch_get_k_vdso_data
 static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
 {
 	return NULL;
 }
 #endif /* __arch_get_k_vdso_data */
+#define vdso_k_time_data __arch_get_k_vdso_data()
+
+#define __arch_get_vdso_u_time_data __arch_get_vdso_data
+
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
 #ifndef __arch_update_vsyscall
 static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 876e31b4461d0ee01fe2bd3d136acdea2611789f..4b81db223f5450218dfaf553b24195be9ba97c08 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,6 +8,7 @@
 #include <linux/ns_common.h>
 #include <linux/err.h>
 #include <linux/time64.h>
+#include <vdso/datapage.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
diff --git a/include/linux/vdso_datastore.h b/include/linux/vdso_datastore.h
new file mode 100644
index 0000000000000000000000000000000000000000..a91fa24b06e09321fdff8c2c7bdfbc1b206db574
--- /dev/null
+++ b/include/linux/vdso_datastore.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VDSO_DATASTORE_H
+#define _LINUX_VDSO_DATASTORE_H
+
+#include <linux/mm_types.h>
+
+extern const struct vm_special_mapping vdso_vvar_mapping;
+struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr);
+
+#endif /* _LINUX_VDSO_DATASTORE_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index d967baa0cd0c65784e38dc4fcd7b9e8273923947..b3d8087488ff35fbbc4d5058ae21e2c6cc58ed9c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -45,11 +45,11 @@ struct arch_vdso_time_data {};
  *
  * There is one vdso_timestamp object in vvar for each vDSO-accelerated
  * clock_id. For high-resolution clocks, this encodes the time
- * corresponding to vdso_data.cycle_last. For coarse clocks this encodes
+ * corresponding to vdso_time_data.cycle_last. For coarse clocks this encodes
  * the actual time.
  *
  * To be noticed that for highres clocks nsec is left-shifted by
- * vdso_data.cs[x].shift.
+ * vdso_time_data[x].shift.
  */
 struct vdso_timestamp {
 	u64	sec;
@@ -57,7 +57,7 @@ struct vdso_timestamp {
 };
 
 /**
- * struct vdso_data - vdso datapage representation
+ * struct vdso_time_data - vdso datapage representation
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -74,7 +74,7 @@ struct vdso_timestamp {
  * @arch_data:		architecture specific data (optional, defaults
  *			to an empty struct)
  *
- * vdso_data will be accessed by 64 bit and compat code at the same time
+ * vdso_time_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
  *
  * The ordering of the struct members is optimized to have fast access to the
@@ -92,7 +92,7 @@ struct vdso_timestamp {
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
  */
-struct vdso_data {
+struct vdso_time_data {
 	u32			seq;
 
 	s32			clock_mode;
@@ -117,6 +117,8 @@ struct vdso_data {
 	struct arch_vdso_time_data arch_data;
 };
 
+#define vdso_data vdso_time_data
+
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds
@@ -136,18 +138,34 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
-extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
+#ifndef CONFIG_GENERIC_VDSO_DATA_STORE
+extern struct vdso_time_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
+extern struct vdso_time_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden")));
+#else
+extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
+
+extern struct vdso_time_data *vdso_k_time_data;
+#endif
 
 /**
  * union vdso_data_store - Generic vDSO data page
  */
 union vdso_data_store {
-	struct vdso_data	data[CS_BASES];
+	struct vdso_time_data	data[CS_BASES];
 	u8			page[1U << CONFIG_PAGE_SHIFT];
 };
 
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+
+enum vdso_pages {
+	VDSO_TIME_PAGE_OFFSET,
+	VDSO_TIMENS_PAGE_OFFSET,
+	VDSO_NR_PAGES
+};
+
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
+
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
@@ -164,6 +182,13 @@ union vdso_data_store {
 #include <asm/vdso/gettimeofday.h>
 #endif /* ENABLE_COMPAT_VDSO */
 
+#else /* !__ASSEMBLY__ */
+
+#define VDSO_VVAR_SYMS						\
+	PROVIDE(vdso_u_data = . - __VDSO_PAGES * PAGE_SIZE);	\
+	PROVIDE(vdso_u_time_data = vdso_u_data);		\
+
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 05d3831431658227c080a89202f45e7a0af88895..09c1e39a6dd8e24aa161982c04078e78d52fa737 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -77,7 +77,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 
 void update_vsyscall(struct timekeeper *tk)
 {
-	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	struct vdso_data *vdata = vdso_k_time_data;
 	struct vdso_timestamp *vdso_ts;
 	s32 clock_mode;
 	u64 nsec;
@@ -128,7 +128,7 @@ void update_vsyscall(struct timekeeper *tk)
 
 void update_vsyscall_tz(void)
 {
-	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	struct vdso_data *vdata = vdso_k_time_data;
 
 	vdata[CS_HRES_COARSE].tz_minuteswest = sys_tz.tz_minuteswest;
 	vdata[CS_HRES_COARSE].tz_dsttime = sys_tz.tz_dsttime;
@@ -150,7 +150,7 @@ void update_vsyscall_tz(void)
  */
 unsigned long vdso_update_begin(void)
 {
-	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	struct vdso_data *vdata = vdso_k_time_data;
 	unsigned long flags = timekeeper_lock_irqsave();
 
 	vdso_write_begin(vdata);
@@ -167,7 +167,7 @@ unsigned long vdso_update_begin(void)
  */
 void vdso_update_end(unsigned long flags)
 {
-	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	struct vdso_data *vdata = vdso_k_time_data;
 
 	vdso_write_end(vdata);
 	__arch_sync_vdso_data(vdata);
diff --git a/lib/Makefile b/lib/Makefile
index a8155c972f02856fcc61ee949ddda436cfe211ff..4d545968b3074a2bb3f03d98d1bde572e2a32887 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -132,7 +132,7 @@ endif
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
-obj-y += math/ crypto/
+obj-y += math/ crypto/ vdso/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 82fe827af5426d8b644bff00e9097e3228d0ebaa..45df764b49ad62479e6456e00c053e46131936a3 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -43,3 +43,8 @@ config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
+
+config GENERIC_VDSO_DATA_STORE
+	bool
+	help
+	  Selected by architectures that use the generic vDSO data store.
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..aedd40aaa950c86f1454d095d9d46992b0cc0abd
--- /dev/null
+++ b/lib/vdso/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) += datastore.o
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
new file mode 100644
index 0000000000000000000000000000000000000000..d3181768424cc3ee2e980bd537ac5ca14dfcb304
--- /dev/null
+++ b/lib/vdso/datastore.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/linkage.h>
+#include <linux/mmap_lock.h>
+#include <linux/mm.h>
+#include <linux/time_namespace.h>
+#include <linux/types.h>
+#include <linux/vdso_datastore.h>
+#include <vdso/datapage.h>
+
+/*
+ * The vDSO data page.
+ */
+#ifdef CONFIG_HAVE_GENERIC_VDSO
+static union vdso_data_store vdso_time_data_store __page_aligned_data;
+struct vdso_time_data *vdso_k_time_data = vdso_time_data_store.data;
+static_assert(sizeof(vdso_time_data_store) == PAGE_SIZE);
+#endif /* CONFIG_HAVE_GENERIC_VDSO */
+
+static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
+			     struct vm_area_struct *vma, struct vm_fault *vmf)
+{
+	struct page *timens_page = find_timens_vvar_page(vma);
+	unsigned long addr, pfn;
+	vm_fault_t err;
+
+	switch (vmf->pgoff) {
+	case VDSO_TIME_PAGE_OFFSET:
+		if (!IS_ENABLED(CONFIG_HAVE_GENERIC_VDSO))
+			return VM_FAULT_SIGBUS;
+		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		if (timens_page) {
+			/*
+			 * Fault in VVAR page too, since it will be accessed
+			 * to get clock data anyway.
+			 */
+			addr = vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
+			err = vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+			pfn = page_to_pfn(timens_page);
+		}
+		break;
+	case VDSO_TIMENS_PAGE_OFFSET:
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
+		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (!IS_ENABLED(CONFIG_TIME_NS) || !timens_page)
+			return VM_FAULT_SIGBUS;
+		pfn = __phys_to_pfn(__pa_symbol(vdso_k_time_data));
+		break;
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+
+	return vmf_insert_pfn(vma, vmf->address, pfn);
+}
+
+const struct vm_special_mapping vdso_vvar_mapping = {
+	.name	= "[vvar]",
+	.fault	= vvar_fault,
+};
+
+struct vm_area_struct *vdso_install_vvar_mapping(struct mm_struct *mm, unsigned long addr)
+{
+	return _install_special_mapping(mm, addr, VDSO_NR_PAGES * PAGE_SIZE,
+					VM_READ | VM_MAYREAD | VM_IO | VM_DONTDUMP | VM_PFNMAP,
+					&vdso_vvar_mapping);
+}
+
+#ifdef CONFIG_TIME_NS
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will be re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma_is_special_mapping(vma, &vdso_vvar_mapping))
+			zap_vma_pages(vma);
+	}
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+
+struct vdso_time_data *arch_get_vdso_data(void *vvar_page)
+{
+	return (struct vdso_time_data *)vvar_page;
+}
+#endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c01eaafd8041916878f3f407f7f4fc3e0a0611ca..20c5b8752fcc81d9a044169b9a3ae534d840ef91 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -5,6 +5,9 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
+/* Bring in default accessors */
+#include <vdso/vsyscall.h>
+
 #ifndef vdso_calc_ns
 
 #ifdef VDSO_DELTA_NOMASK
@@ -69,6 +72,16 @@ static inline bool vdso_cycles_ok(u64 cycles)
 #endif
 
 #ifdef CONFIG_TIME_NS
+
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
+static __always_inline
+const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_time_data *vd)
+{
+	return (void *)vd + PAGE_SIZE;
+}
+#define __arch_get_timens_vdso_data(vd) __arch_get_vdso_u_timens_data(vd)
+#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
+
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
@@ -282,7 +295,7 @@ __cvdso_clock_gettime_data(const struct vdso_data *vd, clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	return __cvdso_clock_gettime_data(__arch_get_vdso_data(), clock, ts);
+	return __cvdso_clock_gettime_data(__arch_get_vdso_u_time_data(), clock, ts);
 }
 
 #ifdef BUILD_VDSO32
@@ -308,7 +321,7 @@ __cvdso_clock_gettime32_data(const struct vdso_data *vd, clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
-	return __cvdso_clock_gettime32_data(__arch_get_vdso_data(), clock, res);
+	return __cvdso_clock_gettime32_data(__arch_get_vdso_u_time_data(), clock, res);
 }
 #endif /* BUILD_VDSO32 */
 
@@ -342,7 +355,7 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	return __cvdso_gettimeofday_data(__arch_get_vdso_data(), tv, tz);
+	return __cvdso_gettimeofday_data(__arch_get_vdso_u_time_data(), tv, tz);
 }
 
 #ifdef VDSO_HAS_TIME
@@ -365,7 +378,7 @@ __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
 
 static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time)
 {
-	return __cvdso_time_data(__arch_get_vdso_data(), time);
+	return __cvdso_time_data(__arch_get_vdso_u_time_data(), time);
 }
 #endif /* VDSO_HAS_TIME */
 
@@ -425,7 +438,7 @@ int __cvdso_clock_getres_data(const struct vdso_data *vd, clockid_t clock,
 static __maybe_unused
 int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 {
-	return __cvdso_clock_getres_data(__arch_get_vdso_data(), clock, res);
+	return __cvdso_clock_getres_data(__arch_get_vdso_u_time_data(), clock, res);
 }
 
 #ifdef BUILD_VDSO32
@@ -451,7 +464,7 @@ __cvdso_clock_getres_time32_data(const struct vdso_data *vd, clockid_t clock,
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
-	return __cvdso_clock_getres_time32_data(__arch_get_vdso_data(),
+	return __cvdso_clock_getres_time32_data(__arch_get_vdso_u_time_data(),
 						clock, res);
 }
 #endif /* BUILD_VDSO32 */

-- 
2.47.1


