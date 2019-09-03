Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B9A6B20
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2019 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfICOTL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 10:19:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfICOTL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:19:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B52FA337;
        Tue,  3 Sep 2019 07:19:10 -0700 (PDT)
Received: from [10.37.8.116] (unknown [10.37.8.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C2933F246;
        Tue,  3 Sep 2019 07:19:08 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
To:     Paul Burton <paul.burton@mips.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "salyzyn@android.com" <salyzyn@android.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-4-vincenzo.frascino@arm.com>
 <20190903134335.uxxf5kvp3afe7rfr@pburton-laptop>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <aef6a427-12af-a77e-994f-37c7a618377c@arm.com>
Date:   Tue, 3 Sep 2019 15:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190903134335.uxxf5kvp3afe7rfr@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

thank you for your review.

On 9/3/19 2:52 PM, Paul Burton wrote:
> Hi Vincenzo,
> 
> On Fri, Aug 30, 2019 at 02:58:57PM +0100, Vincenzo Frascino wrote:
>> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
>> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
>> seccomp setups because these syscalls might be not (yet) allowed.
>>
>> Implement the 32bit variants which use the legacy syscalls and select the
>> variant in the core library.
>>
>> The 64bit time variants are not removed because they are required for the
>> time64 based vdso accessors.
>>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> How would you like this to be applied? I'd be happy to apply this one to
> mips-next, where commit 24640f233b46 ("mips: Add support for generic
> vDSO") added the file being modified here. Otherwise:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>
> 

Please feel free to apply this to mips-next.

Thanks,
Vincenzo

> Thanks,
>     Paul
> 
>> ---
>>  arch/mips/include/asm/vdso/gettimeofday.h | 45 +++++++++++++++++++++++
>>  arch/mips/vdso/config-n32-o32-env.c       |  1 +
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
>> index c59fe08b0347..e78462e8ca2e 100644
>> --- a/arch/mips/include/asm/vdso/gettimeofday.h
>> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
>> @@ -105,6 +105,51 @@ static __always_inline int clock_getres_fallback(
>>  	return error ? -ret : ret;
>>  }
>>  
>> +#if _MIPS_SIM != _MIPS_SIM_ABI64
>> +
>> +#define VDSO_HAS_32BIT_FALLBACK	1
>> +
>> +static __always_inline long clock_gettime32_fallback(
>> +					clockid_t _clkid,
>> +					struct old_timespec32 *_ts)
>> +{
>> +	register struct old_timespec32 *ts asm("a1") = _ts;
>> +	register clockid_t clkid asm("a0") = _clkid;
>> +	register long ret asm("v0");
>> +	register long nr asm("v0") = __NR_clock_gettime;
>> +	register long error asm("a3");
>> +
>> +	asm volatile(
>> +	"       syscall\n"
>> +	: "=r" (ret), "=r" (error)
>> +	: "r" (clkid), "r" (ts), "r" (nr)
>> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
>> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
>> +
>> +	return error ? -ret : ret;
>> +}
>> +
>> +static __always_inline int clock_getres32_fallback(
>> +					clockid_t _clkid,
>> +					struct old_timespec32 *_ts)
>> +{
>> +	register struct old_timespec32 *ts asm("a1") = _ts;
>> +	register clockid_t clkid asm("a0") = _clkid;
>> +	register long ret asm("v0");
>> +	register long nr asm("v0") = __NR_clock_getres;
>> +	register long error asm("a3");
>> +
>> +	asm volatile(
>> +	"       syscall\n"
>> +	: "=r" (ret), "=r" (error)
>> +	: "r" (clkid), "r" (ts), "r" (nr)
>> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
>> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
>> +
>> +	return error ? -ret : ret;
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_CSRC_R4K
>>  
>>  static __always_inline u64 read_r4k_count(void)
>> diff --git a/arch/mips/vdso/config-n32-o32-env.c b/arch/mips/vdso/config-n32-o32-env.c
>> index 7f8d957abd4a..0011a632aef2 100644
>> --- a/arch/mips/vdso/config-n32-o32-env.c
>> +++ b/arch/mips/vdso/config-n32-o32-env.c
>> @@ -10,6 +10,7 @@
>>   */
>>  #undef CONFIG_64BIT
>>  
>> +#define BUILD_VDSO32
>>  #define CONFIG_32BIT 1
>>  #define CONFIG_GENERIC_ATOMIC64 1
>>  #define BUILD_VDSO32_64
>> -- 
>> 2.23.0
>>
