Return-Path: <linux-arch+bounces-10440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F5A48A4A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28567A4217
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD324E00D;
	Thu, 27 Feb 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q38XJ4wZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234841A9B2A;
	Thu, 27 Feb 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740690477; cv=none; b=uLGtpX99c+tpnYZNo/NMCcpM7UvKVG1c2ewLHK29UmKFd2/MSyFo/Ro7+mDFcDdgKWpAtVuCD8Ntu66A8x+uVHH0HeK5pKLu3baqfxKsrKidHBU5oa9cDYBCsp1j6wZoEysOGaPMe4heksxjvHvNx3EHpQy9hD0w+Pbsy1/shag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740690477; c=relaxed/simple;
	bh=Fi9jUvZvCG6GYfCZYsMhxN2ciNunPlLnqb2YNjzyTxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA13rNBCaMA09OGHnMvPN8uCRkJHerJsd3PQ+O7FEzlJ1Ph3RBz3B1eriPd2Fwpc9XCEiSdKRwMcCZ1Wy+2UtS+1SHt75fZq7VZDmqzS9BTbMiieGBIjRH/AEMZDOWWHiJw+JYZfZLYHFfFXkuFQAbZLE8pv2ZhvuQ222sn5xpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q38XJ4wZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 518E7210EAC0;
	Thu, 27 Feb 2025 13:07:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 518E7210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740690475;
	bh=IEOL6HLjW56dyRwoK8KUsakrGDoqCPmIDIIxo6mrB6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q38XJ4wZRq9Fo2GurqKMAPPkl8c/pMalRVlMHGZxAmjQWoqIUJAo8a0eFrjdMAP/1
	 1xWAqfiUzuB+FK7m0Zb/RwE/h7fSFEMZtWduLM9DmfY9fCMcM3pFe8oZToEOqrqZJ9
	 RFeTRHQAIZfc7yjf01FCLdFT20j5DihGKRJD1iH4=
Message-ID: <f9b3d2b7-59d6-42b7-b0eb-d26be3405b22@linux.microsoft.com>
Date: Thu, 27 Feb 2025 13:07:54 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] x86/hyperv: Use hv_hvcall_*() to set up hypercall
 arguments -- part 1
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-4-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250226200612.2062-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 12:06 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_hvcall_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset()
> and explicit zero'ing of input fields.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  arch/x86/hyperv/hv_apic.c   |  6 ++----
>  arch/x86/hyperv/hv_init.c   |  5 +----
>  arch/x86/hyperv/hv_vtl.c    |  8 ++------
>  arch/x86/hyperv/irqdomain.c | 10 ++++------
>  4 files changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index f022d5f64fb6..c16f81dd36fc 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -115,14 +115,12 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
>  		return false;
>  
>  	local_irq_save(flags);
> -	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -
> +	hv_hvcall_in_array(&ipi_arg, sizeof(*ipi_arg),
> +				sizeof(ipi_arg->vp_set.bank_contents[0]));
I think the returned "batch size" should be checked to ensure it is not too small to hold the
variable-sized part of the header.

>  	if (unlikely(!ipi_arg))
>  		goto ipi_mask_ex_done;
>  
While here, is this check really needed? If so, maybe a check for the percpu page(s) could be
baked into hv_hvcall_inout_array()?

>  	ipi_arg->vector = vector;
> -	ipi_arg->reserved = 0;
> -	ipi_arg->vp_set.valid_bank_mask = 0;
>  
>  	/*
>  	 * Use HV_GENERIC_SET_ALL and avoid converting cpumask to VP_SET
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ddeb40930bc8..c5c9511cb7ed 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -400,13 +400,10 @@ static u8 __init get_vtl(void)
>  	u64 ret;
>  
>  	local_irq_save(flags);
> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>  
> -	memset(input, 0, struct_size(input, names, 1));
> +	hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));

This doesn't look right, this is a rep hypercall taking an array of register names
and outputting an array of register values.

hv_hvcall_inout_array() should be fully utilized (input and output arrays) here.

The current code may actually work, but it will overlap the input and output!

>  	input->partition_id = HV_PARTITION_ID_SELF;
>  	input->vp_index = HV_VP_INDEX_SELF;
> -	input->input_vtl.as_uint8 = 0;
>  	input->names[0] = HV_REGISTER_VSM_VP_STATUS;
>  
>  	ret = hv_do_hypercall(control, input, output);
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 3f4e20d7b724..3dd27d548db6 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
<snip>
> @@ -185,13 +184,10 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
>  
>  	local_irq_save(irq_flags);
>  
> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	memset(input, 0, sizeof(*input));
> +	hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
This has the same issue as above - it is a rep hypercall so needs hv_hvcall_inout_array()

>  	input->partition_id = HV_PARTITION_ID_SELF;
>  	input->apic_ids[0] = apic_id;
>  
> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> -
>  	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
>  	status = hv_do_hypercall(control, input, output);
>  	ret = output[0];
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 64b921360b0f..803b1a945c5c 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -24,11 +24,11 @@ static int hv_map_interrupt(union hv_device_id device_id, bool level,
>  
>  	local_irq_save(flags);
>  
> -	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	hv_hvcall_inout_array(&input, sizeof(*input),
> +			sizeof(input->interrupt_descriptor.target.vp_set.bank_contents[0]),
> +			&output, sizeof(*output), 0);
As noted before I think the batch size should be checked to ensure it is large enough.

Side note - it seems in this hypercall, nr_banks + 1 is used as the varhead size, which
counts the vp valid mask, but this is not the case in __send_ipi_mask_ex(). Do you happen
to know why that might be?

Thanks,
Nuno

>  
>  	intr_desc = &input->interrupt_descriptor;
> -	memset(input, 0, sizeof(*input));
>  	input->partition_id = hv_current_partition_id;
>  	input->device_id = device_id.as_uint64;
>  	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
<snip>

