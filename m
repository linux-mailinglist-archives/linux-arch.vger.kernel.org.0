Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7015D2CD17
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2019 19:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfE1RFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 May 2019 13:05:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfE1RFm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 May 2019 13:05:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74093341;
        Tue, 28 May 2019 10:05:41 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C6A43F59C;
        Tue, 28 May 2019 10:05:39 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] kselftest: Extend vDSO selftest to clock_getres
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190523112116.19233-1-vincenzo.frascino@arm.com>
 <20190523112116.19233-4-vincenzo.frascino@arm.com>
 <87lfyrp0d2.fsf@concordia.ellerman.id.au>
 <afb7395f-43e9-c304-2db2-349e6727b687@arm.com>
 <20190528190132.Horde.a454OBLbW8Q4Xvx6vYRfSA1@messagerie.si.c-s.fr>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <bc9a8567-500f-46d4-8574-2148dbf478b5@arm.com>
Date:   Tue, 28 May 2019 18:05:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528190132.Horde.a454OBLbW8Q4Xvx6vYRfSA1@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

On 28/05/2019 18:01, Christophe Leroy wrote:
> Vincenzo Frascino <vincenzo.frascino@arm.com> a écrit :
> 
>> Hi Michael,
>>
>> thank you for your reply.
>>
>> On 28/05/2019 07:19, Michael Ellerman wrote:
>>> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>>>
>>>> The current version of the multiarch vDSO selftest verifies only
>>>> gettimeofday.
>>>>
>>>> Extend the vDSO selftest to clock_getres, to verify that the
>>>> syscall and the vDSO library function return the same information.
>>>>
>>>> The extension has been used to verify the hrtimer_resoltion fix.
>>>
>>> This is passing for me even without patch 1 applied, shouldn't it fail
>>> without the fix? What am I missing?
>>>
>>
>> This is correct, because during the refactoring process I missed an "n" :)
>>
>> if·((x.tv_sec·!=·y.tv_sec)·||·(x.tv_sec·!=·y.tv_sec))
>>
>> Should be:
>>
>> if·((x.tv_sec·!=·y.tv_sec)·||·(x.tv_nsec·!=·y.tv_nsec))
> 
> Maybe you'd better use timercmp() from sys/time.h
> 

timercmp() takes "struct timeval" not "struct timespec".

> Christophe
> 
>>
>> My mistake, I am going to fix the test and re-post v5 of this set.
>>
>> Without my patch if you pass "highres=off" to the kernel (as a command line
>> parameter) it leads to a broken implementation of clock_getres since  
>> the value
>> of CLOCK_REALTIME_RES does not change at runtime.
>>
>> Expected result (with highres=off):
>>
>> # uname -r
>> 5.2.0-rc2
>> # ./vdso_clock_getres
>> clock_id: CLOCK_REALTIME [FAIL]
>> clock_id: CLOCK_BOOTTIME [PASS]
>> clock_id: CLOCK_TAI [PASS]
>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>> clock_id: CLOCK_MONOTONIC [FAIL]
>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>>
>> The reason of this behavior is that the only clocks supported by getres on
>> powerpc are CLOCK_REALTIME and CLOCK_MONOTONIC, the rest on the clocks use
>> always syscalls.
>>
>>> # uname -r
>>> 5.2.0-rc2-gcc-8.2.0
>>>
>>> # ./vdso_clock_getres
>>> clock_id: CLOCK_REALTIME [PASS]
>>> clock_id: CLOCK_BOOTTIME [PASS]
>>> clock_id: CLOCK_TAI [PASS]
>>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>>> clock_id: CLOCK_MONOTONIC [PASS]
>>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>>>
>>> cheers
>>>
>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>> ---
>>>>
>>>> Note: This patch is independent from the others in this series, hence it
>>>> can be merged singularly by the kselftest maintainers.
>>>>
>>>>  tools/testing/selftests/vDSO/Makefile         |   2 +
>>>>  .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
>>>>  2 files changed, 126 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
>>
>> --
>> Regards,
>> Vincenzo
> 
> 

-- 
Regards,
Vincenzo
