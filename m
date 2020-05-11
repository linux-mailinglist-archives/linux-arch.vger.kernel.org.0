Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7C1CDA46
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgEKMlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 08:41:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4330 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729478AbgEKMlh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 08:41:37 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D7C869F86BFA885B62CA;
        Mon, 11 May 2020 20:41:35 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 11 May 2020
 20:41:27 +0800
Subject: Re: [PATCH v2 0/6] arm64: tlb: add support for TTL feature
To:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <6c59eae9-3a77-ef18-fac4-aa21e97fd1f0@huawei.com>
Date:   Mon, 11 May 2020 20:41:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200423135656.2712-1-yezhenyu2@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

How is this going about this patch series? Does anyone have any
suggestions?

Thanks,
Zhenyu

On 2020/4/23 21:56, Zhenyu Ye wrote:
> In order to reduce the cost of TLB invalidation, ARMv8.4 provides
> the TTL field in TLBI instruction.  The TTL field indicates the
> level of page table walk holding the leaf entry for the address
> being invalidated.  This series provide support for this feature.
> 
> When ARMv8.4-TTL is implemented, the operand for TLBIs looks like
> below:
> 
> * +----------+-------+----------------------+
> * |   ASID   |  TTL  |        BADDR         |
> * +----------+-------+----------------------+
> * |63      48|47   44|43                   0|
> 
> 
> This version updates some codes implementation according to Peter's
> suggestion, and adds some commit msg.
> 
> See patches for details, Thanks.
> 
> 
> --
> ChangeList:
> v2:
> rebase series on Linux 5.7-rc1 and simplify the code implementation.
> 
> v1:
> add support for TTL feature in arm64.
> 
> Marc Zyngier (2):
>   arm64: Detect the ARMv8.4 TTL feature
>   arm64: Add level-hinted TLB invalidation helper
> 
> Peter Zijlstra (Intel) (1):
>   tlb: mmu_gather: add tlb_flush_*_range APIs
> 
> Zhenyu Ye (3):
>   arm64: Add tlbi_user_level TLB invalidation helper
>   mm: tlb: Provide flush_*_tlb_range wrappers
>   arm64: tlb: Set the TTL field in flush_tlb_range
> 
>  arch/arm64/include/asm/cpucaps.h  |  3 +-
>  arch/arm64/include/asm/sysreg.h   |  1 +
>  arch/arm64/include/asm/tlb.h      | 29 +++++++++++++++-
>  arch/arm64/include/asm/tlbflush.h | 54 +++++++++++++++++++++++++-----
>  arch/arm64/kernel/cpufeature.c    | 11 +++++++
>  include/asm-generic/pgtable.h     | 12 +++++--
>  include/asm-generic/tlb.h         | 55 ++++++++++++++++++++++---------
>  mm/pgtable-generic.c              | 22 +++++++++++++
>  8 files changed, 160 insertions(+), 27 deletions(-)
> 

