Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1A6473B
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2019 15:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfGJNm7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jul 2019 09:42:59 -0400
Received: from foss.arm.com ([217.140.110.172]:33560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfGJNm6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jul 2019 09:42:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB6732B;
        Wed, 10 Jul 2019 06:42:57 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 152993F71F;
        Wed, 10 Jul 2019 06:42:54 -0700 (PDT)
Subject: Re: [PATCH] arm64: vdso: Fix ABI regression in compat vdso
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, linux@armlinux.org.uk,
        ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, huw@codeweavers.com,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        john.stultz@linaro.org
References: <20190621095252.32307-11-vincenzo.frascino@arm.com>
 <20190710130452.44111-1-vincenzo.frascino@arm.com>
 <20190710132532.r27yryvt25ex76xk@willie-the-truck>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <4ea8fd8a-c50d-0cb7-af56-5bb90b0e50f8@arm.com>
Date:   Wed, 10 Jul 2019 14:42:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710132532.r27yryvt25ex76xk@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/07/2019 14:25, Will Deacon wrote:
> On Wed, Jul 10, 2019 at 02:04:52PM +0100, Vincenzo Frascino wrote:
>> Prior to the introduction of Unified vDSO support and compat layer for
>> vDSO on arm64, AT_SYSINFO_EHDR was not defined for compat tasks.
>> In the current implementation, AT_SYSINFO_EHDR is defined even if the
>> compat vdso layer is not built and this causes a regression in the
>> expected behavior of the ABI.
>>
>> Restore the ABI behavior making sure that AT_SYSINFO_EHDR for compat
>> tasks is defined only when CONFIG_GENERIC_COMPAT_VDSO and
>> CONFIG_COMPAT_VDSO are enabled.
> 
> I think you could do a better job in the changelog of explaining what's
> actually going on here. The problem seems to be that you're advertising
> the presence of a non-existent vDSO to userspace.
> 
>> Reported-by: John Stultz <john.stultz@linaro.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>  arch/arm64/include/asm/elf.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
>> index 3c7037c6ba9b..b7992bb9d414 100644
>> --- a/arch/arm64/include/asm/elf.h
>> +++ b/arch/arm64/include/asm/elf.h
>> @@ -202,7 +202,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
>>  ({									\
>>  	set_thread_flag(TIF_32BIT);					\
>>   })
>> -#ifdef CONFIG_GENERIC_COMPAT_VDSO
>> +#if defined(CONFIG_COMPAT_VDSO) && defined(CONFIG_GENERIC_COMPAT_VDSO)
> 
> Can't this just be #ifdef CONFIG_COMPAT_VDSO ?
>

Yes, I realized it after I pushed the patch that CONFIG_GENERIC_COMPAT_VDSO can
be removed. Posting v2 shortly.

> John -- can you give this a whirl, please?
> 
> Cheers,
> 
> Will
> 

-- 
Regards,
Vincenzo
