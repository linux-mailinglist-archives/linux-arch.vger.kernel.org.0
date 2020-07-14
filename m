Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAB21F333
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGNN5D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 09:57:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgGNN5D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jul 2020 09:57:03 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A5B01131134F9A7732CE;
        Tue, 14 Jul 2020 21:51:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.75) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Jul 2020
 21:51:44 +0800
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <guohanjun@huawei.com>, <olof@lixom.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com> <20200714103629.GA18793@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <cda3d6bc-a7e2-5669-372c-3c34cc822e08@huawei.com>
Date:   Tue, 14 Jul 2020 21:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200714103629.GA18793@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/7/14 18:36, Catalin Marinas wrote:
> On Fri, Jul 10, 2020 at 05:44:20PM +0800, Zhenyu Ye wrote:
>> +#define __TLBI_RANGE_PAGES(num, scale)	(((num) + 1) << (5 * (scale) + 1))
>> +#define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
>> +
>> +#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
>> +#define __TLBI_RANGE_NUM(range, scale)	\
>> +	(((range) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK)
> [...]
>> +	int num = 0;
>> +	int scale = 0;
> [...]
>> +			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> [...]
> 
> Since num is an int, __TLBI_RANGE_PAGES is still an int. Shifting it by
> PAGE_SHIFT can overflow as the maximum would be 8GB for 4K pages (or
> 128GB for 64K pages). I think we probably get away with this because of
> some implicit type conversion but I'd rather make __TLBI_RANGE_PAGES an
> explicit unsigned long:
> 
> #define __TLBI_RANGE_PAGES(num, scale)	((unsigned long)((num) + 1) << (5 * (scale) + 1))
> 

This is valuable and I will update this in next series, with the check
for binutils (or encode the instructions by hand), as soon as possible.

> Without this change, the CBMC check fails (see below for the test). In
> the kernel, we don't have this problem as we encode the address via
> __TLBI_VADDR_RANGE and it doesn't overflow.> The good part is that CBMC reckons the algorithm is correct ;).

Thanks for your test!

Zhenyu

