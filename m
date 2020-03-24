Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9ACE190C85
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgCXLcN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 07:32:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbgCXLcM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 07:32:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D4455B7EA30AA5648347;
        Tue, 24 Mar 2020 19:32:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 19:31:59 +0800
Subject: Re: [RFC PATCH v3 0/4] arm64: tlb: add support for TTL field
To:     Zhenyu Ye <yezhenyu2@huawei.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiexiangyou@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <prime.zeng@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200321121621.1600-1-yezhenyu2@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4e3d42d9-7c57-3659-edbe-1e59ca5b04ea@huawei.com>
Date:   Tue, 24 Mar 2020 19:31:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200321121621.1600-1-yezhenyu2@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Zhenyu,

On 2020/3/21 20:16, Zhenyu Ye wrote:
> --
> ChangeList:
> v3:
> use vma->vm_flags to replace mm->context.flags.
> 
> v2:
> build the patch on Marc's NV series[1].
> 
> v1:
> add support for TTL field in arm64.
> 
> --
> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
> the level of translation table walk holding the leaf entry for the
> address that is being invalidated. Hardware can use this information
> to determine if there was a risk of splintering.
> 
> Marc has provided basic support for ARM64-TTL features on his
> NV series[1] patches. NV is a large feature, however, only
> patches 62[2] and 67[3] are need by this patch set.
> ** You only need read those two patches before review this patch. **

It'd be good if you can put the whole thing into a series, otherwise
people will have difficulty when reviewing and testing it...

I haven't tracked the previous versions. If Marc is OK to share the
two patches below [2][3], I'd suggest you to pick them up, add them
in your series, rebase on top of mainline and resend it.


Thanks,
Zenghui

> 
> Some of this patch depends on a feature powered by @Will Deacon
> two years ago, which tracking the level of page tables in mm_gather.
> See more in commit a6d60245.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-5.6-rc1
> [2] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-63-maz@kernel.org/
> [3] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-68-maz@kernel.org/
> 
> Zhenyu Ye (4):
>    arm64: Add level-hinted TLB invalidation helper to tlbi_user
>    mm: Add page table level flags to vm_flags
>    arm64: tlb: Use translation level hint in vm_flags
>    mm: Set VM_LEVEL flags in some tlb_flush functions
> 
>   arch/arm64/include/asm/mmu.h      |  2 ++
>   arch/arm64/include/asm/tlb.h      | 12 +++++++++
>   arch/arm64/include/asm/tlbflush.h | 44 ++++++++++++++++++++++++++-----
>   arch/arm64/mm/hugetlbpage.c       |  4 +--
>   arch/arm64/mm/mmu.c               | 14 ++++++++++
>   include/asm-generic/pgtable.h     | 16 +++++++++--
>   include/linux/mm.h                | 10 +++++++
>   include/trace/events/mmflags.h    | 15 ++++++++++-
>   mm/huge_memory.c                  |  8 +++++-
>   9 files changed, 113 insertions(+), 12 deletions(-)
> 

