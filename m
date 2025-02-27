Return-Path: <linux-arch+bounces-10420-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC03FA47596
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 06:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A273ACE18
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABA2153C5;
	Thu, 27 Feb 2025 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eQI4y+Ht"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AB214A96;
	Thu, 27 Feb 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635821; cv=none; b=PFDZtPux8wnMh1V1498x0YZmTO12UDF1kxEGu9aUEnZJ4n8XQLEsi6brDcSMdkW8fXFEKzkwvBIrzFN6PDsO+i0qAuWoybI0BRUor8RNQytRZhE4ZTYp1EpyvtfJaJb5YkdwDjzBddUzwyydr2vYMbTl214P1xXy5qwcOIf/kPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635821; c=relaxed/simple;
	bh=n/7501i6uez9aq/kEbc0SV9ZotnO1lRKSkI807l1+yo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KZcYNRn+fWGwRNEZ8VeeP1R6cB4nyYYFuCFGBsG1no4gY2FTtKG60WuMDKFW0TZWTd2oSTUDWOxicwzMo8JggxhI7QIETix0UiVZz9h0+puK5WHOQ2VPR+wokQy60qmo+u7TOMUsLf4Mrh0+UxPUbRHdVtNr4S1CUcXu47w1iE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eQI4y+Ht; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.197] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 91976210C33B;
	Wed, 26 Feb 2025 21:56:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 91976210C33B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740635819;
	bh=W/MkXUhHX7zH6oQ/rHTcpceutPj8HQjNkQ+KPUdG8HE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=eQI4y+Ht6gcca5/C4U2sEvpTwt7K8Tzgnteh+WyGhNwCTshnKA0XUsTDM9eYfZeIh
	 QjkJYSyHomtHB13FhD0M5CcZVt7UgmmGKqHH++pn/K4lVYxywy06xenvAsZSRgtPnE
	 PIn+AldosomUdd9VeWpBXVnsKZVDKLcOS1bKbEns=
Message-ID: <5f3d660d-fe2e-4ac1-94a7-66d6c8ffe579@linux.microsoft.com>
Date: Wed, 26 Feb 2025 21:56:56 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> These non-nested msr and fast hypercall functions are present in x86,
> but they must be available in both architetures for the root partition

nit: *architectures*


> driver code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
>  arch/arm64/include/asm/mshyperv.h | 12 ++++++++++++
>  include/asm-generic/mshyperv.h    |  2 ++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index 69004f619c57..e33a9e3c366a 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -53,6 +53,23 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
>  }
>  EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
>  
> +/*
> + * hv_do_fast_hypercall16 -- Invoke the specified hypercall
> + * with arguments in registers instead of physical memory.
> + * Avoids the overhead of virt_to_phys for simple hypercalls.
> + */
> +u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
> +{
> +	struct arm_smccc_res	res;
> +	u64			control;
> +
> +	control = (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input1, input2, &res);
> +	return res.a0;
> +}
> +EXPORT_SYMBOL_GPL(hv_do_fast_hypercall16);
> +

I'd like this to have been in arch/arm64/include/asm/mshyperv.h like its x86
counterpart, but that's just my personal liking of symmetry. I see why it's here
with its slow and 8-byte brethren.

>  /*
>   * Set a single VP register to a 64-bit value.
>   */
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index 2e2f83bafcfb..2a900ba00622 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -40,6 +40,18 @@ static inline u64 hv_get_msr(unsigned int reg)
>  	return hv_get_vpreg(reg);
>  }
>  
> +/*
> + * Nested is not supported on arm64
> + */
> +static inline void hv_set_non_nested_msr(unsigned int reg, u64 value)
> +{
> +	hv_set_msr(reg, value);
> +}

empty line preferred here, also reported by checkpatch

> +static inline u64 hv_get_non_nested_msr(unsigned int reg)
> +{
> +	return hv_get_msr(reg);
> +}
> +
>  /* SMCCC hypercall parameters */
>  #define HV_SMCCC_FUNC_NUMBER	1
>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c020d5d0ec2a..258034dfd829 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -72,6 +72,8 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>  
>  extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>  extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> +extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> +

checkpatch warns against putting externs in header files, and FWIW, if hv_do_fast_hypercall16()
for arm64 were in arch/arm64/include/asm/mshyperv.h like its x86 counterpart, you probably
wouldn't need this?

>  bool hv_isolation_type_snp(void);
>  bool hv_isolation_type_tdx(void);
>  


