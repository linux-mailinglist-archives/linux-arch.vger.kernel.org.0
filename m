Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951E51CD9A4
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 14:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgEKMZv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 May 2020 08:25:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4389 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729763AbgEKMZs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 May 2020 08:25:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 009F7FA603E696F8AFB2;
        Mon, 11 May 2020 20:25:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 11 May 2020
 20:25:32 +0800
Subject: Re: [RFC PATCH v3 1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE
 feature
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiexiangyou@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <prime.zeng@hisilicon.com>,
        <kuhn.chenqun@huawei.com>, <linux-arm-kernel@lists.infradead.org>
References: <20200414112835.1121-1-yezhenyu2@huawei.com>
 <20200414112835.1121-2-yezhenyu2@huawei.com>
 <20200505101405.GB82424@C02TD0UTHF1T.local>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <cb9d32b6-a9d8-3737-e69d-df4191b7afa9@huawei.com>
Date:   Mon, 11 May 2020 20:25:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200505101405.GB82424@C02TD0UTHF1T.local>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/5/5 18:14, Mark Rutland wrote:
> On Tue, Apr 14, 2020 at 07:28:34PM +0800, Zhenyu Ye wrote:
>> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
>> range of input addresses. This patch detect this feature.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>>  arch/arm64/include/asm/cpucaps.h |  3 ++-
>>  arch/arm64/include/asm/sysreg.h  |  4 ++++
>>  arch/arm64/kernel/cpufeature.c   | 11 +++++++++++
>>  3 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
>> index 8eb5a088ae65..950095a72617 100644
>> --- a/arch/arm64/include/asm/cpucaps.h
>> +++ b/arch/arm64/include/asm/cpucaps.h
>> @@ -61,7 +61,8 @@
>>  #define ARM64_HAS_AMU_EXTN			51
>>  #define ARM64_HAS_ADDRESS_AUTH			52
>>  #define ARM64_HAS_GENERIC_AUTH			53
>> +#define ARM64_HAS_TLBI_RANGE			54
>>  
>> -#define ARM64_NCAPS				54
>> +#define ARM64_NCAPS				55
>>  
>>  #endif /* __ASM_CPUCAPS_H */
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index ebc622432831..ac1b98650234 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -592,6 +592,7 @@
>>  
>>  /* id_aa64isar0 */
>>  #define ID_AA64ISAR0_RNDR_SHIFT		60
>> +#define ID_AA64ISAR0_TLBI_RANGE_SHIFT	56
>>  #define ID_AA64ISAR0_TS_SHIFT		52
>>  #define ID_AA64ISAR0_FHM_SHIFT		48
>>  #define ID_AA64ISAR0_DP_SHIFT		44
>> @@ -605,6 +606,9 @@
>>  #define ID_AA64ISAR0_SHA1_SHIFT		8
>>  #define ID_AA64ISAR0_AES_SHIFT		4
>>  
>> +#define ID_AA64ISAR0_TLBI_RANGE_NI	0x0
>> +#define ID_AA64ISAR0_TLBI_RANGE		0x2
>> +
>>  /* id_aa64isar1 */
>>  #define ID_AA64ISAR1_I8MM_SHIFT		52
>>  #define ID_AA64ISAR1_DGH_SHIFT		48
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 9fac745aa7bb..31bcfd0722b5 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -124,6 +124,7 @@ static bool __system_matches_cap(unsigned int n);
>>   */
>>  static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
>>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_RNDR_SHIFT, 4, 0),
>> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_TLBI_RANGE_SHIFT, 4, 0),
> 
> This should be FTR_HIDDEN as userspace has no reason to see this.
> 
> Otherwise this all seems to match the ARM ARM.
> 
> Mark.
> 

OK, I will change it to FTR_HIDDEN in next version series.

Thanks,
Zhenyu


