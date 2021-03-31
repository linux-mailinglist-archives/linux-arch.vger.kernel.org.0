Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F03350504
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 18:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhCaQtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 12:49:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33163 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234318AbhCaQsr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 12:48:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9XMK1TsBz9txhf;
        Wed, 31 Mar 2021 18:48:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ELWGhG3Z_Itz; Wed, 31 Mar 2021 18:48:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9XMK0lYcz9txhd;
        Wed, 31 Mar 2021 18:48:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E4738B828;
        Wed, 31 Mar 2021 18:48:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wSrNiVss83ou; Wed, 31 Mar 2021 18:48:46 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CF3078B80D;
        Wed, 31 Mar 2021 18:48:45 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A659967641; Wed, 31 Mar 2021 16:48:45 +0000 (UTC)
Message-Id: <539c4204b1baa77c55f758904a1ea239abbc7a5c.1617209142.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1617209141.git.christophe.leroy@csgroup.eu>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH RESEND v1 2/4] lib/vdso: Add vdso_data pointer as input to
 __arch_get_timens_vdso_data()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, avagin@gmail.com, arnd@arndb.de,
        tglx@linutronix.de, vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Date:   Wed, 31 Mar 2021 16:48:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For the same reason as commit e876f0b69dc9 ("lib/vdso: Allow
architectures to provide the vdso data pointer"), powerpc wants to
avoid calculation of relative position to code.

As the timens_vdso_data is next page to vdso_data, provide
vdso_data pointer to __arch_get_timens_vdso_data() in order
to ease the calculation on powerpc in following patches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  3 ++-
 arch/arm64/include/asm/vdso/gettimeofday.h        |  2 +-
 arch/s390/include/asm/vdso/gettimeofday.h         |  3 ++-
 arch/x86/include/asm/vdso/gettimeofday.h          |  3 ++-
 lib/vdso/gettimeofday.c                           | 15 +++++++++------
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 7508b0ac1d21..ecb6fd4c3c64 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -155,7 +155,8 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 }
 
 #ifdef CONFIG_TIME_NS
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	const struct vdso_data *ret;
 
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index 631ab1281633..de86230a9436 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -100,7 +100,7 @@ const struct vdso_data *__arch_get_vdso_data(void)
 
 #ifdef CONFIG_TIME_NS
 static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(void)
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return _timens_data;
 }
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/asm/vdso/gettimeofday.h
index ed89ef742530..383c53c3dddd 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -68,7 +68,8 @@ long clock_getres_fallback(clockid_t clkid, struct __kernel_timespec *ts)
 }
 
 #ifdef CONFIG_TIME_NS
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return _timens_data;
 }
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index df01d7349d79..1936f21ed8cd 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -58,7 +58,8 @@ extern struct ms_hyperv_tsc_page hvclock_page
 #endif
 
 #ifdef CONFIG_TIME_NS
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return __timens_vdso_data;
 }
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c6f6dee08746..ce2f69552003 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -49,13 +49,15 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_data *vd;
 	const struct timens_offset *offs = &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
 	u64 cycles, last, ns;
 	u32 seq;
 	s64 sec;
 
+	vd = vdns - (clk == CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
+	vd = __arch_get_timens_vdso_data(vd);
 	if (clk != CLOCK_MONOTONIC_RAW)
 		vd = &vd[CS_HRES_COARSE];
 	else
@@ -92,7 +94,8 @@ static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_
 	return 0;
 }
 #else
-static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
+static __always_inline
+const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
 	return NULL;
 }
@@ -162,7 +165,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 static __always_inline int do_coarse_timens(const struct vdso_data *vdns, clockid_t clk,
 					    struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd = __arch_get_timens_vdso_data();
+	const struct vdso_data *vd = __arch_get_timens_vdso_data(vdns);
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
 	const struct timens_offset *offs = &vdns->offset[clk];
 	u64 nsec;
@@ -310,7 +313,7 @@ __cvdso_gettimeofday_data(const struct vdso_data *vd,
 	if (unlikely(tz != NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
 		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-			vd = __arch_get_timens_vdso_data();
+			vd = __arch_get_timens_vdso_data(vd);
 
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
 		tz->tz_dsttime = vd[CS_HRES_COARSE].tz_dsttime;
@@ -333,7 +336,7 @@ __cvdso_time_data(const struct vdso_data *vd, __kernel_old_time_t *time)
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		vd = __arch_get_timens_vdso_data();
+		vd = __arch_get_timens_vdso_data(vd);
 
 	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
@@ -363,7 +366,7 @@ int __cvdso_clock_getres_common(const struct vdso_data *vd, clockid_t clock,
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		vd = __arch_get_timens_vdso_data();
+		vd = __arch_get_timens_vdso_data(vd);
 
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
-- 
2.25.0

