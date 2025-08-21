Return-Path: <linux-arch+bounces-13238-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C42B2E973
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 02:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50651C87B91
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E656A1531F9;
	Thu, 21 Aug 2025 00:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fgRkRCib"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC355464E;
	Thu, 21 Aug 2025 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755736319; cv=none; b=SmtAOFYDui0gWChB+VvIBYkxrYtpIxJOnvtWHyONl6ZmpcZqR/PXevXRjS4Ky5m3o+ZmYu7+pr8ExFL+tgyYxYuTlylJLB0ogkbILqgddHBuHYmORwuSzeRFRRKY22j/rQoQrNyawmFbVy8+wdLFAdiHbixxz0hjgrtcr5CBhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755736319; c=relaxed/simple;
	bh=dU8whZC5nQFnLKTOvPqBGari4dX5MZhx1uUJG2HCUm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQoqE+PEwaprjRvY/re/Z1CUKLjLVlEQ//ZXTeDP80xb8CzYKYLJyf+wS0M07REN/ibH69fTQ9/rVincHWvP7EU7pRZvfoOmGzV4xATZsZ6dzGgB9IhHiViv5gf33Jxi02b84orYKck5wYXeFc//TtmOCwXrtdIuNK5rxcMRwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fgRkRCib; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.64.99] (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCC642115A23;
	Wed, 20 Aug 2025 17:31:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCC642115A23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755736317;
	bh=6tWe+ykgzm/q5D9sU/3IncC099spEIMtixvUbdzAH0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fgRkRCibLmm15Pgj0Dh8/jXOwqg24NZtEsHFxPDCYCWFNKvdjQOPsd9qotCOSoosQ
	 cu/PsJA282fh2UGhoSI1UmRJsqDcyGAExSxBjohPwbnUeuDqiGzNeMNU4ark2z/Bif
	 tzJS095bYDDRM8uaEoba7Lr+LE005zUfQHCqXVKA=
Message-ID: <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
Date: Wed, 20 Aug 2025 17:31:56 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
Content-Language: en-US
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20250415180728.1789-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 11:07, mhkelley58@gmail.com wrote:
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
<snip>

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

IMHO, this is unnecessary change that just obfuscates code. With status quo
one has the advantage of seeing what exactly is going on, one can use the
args any which way, change batch size any which way, and is thus flexible.
With time these functions only get more complicated and error prone. The
saving of ram is very minimal, this makes analyzing crash dumps harder,
and in some cases like in your patch 3/7 disables unnecessarily in error case:

- if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
-  pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
-   HV_MAX_MODIFY_GPA_REP_COUNT);
+ local_irq_save(flags);      <<<<<<<
...

So, this is a nak from me. sorry.

<snip>

> +/*
> + * Allocate one page that is shared between input and output args, which is
> + * sufficient for all current hypercalls. If a future hypercall requires

That is incorrect. We've iommu map hypercalls that will use up entire page
for input. More coming as we implement ram withdrawl from the hypervisor.

Thanks,
-Mukesh

