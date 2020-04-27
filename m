Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64FC1BA1F7
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0LJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 07:09:51 -0400
Received: from foss.arm.com ([217.140.110.172]:33816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0LJv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 07:09:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4330A1FB;
        Mon, 27 Apr 2020 04:09:50 -0700 (PDT)
Received: from [10.37.12.144] (unknown [10.37.12.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0ECA3F73D;
        Mon, 27 Apr 2020 04:09:47 -0700 (PDT)
Subject: Re: [PATCH v3 21/23] arm64: mte: Check the DT memory nodes for MTE
 support
To:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, Vincenzo.Frascino@arm.com, Szabolcs.Nagy@arm.com,
        Richard.Earnshaw@arm.com, kevin.brodsky@arm.com,
        andreyknvl@google.com, pcc@google.com, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Rob.Herring@arm.com,
        mark.rutland@arm.com
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-22-catalin.marinas@arm.com> <20200424135735.GB5551@gaia>
 <20200424161742.GE5551@gaia>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <43762365-60f6-e271-1338-795e8d7fbb72@arm.com>
Date:   Mon, 27 Apr 2020 12:14:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200424161742.GE5551@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 04/24/2020 05:17 PM, Catalin Marinas wrote:
> On Fri, Apr 24, 2020 at 02:57:36PM +0100, Catalin Marinas wrote:
>> On Tue, Apr 21, 2020 at 03:26:01PM +0100, Catalin Marinas wrote:
>>> Even if the ID_AA64PFR1_EL1 register advertises the presence of MTE, it
>>> is not guaranteed that the memory system on the SoC supports the
>>> feature. In the absence of system-wide MTE support, the behaviour is
>>> undefined and the kernel should not enable the MTE memory type in
>>> MAIR_EL1.
>>>
>>> For FDT, add an 'arm,armv8.5-memtag' property to the /memory nodes and
>>> check for its presence during MTE probing. For example:
>>>
>>> 	memory@80000000 {
>>> 		device_type = "memory";
>>> 		arm,armv8.5-memtag;
>>> 		reg = <0x00000000 0x80000000 0 0x80000000>,
>>> 		      <0x00000008 0x80000000 0 0x80000000>;
>>> 	};
>>>
>>> If the /memory nodes are not present in DT or if at least one node does
>>> not support MTE, the feature will be disabled. On EFI systems, it is
>>> assumed that the memory description matches the EFI memory map (if not,
>>> it is considered a firmware bug).
>>>
>>> MTE is not currently supported on ACPI systems.
>>>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Rob Herring <Rob.Herring@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
>>
>> This patch turns out to be incomplete. While it does not expose the
>> HWCAP2_MTE to user when the above DT property is not present, it still
>> allows user access to the ID_AA64PFR1_EL1.MTE field (via MRS emulations)
>> since it is marked as visible.
> 
> Attempt below at moving the check to the CPUID fields setup. This way we
> can avoid the original patch entirely since the sanitised id regs will
> have a zero MTE field if DT doesn't support it.
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index afc315814563..0a24d36bf231 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -61,6 +61,7 @@ struct arm64_ftr_bits {
>   	u8		shift;
>   	u8		width;
>   	s64		safe_val; /* safe value for FTR_EXACT features */
> +	s64		(*filter)(const struct arm64_ftr_bits *, s64);
>   };
>   
>   /*
> @@ -542,7 +543,10 @@ cpuid_feature_extract_field(u64 features, int field, bool sign)
>   
>   static inline s64 arm64_ftr_value(const struct arm64_ftr_bits *ftrp, u64 val)
>   {
> -	return (s64)cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width, ftrp->sign);
> +	s64 fval = (s64)cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width, ftrp->sign);
> +	if (ftrp->filter)
> +		fval = ftrp->filter(ftrp, fval);
> +	return fval;
>   }
>   

This change makes sure that the sanitised infrastructure is initialised
with masked value and all consumers see a "sanitised" value, including
KVM (unless they emulate it directly on the local CPU)




>   
> +#ifdef CONFIG_ARM64_MTE
> +s64 mte_ftr_filter(const struct arm64_ftr_bits *ftrp, s64 val)
> +{
> +	struct device_node *np;
> +	static bool memory_checked = false;
> +	static bool mte_capable = true;
> +
> +	/* EL0-only MTE is not supported by Linux, don't expose it */
> +	if (val < ID_AA64PFR1_MTE)
> +		return ID_AA64PFR1_MTE_NI;
> +
> +	if (memory_checked)
> +		return mte_capable ? val : ID_AA64PFR1_MTE_NI;
> +
> +	if (!acpi_disabled) {
> +		pr_warn("MTE not supported on ACPI systems\n");
> +		return ID_AA64PFR1_MTE_NI;
> +	}
> +
> +	/* check the DT "memory" nodes for MTE support */
> +	for_each_node_by_type(np, "memory") {
> +		memory_checked = true;
> +		mte_capable &= of_property_read_bool(np, "arm,armv8.5-memtag");
> +	}
> +
> +	if (!memory_checked || !mte_capable) {
> +		pr_warn("System memory is not MTE-capable\n");
> +		memory_checked = true;
> +		mte_capable = false;
> +		return ID_AA64PFR1_MTE_NI;
> +	}
> +
> +	return val;
> +}
> +#endif
> +
>   /*
>    * NOTE: Any changes to the visibility of features should be kept in
>    * sync with the documentation of the CPU feature register ABI.
> @@ -184,8 +225,10 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>   
>   static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
> -	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_MTE),
> -		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MTE_SHIFT, 4, ID_AA64PFR1_MTE_NI),
> +#ifdef CONFIG_ARM64_MTE
> +	FILTERED_ARM64_FTR_BITS(FTR_UNSIGNED, FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE,
> +				ID_AA64PFR1_MTE_SHIFT, 4, ID_AA64PFR1_MTE_NI, mte_ftr_filter),
> +#endif
>   	ARM64_FTR_END,
>   };
>   

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

