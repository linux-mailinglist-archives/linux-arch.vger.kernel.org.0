Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC193B24A5
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jun 2021 03:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFXB61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 21:58:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:8314 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXB61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jun 2021 21:58:27 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G9NRM1yJXz71yJ;
        Thu, 24 Jun 2021 09:51:59 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 09:56:06 +0800
Received: from [10.174.186.21] (10.174.186.21) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 09:56:05 +0800
Subject: Re: [PATCH v1] arm64: tlb: fix the TTL value of tlb_get_level
To:     Will Deacon <will@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <aneesh.kumar@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        <steven.price@arm.com>, Peter Zijlstra <peterz@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, Xiexiangyou <xiexiangyou@huawei.com>,
        <liushixin2@huawei.com>, huyaqin <huyaqin1@huawei.com>,
        <zhurui3@huawei.com>
References: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
 <20210623110412.GA32177@willie-the-truck>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <800c06ad-1491-c5ba-c650-c78384bf50c9@huawei.com>
Date:   Thu, 24 Jun 2021 09:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210623110412.GA32177@willie-the-truck>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.21]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021/6/23 19:04, Will Deacon wrote:
> On Wed, Jun 23, 2021 at 03:05:22PM +0800, Zhenyu Ye wrote:
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index 61c97d3b58c7..c995d1f4594f 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -28,6 +28,10 @@ static void tlb_flush(struct mmu_gather *tlb);
>>   */
>>  static inline int tlb_get_level(struct mmu_gather *tlb)
>>  {
>> +	/* The TTL field is only valid for the leaf entry. */
>> +	if (tlb->freed_tables)
>> +		return 0;
>> +
>>  	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
>>  				   tlb->cleared_puds ||
>>  				   tlb->cleared_p4ds))
> 
> Thanks. I can't see a better way around this, so I'll queue the patch.
> The stage-2 page-table code looks ok afaict, but please can you check it
> too?

The stage-2 page-table codes seem to be correct to me.

Thanks,
Zhenyu
