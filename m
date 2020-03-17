Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27C187F43
	for <lists+linux-arch@lfdr.de>; Tue, 17 Mar 2020 12:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgCQK7z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Mar 2020 06:59:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgCQK7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 17 Mar 2020 06:59:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC8CE9A663F0575FBBF9;
        Tue, 17 Mar 2020 18:59:51 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Mar 2020
 18:59:42 +0800
Subject: Re: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
To:     Marc Zyngier <maz@kernel.org>
CC:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
References: <20200311025309.1743-1-yezhenyu2@huawei.com>
 <247ad619edf17eb266f856d937dac826@kernel.org>
From:   "yezhenyu (A)" <yezhenyu2@huawei.com>
Message-ID: <e155d744-4433-b9a6-109f-f665316dd928@huawei.com>
Date:   Tue, 17 Mar 2020 18:59:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <247ad619edf17eb266f856d937dac826@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc,

On 2020/3/11 17:12, Marc Zyngier wrote:
> Zhenyu,
> 
> On 2020-03-11 02:53, Zhenyu Ye wrote:
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated. Hardware can use this information
>> to determine if there was a risk of splintering.
>>
>> This set of patches adds TTL field to __TLBI_ADDR, and uses
>> Architecture-specific MM context to pass the TTL value to tlb interface.
>>
>> The default value of TTL is 0, which will not have any impact on the
>> TLB maintenance instructions. The last patch trys to use TTL field in
>> some obviously tlb-flush interface.
> 
> I have already posted some support for ARMv8.4-TTL as part of my NV series [1],
> patches 62, 67, 68 and 69. This only deals with Stage-2 translation so far.
> If you intend to add Stage-1, please build on top of what I have already posted
> (I can extract the patches on a separate branch if you want).
> 
> Thanks,
> 
>         M.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/

I have sent the PATCH v2 on 2020-03-12 [1]. Do you have any suggestion
for my code?  Is it appropriate to post my code based on your branch?

Looking forward to your suggestions.


Thanks,

	zhenyu

[1] https://lkml.org/lkml/2020/3/12/2
	

