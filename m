Return-Path: <linux-arch+bounces-10438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B327A48990
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 21:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DAD1885C04
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F97A271275;
	Thu, 27 Feb 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XWXo4Go3"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6F26FA69;
	Thu, 27 Feb 2025 20:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686966; cv=none; b=mFHh+2Q7DgbSIdK5c2asx2dZy8oXZGaMaI0G7l3qsMygG0Ac/8PHUk632CBy02Z5xErip3SKZxCLXm3rnby750qu8JAg15Kp4PAi7MY16H8AMK9yq5nGnB2SL3TPZeg5zZX1Bv/cLZL9cBEk7UW20n0ZgdlaW4d5YBURR0ec0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686966; c=relaxed/simple;
	bh=fBrVCxpJBEfNKG9j/drwmbNUOrI/ARypiCduWRPTEBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIxMUcD0jZKVuSlDcSkeVfKoLnHzlUt/qvcSF9HhGF6QgqHLKlOJW8ReOtgJlb5PxjZ2/r1st4k3jdxa1Mql81mdgR2vIlVarLUwe988TrqoA9ZlRyO6AY5wWxd/+JNN5a8CWiEIBfpHvipHgWHfY8L8rzb1YK1vJLwhnb59o3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XWXo4Go3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5429D210D0F6;
	Thu, 27 Feb 2025 12:09:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5429D210D0F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740686958;
	bh=0GqjdZyUoxmHDoAKJ5CzA1TGTiAo0pCGgyNuqQwC4pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWXo4Go3v4bgG+YT+6NLUe6Yn3FzJT6MIqjH9PghDT44SASzCjT/VvrtPJxUF8KOz
	 C0Y/nR1HtVTdtR0CENhtKR1yDaPVmrW69xydjw7SzGYZMrGNHYK2hfpKhQzCs9sD0y
	 u7Fs6rW2rZ9Z+J8at3bW/IBwau4gfpLJxOnklqHg=
Message-ID: <e949f5fc-44e2-437e-8b78-9e697ab1ac12@linux.microsoft.com>
Date: Thu, 27 Feb 2025 12:09:17 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
To: Michael Kelley <mhklinux@outlook.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-3-mhklinux@outlook.com>
 <45a1b6b5-407c-4518-9ea2-05341e93a67e@linux.microsoft.com>
 <SN6PR02MB4157FF9AF372F252C6D8B0A1D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157FF9AF372F252C6D8B0A1D4CD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 5:50 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 4:15 PM
>>
>> On 2/26/2025 12:06 PM, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
>>> Current code allocates the "hyperv_pcpu_input_arg", and in
>>> some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
>>> page of memory allocated per-vCPU. A hypercall call site disables
>>> interrupts, then uses this memory to set up the input parameters for
>>> the hypercall, read the output results after hypercall execution, and
>>> re-enable interrupts. The open coding of these steps leads to
>>> inconsistencies, and in some cases, violation of the generic
>>> requirements for the hypercall input and output as described in the
>>> Hyper-V Top Level Functional Spec (TLFS)[1].
>>>
>>> To reduce these kinds of problems, introduce a family of inline
>>> functions to replace the open coding. The functions provide a new way
>>> to manage the use of this per-vCPU memory that is usually the input and
>>> output arguments to Hyper-V hypercalls. The functions encapsulate
>>> key aspects of the usage and ensure that the TLFS requirements are
>>> met (max size of 1 page each for input and output, no overlap of
>>> input and output, aligned to 8 bytes, etc.). Conceptually, there
>>> is no longer a difference between the "per-vCPU input page" and
>>> "per-vCPU output page". Only a single per-vCPU page is allocated, and
>>> it provides both hypercall input and output memory. All current
>>> hypercalls can fit their input and output within that single page,
>>> though the new code allows easy changing to two pages should a future
>>> hypercall require a full page for each of the input and output.
>>>
>>> The new functions always zero the fixed-size portion of the hypercall
>>> input area so that uninitialized memory is not inadvertently passed
>>> to the hypercall. Current open-coded hypercall call sites are
>>> inconsistent on this point, and use of the new functions addresses
>>> that inconsistency. The output area is not zero'ed by the new code
>>> as it is Hyper-V's responsibility to provide legal output.
>>>
>>> When the input or output (or both) contain an array, the new functions
>>> calculate and return how many array entries fit within the per-cpu
>>> memory page, which is effectively the "batch size" for the hypercall
>>> processing multiple entries. This batch size can then be used in the
>>> hypercall control word to specify the repetition count. This
>>> calculation of the batch size replaces current open coding of the
>>> batch size, which is prone to errors. Note that the array portion of
>>> the input area is *not* zero'ed. The arrays are almost always 64-bit
>>> GPAs or something similar, and zero'ing that much memory seems
>>> wasteful at runtime when it will all be overwritten. The hypercall
>>> call site is responsible for ensuring that no part of the array is
>>> left uninitialized (just as with current code).
>>>
>>> The new functions are realized as a single inline function that
>>> handles the most complex case, which is a hypercall with input
>>> and output, both of which contain arrays. Simpler cases are mapped to
>>> this most complex case with #define wrappers that provide zero or NULL
>>> for some arguments. Several of the arguments to this new function are
>>> expected to be compile-time constants generated by "sizeof()"
>>> expressions. As such, most of the code in the new function can be
>>> evaluated by the compiler, with the result that the code paths are
>>> no longer than with the current open coding. The one exception is
>>> new code generated to zero the fixed-size portion of the input area
>>> in cases where it is not currently done.
>>>
>>> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
>>>
>>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>>> ---
>>>  include/asm-generic/mshyperv.h | 102 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 102 insertions(+)
>>>
>>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>>> index b13b0cda4ac8..0c8a9133cf1a 100644
>>> --- a/include/asm-generic/mshyperv.h
>>> +++ b/include/asm-generic/mshyperv.h
>>> @@ -135,6 +135,108 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
>>>  	return status;
>>>  }
>>>
>>> +/*
>>> + * Hypercall input and output argument setup
>>> + */
>>> +
>>> +/* Temporary mapping to be removed at the end of the patch series */
>>> +#define hyperv_pcpu_arg hyperv_pcpu_input_arg
>>> +
>>> +/*
>>> + * Allocate one page that is shared between input and output args, which is
>>> + * sufficient for all current hypercalls. If a future hypercall requires
>>> + * more space, change this value to "2" and everything will work.
>>> + */
>>> +#define HV_HVCALL_ARG_PAGES 1
>>> +
>>> +/*
>>> + * Allocate space for hypercall input and output arguments from the
>>> + * pre-allocated per-cpu hyperv_pcpu_args page(s). A NULL value for the input
>>> + * or output indicates to allocate no space for that argument. For input and
>>> + * for output, specify the size of the fixed portion, and the size of an
>>> + * element in a variable size array. A zero value for entry_size indicates
>>> + * there is no array. The fixed size space for the input is zero'ed.
>>> + *
>> It might be worth explicitly mentioning that interrupts should be disabled when
>> calling this function.
> 
> Agreed.
> 
>>
>>> + * When variable size arrays are present, the function returns the number of
>>> + * elements (i.e, the batch size) that fit in the available space.
>>> + *
>>> + * The four "size" arguments are expected to be constants, in which case the
>>> + * compiler does most of the calculations. Then the generated inline code is no
>>> + * larger than if open coding the access to the hyperv_pcpu_arg and doing
>>> + * memset() on the input.
>>> + */
>>> +static inline int hv_hvcall_inout_array(
>>> +			void *input, u32 in_size, u32 in_entry_size,
>>> +			void *output, u32 out_size, u32 out_entry_size)
>> Is there a reason input and output are void * instead of void ** here?
> 
> Yes -- it must be void *, and not void **.  Consider a function like get_vtl()
> in Patch 3 of this series where local variable "input" is declared as:
> 
> struct hv_input_get_vp_registers *input;
> 
> Then the first argument to hv_hvcall_inout() will be of type
> struct hv_input_get_vp_registers **. The compiler does not consider
> this to match void ** and would generate an error. But
> struct hv_input_get_vp_registers ** _does_ match void * and compiles
> with no error. It makes sense when you think about it, though it
> isn't obvious. I tried to use void ** initially and had to figure out
> why the code wouldn't compile. :-)
> 
Ah, that does make sense. Okay then, fair enough!

>>
>>> +{
>>> +	u32 in_batch_count = 0, out_batch_count = 0, batch_count;
>>> +	u32 in_total_size, out_total_size, offset;
>>> +	u32 batch_space = HV_HYP_PAGE_SIZE * HV_HVCALL_ARG_PAGES;
>>> +	void *space;
>>> +
>>> +	/*
>>> +	 * If input and output have arrays, allocate half the space to input
>>> +	 * and half to output. If only input has an array, the array can use
>>> +	 * all the space except for the fixed size output (but not to exceed
>>> +	 * one page), and vice versa.
>>> +	 */
>>> +	if (in_entry_size && out_entry_size)
>>> +		batch_space = batch_space / 2;
>>> +	else if (in_entry_size)
>>> +		batch_space = min(HV_HYP_PAGE_SIZE, batch_space - out_size);
>>> +	else if (out_entry_size)
>>> +		batch_space = min(HV_HYP_PAGE_SIZE, batch_space - in_size);
>>> +
>>> +	if (in_entry_size)
>>> +		in_batch_count = (batch_space - in_size) / in_entry_size;
>>> +	if (out_entry_size)
>>> +		out_batch_count = (batch_space - out_size) / out_entry_size;
>>> +
>>> +	/*
>>> +	 * If input and output have arrays, use the smaller of the two batch
>>> +	 * counts, in case they are different. If only one has an array, use
>>> +	 * that batch count. batch_count will be zero if neither has an array.
>>> +	 */
>>> +	if (in_batch_count && out_batch_count)
>>> +		batch_count = min(in_batch_count, out_batch_count);
>>> +	else
>>> +		batch_count = in_batch_count | out_batch_count;
>>> +
>>> +	in_total_size = ALIGN(in_size + (in_entry_size * batch_count), 8);
>>> +	out_total_size = ALIGN(out_size + (out_entry_size * batch_count), 8);
>>> +
>>> +	space = *this_cpu_ptr(hyperv_pcpu_arg);
>>> +	if (input) {
>>> +		*(void **)input = space;
>>> +		if (space)
>>> +			/* Zero the fixed size portion, not any array portion */
>>> +			memset(space, 0, ALIGN(in_size, 8));
>>> +	}
>>> +
>>> +	if (output) {
>>> +		if (in_total_size + out_total_size <= HV_HYP_PAGE_SIZE) {
>>> +			offset = in_total_size;
>>> +		} else {
>>> +			offset = HV_HYP_PAGE_SIZE;
>>> +			/* Need more than 1 page, but only 1 was allocated */
>>> +			BUILD_BUG_ON(HV_HVCALL_ARG_PAGES == 1);
>> Interesting... so the compiler is not compiling this BUILD_BUG_ON in your patchset
>> because in_total_size + out_total_size <= HV_HYP_PAGE_SIZE is always known at
>> compile-time?
> 
> Correct. And if for some future hypercall in_total_size + out_total_size is
> *not* <= HV_HYP_PAGE_SIZE, the BUILD_BUG_ON() will alert the developer
> to the problem. Depending on the argument requirements of this future
> hypercall, the solution might require changing HV_HVCALL_ARG_PAGES to 2.
> 
>> So will this also fail if any of the args in_size, in_entry_size, out_size,
>> out_entry_size are runtime-known?
> 
> Correct.  I should change my wording about "The four 'size' arguments are
> expected to be constants" to ". . . must be constants". OTOH, if there's a need
> to support non-constants for any of these arguments, some additional code
> could handle that case. But the overall hv_hvcall_inout_array() function will
> end up generating a lot of code to execute at runtime. I looked at the hypercall
> call sites in the OHCL kernel tree, and didn't see any need for non-constants,
> but I haven't looked yet at the v4 patch series you just posted.  Let me know
> if you have a case requiring non-constants.
> 
I don't think we ever use non-constants. In fact I can't think of a case where these
values aren't the result of a sizeof() (or 0).

Overall I think this approach is looking quite nice and I'd be happy to adopt it
in the mshv driver code when this is merged.

With the comment change mentioned above:

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

> Michael


