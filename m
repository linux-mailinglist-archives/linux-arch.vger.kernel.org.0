Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75434629
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfFDMFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 08:05:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41426 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfFDMFD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 08:05:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AF3280D;
        Tue,  4 Jun 2019 05:05:03 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 348353F690;
        Tue,  4 Jun 2019 05:05:00 -0700 (PDT)
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d96667d5-e43b-d33a-fbd0-5acfb4904316@arm.com>
Date:   Tue, 4 Jun 2019 13:04:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

thank you for your review.

On 31/05/2019 09:46, Arnd Bergmann wrote:
> On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> vDSO (virtual dynamic shared object) is a mechanism that the Linux
>> kernel provides as an alternative to system calls to reduce where
>> possible the costs in terms of cycles.
>> This is possible because certain syscalls like gettimeofday() do
>> not write any data and return one or more values that are stored
>> in the kernel, which makes relatively safe calling them directly
>> as a library function.
> 
> Hi Vincento,
> 
> I've very happy with how this turned out overall, and as far as I can
> tell you have addressed all my previous comments. I had another
> look through the series and only noticed a few very minor issues.
> 

Thanks! I agree with what you pointed out in the single patches, I will wait for
Thomas to review them as well and then will address all the comments in v7.

...

> 
> One open question I touched in my review is whether we want to
> have a vdso version of clock_getres() in all architectures or not.
> I'd prefer to leave it out because there is very little advantage to
> it over the system call (the results don't change at runtime and
> can easily be cached by libc if performance ever matters), and
> it takes up a small amount of memory for the implementation.
> 

I thought about it and I ended up with what proposed in this patchset mainly for
symmetry across all the architectures since in the end they use the same common
code.

It seems also that there is some performance impact (i.e.):

clock-getres-monotonic:    libc(system call): 296 nsec/call
clock-getres-monotonic:    libc(vdso): 5 nsec/call


I agree with you though when you say that caching it in the libc is a
possibility to overcome the performance impact.

> We shouldn't just need it for consistency because all callers
> would require implementing a fallback to the system call
> anyway, to deal with old kernels.
> 

A way to address this issue would be to use versioning, which seems supported in
the vdso library (i.e. arch/x86/entry/vdso/vdso32/vdso32.lds.S).

For example for x86 (vdso32) we would have something like:

VERSION
{
	LINUX_5.3 (being optimistic here :) ) {
	global:
                __vdso_clock_getres;
                __vdso_clock_gettime64;
        };
        LINUX_2.6 {
        global:
                __vdso_clock_gettime;
                __vdso_gettimeofday;
                __vdso_time;
        };

        LINUX_2.5 {
        global:
                __kernel_vsyscall;
                __kernel_sigreturn;
                __kernel_rt_sigreturn;
        local: *;
        };
}

What do you think? Would this be a viable solution?

> If anyone comes up with a good reason why it should be added
> after all, let me know and I'll stop mentioning it.
> 
>       Arnd
> 

-- 
Regards,
Vincenzo
