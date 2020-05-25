Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A81E0766
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 08:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgEYG6M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 02:58:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388942AbgEYG6J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 02:58:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 968702E8603D2EE3E816;
        Mon, 25 May 2020 14:58:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 25 May 2020
 14:58:00 +0800
Subject: Re: [PATCH v2 3/6] arm64: Add tlbi_user_level TLB invalidation helper
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
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-4-yezhenyu2@huawei.com> <20200522154925.GE26492@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <67ac92a2-d37b-d472-3cbc-0bc855235c3f@huawei.com>
Date:   Mon, 25 May 2020 14:57:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200522154925.GE26492@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/5/22 23:49, Catalin Marinas wrote:
> On Thu, Apr 23, 2020 at 09:56:53PM +0800, Zhenyu Ye wrote:
>> @@ -190,8 +196,8 @@ static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
>>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>>  
>>  	dsb(ishst);
>> -	__tlbi(vale1is, addr);
>> -	__tlbi_user(vale1is, addr);
>> +	__tlbi_level(vale1is, addr, 0);
>> +	__tlbi_user_level(vale1is, addr, 0);
>>  }
> 
> This one remains with a level 0 throughout the series. Is this
> intentional? If we can't guarantee the level here, better to use the
> non-level __tlbi().
> 

OK, I will change it back to non-level __tlbi().

Thanks,
Zhenyu

