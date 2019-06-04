Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A347434657
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 14:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfFDMNZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 08:13:25 -0400
Received: from foss.arm.com ([217.140.101.70]:41718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfFDMNY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jun 2019 08:13:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD5980D;
        Tue,  4 Jun 2019 05:13:24 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A9C3F690;
        Tue,  4 Jun 2019 05:13:20 -0700 (PDT)
Subject: Re: [PATCH v6 18/19] x86: Add support for generic vDSO
To:     Michael Kelley <mikelley@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <97175325-1619-fd38-2a5c-c71b3b161808@arm.com>
Date:   Tue, 4 Jun 2019 13:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On 30/05/2019 16:41, Michael Kelley wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com> On Thursday, May 30, 2019 7:16 AM
>>
>> The x86 vDSO library requires some adaptations to take advantage of the
>> newly introduced generic vDSO library.
>>
>> Introduce the following changes:
>>  - Modification of vdso.c to be compliant with the common vdso datapage
>>  - Use of lib/vdso for gettimeofday
>>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>>
>> diff --git a/arch/x86/include/asm/mshyperv-tsc.h b/arch/x86/include/asm/mshyperv-tsc.h
>> new file mode 100644
>> index 000000000000..99c98ccea0bf
>> --- /dev/null
>> +++ b/arch/x86/include/asm/mshyperv-tsc.h
>> @@ -0,0 +1,76 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_MSHYPER_TSCPAGE_H
>> +#define _ASM_X86_MSHYPER_TSCPAGE_H
>> +
>> +#include <asm/hyperv-tlfs.h>
>> +
>> +#ifdef CONFIG_HYPERV_TSCPAGE
>> +struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>> +				       u64 *cur_tsc)
>> +{
>> +	u64 scale, offset;
>> +	u32 sequence;
>> +
>> +	/*
>> +	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
>> +	 * Top-Level Functional Specification ver. 3.0 and above. To get the
>> +	 * reference time we must do the following:
>> +	 * - READ ReferenceTscSequence
>> +	 *   A special '0' value indicates the time source is unreliable and we
>> +	 *   need to use something else. The currently published specification
>> +	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
>> +	 *   instead of '0' as the special value, see commit c35b82ef0294.
>> +	 * - ReferenceTime =
>> +	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
>> +	 * - READ ReferenceTscSequence again. In case its value has changed
>> +	 *   since our first reading we need to discard ReferenceTime and repeat
>> +	 *   the whole sequence as the hypervisor was updating the page in
>> +	 *   between.
>> +	 */
>> +	do {
>> +		sequence = READ_ONCE(tsc_pg->tsc_sequence);
>> +		if (!sequence)
>> +			return U64_MAX;
>> +		/*
>> +		 * Make sure we read sequence before we read other values from
>> +		 * TSC page.
>> +		 */
>> +		smp_rmb();
>> +
>> +		scale = READ_ONCE(tsc_pg->tsc_scale);
>> +		offset = READ_ONCE(tsc_pg->tsc_offset);
>> +		*cur_tsc = rdtsc_ordered();
>> +
>> +		/*
>> +		 * Make sure we read sequence after we read all other values
>> +		 * from TSC page.
>> +		 */
>> +		smp_rmb();
>> +
>> +	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
>> +
>> +	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
>> +}
>> +
>> +static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
>> +{
>> +	u64 cur_tsc;
>> +
>> +	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
>> +}
>> +
>> +#else
>> +static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>> +				       u64 *cur_tsc)
>> +{
>> +	BUG();
>> +	return U64_MAX;
>> +}
>> +#endif
>> +#endif
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index cc60e617931c..db095a992f3e 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -7,6 +7,7 @@
>>  #include <linux/nmi.h>
>>  #include <asm/io.h>
>>  #include <asm/hyperv-tlfs.h>
>> +#include <asm/mshyperv-tsc.h>
>>  #include <asm/nospec-branch.h>
>>
>>  #define VP_INVAL	U32_MAX
>> @@ -387,73 +388,4 @@ static inline int hyperv_flush_guest_mapping_range(u64 as,
>>  }
>>  #endif /* CONFIG_HYPERV */
>>
>> -#ifdef CONFIG_HYPERV_TSCPAGE
>> -struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
>> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>> -				       u64 *cur_tsc)
>> -{
>> -	u64 scale, offset;
>> -	u32 sequence;
>> -
>> -	/*
>> -	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
>> -	 * Top-Level Functional Specification ver. 3.0 and above. To get the
>> -	 * reference time we must do the following:
>> -	 * - READ ReferenceTscSequence
>> -	 *   A special '0' value indicates the time source is unreliable and we
>> -	 *   need to use something else. The currently published specification
>> -	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
>> -	 *   instead of '0' as the special value, see commit c35b82ef0294.
>> -	 * - ReferenceTime =
>> -	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
>> -	 * - READ ReferenceTscSequence again. In case its value has changed
>> -	 *   since our first reading we need to discard ReferenceTime and repeat
>> -	 *   the whole sequence as the hypervisor was updating the page in
>> -	 *   between.
>> -	 */
>> -	do {
>> -		sequence = READ_ONCE(tsc_pg->tsc_sequence);
>> -		if (!sequence)
>> -			return U64_MAX;
>> -		/*
>> -		 * Make sure we read sequence before we read other values from
>> -		 * TSC page.
>> -		 */
>> -		smp_rmb();
>> -
>> -		scale = READ_ONCE(tsc_pg->tsc_scale);
>> -		offset = READ_ONCE(tsc_pg->tsc_offset);
>> -		*cur_tsc = rdtsc_ordered();
>> -
>> -		/*
>> -		 * Make sure we read sequence after we read all other values
>> -		 * from TSC page.
>> -		 */
>> -		smp_rmb();
>> -
>> -	} while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
>> -
>> -	return mul_u64_u64_shr(*cur_tsc, scale, 64) + offset;
>> -}
>> -
>> -static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
>> -{
>> -	u64 cur_tsc;
>> -
>> -	return hv_read_tsc_page_tsc(tsc_pg, &cur_tsc);
>> -}
>> -
>> -#else
>> -static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
>> -{
>> -	return NULL;
>> -}
>> -
>> -static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
>> -				       u64 *cur_tsc)
>> -{
>> -	BUG();
>> -	return U64_MAX;
>> -}
>> -#endif
>>  #endif
> 
> Vincenzo -- these changes for Hyper-V are a subset of a larger patch set
> I have that moves all of the Hyper-V clock/timer code into a separate
> clocksource driver in drivers/clocksource, with an include file in
> includes/clocksource.  That new include file should be able to work
> instead of your new mshyperv-tsc.h.  It also has the benefit of being
> ISA neutral, so it will work with my in-progress patch set to support
> Linux on Hyper-V on ARM64.  See https://lkml.org/lkml/2019/5/27/231
> for the new clocksource driver patch set.
>

Thank you for pointing this out, I will rebase my changes on your patches.


> Michael
> 

-- 
Regards,
Vincenzo
