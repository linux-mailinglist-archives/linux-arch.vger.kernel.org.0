Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66259190DDB
	for <lists+linux-arch@lfdr.de>; Tue, 24 Mar 2020 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgCXMmn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 24 Mar 2020 08:42:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727130AbgCXMmm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 08:42:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ED1D1EFA49A6818519B0;
        Tue, 24 Mar 2020 20:42:19 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Mar 2020 20:42:13 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <yuzenghui@huawei.com>
CC:     <aneesh.kumar@linux.ibm.com>, <arm@kernel.org>,
        <broonie@kernel.org>, <catalin.marinas@arm.com>,
        <guohanjun@huawei.com>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mark.rutland@arm.com>, <maz@kernel.org>,
        <prime.zeng@hisilicon.com>, <steven.price@arm.com>,
        <will@kernel.org>, <xiexiangyou@huawei.com>,
        <yezhenyu2@huawei.com>, <zhangshaokun@hisilicon.com>
Subject: Re: [RFC PATCH v3 0/4] arm64: tlb: add support for TTL field
Date:   Tue, 24 Mar 2020 20:41:44 +0800
Message-ID: <20200324124144.1492-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <4e3d42d9-7c57-3659-edbe-1e59ca5b04ea@huawei.com>
References: <4e3d42d9-7c57-3659-edbe-1e59ca5b04ea@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Zenghui,

On 2020/3/24 19:31, Zenghui Yu wrote:
>Hi Zhenyu,
>
>On 2020/3/21 20:16, Zhenyu Ye wrote:
>> --
>> ChangeList:
>> v3:
>> use vma->vm_flags to replace mm->context.flags.
>> 
>> v2:
>> build the patch on Marc's NV series[1].
>> 
>> v1:
>> add support for TTL field in arm64.
>> 
>> --
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated. Hardware can use this information
>> to determine if there was a risk of splintering.
>> 
>> Marc has provided basic support for ARM64-TTL features on his
>> NV series[1] patches. NV is a large feature, however, only
>> patches 62[2] and 67[3] are need by this patch set.
>> ** You only need read those two patches before review this patch. **
>
>It'd be good if you can put the whole thing into a series, otherwise
>people will have difficulty when reviewing and testing it...
>
>I haven't tracked the previous versions. If Marc is OK to share the
>two patches below [2][3], I'd suggest you to pick them up, add them
>in your series, rebase on top of mainline and resend it.
>
>
>Thanks,
>Zenghui
>

Thanks for your review.  I'd take your suggestion and resend a new set
right now.

Thanks,
Zhenyu

>> 
>> Some of this patch depends on a feature powered by @Will Deacon
>> two years ago, which tracking the level of page tables in mm_gather.
>> See more in commit a6d60245.
>> 
>> [1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-5.6-rc1
>> [2] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-63-maz@kernel.org/
>> [3] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-68-maz@kernel.org/
>> 
>> Zhenyu Ye (4):
>>    arm64: Add level-hinted TLB invalidation helper to tlbi_user
>>    mm: Add page table level flags to vm_flags
>>    arm64: tlb: Use translation level hint in vm_flags
>>    mm: Set VM_LEVEL flags in some tlb_flush functions
>> 
>>   arch/arm64/include/asm/mmu.h      |  2 ++
>>   arch/arm64/include/asm/tlb.h      | 12 +++++++++
>>   arch/arm64/include/asm/tlbflush.h | 44 ++++++++++++++++++++++++++-----
>>   arch/arm64/mm/hugetlbpage.c       |  4 +--
>>   arch/arm64/mm/mmu.c               | 14 ++++++++++
>>   include/asm-generic/pgtable.h     | 16 +++++++++--
>>   include/linux/mm.h                | 10 +++++++
>>   include/trace/events/mmflags.h    | 15 ++++++++++-
>>   mm/huge_memory.c                  |  8 +++++-
>>   9 files changed, 113 insertions(+), 12 deletions(-)
>> 
>
