Return-Path: <linux-arch+bounces-10414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD8A4700E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 01:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD593B0BB8
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0EEC2FA;
	Thu, 27 Feb 2025 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f7Z/syY5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF821348;
	Thu, 27 Feb 2025 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615300; cv=none; b=Jy6zaCVRCPG8ZvzKkW94F3Fg/71MzYSiN22AU9VUfBHx8IvrEGoIpHyUWBao+B9EtB4G0+kwgUvLC5LRYxebMvgaXzRJXqEcWi/VQOFtPZMe6qa+2oOCKpNLcvcwstSnfhtytCbSQ7vOKmPueYGE/+d4+r9HfoXPgznporaiTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615300; c=relaxed/simple;
	bh=Mr1gbzUbQ0j3qkkUKPjWHD46E5NJpSmdXGoeAOqoSBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLLpOSQCUemzCUpZwVSzt+m1vpMOYk1cidPoRV/vWvCT3Ej+7Oqw7zvhZHQDCXuelVwkb7tAs2MAGztQo07fMQyYosIL+84LXeR4/fOnHYH+gRfjRsojR+KufrorUdYOvR3q72TErkx2VmJvd5qlN5zAgjJ6soT2sGNfRf0SbH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f7Z/syY5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id E44CF2109CE5;
	Wed, 26 Feb 2025 16:14:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E44CF2109CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740615298;
	bh=MuT+XOUJkIW730Xeyu4axAApZR2vytUBgr+CCuYTT6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f7Z/syY5hyUuZiiRnIJ6umWHxoN3Zf0T26PyoAugM6sJ0lSKf9Ae3QRjAf4KlztcD
	 Cn4UWQu5r7mzCrEvOct1kHBlgCgoFxPYYp5w4lN+J6nmtqM9ZMtrLMV/gBHmBZNeF5
	 FG7nWaHfVjTm3UMdkHIXEu62AowbjhyvTOAU/7fM=
Message-ID: <45a1b6b5-407c-4518-9ea2-05341e93a67e@linux.microsoft.com>
Date: Wed, 26 Feb 2025 16:14:57 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-3-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250226200612.2062-3-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 12:06 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current code allocates the "hyperv_pcpu_input_arg", and in
> some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
> page of memory allocated per-vCPU. A hypercall call site disables
> interrupts, then uses this memory to set up the input parameters for
> the hypercall, read the output results after hypercall execution, and
> re-enable interrupts. The open coding of these steps leads to
> inconsistencies, and in some cases, violation of the generic
> requirements for the hypercall input and output as described in the
> Hyper-V Top Level Functional Spec (TLFS)[1].
> 
> To reduce these kinds of problems, introduce a family of inline
> functions to replace the open coding. The functions provide a new way
> to manage the use of this per-vCPU memory that is usually the input and
> output arguments to Hyper-V hypercalls. The functions encapsulate
> key aspects of the usage and ensure that the TLFS requirements are
> met (max size of 1 page each for input and output, no overlap of
> input and output, aligned to 8 bytes, etc.). Conceptually, there
> is no longer a difference between the "per-vCPU input page" and
> "per-vCPU output page". Only a single per-vCPU page is allocated, and
> it provides both hypercall input and output memory. All current
> hypercalls can fit their input and output within that single page,
> though the new code allows easy changing to two pages should a future
> hypercall require a full page for each of the input and output.
> 
> The new functions always zero the fixed-size portion of the hypercall
> input area so that uninitialized memory is not inadvertently passed
> to the hypercall. Current open-coded hypercall call sites are
> inconsistent on this point, and use of the new functions addresses
> that inconsistency. The output area is not zero'ed by the new code
> as it is Hyper-V's responsibility to provide legal output.
> 
> When the input or output (or both) contain an array, the new functions
> calculate and return how many array entries fit within the per-cpu
> memory page, which is effectively the "batch size" for the hypercall
> processing multiple entries. This batch size can then be used in the
> hypercall control word to specify the repetition count. This
> calculation of the batch size replaces current open coding of the
> batch size, which is prone to errors. Note that the array portion of
> the input area is *not* zero'ed. The arrays are almost always 64-bit
> GPAs or something similar, and zero'ing that much memory seems
> wasteful at runtime when it will all be overwritten. The hypercall
> call site is responsible for ensuring that no part of the array is
> left uninitialized (just as with current code).
> 
> The new functions are realized as a single inline function that
> handles the most complex case, which is a hypercall with input
> and output, both of which contain arrays. Simpler cases are mapped to
> this most complex case with #define wrappers that provide zero or NULL
> for some arguments. Several of the arguments to this new function are
> expected to be compile-time constants generated by "sizeof()"
> expressions. As such, most of the code in the new function can be
> evaluated by the compiler, with the result that the code paths are
> no longer than with the current open coding. The one exception is
> new code generated to zero the fixed-size portion of the input area
> in cases where it is not currently done.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  include/asm-generic/mshyperv.h | 102 +++++++++++++++++++++++++++++++++
>  1 file changed, 102 insertions(+)
> 
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index b13b0cda4ac8..0c8a9133cf1a 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -135,6 +135,108 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>  	return status;
>  }
>  
> +/*
> + * Hypercall input and output argument setup
> + */
> +
> +/* Temporary mapping to be removed at the end of the patch series */
> +#define hyperv_pcpu_arg hyperv_pcpu_input_arg
> +
> +/*
> + * Allocate one page that is shared between input and output args, which is
> + * sufficient for all current hypercalls. If a future hypercall requires
> + * more space, change this value to "2" and everything will work.
> + */
> +#define HV_HVCALL_ARG_PAGES 1
> +
> +/*
> + * Allocate space for hypercall input and output arguments from the
> + * pre-allocated per-cpu hyperv_pcpu_args page(s). A NULL value for the input
> + * or output indicates to allocate no space for that argument. For input and
> + * for output, specify the size of the fixed portion, and the size of an
> + * element in a variable size array. A zero value for entry_size indicates
> + * there is no array. The fixed size space for the input is zero'ed.
> + *
It might be worth explicitly mentioning that interrupts should be disabled when
calling this function.

> + * When variable size arrays are present, the function returns the number of
> + * elements (i.e, the batch size) that fit in the available space.
> + *
> + * The four "size" arguments are expected to be constants, in which case the
> + * compiler does most of the calculations. Then the generated inline code is no
> + * larger than if open coding the access to the hyperv_pcpu_arg and doing
> + * memset() on the input.
> + */
> +static inline int hv_hvcall_inout_array(
> +			void *input, u32 in_size, u32 in_entry_size,
> +			void *output, u32 out_size, u32 out_entry_size)
Is there a reason input and output are void * instead of void ** here?

> +{
> +	u32 in_batch_count = 0, out_batch_count = 0, batch_count;
> +	u32 in_total_size, out_total_size, offset;
> +	u32 batch_space = HV_HYP_PAGE_SIZE * HV_HVCALL_ARG_PAGES;
> +	void *space;
> +
> +	/*
> +	 * If input and output have arrays, allocate half the space to input
> +	 * and half to output. If only input has an array, the array can use
> +	 * all the space except for the fixed size output (but not to exceed
> +	 * one page), and vice versa.
> +	 */
> +	if (in_entry_size && out_entry_size)
> +		batch_space = batch_space / 2;
> +	else if (in_entry_size)
> +		batch_space = min(HV_HYP_PAGE_SIZE, batch_space - out_size);
> +	else if (out_entry_size)
> +		batch_space = min(HV_HYP_PAGE_SIZE, batch_space - in_size);
> +
> +	if (in_entry_size)
> +		in_batch_count = (batch_space - in_size) / in_entry_size;
> +	if (out_entry_size)
> +		out_batch_count = (batch_space - out_size) / out_entry_size;
> +
> +	/*
> +	 * If input and output have arrays, use the smaller of the two batch
> +	 * counts, in case they are different. If only one has an array, use
> +	 * that batch count. batch_count will be zero if neither has an array.
> +	 */
> +	if (in_batch_count && out_batch_count)
> +		batch_count = min(in_batch_count, out_batch_count);
> +	else
> +		batch_count = in_batch_count | out_batch_count;
> +
> +	in_total_size = ALIGN(in_size + (in_entry_size * batch_count), 8);
> +	out_total_size = ALIGN(out_size + (out_entry_size * batch_count), 8);
> +
> +	space = *this_cpu_ptr(hyperv_pcpu_arg);
> +	if (input) {
> +		*(void **)input = space;
> +		if (space)
> +			/* Zero the fixed size portion, not any array portion */
> +			memset(space, 0, ALIGN(in_size, 8));
> +	}
> +
> +	if (output) {
> +		if (in_total_size + out_total_size <= HV_HYP_PAGE_SIZE) {
> +			offset = in_total_size;
> +		} else {
> +			offset = HV_HYP_PAGE_SIZE;
> +			/* Need more than 1 page, but only 1 was allocated */
> +			BUILD_BUG_ON(HV_HVCALL_ARG_PAGES == 1);
Interesting... so the compiler is not compiling this BUILD_BUG_ON in your patchset
because in_total_size + out_total_size <= HV_HYP_PAGE_SIZE is always known at
compile-time?
So will this also fail if any of the args in_size, in_entry_size, out_size,
out_entry_size are runtime-known?

Nuno

> +		}
> +		*(void **)output = space + offset;
> +	}
> +
> +	return batch_count;
> +}
> +
> +/* Wrappers for some of the simpler cases with only input, or with no arrays */
> +#define hv_hvcall_in(input, in_size) \
> +	hv_hvcall_inout_array(input, in_size, 0, NULL, 0, 0)
> +
> +#define hv_hvcall_inout(input, in_size, output, out_size) \
> +	hv_hvcall_inout_array(input, in_size, 0, output, out_size, 0)
> +
> +#define hv_hvcall_in_array(input, in_size, in_entry_size) \
> +	hv_hvcall_inout_array(input, in_size, in_entry_size, NULL, 0, 0)
> +
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
>  static inline u64 hv_generate_guest_id(u64 kernel_version)
>  {


