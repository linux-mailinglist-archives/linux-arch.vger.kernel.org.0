Return-Path: <linux-arch+bounces-11490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975CDA95773
	for <lists+linux-arch@lfdr.de>; Mon, 21 Apr 2025 22:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E7A171790
	for <lists+linux-arch@lfdr.de>; Mon, 21 Apr 2025 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F91F09BF;
	Mon, 21 Apr 2025 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Nvu1h5eF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B9A1F03FB;
	Mon, 21 Apr 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268074; cv=none; b=bMCNh3/ku1dcsDnwtwbe3GC2QQIc7ghUvdA7r8QBhlHZYz1GXhKZXKJxNQnhcDREEecf+cP1ag//PDs7vINFYZ9jPH9U1qFwCCH0d5nmwkK+PsOo90FUU54Alps/fNZXDng4BKBtJL+yAF2JYQbv70aFXfiuXNVZttBe/zrKpao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268074; c=relaxed/simple;
	bh=9CgOcmGfyjZdUzyJIxqK00XqSMjhJUaKZe3x3inW5VA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ng8nox4S85aaNCRh5c/4QHcBN49mVfgrJhV52nXbRBpXx+XCY3bfGvTwxSEIdNyAxzBjtwlULZSh+Tii2RKaNBGGONIr8MlSwcQnRKnOJQalNmPwG9miTWl1XJ3jcmFzE32lgeGirLD965jlyxcU6Nv9ZDrmJ5N+3L3yZ7j40VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Nvu1h5eF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.97.83] (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DF4D203B868;
	Mon, 21 Apr 2025 13:41:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DF4D203B868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745268071;
	bh=6E8XjFIM95VxJOT34rYcy7po1mFztLTdPxEur10FtbI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Nvu1h5eFRiC74/XDZ74iP/wkIZtQUCVP9W7DrCWtCG+Cl89gpXXZ91C34bebHv+5P
	 Y3Ygs6mepA4hXT8qFKqzR6cBbL3AGl7/ef7SSQuNF8d1BDAjR0SqZesZZmLpDtG/Va
	 evDKYIYl+URYRwmM2/rGnoTuNYiWKOYkuELMAcJQ=
Message-ID: <f2ccf839-1ce3-4827-997e-809ec9d3b021@linux.microsoft.com>
Date: Mon, 21 Apr 2025 13:41:11 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, eahariha@linux.microsoft.com,
 x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
To: mhklinux@outlook.com
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250415180728.1789-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/2025 11:07 AM, mhkelley58@gmail.com wrote:
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
> calculate and return how many array entries fit within the per-vCPU
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
> for some arguments. Several of the arguments to this new function
> must be compile-time constants generated by "sizeof()"
> expressions. As such, most of the code in the new function can be
> evaluated by the compiler, with the result that the code paths are
> no longer than with the current open coding. The one exception is
> new code generated to zero the fixed-size portion of the input area
> in cases where it is not currently done.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> 
> Notes:
>     Changes in v3:
>     * Added wrapper #define hv_hvcall_in_batch_size() to get the batch size
>       without setting up hypercall input/output parameters. This call can be
>       used when the batch size is needed for validation checks or memory
>       allocations prior to disabling interrupts.
>     
>     Changes in v2:
>     * Added comment that hv_hvcall_inout_array() should always be called with
>       interrupts disabled because it is returning pointers to per-cpu memory
>       [Nuno Das Neves]
> 
>  include/asm-generic/mshyperv.h | 106 +++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>

This is very cool, thanks for taking the time! I think the function naming
could be more intuitive, e.g. hv_setup_*_args(). I'd not block it for that reason,
but would be super happy if you would update it. What do you think?

Thanks,
Easwar (he/him)

