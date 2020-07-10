Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5684021AC76
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGJBVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:21:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbgGJBVO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 21:21:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5C638CEB53E9A7DF348C;
        Fri, 10 Jul 2020 09:21:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.75) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Jul 2020
 09:21:02 +0800
Subject: Re: [RESEND PATCH v5 3/6] arm64: Add tlbi_user_level TLB invalidation
 helper
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200625080314.230-1-yezhenyu2@huawei.com>
 <20200625080314.230-4-yezhenyu2@huawei.com> <20200709164845.GB6579@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <33a5dc75-8209-e198-bb41-8b4ab82c000e@huawei.com>
Date:   Fri, 10 Jul 2020 09:20:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200709164845.GB6579@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 2020/7/10 0:48, Catalin Marinas wrote:
> On Thu, Jun 25, 2020 at 04:03:11PM +0800, Zhenyu Ye wrote:
>> @@ -189,8 +195,9 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>>  
>>  	dsb(ishst);
>> -	__tlbi(vale1is, addr);
>> -	__tlbi_user(vale1is, addr);
>> +	/* This function is only called on a small page */
>> +	__tlbi_level(vale1is, addr, 3);
>> +	__tlbi_user_level(vale1is, addr, 3);
>>  }
> 
> Actually, that's incorrect. It was ok in v2 of your patches when I
> suggested to drop level 0, just leave the function unchanged but I
> missed that you updated it to pass level 3.
> 
> pmdp_set_access_flags -> ptep_set_access_flags ->
> flush_tlb_fix_spurious_fault -> flush_tlb_page -> flush_tlb_page_nosync.

How do you want to fix this error? I notice that this series have been applied
to arm64 (for-next/tlbi).  Should I send a new series based on arm64 (for-next/tlbi)?

Thanks,
Zhenyu

