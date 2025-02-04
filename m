Return-Path: <linux-arch+bounces-10003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D8A27176
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26007A072D
	for <lists+linux-arch@lfdr.de>; Tue,  4 Feb 2025 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24B215F5D;
	Tue,  4 Feb 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3KQjj7F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NnSSJe0H"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5D20D4F7;
	Tue,  4 Feb 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670784; cv=none; b=NDQ+aewTPiqcmHOczwhE1zKJwXWPJ82y7dCj3M9zcw84uRwm5KwQPNWj5RzlXfb0h3DPkjIfPVEoJyPsf5HxLlrAx3FNQKAdbR/FnN/JWOt09c1cg4FjvKkxneorvyD/PE6jKHSqrUds78QZik/shvGFHqTvPtouM4rzTdjZ2Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670784; c=relaxed/simple;
	bh=Mn4plfh6miiiQwOwjuqlkuZn2mXyEfEFTkWg4rVIUvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jm7u84ZtAhU44CfHhLeLXrfz/iFpzmGX1bN7/yJDfwtDQGziTIpEnHGEkssU625YXPL//rqN2iccjvchdigk6BquEoc5Zm1pUB2aIG/2A9Pe3CdwB/E6yVYTrsWcPXy3hDYf1jestjVKY7ycvr4LBAsSXEMOSbwZHfRKX3OMfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3KQjj7F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NnSSJe0H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJev7qc7WdPVC3bh+c7TDU1+3X+PYPS1LUdYMSm0CD8=;
	b=A3KQjj7Fwe7wakZDkLehTYhSC5nkWkEHH0hhtsjbB+r9k97rQn3FwydvMCGd6BbAyLMRzf
	KV4TZbxNW5cCrbObFgsrggESO2EKMlOH9qWxzSZxl6V6LptgThlQyuwtBQE2qUx0aVWT8t
	g3uI+nj89ANucwU1tBLcX4CoQOKuL5t9d7NGX0b0z+c6qqh/NjmmwXa1RJwXIKhgp7IJ52
	UTHQk8l92CQ9+0bJ1ETfl2BrV26qq9LoSmmgft2BkWduHq0kSVD2X1xTbGXtzXQco5dMSm
	r7z4iMpkrisO6PTs8TOU3P4CI/+R2ABAZf54eIHRtiEgbdtabKIjhWtV8IAjpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJev7qc7WdPVC3bh+c7TDU1+3X+PYPS1LUdYMSm0CD8=;
	b=NnSSJe0HiScvZ2Gv9ROIRuD3jYq64XJ1NHoDd9K7TMRzfkV6+7Sxivt4+v21CwncIpJpgC
	uduhfAtv6MELApBw==
Date: Tue, 04 Feb 2025 13:05:50 +0100
Subject: [PATCH v3 18/18] vdso: Remove remnants of architecture-specific
 time storage
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-vdso-store-rng-v3-18-13a4669dfc8c@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=19961;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Mn4plfh6miiiQwOwjuqlkuZn2mXyEfEFTkWg4rVIUvk=;
 b=9k3ySPEmjAbpr2ATbvTSurlSePqoJ4TQiU/CWBgKiO0hwreklF4CY++q17CLxw3qPdu9xG1sy
 AaBFFBPGqobDQeWAdeeAGUIJXJih23jdit0P2NNBW0hzdHU2P+nmdPZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

All users of the random vDSO are using the generic storage
implementation. Remove the now unnecessary compatibility accessor
functions and symbols.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/vdso/vsyscall.h | 20 +++------------
 include/linux/time_namespace.h      |  3 ---
 include/vdso/datapage.h             | 19 +-------------
 include/vdso/helpers.h              |  8 +++---
 kernel/time/namespace.c             | 12 ++++-----
 kernel/time/vsyscall.c              | 19 +++++++-------
 lib/vdso/datastore.c                | 10 +++-----
 lib/vdso/gettimeofday.c             | 51 ++++++++++++++++++-------------------
 8 files changed, 53 insertions(+), 89 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 13e2ac3736ee9b4aea6800117997ee165a7e2b9d..1fb3000f50364feeaaa9348d438b3ab8091bb265 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -20,31 +20,19 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(vo
 }
 #endif
 
-#else  /* !CONFIG_GENERIC_VDSO_DATA_STORE */
-
-#ifndef __arch_get_k_vdso_data
-static __always_inline struct vdso_data *__arch_get_k_vdso_data(void)
-{
-	return NULL;
-}
-#endif /* __arch_get_k_vdso_data */
-#define vdso_k_time_data __arch_get_k_vdso_data()
-
-#define __arch_get_vdso_u_time_data __arch_get_vdso_data
-
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
 #ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
+static __always_inline void __arch_update_vsyscall(struct vdso_time_data *vdata)
 {
 }
 #endif /* __arch_update_vsyscall */
 
-#ifndef __arch_sync_vdso_data
-static __always_inline void __arch_sync_vdso_data(struct vdso_data *vdata)
+#ifndef __arch_sync_vdso_time_data
+static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
 }
-#endif /* __arch_sync_vdso_data */
+#endif /* __arch_sync_vdso_time_data */
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 4b81db223f5450218dfaf553b24195be9ba97c08..0b8b32bf0655109d368c5dacc23ca5efcbb5aa80 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -8,7 +8,6 @@
 #include <linux/ns_common.h>
 #include <linux/err.h>
 #include <linux/time64.h>
-#include <vdso/datapage.h>
 
 struct user_namespace;
 extern struct user_namespace init_user_ns;
@@ -166,6 +165,4 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 #endif
 
-struct vdso_data *arch_get_vdso_data(void *vvar_page);
-
 #endif /* _LINUX_TIMENS_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 497907c3aa11fcae913f62ef7373bbe6a1026bd6..ed4fb4c06e3ee6423fe68ccb476565213f234863 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -128,8 +128,6 @@ struct vdso_time_data {
 	struct arch_vdso_time_data arch_data;
 };
 
-#define vdso_data vdso_time_data
-
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds
@@ -149,10 +147,7 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-#ifndef CONFIG_GENERIC_VDSO_DATA_STORE
-extern struct vdso_time_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
-extern struct vdso_time_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
-#else
+#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hidden")));
@@ -160,17 +155,6 @@ extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hidden"
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
 extern struct vdso_arch_data *vdso_k_arch_data;
-#endif
-
-/**
- * union vdso_data_store - Generic vDSO data page
- */
-union vdso_data_store {
-	struct vdso_time_data	data[CS_BASES];
-	u8			page[1U << CONFIG_PAGE_SHIFT];
-};
-
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 
 #define VDSO_ARCH_DATA_SIZE ALIGN(sizeof(struct vdso_arch_data), PAGE_SIZE)
 #define VDSO_ARCH_DATA_PAGES (VDSO_ARCH_DATA_SIZE >> PAGE_SHIFT)
@@ -189,7 +173,6 @@ enum vdso_pages {
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
- * - __arch_get_vdso_data(): to get the vdso datapage.
  * - __arch_get_hw_counter(): to get the hw counter based on the
  *   clock_mode.
  * - gettimeofday_fallback(): fallback for gettimeofday.
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 3ddb03bb05cbeefc110adf0e672c2cd68848a0ae..41c3087070c7ab21d7adec04e6cd30c4b32ea221 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -7,7 +7,7 @@
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
 
-static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
+static __always_inline u32 vdso_read_begin(const struct vdso_time_data *vd)
 {
 	u32 seq;
 
@@ -18,7 +18,7 @@ static __always_inline u32 vdso_read_begin(const struct vdso_data *vd)
 	return seq;
 }
 
-static __always_inline u32 vdso_read_retry(const struct vdso_data *vd,
+static __always_inline u32 vdso_read_retry(const struct vdso_time_data *vd,
 					   u32 start)
 {
 	u32 seq;
@@ -28,7 +28,7 @@ static __always_inline u32 vdso_read_retry(const struct vdso_data *vd,
 	return seq != start;
 }
 
-static __always_inline void vdso_write_begin(struct vdso_data *vd)
+static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
@@ -40,7 +40,7 @@ static __always_inline void vdso_write_begin(struct vdso_data *vd)
 	smp_wmb();
 }
 
-static __always_inline void vdso_write_end(struct vdso_data *vd)
+static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
 	smp_wmb();
 	/*
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 0775b9ec952af9639480db9480d06d12293d1ceb..12f55aa539adbc11cce4055f519dbeca8a73320c 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -165,18 +165,18 @@ static struct timens_offset offset_from_ts(struct timespec64 off)
  *     HVCLOCK
  *     VVAR
  *
- * The check for vdso_data->clock_mode is in the unlikely path of
+ * The check for vdso_time_data->clock_mode is in the unlikely path of
  * the seq begin magic. So for the non-timens case most of the time
  * 'seq' is even, so the branch is not taken.
  *
  * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
- * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
+ * for vdso_time_data->clock_mode is a non-issue. The task is spin waiting for the
  * update to finish and for 'seq' to become even anyway.
  *
- * Timens page has vdso_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
+ * Timens page has vdso_time_data->clock_mode set to VDSO_CLOCKMODE_TIMENS which
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_data(struct vdso_data *vdata,
+static void timens_setup_vdso_data(struct vdso_time_data *vdata,
 				   struct time_namespace *ns)
 {
 	struct timens_offset *offset = vdata->offset;
@@ -219,7 +219,7 @@ static DEFINE_MUTEX(offset_lock);
 static void timens_set_vvar_page(struct task_struct *task,
 				struct time_namespace *ns)
 {
-	struct vdso_data *vdata;
+	struct vdso_time_data *vdata;
 	unsigned int i;
 
 	if (ns == &init_time_ns)
@@ -235,7 +235,7 @@ static void timens_set_vvar_page(struct task_struct *task,
 		goto out;
 
 	ns->frozen_offsets = true;
-	vdata = arch_get_vdso_data(page_address(ns->vvar_page));
+	vdata = page_address(ns->vvar_page);
 
 	for (i = 0; i < CS_BASES; i++)
 		timens_setup_vdso_data(&vdata[i], ns);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 09c1e39a6dd8e24aa161982c04078e78d52fa737..418192296ef7dd3c1772d50f129e7838883cf00c 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -15,8 +15,7 @@
 
 #include "timekeeping_internal.h"
 
-static inline void update_vdso_data(struct vdso_data *vdata,
-				    struct timekeeper *tk)
+static inline void update_vdso_time_data(struct vdso_time_data *vdata, struct timekeeper *tk)
 {
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec, sec;
@@ -77,7 +76,7 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 
 void update_vsyscall(struct timekeeper *tk)
 {
-	struct vdso_data *vdata = vdso_k_time_data;
+	struct vdso_time_data *vdata = vdso_k_time_data;
 	struct vdso_timestamp *vdso_ts;
 	s32 clock_mode;
 	u64 nsec;
@@ -117,23 +116,23 @@ void update_vsyscall(struct timekeeper *tk)
 	 * update of the high resolution parts.
 	 */
 	if (clock_mode != VDSO_CLOCKMODE_NONE)
-		update_vdso_data(vdata, tk);
+		update_vdso_time_data(vdata, tk);
 
 	__arch_update_vsyscall(vdata);
 
 	vdso_write_end(vdata);
 
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 }
 
 void update_vsyscall_tz(void)
 {
-	struct vdso_data *vdata = vdso_k_time_data;
+	struct vdso_time_data *vdata = vdso_k_time_data;
 
 	vdata[CS_HRES_COARSE].tz_minuteswest = sys_tz.tz_minuteswest;
 	vdata[CS_HRES_COARSE].tz_dsttime = sys_tz.tz_dsttime;
 
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 }
 
 /**
@@ -150,7 +149,7 @@ void update_vsyscall_tz(void)
  */
 unsigned long vdso_update_begin(void)
 {
-	struct vdso_data *vdata = vdso_k_time_data;
+	struct vdso_time_data *vdata = vdso_k_time_data;
 	unsigned long flags = timekeeper_lock_irqsave();
 
 	vdso_write_begin(vdata);
@@ -167,9 +166,9 @@ unsigned long vdso_update_begin(void)
  */
 void vdso_update_end(unsigned long flags)
 {
-	struct vdso_data *vdata = vdso_k_time_data;
+	struct vdso_time_data *vdata = vdso_k_time_data;
 
 	vdso_write_end(vdata);
-	__arch_sync_vdso_data(vdata);
+	__arch_sync_vdso_time_data(vdata);
 	timekeeper_unlock_irqrestore(flags);
 }
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 0959d62d78586ef458eb5f7c1e152f6b5d4cbf85..e227fbbcb79694f9a40606ac864f52cf1fdbfcf4 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -12,7 +12,10 @@
  * The vDSO data page.
  */
 #ifdef CONFIG_HAVE_GENERIC_VDSO
-static union vdso_data_store vdso_time_data_store __page_aligned_data;
+static union {
+	struct vdso_time_data	data[CS_BASES];
+	u8			page[PAGE_SIZE];
+} vdso_time_data_store __page_aligned_data;
 struct vdso_time_data *vdso_k_time_data = vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) == PAGE_SIZE);
 #endif /* CONFIG_HAVE_GENERIC_VDSO */
@@ -123,9 +126,4 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 
 	return 0;
 }
-
-struct vdso_time_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_time_data *)vvar_page;
-}
 #endif
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 20c5b8752fcc81d9a044169b9a3ae534d840ef91..299f027116ee0e50a69c5a8a17218004e4af0ea1 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -17,12 +17,12 @@
 #endif
 
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 delta)
+static __always_inline bool vdso_delta_ok(const struct vdso_time_data *vd, u64 delta)
 {
 	return delta < vd->max_cycles;
 }
 #else
-static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 delta)
+static __always_inline bool vdso_delta_ok(const struct vdso_time_data *vd, u64 delta)
 {
 	return true;
 }
@@ -39,7 +39,7 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64 cycles, u64 base)
 {
 	u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
 
@@ -58,7 +58,7 @@ static inline bool __arch_vdso_hres_capable(void)
 #endif
 
 #ifndef vdso_clocksource_ok
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return vd->clock_mode != VDSO_CLOCKMODE_NONE;
 }
@@ -79,21 +79,20 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
 {
 	return (void *)vd + PAGE_SIZE;
 }
-#define __arch_get_timens_vdso_data(vd) __arch_get_vdso_u_timens_data(vd)
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
-static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+static __always_inline int do_hres_timens(const struct vdso_time_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
 	const struct timens_offset *offs = &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_data *vd;
+	const struct vdso_time_data *vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
 
 	vd = vdns - (clk == CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
-	vd = __arch_get_timens_vdso_data(vd);
+	vd = __arch_get_vdso_u_timens_data(vd);
 	if (clk != CLOCK_MONOTONIC_RAW)
 		vd = &vd[CS_HRES_COARSE];
 	else
@@ -128,19 +127,19 @@ static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_
 }
 #else
 static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
+const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_time_data *vd)
 {
 	return NULL;
 }
 
-static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
+static __always_inline int do_hres_timens(const struct vdso_time_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
 	return -EINVAL;
 }
 #endif
 
-static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
+static __always_inline int do_hres(const struct vdso_time_data *vd, clockid_t clk,
 				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -192,10 +191,10 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 }
 
 #ifdef CONFIG_TIME_NS
-static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+static __always_inline int do_coarse_timens(const struct vdso_time_data *vdns, clockid_t clk,
 					    struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_timens_vdso_data(vdns);
+	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	const struct timens_offset *offs = &vdns->offset[clk];
 	u64 nsec;
@@ -221,14 +220,14 @@ static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clocki
 	return 0;
 }
 #else
-static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
+static __always_inline int do_coarse_timens(const struct vdso_time_data *vdns, clockid_t clk,
 					    struct __kernel_timespec *ts)
 {
 	return -1;
 }
 #endif
 
-static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
+static __always_inline int do_coarse(const struct vdso_time_data *vd, clockid_t clk,
 				     struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
@@ -255,7 +254,7 @@ static __always_inline int do_coarse(const struct vdso_data *vd, clockid_t clk,
 }
 
 static __always_inline int
-__cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
 {
 	u32 msk;
@@ -282,7 +281,7 @@ __cvdso_clock_gettime_common(const struct vdso_data *vd, clockid_t clock,
 }
 
 static __maybe_unused int
-__cvdso_clock_gettime_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
 	int ret = __cvdso_clock_gettime_common(vd, clock, ts);
@@ -300,7 +299,7 @@ __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_gettime32_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_gettime32_data(const struct vdso_time_data *vd, clockid_t clock,
 			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
@@ -326,7 +325,7 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 #endif /* BUILD_VDSO32 */
 
 static __maybe_unused int
-__cvdso_gettimeofday_data(const struct vdso_data *vd,
+__cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
 
@@ -343,7 +342,7 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 	if (unlikely(tz != NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
 		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-			vd = __arch_get_timens_vdso_data(vd);
+			vd = __arch_get_vdso_u_timens_data(vd);
 
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
@@ -360,13 +359,13 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 
 #ifdef VDSO_HAS_TIME
 static __maybe_unused __kernel_old_time_t
-__cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
+__cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
 	__kernel_old_time_t t;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		vd = __arch_get_timens_vdso_data(vd);
+		vd = __arch_get_vdso_u_timens_data(vd);
 
 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
@@ -384,7 +383,7 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time
 
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
+int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock,
 				struct __kernel_timespec *res)
 {
 	u32 msk;
@@ -396,7 +395,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		vd = __arch_get_timens_vdso_data(vd);
+		vd = __arch_get_vdso_u_timens_data(vd);
 
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -425,7 +424,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
 }
 
 static __maybe_unused
-int __cvdso_clock_getres_data(const struct vdso_data *vd, clockid_t clock,
+int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clock,
 			      struct __kernel_timespec *res)
 {
 	int ret = __cvdso_clock_getres_common(vd, clock, res);
@@ -443,7 +442,7 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 
 #ifdef BUILD_VDSO32
 static __maybe_unused int
-__cvdso_clock_getres_time32_data(const struct vdso_data *vd, clockid_t clock,
+__cvdso_clock_getres_time32_data(const struct vdso_time_data *vd, clockid_t clock,
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;

-- 
2.48.1


