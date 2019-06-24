Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100A350D1D
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2019 16:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfFXOAZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jun 2019 10:00:25 -0400
Received: from foss.arm.com ([217.140.110.172]:51272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfFXOAZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jun 2019 10:00:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 051CD344;
        Mon, 24 Jun 2019 07:00:24 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70E373F71E;
        Mon, 24 Jun 2019 07:00:21 -0700 (PDT)
Date:   Mon, 24 Jun 2019 15:00:19 +0100
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
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
Message-ID: <20190624140018.GD29120@arrakis.emea.arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621095252.32307-11-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 10:52:37AM +0100, Vincenzo Frascino wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/compat_barrier.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 ARM Limited
> + */
> +#ifndef __COMPAT_BARRIER_H
> +#define __COMPAT_BARRIER_H
> +
> +#ifndef __ASSEMBLY__
> +/*
> + * Warning: This code is meant to be used with
> + * ENABLE_COMPAT_VDSO only.
> + */
> +#ifndef ENABLE_COMPAT_VDSO
> +#error This header is meant to be used with ENABLE_COMPAT_VDSO only
> +#endif
> +
> +#ifdef dmb
> +#undef dmb
> +#endif
> +
> +#if __LINUX_ARM_ARCH__ >= 7
> +#define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
> +#elif __LINUX_ARM_ARCH__ == 6
> +#define dmb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
> +				    : : "r" (0) : "memory")
> +#else
> +#define dmb(x) __asm__ __volatile__ ("" : : : "memory")
> +#endif

We don't need pre-ARMv7 barriers (they've been deprecated and the arm64
kernel actually traps and emulates them by default). Also your Makefile
changes never define a __LINUX_ARM_ARCH__ lower than 7. Fix-up below:

------8<-----------------------
From 5655a0313ce7bb731bfed6a19bcfe6b1100b542a Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 24 Jun 2019 12:16:06 +0100
Subject: [PATCH] arm64: compat: No need for pre-ARMv7 barriers on an ARMv8
 system

This patch removes the deprecated (pre-ARMv7) compat barriers as they
would not be used on an ARMv8 system.

Fixes: a7f71a2c8903 ("arm64: compat: Add vDSO")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/vdso/compat_barrier.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/include/asm/vdso/compat_barrier.h
index ea24ea856b07..fb60a88b5ed4 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -18,14 +18,7 @@
 #undef dmb
 #endif
 
-#if __LINUX_ARM_ARCH__ >= 7
 #define dmb(option) __asm__ __volatile__ ("dmb " #option : : : "memory")
-#elif __LINUX_ARM_ARCH__ == 6
-#define dmb(x) __asm__ __volatile__ ("mcr p15, 0, %0, c7, c10, 5" \
-				    : : "r" (0) : "memory")
-#else
-#define dmb(x) __asm__ __volatile__ ("" : : : "memory")
-#endif
 
 #if __LINUX_ARM_ARCH__ >= 8
 #define aarch32_smp_mb()	dmb(ish)
