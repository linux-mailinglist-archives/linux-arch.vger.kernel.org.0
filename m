Return-Path: <linux-arch+bounces-9563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43A8A00555
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 08:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE84C162D13
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891FA93D;
	Fri,  3 Jan 2025 07:46:41 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48511CCB26;
	Fri,  3 Jan 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890400; cv=none; b=B0i7VHqFjEMvbtusSYqWfSWLkuQca00gHqqRtPEQNgzcV7cyE5hwKiGtPYbGY74hIy5xcM7sLvbJ0km/i62C6uRQpkeiNlryl3/zcpEs5Q4C9+aD9IcZ9S/4RrZ8mne+EqzVTCfg29ZxfvbW+io/cFwe/U4g2Nl8iTw5GhpiiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890400; c=relaxed/simple;
	bh=mzXoocIGNPwPKsYdLFaXMb11ojm1vKIwEO1w66c7Yo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffgE1yGggg6/X1CY/EVsV8CWRQawPYb7dCMFVv9GGtyyy0VPzydm6Trk3lMqiidN9YYNdmaeG1G91tHzkEPZ8WvnSmF254n2IXvFyOAE76+Uls6ZNnqWfYK4Grlhk8y792vqpatYfAnjQ9wbkCX6A6dR6EKq1Frey4/YLAtWZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C9D1516;
	Thu,  2 Jan 2025 23:47:05 -0800 (PST)
Received: from [10.57.92.237] (unknown [10.57.92.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E1313F6A8;
	Thu,  2 Jan 2025 23:46:28 -0800 (PST)
Message-ID: <d7f079ea-6530-4f92-9cab-bee90b84e2c3@arm.com>
Date: Fri, 3 Jan 2025 08:46:25 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] mm: pgtable: add statistics for P4D level page
 table
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
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
 <2fa644e37ab917292f5c342e40fa805aa91afbbd.1735549103.git.zhengqi.arch@bytedance.com>
 <237a3bf6-c24f-4feb-8d3d-bb3beb2fd18e@arm.com>
 <77c202bf-e0a3-45e7-bf8d-eef7903e3c64@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <77c202bf-e0a3-45e7-bf8d-eef7903e3c64@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/01/2025 04:53, Qi Zheng wrote:
> On 2025/1/3 00:53, Kevin Brodsky wrote:
>> On 30/12/2024 10:07, Qi Zheng wrote:
>>> diff --git a/arch/riscv/include/asm/pgalloc.h
>>> b/arch/riscv/include/asm/pgalloc.h
>>> index 551d614d3369c..3466fbe2e508d 100644
>>> --- a/arch/riscv/include/asm/pgalloc.h
>>> +++ b/arch/riscv/include/asm/pgalloc.h
>>> @@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct
>>> mmu_gather *tlb, pud_t *pud,
>>>   static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>>>                     unsigned long addr)
>>>   {
>>> -    if (pgtable_l5_enabled)
>>> +    if (pgtable_l5_enabled) {
>>> +        struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
>>> +
>>> +        pagetable_p4d_dtor(ptdesc);
>>>           riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
>>
>> Nit: could use the new ptdesc variable here instead of calling
>> virt_to_ptdesc().
>
> Right, but we will remove pagetable_p4d_dtor() in patch #10, so this
> may not matter.

You're right, I missed that. Makes sense not to create a diff that's
reverted later then :)

- Kevin

