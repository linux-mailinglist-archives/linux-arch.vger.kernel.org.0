Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83E113082
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfLDRNA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 12:13:00 -0500
Received: from foss.arm.com ([217.140.110.172]:59112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDRNA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 4 Dec 2019 12:13:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB7231B;
        Wed,  4 Dec 2019 09:12:58 -0800 (PST)
Received: from [10.37.12.197] (unknown [10.37.12.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B509D3F52E;
        Wed,  4 Dec 2019 09:12:54 -0800 (PST)
Subject: Re: [PATCH v7 16/25] arm: Add support for generic vDSO (causing
 crash)
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <20190621095252.32307-17-vincenzo.frascino@arm.com>
 <20191204135159.GA7210@roeck-us.net>
 <6cdf4734-4065-09c1-8623-1bf523b38c1b@arm.com>
 <20191204161641.GA28130@roeck-us.net>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <e35a7f71-2477-fa52-01e4-301199e99c2e@arm.com>
Date:   Wed, 4 Dec 2019 17:15:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204161641.GA28130@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guenter,

On 12/4/19 4:16 PM, Guenter Roeck wrote:
> On Wed, Dec 04, 2019 at 01:58:25PM +0000, Vincenzo Frascino wrote:
>> Hi Guenter,
>>
>> On 12/4/19 1:51 PM, Guenter Roeck wrote:
>>> On Fri, Jun 21, 2019 at 10:52:43AM +0100, Vincenzo Frascino wrote:
>>>> The arm vDSO library requires some adaptations to use to take advantage
>>>> of the newly introduced generic vDSO library.
>>>>
>>>> Introduce the following changes:
>>>>  - Modification vdso.c to be compliant with the common vdso datapage
>>>>  - Use of lib/vdso for gettimeofday
>>>>  - Implementation of elf note
>>>>
>>>> Cc: Russell King <linux@armlinux.org.uk>
>>>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>>
>>> This patch causes a crash with qemu's mcimx6ul-evk emulation while running
>>> imx_v6_v7_defconfig.
>>>
>>
>> Thank you for reporting this. Could you please provide some details on how I can
>> reproduce the scenario you are describing?
>>
> - Build imx_v6_v7_defconfig
> - Get root file system or initrd, for example from
>   https://github.com/groeck/linux-build-test/tree/master/rootfs/arm
> - Run image. Example, with initrd:
> 	qemu-system-arm -M mcimx6ul-evk -kernel arch/arm/boot/zImage \
> 		-no-reboot -initrd rootfs-armv7a.cpio \
> 		-m 256 -display none -serial null \
> 		--append 'rdinit=/sbin/init earlycon=ec_imx6q,mmio,0x21e8000,115200n8 console=ttymxc1,115200'
> 		-dtb arch/arm/boot/dts/imx6ul-14x14-evk.dtb \
> 		-nographic -monitor null -serial stdio
> 
> qemu has to be v3.1 or later to support the machine.
> 

Thanks for this. Could you please try the patch below the scissors? Seems fixing
the issue for me.

> Hope this helps,
> Guenter
> 

-- 
Regards,
Vincenzo

--->8---

Author: Vincenzo Frascino <vincenzo.frascino@arm.com>
Date:   Wed Dec 4 16:58:55 2019 +0000

    arm: Fix __arch_get_hw_counter() access to CNTVCT

    __arch_get_hw_counter() should check clock_mode to see if it can access
    CNTVCT. With the conversion to unified vDSO this check has been left out.

    This causes on imx v6 and v7 (imx_v6_v7_defconfig) and other platforms to
    hang at boot during the execution of the init process as per below:

    [   19.976852] Run /sbin/init as init process
    [   20.044931] Kernel panic - not syncing: Attempted to kill init!
    exitcode=0x00000004

    Fix the problem verifying that clock_mode is set coherently before
    accessing CNTVCT.

    Cc: Russell King <linux@armlinux.org.uk>
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Investigated-by: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h
b/arch/arm/include/asm/vdso/gettimeofday.h
index 5b879ae7afc1..0ad2429c324f 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -75,6 +75,9 @@ static __always_inline u64 __arch_get_hw_counter(int clock_mode)
 #ifdef CONFIG_ARM_ARCH_TIMER
        u64 cycle_now;

+       if (!clock_mode)
+               return -EINVAL;
+
        isb();
        cycle_now = read_sysreg(CNTVCT);


