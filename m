Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FF2A1FEA
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfH2Pvj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 11:51:39 -0400
Received: from foss.arm.com ([217.140.110.172]:47400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbfH2Pvj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:51:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29E9828;
        Thu, 29 Aug 2019 08:51:38 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D34B3F718;
        Thu, 29 Aug 2019 08:51:36 -0700 (PDT)
Subject: Re: [PATCH 4/7] lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-5-vincenzo.frascino@arm.com>
 <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <77d5c414-77c4-49e9-3541-772c74a4735d@arm.com>
Date:   Thu, 29 Aug 2019 16:51:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVprrrR3TSVSAnHfLW4HDQG=gcVrdjmsk6ss6Z3+vKOBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 29/08/2019 16:25, Andy Lutomirski wrote:
> On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> VDSO_HAS_32BIT_FALLBACK was introduced to address a regression which
>> caused seccomp to deny access to the applications to clock_gettime64()
>> and clock_getres64() because they are not enabled in the existing
>> filters.
>>
>> The purpose of VDSO_HAS_32BIT_FALLBACK was to simplify the conditional
>> implementation of __cvdso_clock_get*time32() variants.
>>
>> Now that all the architectures that support the generic vDSO library
>> have been converted to support the 32 bit fallbacks the conditional
>> can be removed.
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> CC: Andy Lutomirski <luto@kernel.org>
>> References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  lib/vdso/gettimeofday.c | 10 ----------
>>  1 file changed, 10 deletions(-)
>>
>> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
>> index a86e89e6dedc..2c4b311c226d 100644
>> --- a/lib/vdso/gettimeofday.c
>> +++ b/lib/vdso/gettimeofday.c
>> @@ -126,13 +126,8 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
>>
>>         ret = __cvdso_clock_gettime_common(clock, &ts);
>>
>> -#ifdef VDSO_HAS_32BIT_FALLBACK
>>         if (unlikely(ret))
>>                 return clock_gettime32_fallback(clock, res);
>> -#else
>> -       if (unlikely(ret))
>> -               ret = clock_gettime_fallback(clock, &ts);
>> -#endif
>>
>>         if (likely(!ret)) {
>>                 res->tv_sec = ts.tv_sec;
> 
> I think you could have a little follow-up patch to remove the if
> statement -- by the time you get here, it's guaranteed that ret == 0.
>

Thanks, I will add a new patch that does that to v2 (with a comment).

> --Andy
> 

-- 
Regards,
Vincenzo
