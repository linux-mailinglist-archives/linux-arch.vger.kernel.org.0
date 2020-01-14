Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0016913A3E2
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 10:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgANJeB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 14 Jan 2020 04:34:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANJeB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 04:34:01 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irIa7-0006V0-A2; Tue, 14 Jan 2020 10:33:51 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 90C00101DEE; Tue, 14 Jan 2020 10:33:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        salyzyn@android.com, 0x7f454c46@gmail.com, luto@kernel.org
Subject: Re: [PATCH v2 2/8] lib: vdso: Build 32 bit specific functions in the right context
In-Reply-To: <87tv4zq9dc.fsf@nanos.tec.linutronix.de>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com> <20190830135902.20861-3-vincenzo.frascino@arm.com> <87tv4zq9dc.fsf@nanos.tec.linutronix.de>
Date:   Tue, 14 Jan 2020 10:33:50 +0100
Message-ID: <87r202qt4x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>
>> clock_gettime32 and clock_getres_time32 should be compiled only with a
>> 32 bit vdso library.
>>
>> Exclude these symbols when BUILD_VDSO32 is not defined.
>
> This breaks the ARM build with:
>
> arch/arm/vdso/vgettimeofday.c: In function ‘__vdso_clock_gettime’:
> arch/arm/vdso/vgettimeofday.c:15:9: error: implicit declaration of function ‘__cvdso_clock_gettime32’; did you mean ‘__cvdso_clock_gettime’? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_gettime32(clock, ts);
>          ^~~~~~~~~~~~~~~~~~~~~~~
>          __cvdso_clock_gettime
> arch/arm/vdso/vgettimeofday.c: In function ‘__vdso_clock_getres’:
> arch/arm/vdso/vgettimeofday.c:33:9: error: implicit declaration of function ‘__cvdso_clock_getres_time32’; did you mean ‘__cvdso_clock_getres_common’? [-Werror=implicit-function-declaration]
>   return __cvdso_clock_getres_time32(clock_id, res);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>          __cvdso_clock_getres_common
> cc1: some warnings being treated as errors
>
> The patch below 'fixes' at least the build. Can someone please confirm
> the correctness?

Bah, it's not fixing it. That's what you get when you compile the wrong
tree...
