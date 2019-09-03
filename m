Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB79A6BD9
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2019 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfICOuB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Sep 2019 10:50:01 -0400
Received: from foss.arm.com ([217.140.110.172]:38518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICOuA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:50:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1EC337;
        Tue,  3 Sep 2019 07:49:59 -0700 (PDT)
Received: from [10.37.8.116] (unknown [10.37.8.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3E663F246;
        Tue,  3 Sep 2019 07:49:57 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
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
 <20190830135902.20861-8-vincenzo.frascino@arm.com>
 <20190903143801.7upetfqe6upouzlh@pburton-laptop>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f783346b-3e33-1bce-f204-f9737ef493e0@arm.com>
Date:   Tue, 3 Sep 2019 15:51:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190903143801.7upetfqe6upouzlh@pburton-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On 9/3/19 3:46 PM, Paul Burton wrote:
> Hi Vincenzo,
> 
> On Fri, Aug 30, 2019 at 02:59:01PM +0100, Vincenzo Frascino wrote:
>> VDSO_HAS_32BIT_FALLBACK has been removed from the core since
>> the architectures that support the generic vDSO library have
>> been converted to support the 32 bit fallbacks.
>>
>> Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.
>>
>> Cc: Paul Burton <paul.burton@mips.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> Do you want this one in mips-next too, or applied somewhere else along
> with the rest of the series? If the latter:
> 
>     Acked-by: Paul Burton <paul.burton@mips.com>
> 

This patch has a dependency on patch n5 hence can not be applied independently.

Thanks,
Vincenzo

> Thanks,
>     Paul
> 
>> ---
>>  arch/mips/include/asm/vdso/gettimeofday.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
>> index e78462e8ca2e..5ad2b086626d 100644
>> --- a/arch/mips/include/asm/vdso/gettimeofday.h
>> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
>> @@ -107,8 +107,6 @@ static __always_inline int clock_getres_fallback(
>>  
>>  #if _MIPS_SIM != _MIPS_SIM_ABI64
>>  
>> -#define VDSO_HAS_32BIT_FALLBACK	1
>> -
>>  static __always_inline long clock_gettime32_fallback(
>>  					clockid_t _clkid,
>>  					struct old_timespec32 *_ts)
>> -- 
>> 2.23.0
>>

