Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97545C91
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 14:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfFNMTT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 08:19:19 -0400
Received: from foss.arm.com ([217.140.110.172]:60964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfFNMTT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 08:19:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E2DA3EF;
        Fri, 14 Jun 2019 05:19:18 -0700 (PDT)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C24183F246;
        Fri, 14 Jun 2019 05:19:15 -0700 (PDT)
Subject: Re: [PATCH v6 00/19] Unify vDSOs across more architectures
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
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
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <CAK8P3a11DE0sXteZoaP_N=mDhx3tXitGKddn1ogtFqJBYO-SCA@mail.gmail.com>
 <d96667d5-e43b-d33a-fbd0-5acfb4904316@arm.com>
 <alpine.DEB.2.21.1906141413070.1722@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <6f3bcd07-6eb4-53d6-d209-de42396a4ee2@arm.com>
Date:   Fri, 14 Jun 2019 13:19:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141413070.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 6/14/19 1:16 PM, Thomas Gleixner wrote:
> On Tue, 4 Jun 2019, Vincenzo Frascino wrote:
>> On 31/05/2019 09:46, Arnd Bergmann wrote:
>>> One open question I touched in my review is whether we want to
>>> have a vdso version of clock_getres() in all architectures or not.
>>> I'd prefer to leave it out because there is very little advantage to
>>> it over the system call (the results don't change at runtime and
>>> can easily be cached by libc if performance ever matters), and
>>> it takes up a small amount of memory for the implementation.
>>>
>>
>> I thought about it and I ended up with what proposed in this patchset mainly for
>> symmetry across all the architectures since in the end they use the same common
>> code.
>>
>> It seems also that there is some performance impact (i.e.):
>>
>> clock-getres-monotonic:    libc(system call): 296 nsec/call
>> clock-getres-monotonic:    libc(vdso): 5 nsec/call
> 
> clock_getres() is usually not a hot path operation.
> 
>> I agree with you though when you say that caching it in the libc is a
>> possibility to overcome the performance impact.
>>
>>> We shouldn't just need it for consistency because all callers
>>> would require implementing a fallback to the system call
>>> anyway, to deal with old kernels.
> 
> libc has the fallback already. Let's aim for 1:1 replacement of the
> architecture code first and then add the extra bits in separate patches.
>

Ok, thanks Thomas, I will split the patches accordingly.

> Thanks,
> 
> 	tglx
> 

-- 
Regards,
Vincenzo
