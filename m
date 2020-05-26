Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6654A1E1998
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 04:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbgEZCjw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 22:39:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388428AbgEZCjw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 22:39:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D92A51FB;
        Mon, 25 May 2020 19:39:50 -0700 (PDT)
Received: from [10.163.76.123] (unknown [10.163.76.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3712B3F52E;
        Mon, 25 May 2020 19:39:42 -0700 (PDT)
Subject: Re: [PATCH v3 1/6] arm64: Detect the ARMv8.4 TTL feature
To:     Zhenyu Ye <yezhenyu2@huawei.com>, catalin.marinas@arm.com,
        peterz@infradead.org, mark.rutland@arm.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org,
        maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
References: <20200525125300.794-1-yezhenyu2@huawei.com>
 <20200525125300.794-2-yezhenyu2@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c6b6eb07-2606-9fc0-280a-e53b81a6491c@arm.com>
Date:   Tue, 26 May 2020 08:09:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200525125300.794-2-yezhenyu2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Zhenyu,

On 05/25/2020 06:22 PM, Zhenyu Ye wrote:
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c4ac0ac25a00..477d84ba1056 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -725,6 +725,7 @@
>  
>  /* id_aa64mmfr2 */
>  #define ID_AA64MMFR2_E0PD_SHIFT		60
> +#define ID_AA64MMFR2_TTL_SHIFT		48
>  #define ID_AA64MMFR2_FWB_SHIFT		40
>  #define ID_AA64MMFR2_AT_SHIFT		32
>  #define ID_AA64MMFR2_LVA_SHIFT		16
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9fac745aa7bb..d993dc6dc7d5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -244,6 +244,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
>  
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_E0PD_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_TTL_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
> @@ -1622,6 +1623,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		.cpu_enable = cpu_has_fwb,
>  	},

This patch (https://patchwork.kernel.org/patch/11557359/) is adding some
more ID_AA64MMFR2 features including the TTL. I am going to respin parts
of the V4 series patches along with the above mentioned patch. So please
rebase this series accordingly, probably on latest next.

- Anshuman
