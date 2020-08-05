Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0898423C6A0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgHEHJe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 03:09:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:24596 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgHEHJa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Aug 2020 03:09:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BM2mk02YLz9vD3p;
        Wed,  5 Aug 2020 09:09:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kXUHZnOa37pX; Wed,  5 Aug 2020 09:09:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BM2mj5Zxmz9vD3j;
        Wed,  5 Aug 2020 09:09:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA1538B7E1;
        Wed,  5 Aug 2020 09:09:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xQhmU62iHP7V; Wed,  5 Aug 2020 09:09:26 +0200 (CEST)
Received: from po16052vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D7088B75F;
        Wed,  5 Aug 2020 09:09:26 +0200 (CEST)
Received: by po16052vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 676E865BBD; Wed,  5 Aug 2020 07:09:26 +0000 (UTC)
Message-Id: <32049545671e558b6ef822e0f501a2038c121bf1.1596611196.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1596611196.git.christophe.leroy@csgroup.eu>
References: <cover.1596611196.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v10 5/5] powerpc/vdso: Provide __kernel_clock_gettime64() on
 vdso32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, nathanl@linux.ibm.com,
        anton@ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de, tglx@linutronix.de, vincenzo.frascino@arm.com,
        luto@kernel.org, linux-arch@vger.kernel.org
Date:   Wed,  5 Aug 2020 07:09:26 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provides __kernel_clock_gettime64() on vdso32. This is the
64 bits version of __kernel_clock_gettime() which is
y2038 compliant.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso32/gettimeofday.S  | 9 +++++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S    | 1 +
 arch/powerpc/kernel/vdso32/vgettimeofday.c | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
index fd7b01c51281..a6e29f880e0e 100644
--- a/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -35,6 +35,15 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	cvdso_call __c_kernel_clock_gettime
 V_FUNCTION_END(__kernel_clock_gettime)
 
+/*
+ * Exact prototype of clock_gettime64()
+ *
+ * int __kernel_clock_gettime64(clockid_t clock_id, struct __timespec64 *ts);
+ *
+ */
+V_FUNCTION_BEGIN(__kernel_clock_gettime64)
+	cvdso_call __c_kernel_clock_gettime64
+V_FUNCTION_END(__kernel_clock_gettime64)
 
 /*
  * Exact prototype of clock_getres()
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 4c985467a668..582c5b046cc9 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -148,6 +148,7 @@ VERSION
 #ifndef CONFIG_PPC_BOOK3S_601
 		__kernel_gettimeofday;
 		__kernel_clock_gettime;
+		__kernel_clock_gettime64;
 		__kernel_clock_getres;
 		__kernel_time;
 		__kernel_get_tbfreq;
diff --git a/arch/powerpc/kernel/vdso32/vgettimeofday.c b/arch/powerpc/kernel/vdso32/vgettimeofday.c
index 0b9ab4c22ef2..f7f71fecf4ed 100644
--- a/arch/powerpc/kernel/vdso32/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso32/vgettimeofday.c
@@ -11,6 +11,12 @@ int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
 
+int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
+			       const struct vdso_data *vd)
+{
+	return __cvdso_clock_gettime_data(vd, clock, ts);
+}
+
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz,
 			    const struct vdso_data *vd)
 {
-- 
2.25.0

