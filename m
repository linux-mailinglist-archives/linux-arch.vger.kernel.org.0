Return-Path: <linux-arch+bounces-1279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA82F823FC7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 11:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692611F25277
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD96720DD8;
	Thu,  4 Jan 2024 10:46:19 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC020DDD;
	Thu,  4 Jan 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D55FC0006;
	Thu,  4 Jan 2024 10:46:14 +0000 (UTC)
Message-ID: <509f3dd7-1c38-4b98-b21b-28d50399a344@ghiti.fr>
Date: Thu, 4 Jan 2024 11:46:14 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] riscv: enable HAVE_FAST_GUP if MMU
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20231219175046.2496-1-jszhang@kernel.org>
 <20231219175046.2496-5-jszhang@kernel.org>
 <3d36ca3c-9a91-41a7-9e68-288982c2c8a8@ghiti.fr> <ZZOCRZjBch1grrFp@xhacker>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZZOCRZjBch1grrFp@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 02/01/2024 04:25, Jisheng Zhang wrote:
> On Sun, Dec 31, 2023 at 07:37:33AM +0100, Alexandre Ghiti wrote:
>> On 19/12/2023 18:50, Jisheng Zhang wrote:
>>> Activate the fast gup for riscv mmu platforms. Here are some
>>> GUP_FAST_BENCHMARK performance numbers:
>>>
>>> Before the patch:
>>> GUP_FAST_BENCHMARK: Time: get:53203 put:5085 us
>>>
>>> After the patch:
>>> GUP_FAST_BENCHMARK: Time: get:17711 put:5060 us
>>
>> On which platform did you run this benchmark?
> T-HEAD th1520(cpufreq isn't enabled since the clk/pll isn't upstreamed,
> so cpu is running at the default freq set by u-boot)
>>
>>> The get time is reduced by 66.7%! IOW, 3x get speed!
>>
>> Well done!
>>
>> Thanks,
>>
>> Alex
>>
>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> ---
>>>    arch/riscv/Kconfig               | 1 +
>>>    arch/riscv/include/asm/pgtable.h | 6 ++++++
>>>    2 files changed, 7 insertions(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index d3555173d9f4..04df9920282d 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -119,6 +119,7 @@ config RISCV
>>>    	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>>>    	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
>>>    	select HAVE_EBPF_JIT if MMU
>>> +	select HAVE_FAST_GUP if MMU
>>>    	select HAVE_FUNCTION_ARG_ACCESS_API
>>>    	select HAVE_FUNCTION_ERROR_INJECTION
>>>    	select HAVE_GCC_PLUGINS
>>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>>> index ab00235b018f..c6eb214139e6 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -673,6 +673,12 @@ static inline int pmd_write(pmd_t pmd)
>>>    	return pte_write(pmd_pte(pmd));
>>>    }
>>> +#define pud_write pud_write
>>> +static inline int pud_write(pud_t pud)
>>> +{
>>> +	return pte_write(pud_pte(pud));
>>> +}
>>> +
>>>    static inline int pmd_dirty(pmd_t pmd)
>>>    {
>>>    	return pte_dirty(pmd_pte(pmd));


Thanks, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

