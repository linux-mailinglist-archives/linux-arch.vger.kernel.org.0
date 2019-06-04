Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12C3496E
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfFDNwI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 09:52:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23496 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDNwH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 09:52:07 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45JCyq61Nqz9tvgH;
        Tue,  4 Jun 2019 15:52:03 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hcyL/Npk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Xob6WxqZVdF0; Tue,  4 Jun 2019 15:52:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45JCyq4m0yz9tvgB;
        Tue,  4 Jun 2019 15:52:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1559656323; bh=cG2I4/+or6jXocomspUNW4bsSOR2Dja046zVaBRzVW0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hcyL/Npk9wJ9Gktux6y6e2ijNkjejGIUDc3bf1FMtdfJq9xDzJe8yarKpH2NyOPKB
         BNyKoTleJQnbyimqTnvpYN/8A8iyTK8ueA/RJY/D1S2tTme1AxIeK6Xm5Zi0cMUR9n
         fkfXF5tN6bJIzunEK/VDarAIwlr2JehxKg8421qs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 908658B98E;
        Tue,  4 Jun 2019 15:52:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qcGfuJDy_YZD; Tue,  4 Jun 2019 15:52:04 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 23EF68B967;
        Tue,  4 Jun 2019 15:52:03 +0200 (CEST)
Subject: Re: [PATCH v4 3/3] kselftest: Extend vDSO selftest to clock_getres
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190523112116.19233-1-vincenzo.frascino@arm.com>
 <20190523112116.19233-4-vincenzo.frascino@arm.com>
 <87lfyrp0d2.fsf@concordia.ellerman.id.au>
 <afb7395f-43e9-c304-2db2-349e6727b687@arm.com>
 <5c99721a-ce6b-10a0-99f2-6c37c1da4542@c-s.fr>
 <b710d906-edac-f8a7-792b-e6822399187c@arm.com>
 <dd8bf915-f438-74f0-494e-427d10fc0505@c-s.fr>
 <eacdc960-c344-9f9f-7f1b-ad770cb4a725@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2389b7f2-288b-215e-994a-3b24be08e125@c-s.fr>
Date:   Tue, 4 Jun 2019 15:52:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eacdc960-c344-9f9f-7f1b-ad770cb4a725@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 04/06/2019 à 15:43, Vincenzo Frascino a écrit :
> On 04/06/2019 14:39, Christophe Leroy wrote:
>>
>>
>> Le 04/06/2019 à 15:32, Vincenzo Frascino a écrit :
>>> Hi Christophe,
>>>
>>> On 04/06/2019 14:16, Christophe Leroy wrote:
>>>> Hi Vincenzo
>>>>
>>>> Le 28/05/2019 à 13:57, Vincenzo Frascino a écrit :
>>>>> Hi Michael,
>>>>>
>>>>> thank you for your reply.
>>>>>
>>>>> On 28/05/2019 07:19, Michael Ellerman wrote:
>>>>>> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
>>>>>>
>>>>>>> The current version of the multiarch vDSO selftest verifies only
>>>>>>> gettimeofday.
>>>>>>>
>>>>>>> Extend the vDSO selftest to clock_getres, to verify that the
>>>>>>> syscall and the vDSO library function return the same information.
>>>>>>>
>>>>>>> The extension has been used to verify the hrtimer_resoltion fix.
>>>>>>
>>>>>> This is passing for me even without patch 1 applied, shouldn't it fail
>>>>>> without the fix? What am I missing?
>>>>>>
>>>>>
>>>>> This is correct, because during the refactoring process I missed an "n" :)
>>>>>
>>>>> if·((x.tv_sec·!=·y.tv_sec)·||·(x.tv_sec·!=·y.tv_sec))
>>>>>
>>>>> Should be:
>>>>>
>>>>> if·((x.tv_sec·!=·y.tv_sec)·||·(x.tv_nsec·!=·y.tv_nsec))
>>>>>
>>>>> My mistake, I am going to fix the test and re-post v5 of this set.
>>>>>
>>>>> Without my patch if you pass "highres=off" to the kernel (as a command line
>>>>> parameter) it leads to a broken implementation of clock_getres since the value
>>>>> of CLOCK_REALTIME_RES does not change at runtime.
>>>>>
>>>>> Expected result (with highres=off):
>>>>>
>>>>> # uname -r
>>>>> 5.2.0-rc2
>>>>> # ./vdso_clock_getres
>>>>> clock_id: CLOCK_REALTIME [FAIL]
>>>>> clock_id: CLOCK_BOOTTIME [PASS]
>>>>> clock_id: CLOCK_TAI [PASS]
>>>>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>>>>> clock_id: CLOCK_MONOTONIC [FAIL]
>>>>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>>>>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>>>>>
>>>>> The reason of this behavior is that the only clocks supported by getres on
>>>>> powerpc are CLOCK_REALTIME and CLOCK_MONOTONIC, the rest on the clocks use
>>>>> always syscalls.
>>>>
>>>> vdso64 is supposed to implement CLOCK_{REALTIME/MONOTONIC}_COARSE, so I
>>>> guess it should fail for them too ?
>>>>
>>>> Or is your test done on vdso32 ?
>>>>
>>>
>>> Based on what I can see in kernel/vdso64 in 5.2-rc3:
>>>
>>> /*
>>>    * Exact prototype of clock_getres()
>>>    *
>>>    * int __kernel_clock_getres(clockid_t clock_id, struct timespec *res);
>>>    *
>>>    */
>>> V_FUNCTION_BEGIN(__kernel_clock_getres)
>>>     .cfi_startproc
>>> 	/* Check for supported clock IDs */
>>> 	cmpwi	cr0,r3,CLOCK_REALTIME
>>> 	cmpwi	cr1,r3,CLOCK_MONOTONIC
>>> 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
>>> 	bne	cr0,99f
>>>
>>> 	li	r3,0
>>> 	cmpldi	cr0,r4,0
>>> 	crclr	cr0*4+so
>>> 	beqlr
>>> 	lis	r5,CLOCK_REALTIME_RES@h
>>> 	ori	r5,r5,CLOCK_REALTIME_RES@l
>>> 	std	r3,TSPC64_TV_SEC(r4)
>>> 	std	r5,TSPC64_TV_NSEC(r4)
>>> 	blr
>>>
>>> 	/*
>>> 	 * syscall fallback
>>> 	 */
>>> 99:
>>> 	li	r0,__NR_clock_getres
>>> 	sc
>>> 	blr
>>>     .cfi_endproc
>>> V_FUNCTION_END(__kernel_clock_getres)
>>>
>>> it does not seem so for what concerns vdso64. I did run again the test both on
>>> ppc and ppc64 qemu instances and the result is the same to what I reported in
>>> this thread.
>>>
>>> Am I missing something?
>>
>> I was thinking about
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5c929885f1bb
>> but apparently clock_getres() was left aside. Should we do something
>> about it ?
>>
> 
> Sure, but I would like this series to be merged first (since the topic is
> different). I am happy, after that, to push a separate one on top that addresses
> the problem.
> 
> Please let me know if it works for you and Michael.

No problem for myself.

By the way, next time (or next spin ?) I recommend you to handle your 
patches independently and not as a series since they are all 
independant. It would have avoided confusion and the need for you to 
resend all 3 patches everytime you did a change in one of them.

Christophe

> 
>> Christophe
>>
>>>
>>>> Christophe
>>>>
>>>>>
>>>>>> # uname -r
>>>>>> 5.2.0-rc2-gcc-8.2.0
>>>>>>
>>>>>> # ./vdso_clock_getres
>>>>>> clock_id: CLOCK_REALTIME [PASS]
>>>>>> clock_id: CLOCK_BOOTTIME [PASS]
>>>>>> clock_id: CLOCK_TAI [PASS]
>>>>>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>>>>>> clock_id: CLOCK_MONOTONIC [PASS]
>>>>>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>>>>>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>>>>>>
>>>>>> cheers
>>>>>>
>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Note: This patch is independent from the others in this series, hence it
>>>>>>> can be merged singularly by the kselftest maintainers.
>>>>>>>
>>>>>>>     tools/testing/selftests/vDSO/Makefile         |   2 +
>>>>>>>     .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
>>>>>>>     2 files changed, 126 insertions(+)
>>>>>>>     create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
>>>>>
>>>
> 
