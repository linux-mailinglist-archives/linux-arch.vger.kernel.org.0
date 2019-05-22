Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACED5262BE
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2019 13:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfEVLHq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 07:07:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48154 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727464AbfEVLHq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 May 2019 07:07:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D472715BF;
        Wed, 22 May 2019 04:07:45 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AC9C3F575;
        Wed, 22 May 2019 04:07:43 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/3] s390: Fix vDSO clock_getres()
Date:   Wed, 22 May 2019 12:07:21 +0100
Message-Id: <20190522110722.28094-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522110722.28094-1-vincenzo.frascino@arm.com>
References: <20190522110722.28094-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

Fix the s390 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

Note: This patch is independent from the others in this series, hence it
can be merged singularly by the s390 maintainers.

 arch/s390/include/asm/vdso.h           |  1 +
 arch/s390/kernel/asm-offsets.c         |  2 +-
 arch/s390/kernel/time.c                |  1 +
 arch/s390/kernel/vdso32/clock_getres.S | 12 +++++++-----
 arch/s390/kernel/vdso64/clock_getres.S | 10 +++++-----
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 169d7604eb80..f3ba84fa9bd1 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -36,6 +36,7 @@ struct vdso_data {
 	__u32 tk_shift;			/* Shift used for xtime_nsec	0x60 */
 	__u32 ts_dir;			/* TOD steering direction	0x64 */
 	__u64 ts_end;			/* TOD steering end		0x68 */
+	__u32 hrtimer_res;		/* hrtimer resolution		0x70 */
 };
 
 struct vdso_per_cpu_data {
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 41ac4ad21311..4a229a60b24a 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -76,6 +76,7 @@ int main(void)
 	OFFSET(__VDSO_TK_SHIFT, vdso_data, tk_shift);
 	OFFSET(__VDSO_TS_DIR, vdso_data, ts_dir);
 	OFFSET(__VDSO_TS_END, vdso_data, ts_end);
+	OFFSET(__VDSO_CLOCK_REALTIME_RES, vdso_data, hrtimer_res);
 	OFFSET(__VDSO_ECTG_BASE, vdso_per_cpu_data, ectg_timer_base);
 	OFFSET(__VDSO_ECTG_USER, vdso_per_cpu_data, ectg_user_time);
 	OFFSET(__VDSO_CPU_NR, vdso_per_cpu_data, cpu_nr);
@@ -87,7 +88,6 @@ int main(void)
 	DEFINE(__CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(__CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
 	DEFINE(__CLOCK_THREAD_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID);
-	DEFINE(__CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 	DEFINE(__CLOCK_COARSE_RES, LOW_RES_NSEC);
 	BLANK();
 	/* idle data offsets */
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e8766beee5ad..8ea9db599d38 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -310,6 +310,7 @@ void update_vsyscall(struct timekeeper *tk)
 
 	vdso_data->tk_mult = tk->tkr_mono.mult;
 	vdso_data->tk_shift = tk->tkr_mono.shift;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	smp_wmb();
 	++vdso_data->tb_update_count;
 }
diff --git a/arch/s390/kernel/vdso32/clock_getres.S b/arch/s390/kernel/vdso32/clock_getres.S
index eaf9cf1417f6..fecd7684c645 100644
--- a/arch/s390/kernel/vdso32/clock_getres.S
+++ b/arch/s390/kernel/vdso32/clock_getres.S
@@ -18,20 +18,22 @@
 __kernel_clock_getres:
 	CFI_STARTPROC
 	basr	%r1,0
-	la	%r1,4f-.(%r1)
+10:	al	%r1,4f-10b(%r1)
+	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
 	chi	%r2,__CLOCK_REALTIME
 	je	0f
 	chi	%r2,__CLOCK_MONOTONIC
 	je	0f
-	la	%r1,5f-4f(%r1)
+	basr	%r1,0
+	la	%r1,5f-.(%r1)
+	l	%r0,0(%r1)
 	chi	%r2,__CLOCK_REALTIME_COARSE
 	je	0f
 	chi	%r2,__CLOCK_MONOTONIC_COARSE
 	jne	3f
 0:	ltr	%r3,%r3
 	jz	2f				/* res == NULL */
-1:	l	%r0,0(%r1)
-	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
+1:	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
 	st	%r0,4(%r3)			/* store tp->tv_usec */
 2:	lhi	%r2,0
 	br	%r14
@@ -39,6 +41,6 @@ __kernel_clock_getres:
 	svc	0
 	br	%r14
 	CFI_ENDPROC
-4:	.long	__CLOCK_REALTIME_RES
+4:	.long	_vdso_data - 10b
 5:	.long	__CLOCK_COARSE_RES
 	.size	__kernel_clock_getres,.-__kernel_clock_getres
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
index 081435398e0a..022b58c980db 100644
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ b/arch/s390/kernel/vdso64/clock_getres.S
@@ -17,12 +17,14 @@
 	.type  __kernel_clock_getres,@function
 __kernel_clock_getres:
 	CFI_STARTPROC
-	larl	%r1,4f
+	larl	%r1,3f
+	lg	%r0,0(%r1)
 	cghi	%r2,__CLOCK_REALTIME_COARSE
 	je	0f
 	cghi	%r2,__CLOCK_MONOTONIC_COARSE
 	je	0f
-	larl	%r1,3f
+	larl	%r1,_vdso_data
+	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
 	cghi	%r2,__CLOCK_REALTIME
 	je	0f
 	cghi	%r2,__CLOCK_MONOTONIC
@@ -36,7 +38,6 @@ __kernel_clock_getres:
 	jz	2f
 0:	ltgr	%r3,%r3
 	jz	1f				/* res == NULL */
-	lg	%r0,0(%r1)
 	xc	0(8,%r3),0(%r3)			/* set tp->tv_sec to zero */
 	stg	%r0,8(%r3)			/* store tp->tv_usec */
 1:	lghi	%r2,0
@@ -45,6 +46,5 @@ __kernel_clock_getres:
 	svc	0
 	br	%r14
 	CFI_ENDPROC
-3:	.quad	__CLOCK_REALTIME_RES
-4:	.quad	__CLOCK_COARSE_RES
+3:	.quad	__CLOCK_COARSE_RES
 	.size	__kernel_clock_getres,.-__kernel_clock_getres
-- 
2.21.0

