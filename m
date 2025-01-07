Return-Path: <linux-arch+bounces-9615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E11B0A03AFA
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FF6188347C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 09:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5D1E0E01;
	Tue,  7 Jan 2025 09:24:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686B647;
	Tue,  7 Jan 2025 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241845; cv=none; b=osVFP5EfYyP0+rVSswKY0QMqUb0QI3DfLwN0UiLpax78QavNv3B3LW7k/NMP9t+1v2xrKkrIN3Rb3zFJPDaicAV/kz1+BmOe5EAhsVoR9AX7eJ2ZkM7sWZzPsOK0qhPOJso7Ks5UgcLI80RhVDm/veDotYDjAg02KpWQb/kOEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241845; c=relaxed/simple;
	bh=DFJhVvdeLGk2efSvJopONsRNtRHM8RshXpbuce0z+N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vai0vnPDd4IvubWRqHzYG4b2XkeHhLFJY8c9RH8/UwxmfHZbrL/ru+P/gE3P1Tqgwnr3ApRRP4Y8Ua/H71AHu5n7EszDh6m77CZwJo6vlJytkJzyFTwiiwIlnjb5jS/qm7EfmO16Sp9Ibtc/5SgbMLDQ7qvsF3ZIDE8xdrck08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFCE143D;
	Tue,  7 Jan 2025 01:24:31 -0800 (PST)
Received: from [10.57.93.53] (unknown [10.57.93.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96F593F66E;
	Tue,  7 Jan 2025 01:23:54 -0800 (PST)
Message-ID: <83df51a5-5eb9-4470-92a1-e69fd12b98b4@arm.com>
Date: Tue, 7 Jan 2025 10:23:52 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
To: Qi Zheng <zhengqi.arch@bytedance.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
 <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <bce4bb4e-459a-44c8-945b-8889149377fd@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <bce4bb4e-459a-44c8-945b-8889149377fd@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/01/2025 14:23, Qi Zheng wrote:
> On 2025/1/6 20:36, Alexander Gordeev wrote:
>> On Mon, Jan 06, 2025 at 06:55:58PM +0800, Qi Zheng wrote:
>>>>> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
>>>>> +{
>>>>> +    struct folio *folio = ptdesc_folio(ptdesc);
>>>>> +
>>>>> +    ptlock_free(ptdesc);
>>>>> +    __folio_clear_pgtable(folio);
>>>>> +    lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>>>> +}
>>>>> +
>>>>
>>>> If I am not mistaken, it is just pagetable_pte_dtor() rename.
>>>> What is the point in moving the code around?
>>>
>>> No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
>>> that we can move pagetable_dtor() to __tlb_remove_table(), and then
>>> ptlock and PTE page can be freed together through RCU, which is
>>> also the main purpose of this patch series.
>>
>> I am only talking about this patch. pagetable_dtor() code above is
>> the same pagetable_pte_dtor() below - it is only the function name
>> that changed. So why to move the function body? Anyway, that is
>
> Ah, I just don't want to put pagetable_dtor() in between
> pagetable_pte_ctor() and ___pte_offset_map(), so I moved it above
> pagetable_pte_ctor(). No other special reason. 😉 

I think inserting pagetable_dtor() there makes sense. I wouldn't say
that pagetable_pte_dtor() is being renamed to pagetable_dtor(), because
in fact this patch replaces all of pagetable_{pte,pmd,pud}_dtor() with
pagetable_dtor(), and it is arguably clearer to insert the latter higher
up in mm.h.

FWIW my follow-up series introduces a common __pagetable_dtor(),
inserted below pagetable_ctor() [1].

- Kevin

[1]
https://lore.kernel.org/linux-mm/20250103184415.2744423-2-kevin.brodsky@arm.com/

