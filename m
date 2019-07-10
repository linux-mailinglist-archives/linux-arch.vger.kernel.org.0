Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5394E64736
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 15:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGJNlQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 09:41:16 -0400
Received: from foss.arm.com ([217.140.110.172]:33502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfGJNlQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 09:41:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33C432B;
        Wed, 10 Jul 2019 06:41:15 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496FE3F71F;
        Wed, 10 Jul 2019 06:41:11 -0700 (PDT)
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     linux-arch@vger.kernel.org, Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
 <d9b171d5-896c-c4f7-eb2d-182ce2ce2d30@arm.com>
Message-ID: <6792a9f4-d8ed-b71d-b07c-e774da703dfa@arm.com>
Date:   Wed, 10 Jul 2019 14:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d9b171d5-896c-c4f7-eb2d-182ce2ce2d30@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On 10/07/2019 10:47, Vincenzo Frascino wrote:
> Hi John,
> 
> On 10/07/2019 05:02, John Stultz wrote:
>> On Fri, Jun 21, 2019 at 3:18 AM Vincenzo Frascino
>> <vincenzo.frascino@arm.com> wrote:
>>>
>>> Provide the arm64 compat (AArch32) vDSO in kernel/vdso32 in a similar
>>> way to what happens in kernel/vdso.
>>>
>>> The compat vDSO leverages on an adaptation of the arm architecture code
>>> with few changes:
>>>  - Use of lib/vdso for gettimeofday
>>>  - Implementation of syscall based fallback
>>>  - Introduction of clock_getres for the compat library
>>>  - Implementation of trampolines
>>>  - Implementation of elf note
>>>
>>> To build the compat vDSO a 32 bit compiler is required and needs to be
>>> specified via CONFIG_CROSS_COMPILE_COMPAT_VDSO.
>>>
>>
>> Hey Vincenzo!
>>   Congrats on getting this work merged, I know its been a long effort
>> over a number of years!
>>
>> Though unfortunately, it seems the arm64 vdso code that just landed is
>> breaking AOSP for me.
>>
>> I see a lot of the following errors:
>> 01-01 01:22:14.097   755   755 F libc    : Fatal signal 11 (SIGSEGV),
>> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 755 (cameraserver),
>> pid 755 (cameraserver)
>> 01-01 01:22:14.112   759   759 F libc    : Fatal signal 11 (SIGSEGV),
>> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 759
>> (android.hardwar), pid 759 (android.hardwar)
>> 01-01 01:22:14.120   756   756 F libc    : Fatal signal 11 (SIGSEGV),
>> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 756 (drmserver),
>> pid 756 (drmserver)
>>
>> Which go away if I revert the vdso merge that went in via tip/timers.
>>
>> I tried to bisect things down a bit, but as some later fixes are
>> required (at one point, date was returning the start epoch and never
>> increasing), this hasn't worked too well. But I'm guessing since I
>> see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
>> not be built", and the system is half working, I'm guessing this is an
>> issue with just the 32bit code failing.  While I can try to sort out
>> the proper CROSS_COMPILE_COMPAT in my build environment, I assume
>> userland shouldn't be crashing if that value isn't set.
>>
>> Any chance this issue has already been raised?
>>
> 
> I do not have Android (bionic/libc) as part of my testing environment hence I
> never saw this issue. Thanks for reporting it.
> 
> I am investigating the problem and will post a fix as soon as it is ready.
> 
> As Will suggested, .config would help the debugging and I would like to ask to
> you to test my fix once it is ready. Is that OK for you?
> 
>> thanks
>> -john
>>
> 

Seems that the problem you are experiencing is caused by an ABI regression for
which I provided a fix in [1]. Could you please verify that works for you as well?

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2046889.html

Please find below the tests that I conducted to verify that when
CROSS_COMPILE_COMPAT is not defined or empty the compat vdso library is not exposed.

# cat main-arm32.c

#include <stdio.h>
#include <sys/auxv.h>

int main()
{
	uintptr_t vdso = (uintptr_t) getauxval(AT_SYSINFO_EHDR);

	printf("AT_SYSINFO_EHDR: %p\n", vdso);

[...]

	return 0;
}

# file main-arm32
main-arm32: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically
linked, interpreter /lib/ld-, for GNU/Linux 3.2.0, with d

When CROSS_COMPILE_COMPAT is _not_ defined:
===========================================

# ./main-arm32
AT_SYSINFO_EHDR: (nil)

Memory Map:
-----------

00008000-00010000 rw-p 00000000 00:00 0
00010000-00011000 r-xp 00000000 00:13 24905929 /home/vinfra01/bin/main-arm32
00011000-00020000 rw-p 00000000 00:00 0
00020000-00021000 r--p 00000000 00:13 24905929 /home/vinfra01/bin/main-arm32
00021000-00022000 rw-p 00001000 00:13 24905929 /home/vinfra01/bin/main-arm32
00022000-f773d000 rw-p 00000000 00:00 0        [heap]
f773d000-f781f000 r-xp 00000000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f781f000-f782f000 ---p 000e2000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f782f000-f7831000 r--p 000e2000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f7831000-f7832000 rw-p 000e4000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f7832000-f7835000 rw-p 00000000 00:00 0
f7835000-f784b000 rw-p 00000000 00:00 0
f784b000-f7863000 r-xp 00000000 00:13 24906908 /lib/arm-linux-gnueabihf/ld-2.27.so
f7863000-f7870000 rw-p 00000000 00:00 0
f7870000-f7872000 rw-p 00000000 00:00 0
f7872000-f7873000 r-xp 00000000 00:00 0        [sigpage]
f7873000-f7874000 r--p 00018000 00:13 24906908 /lib/arm-linux-gnueabihf/ld-2.27.so
f7874000-f7875000 rw-p 00019000 00:13 24906908 /lib/arm-linux-gnueabihf/ld-2.27.so
f7875000-ff77a000 rw-p 00000000 00:00 0
ff87a000-ff89b000 rw-p 00000000 00:00 0        [stack]
ff89b000-ffff0000 rw-p 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0        [vectors]
ffff1000-fffff000 rw-p 00000000 00:00 0


vdsotest for compat [2]:
------------------------

Note: vDSO version of clock_gettime not found
clock-gettime-monotonic: syscall: 796 nsec/call
clock-gettime-monotonic:    libc: 816 nsec/call
clock-gettime-monotonic:    vdso: not tested
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_getres not found
clock-getres-monotonic: syscall: 567 nsec/call
clock-getres-monotonic:    libc: 581 nsec/call
clock-getres-monotonic:    vdso: not tested
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_gettime not found
clock-gettime-monotonic-coarse: syscall: 617 nsec/call
clock-gettime-monotonic-coarse:    libc: 656 nsec/call
clock-gettime-monotonic-coarse:    vdso: not tested
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_getres not found
clock-getres-monotonic-coarse: syscall: 591 nsec/call
clock-getres-monotonic-coarse:    libc: 614 nsec/call
clock-getres-monotonic-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_gettime not found
clock-gettime-realtime: syscall: 819 nsec/call
clock-gettime-realtime:    libc: 858 nsec/call
clock-gettime-realtime:    vdso: not tested
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_getres not found
clock-getres-realtime: syscall: 567 nsec/call
clock-getres-realtime:    libc: 583 nsec/call
clock-getres-realtime:    vdso: not tested
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_gettime not found
clock-gettime-realtime-coarse: syscall: 599 nsec/call
clock-gettime-realtime-coarse:    libc: 638 nsec/call
clock-gettime-realtime-coarse:    vdso: not tested
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_gettime not found
Note: vDSO version of clock_getres not found
clock-getres-realtime-coarse: syscall: 591 nsec/call
clock-getres-realtime-coarse:    libc: 610 nsec/call
clock-getres-realtime-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
Note: vDSO version of clock_getres not found
Note: vDSO version of getcpu not found
getcpu: syscall: 431 nsec/call
getcpu:    libc: 451 nsec/call
getcpu:    vdso: not tested
Note: vDSO version of getcpu not found
Note: vDSO version of getcpu not found
Note: vDSO version of gettimeofday not found
gettimeofday: syscall: 765 nsec/call
gettimeofday:    libc: 808 nsec/call
gettimeofday:    vdso: not tested
Note: vDSO version of gettimeofday not found
Note: vDSO version of gettimeofday not found

When CROSS_COMPILE_COMPAT is defined:
=====================================

# ./main-arm32
AT_SYSINFO_EHDR: 0xf7a67000

Memory map:
-----------

00008000-00010000 rw-p 00000000 00:00 0
00010000-00011000 r-xp 00000000 00:13 24905929 /home/vinfra01/bin/main-arm32
00011000-00020000 rw-p 00000000 00:00 0
00020000-00021000 r--p 00000000 00:13 24905929 /home/vinfra01/bin/main-arm32
00021000-00022000 rw-p 00001000 00:13 24905929 /home/vinfra01/bin/main-arm32
00022000-f7932000 rw-p 00000000 00:00 0        [heap]
f7932000-f7a14000 r-xp 00000000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f7a14000-f7a24000 ---p 000e2000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f7a24000-f7a26000 r--p 000e2000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f7a26000-f7a27000 rw-p 000e4000 00:13 24906912 /lib/arm-linux-gnueabihf/libc-2.27.so
f7a27000-f7a2a000 rw-p 00000000 00:00 0
f7a2a000-f7a40000 rw-p 00000000 00:00 0
f7a40000-f7a58000 r-xp 00000000 00:13 24906908 /lib/arm-linux-gnueabihf/ld-2.27.so
f7a58000-f7a64000 rw-p 00000000 00:00 0
f7a64000-f7a66000 rw-p 00000000 00:00 0
f7a66000-f7a67000 r--p 00000000 00:00 0        [vvar]
f7a67000-f7a68000 r-xp 00000000 00:00 0        [vdso]
f7a68000-f7a69000 r--p 00018000 00:13 24906908 /lib/arm-linux-gnueabihf/ld-2.27.so
f7a69000-f7a6a000 rw-p 00019000 00:13 24906908 /lib/arm-linux-gnueabihf/ld-2.27.so
f7a6a000-ff6d8000 rw-p 00000000 00:00 0
ff7d8000-ff7f9000 rw-p 00000000 00:00 0        [stack]
ff7f9000-ffff0000 rw-p 00000000 00:00 0
ffff0000-ffff1000 r-xp 00000000 00:00 0        [vectors]
ffff1000-fffff000 rw-p 00000000 00:00 0

vdsotest for compat [2]:
------------------------

clock-gettime-monotonic: syscall: 700 nsec/call
clock-gettime-monotonic:    libc: 226 nsec/call
clock-gettime-monotonic:    vdso: 189 nsec/call
clock-getres-monotonic: syscall: 582 nsec/call
clock-getres-monotonic:    libc: 581 nsec/call
clock-getres-monotonic:    vdso: 40 nsec/call
clock-gettime-monotonic-coarse: syscall: 618 nsec/call
clock-gettime-monotonic-coarse:    libc: 103 nsec/call
clock-gettime-monotonic-coarse:    vdso: 85 nsec/call
clock-getres-monotonic-coarse: syscall: 602 nsec/call
clock-getres-monotonic-coarse:    libc: 610 nsec/call
clock-getres-monotonic-coarse:    vdso: 64 nsec/call
clock-gettime-realtime: syscall: 741 nsec/call
clock-gettime-realtime:    libc: 209 nsec/call
clock-gettime-realtime:    vdso: 189 nsec/call
clock-getres-realtime: syscall: 627 nsec/call
clock-getres-realtime:    libc: 604 nsec/call
clock-getres-realtime:    vdso: 41 nsec/call
clock-gettime-realtime-coarse: syscall: 640 nsec/call
clock-gettime-realtime-coarse:    libc: 105 nsec/call
clock-gettime-realtime-coarse:    vdso: 84 nsec/call
clock-getres-realtime-coarse: syscall: 597 nsec/call
clock-getres-realtime-coarse:    libc: 608 nsec/call
clock-getres-realtime-coarse:    vdso: 46 nsec/call
Note: vDSO version of getcpu not found
getcpu: syscall: 492 nsec/call
getcpu:    libc: 492 nsec/call
getcpu:    vdso: not tested
Note: vDSO version of getcpu not found
Note: vDSO version of getcpu not found
gettimeofday: syscall: 664 nsec/call
gettimeofday:    libc: 224 nsec/call
gettimeofday:    vdso: 185 nsec/call

[2] https://github.com/nathanlynch/vdsotest

-- 
Regards,
Vincenzo
