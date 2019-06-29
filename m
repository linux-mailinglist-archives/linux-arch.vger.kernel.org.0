Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB885A956
	for <lists+linux-arch@lfdr.de>; Sat, 29 Jun 2019 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF2G5f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Jun 2019 02:57:35 -0400
Received: from foss.arm.com ([217.140.110.172]:60628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfF2G5f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Jun 2019 02:57:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3C928;
        Fri, 28 Jun 2019 23:57:34 -0700 (PDT)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2026F3F246;
        Fri, 28 Jun 2019 23:59:20 -0700 (PDT)
Subject: Re: [PATCH v7 04/25] arm64: Substitute gettimeofday with C
 implementation
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
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
 <20190621095252.32307-5-vincenzo.frascino@arm.com>
 <CGME20190628130921eucas1p239935b0771032c331911eacc1a69dd2e@eucas1p2.samsung.com>
 <1fd47b0d-f77f-8d07-c039-6ac9072834fc@samsung.com>
 <27386d82-2906-b541-f71d-3c61f5099bdf@arm.com>
 <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <06c264a8-8778-18b1-1094-4281a4a2abc9@arm.com>
Date:   Sat, 29 Jun 2019 07:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <530cd07e-0da7-1d83-be4e-b14813029424@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Sylwester,

thank you for the quick turn around to my email.

On 6/28/19 5:50 PM, Sylwester Nawrocki wrote:
> Hi Vincenzo,
> 
> On 6/28/19 16:32, Vincenzo Frascino wrote:
>> On 6/28/19 2:09 PM, Marek Szyprowski wrote:
>>> On 2019-06-21 11:52, Vincenzo Frascino wrote:
>>>> To take advantage of the commonly defined vdso interface for
>>>> gettimeofday the architectural code requires an adaptation.
>>>>
>>>> Re-implement the gettimeofday vdso in C in order to use lib/vdso.
>>>>
>>>> With the new implementation arm64 gains support for CLOCK_BOOTTIME
>>>> and CLOCK_TAI.
>>>>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>> Tested-by: Shijith Thotton <sthotton@marvell.com>
>>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>> This patch causes serious regression on Samsung Exynos5433 SoC based 
>>> TM2(e) boards. The time in userspace is always set to begin of the epoch:
>>>
>>> # date 062813152019
>>> Fri Jun 28 13:15:00 UTC 2019
>>> # date
>>> Thu Jan  1 00:00:00 UTC 1970
>>> # date
>>> Thu Jan  1 00:00:00 UTC 1970
>>>
>>> I've noticed that since the patch landed in Linux next-20190625 and 
>>> bisect indeed pointed to this patch.
>>>
>> Thank you for reporting this, seems that the next that you posted is missing
>> some fixes for arm64.
>>
>> Could you please try the tree below?
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
>>
>> Let us know if the functionality is restored. Otherwise the issue will require
>> further investigation.
>  
> Marek is already out for holidays, I gave your tree a try but kernel from 
> that branch was failing to boot on TM2(e).  
> 
> Then I have cherry-picked 5 patches from the branch that seemed to 
> be missing in next-20190628:
> 
> 28028f3174cf1 (HEAD) MAINTAINERS: Fix Andy's surname and the directory entries of VDSO
> ec8f8e4bf2206 arm64: vdso: Fix compilation with clang older than 8
> 721882ebb5729 arm64: compat: Fix __arch_get_hw_counter() implementation
> 7027fea977a3d arm64: Fix __arch_get_hw_counter() implementation
> 10b305853fe22 lib/vdso: Make delta calculation work correctly
> 48568d8c7f479 (tag: next-20190628, linux-next/master) Add linux-next specific files for 20190628
> 
> With those 5 additional patches on top of next-20190628 the problem
> is not observed any more. date, ping, etc. seems to be working well.
> 
> # date
> Fri Jun 28 16:39:22 UTC 2019
> #
> # systemctl stop systemd-timesyncd
> #  
> # date 062818392019
> Fri Jun 28 18:39:00 UTC 2019
> # date
> Fri Jun 28 18:39:01 UTC 2019
> # 
> # date 062818432019; date
> Fri Jun 28 18:43:00 UTC 2019
> Fri Jun 28 18:43:00 UTC 2019
> # date
> Fri Jun 28 18:43:04 UTC 2019
>

This seems ok, thanks for spending some time to test our patches against your board.

If I may, I would like to ask to you one favor, could you please keep an eye on
next and once those patches are merged repeat the test?

I want just to make sure that the regression does not reappear.

Have a nice weekend.

> --
> Regards,
> Sylwester
> 

-- 
Regards,
Vincenzo
