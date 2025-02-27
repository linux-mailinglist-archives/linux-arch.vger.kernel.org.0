Return-Path: <linux-arch+bounces-10433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4DA48784
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 19:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345113A3C40
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AA7231A42;
	Thu, 27 Feb 2025 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PmR8jm+e"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C7722FF4D;
	Thu, 27 Feb 2025 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679802; cv=none; b=bfrOx3wPMGKIkgBzdCE0QjGEw8EA1TGitYocZfeVTXUBCt0ztcSd9QjRVAJ/mYUJZoQbzJ66VcS1a84ONa//+hqnSHAJwz2+MzmVNBa8btecLtvowIeNPhKdEQDTim2njlQV9+4GR2UmvegGBCFqs3qsrA9M/++XlB1F4tv2Fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679802; c=relaxed/simple;
	bh=UJ29GXqR1xOqD5wP4/T1f63UJV4YWobyXBoSuD/X/ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih/Vca/ypYrXYC3Q9huRJvyaQVjJkdGHIFedTsjz0U5sFtewRNa96w41XfhNfWR0J4PVCccxnadypJMNXzJ8gwIgDhxA+aL2Hxh7aV9lhmUcAB7gjCfKEPxEdL90gowvD4k208bgE/JgMLJmhOk1IHMRFPQldotOiZ0RqKiX4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PmR8jm+e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 10CD5210D0D8;
	Thu, 27 Feb 2025 10:10:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 10CD5210D0D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740679800;
	bh=KeYtkcgDZD7jrGalV3gn7cspJ+K9p8TNK/AvqR9qhMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PmR8jm+eJp9kQKiEE+jGdsgon6HrbL9A7dQ3q/qr39B3aqwYrYfU9urOx4uE5QKhf
	 30NvnRXCZS7W9GcXPKmZoAUTNcacqW43TCgCLebkks/X3aBEKEJj6T4r0IFN13E8HE
	 PPVD/rmzFnTxYicN4iD+Zx91upc7yZ5qBUnIk9CE=
Message-ID: <c0df9fd7-6e09-4326-b4f4-2524140dc86b@linux.microsoft.com>
Date: Thu, 27 Feb 2025 10:09:59 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] arm64/hyperv: Add some missing functions to
 arm64
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1740611284-27506-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> These non-nested msr and fast hypercall functions are present in x86,
> but they must be available in both architetures for the root partition
> driver code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>   arch/arm64/hyperv/hv_core.c       | 17 +++++++++++++++++
>   arch/arm64/include/asm/mshyperv.h | 12 ++++++++++++
>   include/asm-generic/mshyperv.h    |  2 ++
>   3 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index 69004f619c57..e33a9e3c366a 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -53,6 +53,23 @@ u64 hv_do_fast_hypercall8(u16 code, u64 input)
>   }
>   EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
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
>   /*
>    * Set a single VP register to a 64-bit value.
>    */
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index 2e2f83bafcfb..2a900ba00622 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -40,6 +40,18 @@ static inline u64 hv_get_msr(unsigned int reg)
>   	return hv_get_vpreg(reg);
>   }
>   
> +/*
> + * Nested is not supported on arm64
> + */
> +static inline void hv_set_non_nested_msr(unsigned int reg, u64 value)
> +{
> +	hv_set_msr(reg, value);
> +}
> +static inline u64 hv_get_non_nested_msr(unsigned int reg)
> +{
> +	return hv_get_msr(reg);
> +}
> +
>   /* SMCCC hypercall parameters */
>   #define HV_SMCCC_FUNC_NUMBER	1
>   #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index c020d5d0ec2a..258034dfd829 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -72,6 +72,8 @@ extern void * __percpu *hyperv_pcpu_output_arg;
>   
>   extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
>   extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
> +extern u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
> +
>   bool hv_isolation_type_snp(void);
>   bool hv_isolation_type_tdx(void);
>   

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman


