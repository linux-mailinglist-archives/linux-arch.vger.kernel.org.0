Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BCE1D6F9A
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 06:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgEREWv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 00:22:51 -0400
Received: from foss.arm.com ([217.140.110.172]:33200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgEREWu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 00:22:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E4D7101E;
        Sun, 17 May 2020 21:22:50 -0700 (PDT)
Received: from [10.163.74.67] (unknown [10.163.74.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 650DB3F68F;
        Sun, 17 May 2020 21:22:45 -0700 (PDT)
Subject: Re: [RFC PATCH v3 1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE
 feature
To:     Zhenyu Ye <yezhenyu2@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com,
        olof@lixom.net, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiexiangyou@huawei.com,
        zhangshaokun@hisilicon.com, linux-mm@kvack.org, arm@kernel.org,
        prime.zeng@hisilicon.com, kuhn.chenqun@huawei.com,
        linux-arm-kernel@lists.infradead.org
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-2-yezhenyu2@huawei.com>
 <20200505101405.GB82424@C02TD0UTHF1T.local>
 <cb9d32b6-a9d8-3737-e69d-df4191b7afa9@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4d8cb48c-4f47-d966-f29b-3343bd966c5f@arm.com>
Date:   Mon, 18 May 2020 09:52:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb9d32b6-a9d8-3737-e69d-df4191b7afa9@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 05/11/2020 05:55 PM, Zhenyu Ye wrote:
> On 2020/5/5 18:14, Mark Rutland wrote:
>> On Tue, Apr 14, 2020 at 07:28:34PM +0800, Zhenyu Ye wrote:
>>> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>>> range of input addresses. This patch detect this feature.
>>>
>>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>>> ---
>>>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>>>  arch/arm64/include/asm/sysreg.h  |  4 ++++
>>>  arch/arm64/kernel/cpufeature.c   | 11 +++++++++++
>>>  3 files changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
>>> index 8eb5a088ae65..950095a72617 100644
>>> --- a/arch/arm64/include/asm/cpucaps.h
>>> +++ b/arch/arm64/include/asm/cpucaps.h
>>> @@ -61,7 +61,8 @@
>>>  #define ARM64_HAS_AMU_EXTN			51
>>>  #define ARM64_HAS_ADDRESS_AUTH			52
>>>  #define ARM64_HAS_GENERIC_AUTH			53
>>> +#define ARM64_HAS_TLBI_RANGE			54
>>>  
>>> -#define ARM64_NCAPS				54
>>> +#define ARM64_NCAPS				55
>>>  
>>>  #endif /* __ASM_CPUCAPS_H */
>>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>>> index ebc622432831..ac1b98650234 100644
>>> --- a/arch/arm64/include/asm/sysreg.h
>>> +++ b/arch/arm64/include/asm/sysreg.h
>>> @@ -592,6 +592,7 @@
>>>  
>>>  /* id_aa64isar0 */
>>>  #define ID_AA64ISAR0_RNDR_SHIFT		60
>>> +#define ID_AA64ISAR0_TLBI_RANGE_SHIFT	56
>>>  #define ID_AA64ISAR0_TS_SHIFT		52
>>>  #define ID_AA64ISAR0_FHM_SHIFT		48
>>>  #define ID_AA64ISAR0_DP_SHIFT		44
>>> @@ -605,6 +606,9 @@
>>>  #define ID_AA64ISAR0_SHA1_SHIFT		8
>>>  #define ID_AA64ISAR0_AES_SHIFT		4
>>>  
>>> +#define ID_AA64ISAR0_TLBI_RANGE_NI	0x0
>>> +#define ID_AA64ISAR0_TLBI_RANGE		0x2
>>> +
>>>  /* id_aa64isar1 */
>>>  #define ID_AA64ISAR1_I8MM_SHIFT		52
>>>  #define ID_AA64ISAR1_DGH_SHIFT		48
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 9fac745aa7bb..31bcfd0722b5 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -124,6 +124,7 @@ static bool __system_matches_cap(unsigned int n);
>>>   */
>>>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>>>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
>>> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TLBI_RANGE_SHIFT, 4, 0),

Hello Zhenyu,

This is already being added through another patch [1] in a series [2] which primarily
has cpufeature changes. I will soon update the series making this feature FTR_HIDDEN.

[1] https://patchwork.kernel.org/patch/11523881/
[2] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=281211

I am planning to respin the series (V4) based on arm64 tree (for-next/cpufeature). So
could you please rebase this patch (probably dropping cpufeature related changes) on
upcoming V4, so that all the changes will be based on arm64 tree (for-next/cpufeature).

- Anshuman
