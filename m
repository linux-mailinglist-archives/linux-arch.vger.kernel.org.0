Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDA2A6449B
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 11:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfGJJrX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 05:47:23 -0400
Received: from foss.arm.com ([217.140.110.172]:58574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfGJJrX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 05:47:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B07344;
        Wed, 10 Jul 2019 02:47:22 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7905E3F246;
        Wed, 10 Jul 2019 02:47:18 -0700 (PDT)
Subject: Re: [PATCH v7 10/25] arm64: compat: Add vDSO
To:     John Stultz <john.stultz@linaro.org>
Cc:     linux-arch@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Huw Davies <huw@codeweavers.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Burton <paul.burton@mips.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shijith Thotton <sthotton@marvell.com>,
        Peter Collingbourne <pcc@google.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d9b171d5-896c-c4f7-eb2d-182ce2ce2d30@arm.com>
Date:   Wed, 10 Jul 2019 10:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLXxE5B+vVLj7NcW8S05nhDQ+XSKVn=_MNDci667JDFEhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi John,

On 10/07/2019 05:02, John Stultz wrote:
> On Fri, Jun 21, 2019 at 3:18 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Provide the arm64 compat (AArch32) vDSO in kernel/vdso32 in a similar
>> way to what happens in kernel/vdso.
>>
>> The compat vDSO leverages on an adaptation of the arm architecture code
>> with few changes:
>>  - Use of lib/vdso for gettimeofday
>>  - Implementation of syscall based fallback
>>  - Introduction of clock_getres for the compat library
>>  - Implementation of trampolines
>>  - Implementation of elf note
>>
>> To build the compat vDSO a 32 bit compiler is required and needs to be
>> specified via CONFIG_CROSS_COMPILE_COMPAT_VDSO.
>>
> 
> Hey Vincenzo!
>   Congrats on getting this work merged, I know its been a long effort
> over a number of years!
> 
> Though unfortunately, it seems the arm64 vdso code that just landed is
> breaking AOSP for me.
> 
> I see a lot of the following errors:
> 01-01 01:22:14.097   755   755 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 755 (cameraserver),
> pid 755 (cameraserver)
> 01-01 01:22:14.112   759   759 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 759
> (android.hardwar), pid 759 (android.hardwar)
> 01-01 01:22:14.120   756   756 F libc    : Fatal signal 11 (SIGSEGV),
> code 1 (SEGV_MAPERR), fault addr 0x3cf2c96c in tid 756 (drmserver),
> pid 756 (drmserver)
> 
> Which go away if I revert the vdso merge that went in via tip/timers.
> 
> I tried to bisect things down a bit, but as some later fixes are
> required (at one point, date was returning the start epoch and never
> increasing), this hasn't worked too well. But I'm guessing since I
> see: "CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will
> not be built", and the system is half working, I'm guessing this is an
> issue with just the 32bit code failing.  While I can try to sort out
> the proper CROSS_COMPILE_COMPAT in my build environment, I assume
> userland shouldn't be crashing if that value isn't set.
> 
> Any chance this issue has already been raised?
> 

I do not have Android (bionic/libc) as part of my testing environment hence I
never saw this issue. Thanks for reporting it.

I am investigating the problem and will post a fix as soon as it is ready.

As Will suggested, .config would help the debugging and I would like to ask to
you to test my fix once it is ready. Is that OK for you?

> thanks
> -john
> 

-- 
Regards,
Vincenzo
