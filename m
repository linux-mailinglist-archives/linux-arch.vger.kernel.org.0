Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39D1CC3BC
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 20:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgEISsv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 14:48:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36435 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgEISsv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 May 2020 14:48:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49KGSG1DQfz9v0bb;
        Sat,  9 May 2020 20:48:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PslmPuTS_Qi2; Sat,  9 May 2020 20:48:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49KGSF5mGvz9v0bX;
        Sat,  9 May 2020 20:48:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B4E88B775;
        Sat,  9 May 2020 20:48:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vZm-xPGAfqgM; Sat,  9 May 2020 20:48:48 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 06C8C8B75F;
        Sat,  9 May 2020 20:48:46 +0200 (CEST)
Subject: Re: [PATCH v8 8/8] powerpc/vdso: Provide __kernel_clock_gettime64()
 on vdso32
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
 <CAK8P3a2aXJRWjxWO8oMRX2AJkfeVeeoYbOPbpd9-UTgjqM4B7g@mail.gmail.com>
 <d3f303f1-8b2c-0c54-5380-0b9a370a4eb3@csgroup.eu>
Message-ID: <35e09925-b475-237c-57f2-3f10cf5ad9b2@csgroup.eu>
Date:   Sat, 9 May 2020 20:48:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d3f303f1-8b2c-0c54-5380-0b9a370a4eb3@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 09/05/2020 à 17:54, Christophe Leroy a écrit :
> 
> 
> Le 28/04/2020 à 18:05, Arnd Bergmann a écrit :
>> On Tue, Apr 28, 2020 at 3:16 PM Christophe Leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>> Provides __kernel_clock_gettime64() on vdso32. This is the
>>> 64 bits version of __kernel_clock_gettime() which is
>>> y2038 compliant.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>
>> Looks good to me
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>>
>> There was a bug on ARM for the corresponding function, so far it is 
>> unclear
>> if this was a problem related to particular hardware, the 32-bit 
>> kernel code,
>> or the common implementation of clock_gettime64 in the vdso library,
>> see https://github.com/richfelker/musl-cross-make/issues/96
>>
>> Just to be sure that powerpc is not affected by the same issue, can you
>> confirm that repeatedly calling clock_gettime64 on powerpc32, alternating
>> between vdso and syscall, results in monotically increasing times?
>>
> 
> I think that's one of the things vdsotest checks, so yes that's ok I think.
> 

Here is the full result with vdsotest:

gettimeofday: syscall: 3715 nsec/call
gettimeofday:    libc: 794 nsec/call
gettimeofday:    vdso: 947 nsec/call
getcpu: syscall: 1614 nsec/call
getcpu:    libc: 484 nsec/call
getcpu:    vdso: 184 nsec/call
clock-gettime64-realtime-coarse: syscall: 3152 nsec/call
clock-gettime64-realtime-coarse:    libc: not tested
clock-gettime64-realtime-coarse:    vdso: 653 nsec/call
clock-getres-realtime-coarse: syscall: 2963 nsec/call
clock-getres-realtime-coarse:    libc: 745 nsec/call
clock-getres-realtime-coarse:    vdso: 553 nsec/call
clock-gettime-realtime-coarse: syscall: 5120 nsec/call
clock-gettime-realtime-coarse:    libc: 731 nsec/call
clock-gettime-realtime-coarse:    vdso: 577 nsec/call
clock-gettime64-realtime: syscall: 3719 nsec/call
clock-gettime64-realtime:    libc: not tested
clock-gettime64-realtime:    vdso: 976 nsec/call
clock-getres-realtime: syscall: 2496 nsec/call
clock-getres-realtime:    libc: 745 nsec/call
clock-getres-realtime:    vdso: 546 nsec/call
clock-gettime-realtime: syscall: 4800 nsec/call
clock-gettime-realtime:    libc: 1080 nsec/call
clock-gettime-realtime:    vdso: 1798 nsec/call
clock-gettime64-boottime: syscall: 4132 nsec/call
clock-gettime64-boottime:    libc: not tested
clock-gettime64-boottime:    vdso: 975 nsec/call
clock-getres-boottime: syscall: 2497 nsec/call
clock-getres-boottime:    libc: 730 nsec/call
clock-getres-boottime:    vdso: 546 nsec/call
clock-gettime-boottime: syscall: 3728 nsec/call
clock-gettime-boottime:    libc: 1079 nsec/call
clock-gettime-boottime:    vdso: 941 nsec/call
clock-gettime64-tai: syscall: 4148 nsec/call
clock-gettime64-tai:    libc: not tested
clock-gettime64-tai:    vdso: 955 nsec/call
clock-getres-tai: syscall: 2494 nsec/call
clock-getres-tai:    libc: 730 nsec/call
clock-getres-tai:    vdso: 545 nsec/call
clock-gettime-tai: syscall: 3729 nsec/call
clock-gettime-tai:    libc: 1079 nsec/call
clock-gettime-tai:    vdso: 927 nsec/call
clock-gettime64-monotonic-raw: syscall: 3677 nsec/call
clock-gettime64-monotonic-raw:    libc: not tested
clock-gettime64-monotonic-raw:    vdso: 1032 nsec/call
clock-getres-monotonic-raw: syscall: 2494 nsec/call
clock-getres-monotonic-raw:    libc: 745 nsec/call
clock-getres-monotonic-raw:    vdso: 545 nsec/call
clock-gettime-monotonic-raw: syscall: 3276 nsec/call
clock-gettime-monotonic-raw:    libc: 1140 nsec/call
clock-gettime-monotonic-raw:    vdso: 1002 nsec/call
clock-gettime64-monotonic-coarse: syscall: 4099 nsec/call
clock-gettime64-monotonic-coarse:    libc: not tested
clock-gettime64-monotonic-coarse:    vdso: 653 nsec/call
clock-getres-monotonic-coarse: syscall: 2962 nsec/call
clock-getres-monotonic-coarse:    libc: 745 nsec/call
clock-getres-monotonic-coarse:    vdso: 545 nsec/call
clock-gettime-monotonic-coarse: syscall: 4297 nsec/call
clock-gettime-monotonic-coarse:    libc: 730 nsec/call
clock-gettime-monotonic-coarse:    vdso: 592 nsec/call
clock-gettime64-monotonic: syscall: 3863 nsec/call
clock-gettime64-monotonic:    libc: not tested
clock-gettime64-monotonic:    vdso: 975 nsec/call
clock-getres-monotonic: syscall: 2494 nsec/call
clock-getres-monotonic:    libc: 745 nsec/call
clock-getres-monotonic:    vdso: 545 nsec/call
clock-gettime-monotonic: syscall: 3465 nsec/call
clock-gettime-monotonic:    libc: 1079 nsec/call
clock-gettime-monotonic:    vdso: 927 nsec/call

Christophe
