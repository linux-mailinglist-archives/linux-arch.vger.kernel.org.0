Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADFCB50CEE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfFXN6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 09:58:19 -0400
Received: from foss.arm.com ([217.140.110.172]:51126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbfFXN6S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 09:58:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E44DC0A;
        Mon, 24 Jun 2019 06:58:17 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77423F7BE;
        Mon, 24 Jun 2019 06:58:14 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:58:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
Message-ID: <20190624135812.GC29120@arrakis.emea.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-5-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 10:52:31AM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 947e39896e28..9e4b7ccbab2f 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -25,13 +25,13 @@
>  #include <linux/kvm_host.h>
>  #include <linux/preempt.h>
>  #include <linux/suspend.h>
> +#include <vdso/datapage.h>
>  #include <asm/cpufeature.h>
>  #include <asm/fixmap.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
> -#include <asm/vdso_datapage.h>
>  #include <linux/kbuild.h>
>  #include <linux/arm-smccc.h>
>  
> @@ -100,17 +100,28 @@ int main(void)
>    DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
>    DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
>    BLANK();
> -  DEFINE(VDSO_CS_CYCLE_LAST,	offsetof(struct vdso_data, cs_cycle_last));
> -  DEFINE(VDSO_RAW_TIME_SEC,	offsetof(struct vdso_data, raw_time_sec));
> -  DEFINE(VDSO_XTIME_CLK_SEC,	offsetof(struct vdso_data, xtime_clock_sec));
> -  DEFINE(VDSO_XTIME_CRS_SEC,	offsetof(struct vdso_data, xtime_coarse_sec));
> -  DEFINE(VDSO_XTIME_CRS_NSEC,	offsetof(struct vdso_data, xtime_coarse_nsec));
> -  DEFINE(VDSO_WTM_CLK_SEC,	offsetof(struct vdso_data, wtm_clock_sec));
> -  DEFINE(VDSO_TB_SEQ_COUNT,	offsetof(struct vdso_data, tb_seq_count));
> -  DEFINE(VDSO_CS_MONO_MULT,	offsetof(struct vdso_data, cs_mono_mult));
> -  DEFINE(VDSO_CS_SHIFT,		offsetof(struct vdso_data, cs_shift));
> +  DEFINE(VDSO_SEQ,		offsetof(struct vdso_data, seq));
> +  DEFINE(VDSO_CLK_MODE,		offsetof(struct vdso_data, clock_mode));
> +  DEFINE(VDSO_CYCLE_LAST,	offsetof(struct vdso_data, cycle_last));
> +  DEFINE(VDSO_MASK,		offsetof(struct vdso_data, mask));
> +  DEFINE(VDSO_MULT,		offsetof(struct vdso_data, mult));
> +  DEFINE(VDSO_SHIFT,		offsetof(struct vdso_data, shift));
> +  DEFINE(VDSO_REALTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].sec));
> +  DEFINE(VDSO_REALTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].nsec));
> +  DEFINE(VDSO_MONO_SEC,		offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].sec));
> +  DEFINE(VDSO_MONO_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].nsec));
> +  DEFINE(VDSO_MONO_RAW_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].sec));
> +  DEFINE(VDSO_MONO_RAW_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].nsec));
> +  DEFINE(VDSO_BOOTTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].sec));
> +  DEFINE(VDSO_BOOTTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].nsec));
> +  DEFINE(VDSO_TAI_SEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].sec));
> +  DEFINE(VDSO_TAI_NSEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].nsec));
> +  DEFINE(VDSO_RT_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].sec));
> +  DEFINE(VDSO_RT_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].nsec));
> +  DEFINE(VDSO_MONO_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].sec));
> +  DEFINE(VDSO_MONO_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].nsec));
>    DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
> -  DEFINE(VDSO_USE_SYSCALL,	offsetof(struct vdso_data, use_syscall));
> +  DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
>    BLANK();
>    DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
>    DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));

Now that we are moving this to C, do we actually need the asm-offsets?
If not, here's a clean-up patch:

---------------8<--------------------------------------
From 7e818178a8b225b522fe547cf00ba8508d4cdcf0 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 24 Jun 2019 14:12:48 +0100
Subject: [PATCH] arm64: vdso: Remove unnecessary asm-offsets.c definitions

Since the VDSO code is moving to C from assembly, there is no need to
define and maintain the corresponding asm offsets.

Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/asm-offsets.c | 39 ---------------------------------
 1 file changed, 39 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index e6f7409a78a4..214685760e1c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -14,7 +14,6 @@
 #include <linux/kvm_host.h>
 #include <linux/preempt.h>
 #include <linux/suspend.h>
-#include <vdso/datapage.h>
 #include <asm/cpufeature.h>
 #include <asm/fixmap.h>
 #include <asm/thread_info.h>
@@ -86,44 +85,6 @@ int main(void)
   BLANK();
   DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
   BLANK();
-  DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
-  DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
-  DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-  DEFINE(CLOCK_REALTIME_RES,	offsetof(struct vdso_data, hrtimer_res));
-  DEFINE(CLOCK_REALTIME_COARSE,	CLOCK_REALTIME_COARSE);
-  DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
-  DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
-  DEFINE(NSEC_PER_SEC,		NSEC_PER_SEC);
-  BLANK();
-  DEFINE(VDSO_SEQ,		offsetof(struct vdso_data, seq));
-  DEFINE(VDSO_CLK_MODE,		offsetof(struct vdso_data, clock_mode));
-  DEFINE(VDSO_CYCLE_LAST,	offsetof(struct vdso_data, cycle_last));
-  DEFINE(VDSO_MASK,		offsetof(struct vdso_data, mask));
-  DEFINE(VDSO_MULT,		offsetof(struct vdso_data, mult));
-  DEFINE(VDSO_SHIFT,		offsetof(struct vdso_data, shift));
-  DEFINE(VDSO_REALTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].sec));
-  DEFINE(VDSO_REALTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME].nsec));
-  DEFINE(VDSO_MONO_SEC,		offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].sec));
-  DEFINE(VDSO_MONO_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC].nsec));
-  DEFINE(VDSO_MONO_RAW_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].sec));
-  DEFINE(VDSO_MONO_RAW_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_RAW].nsec));
-  DEFINE(VDSO_BOOTTIME_SEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].sec));
-  DEFINE(VDSO_BOOTTIME_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_BOOTTIME].nsec));
-  DEFINE(VDSO_TAI_SEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].sec));
-  DEFINE(VDSO_TAI_NSEC,		offsetof(struct vdso_data, basetime[CLOCK_TAI].nsec));
-  DEFINE(VDSO_RT_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].sec));
-  DEFINE(VDSO_RT_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_REALTIME_COARSE].nsec));
-  DEFINE(VDSO_MONO_COARSE_SEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].sec));
-  DEFINE(VDSO_MONO_COARSE_NSEC,	offsetof(struct vdso_data, basetime[CLOCK_MONOTONIC_COARSE].nsec));
-  DEFINE(VDSO_TZ_MINWEST,	offsetof(struct vdso_data, tz_minuteswest));
-  DEFINE(VDSO_TZ_DSTTIME,	offsetof(struct vdso_data, tz_dsttime));
-  BLANK();
-  DEFINE(TVAL_TV_SEC,		offsetof(struct timeval, tv_sec));
-  DEFINE(TSPEC_TV_SEC,		offsetof(struct timespec, tv_sec));
-  BLANK();
-  DEFINE(TZ_MINWEST,		offsetof(struct timezone, tz_minuteswest));
-  DEFINE(TZ_DSTTIME,		offsetof(struct timezone, tz_dsttime));
-  BLANK();
   DEFINE(CPU_BOOT_STACK,	offsetof(struct secondary_data, stack));
   DEFINE(CPU_BOOT_TASK,		offsetof(struct secondary_data, task));
   BLANK();
