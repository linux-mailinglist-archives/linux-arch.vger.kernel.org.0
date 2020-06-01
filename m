Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323BB1EA65B
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFAO5s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 10:57:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgFAO5s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 10:57:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1D32A44F0A1957BAB3EB;
        Mon,  1 Jun 2020 22:57:46 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 22:57:36 +0800
Subject: Re: [RFC PATCH v3 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <linux-arch@vger.kernel.org>, <suzuki.poulose@arm.com>,
        <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiexiangyou@huawei.com>, <steven.price@arm.com>,
        <zhangshaokun@hisilicon.com>, <linux-mm@kvack.org>,
        <arm@kernel.org>, <prime.zeng@hisilicon.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>,
        <kuhn.chenqun@huawei.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-3-yezhenyu2@huawei.com> <20200514152840.GC1907@gaia>
 <54468aae-dbb1-66bd-c633-82fc75936206@huawei.com>
 <20200520170759.GE18302@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <a159dd5a-7189-308f-9ebc-98f0eadca852@huawei.com>
Date:   Mon, 1 Jun 2020 22:57:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200520170759.GE18302@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

I have sent the v4 of this series [1] and combine the two function with
a single loop.  See codes for details.

[1] https://lore.kernel.org/linux-arm-kernel/20200601144713.2222-1-yezhenyu2@huawei.com/

On 2020/5/21 1:08, Catalin Marinas wrote:
>> This optimization is only effective when the range is a multiple of 256KB
>> (when the page size is 4KB), and I'm worried about the performance
>> of ilog2().  I traced the __flush_tlb_range() last year and found that in
>> most cases the range is less than 256K (see details in [1]).
> 
> THP or hugetlbfs would exercise bigger strides but I guess it depends on
> the use-case. ilog2() should be reduced to a few instructions on arm64
> AFAICT (haven't tried but it should use the CLZ instruction).
> 

Not bigger than 256K, but the range must be a integer multiple of 256KB,
so I still start from scale 0.

Thanks,
Zhenyu

