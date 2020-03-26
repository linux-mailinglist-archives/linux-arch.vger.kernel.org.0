Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEF9193975
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 08:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCZHPu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 03:15:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbgCZHPt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Mar 2020 03:15:49 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2F379D56FD4517F2B7F;
        Thu, 26 Mar 2020 15:15:38 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Mar 2020
 15:15:29 +0800
Subject: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <guohanjun@huawei.com>, <will@kernel.org>,
        <linux-arch@vger.kernel.org>, <yuzhao@google.com>,
        <maz@kernel.org>, <steven.price@arm.com>, <arm@kernel.org>,
        <Dave.Martin@arm.com>, <arnd@arndb.de>, <suzuki.poulose@arm.com>,
        <npiggin@gmail.com>, <zhangshaokun@hisilicon.com>,
        <broonie@kernel.org>, <rostedt@goodmis.org>,
        <prime.zeng@hisilicon.com>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>, <xiexiangyou@huawei.com>,
        <linux-kernel@vger.kernel.org>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324150155.GH20713@hirez.programming.kicks-ass.net>
 <fb06ba92-a3ce-6925-e914-167a85837f27@huawei.com>
 <20200325133201.GI20713@hirez.programming.kicks-ass.net>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <43164360-8204-89c6-0d4d-c38b1aa09642@huawei.com>
Date:   Thu, 26 Mar 2020 15:15:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200325133201.GI20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/3/25 21:32, Peter Zijlstra wrote:
> On Wed, Mar 25, 2020 at 12:49:45PM +0800, Zhenyu Ye wrote:
>> Hi Peter,
>>
>> On 2020/3/24 23:01, Peter Zijlstra wrote:
>>> On Tue, Mar 24, 2020 at 09:45:28PM +0800, Zhenyu Ye wrote:
>>>> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
>>>> feature allows TLBs to be issued with a level allowing for quicker
>>>> invalidation.  This series provide support for this feature. 
>>>>
>>>> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
>>>> which detect the TTL feature and add __tlbi_level interface.
>>>
>>> I realy hate how it makes vma->vm_flags more important for tlbi.
>>>
>>
>> Thanks for your review.
>>
>> The tlbi interfaces only have two parameters: vma and addr. If we
>> try to not use vma->vm_flags, we may should have to add a parameter
>> to some of these interfaces(such as flush_tlb_range), which are
>> common to all architectures.
>>
>> I'm not sure if this is feasible, because this feature is only
>> supported by ARM64 currently.
> 
> Power (p9-radix) also has level dependent invalidation instructions, so
> at the very least you can hook them up as well.
> 
> .
>

Thanks, I will push my next version soon.

Zhenyu
.

