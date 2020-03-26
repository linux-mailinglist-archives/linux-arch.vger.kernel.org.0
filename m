Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA61938D1
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 07:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCZGqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 02:46:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726298AbgCZGqH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 02:46:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB80A3012A2B4E7E1AE2;
        Thu, 26 Mar 2020 14:45:56 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Mar 2020
 14:45:48 +0800
Subject: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
To:     James Morse <james.morse@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <peterz@infradead.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <7859561b-78b4-4a12-2642-3741d7d3e7b8@huawei.com>
Date:   Thu, 26 Mar 2020 14:45:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi James,

On 2020/3/26 0:15, James Morse wrote:
> Hi Zhenyu,
> 
> On 3/24/20 1:45 PM, Zhenyu Ye wrote:
>> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
>> feature allows TLBs to be issued with a level allowing for quicker
>> invalidation.  This series provide support for this feature. 
>>
>> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
>> which detect the TTL feature and add __tlbi_level interface.
> 
> How does this interact with THP?
> (I don't see anything on that in the series.)
> 
> With THP, there is no one answer to the size of mapping in a VMA.
> This is a problem because the arm-arm has in "Translation table level
> hints" in D5.10.2 of DDI0487E.a:
> | If an incorrect value for the entry being invalidated by the
> | instruction is specified in the TTL field, then no entries are
> | required by the architecture to be invalidated from the TLB.
> 
> If we get it wrong, not TLB maintenance occurs!
> 

Thanks for your review.  With THP, we should update the TTL value
after the page collapse and merge.  If not sure what it should be,
we can set it to 0 to avoid "no TLB maintenance occur" problem.
The Table D5-53 in DDI0487E.a says:
| when TTL[1:0] is 0b00:
|   This value is reserved, and hardware should treat this as if TTL[3:2] is 0b00
| when TTL[3:2] is 0b00:
|   Hardware must assume that the entry can be from any level.

> Unless THP leaves its fingerprints on the vma, I think you can only do
> this for VMA types that THP can't mess with. (see
> transparent_hugepage_enabled())
> 

I will try to add struct mmu_gather to TLBI interfaces, which has enough
info to track tlb's level.  See in next patch version!


Thanks,
Zhenyu

.

