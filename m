Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84313A77A
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 11:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgANKiG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 05:38:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANKiG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 05:38:06 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irJaA-000077-9A; Tue, 14 Jan 2020 11:37:58 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7A5D4101DEE; Tue, 14 Jan 2020 11:37:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Subject: Re: [PATCH v2 2/8] lib: vdso: Build 32 bit specific functions in the right context
In-Reply-To: <d0df0900-5001-540e-e246-c87c8525d0a4@arm.com>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com> <20190830135902.20861-3-vincenzo.frascino@arm.com> <87tv4zq9dc.fsf@nanos.tec.linutronix.de> <87r202qt4x.fsf@nanos.tec.linutronix.de> <d0df0900-5001-540e-e246-c87c8525d0a4@arm.com>
Date:   Tue, 14 Jan 2020 11:37:57 +0100
Message-ID: <87muaqqq62.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>
> On 14/01/2020 09:33, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> 
> [...]
>
>> 
>> Bah, it's not fixing it. That's what you get when you compile the wrong
>> tree...

This part is required to cover the BUILD_VDSO32 guard, but then when the
fallback thing is removed it fails again because the 32bit fallbacks are
missing.

The patch below makes it build again.

Thanks,

        tglx

8<----------------
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -52,6 +52,24 @@ static __always_inline long clock_gettim
 	return ret;
 }
 
+static __always_inline long clock_gettime32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_gettime;
+
+	asm volatile(
+	"	swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
 static __always_inline int clock_getres_fallback(
 					clockid_t _clkid,
 					struct __kernel_timespec *_ts)
@@ -63,6 +81,24 @@ static __always_inline int clock_getres_
 
 	asm volatile(
 	"       swi #0\n"
+	: "=r" (ret)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "memory");
+
+	return ret;
+}
+
+static __always_inline int clock_getres32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("r1") = _ts;
+	register clockid_t clkid asm("r0") = _clkid;
+	register long ret asm ("r0");
+	register long nr asm("r7") = __NR_clock_getres;
+
+	asm volatile(
+	"       swi #0\n"
 	: "=r" (ret)
 	: "r" (clkid), "r" (ts), "r" (nr)
 	: "memory");
