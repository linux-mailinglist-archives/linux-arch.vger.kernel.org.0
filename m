Return-Path: <linux-arch+bounces-13239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F99B2EB87
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 04:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03B95A1EE1
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 02:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DC2D3ECE;
	Thu, 21 Aug 2025 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rc8eQ6XK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53CF243954;
	Thu, 21 Aug 2025 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745106; cv=none; b=rKwJW5jXK/3dtAohocLrr/NCGWaFNr4dHTeVodFmRsWpMg+6u/igdf6NFElKVT449MrubEvfPCGBskTnvdg8KVzzPE+Qq9KGUs3v+aLdADrO+6HH1kTRwHcAS7Er7Abj+tDi0vDSlq735sfMozlv01VD338FtMMy4BXuur+pYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745106; c=relaxed/simple;
	bh=1s4z5xUS6Vwmn4YylI4NdVSd7+7RC3DbHO3vP3ADwYA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G0UjjRg0WgN4jRlY9u2L/uGtSWelce6HU/SO7IBsKI5pIDGNfeqIuGDSXXlMbtX5Gt+fmCL0pk3udimD++8o2RuEwNgQkbc5gXFJDb/4A/uTMWPviU+XsfIfRyJtz6xh6fE4pbUAQktPtidzH/K49kApK4J0cGPX70JgouBK+dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rc8eQ6XK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.64.28] (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E6092115A55;
	Wed, 20 Aug 2025 19:58:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E6092115A55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755745104;
	bh=sSht/tt1K7fboafZngL56CLey+1piWRHGqjM0QUwPq8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=rc8eQ6XKKAnCWn2cRsBm72J0Dgt3KgsP3s8+UG7o82WAyVNGWqKr4RL4dqPYS74j2
	 MEtFqtsxtMtvKM038Nat2Kge2pv0WMbKgsnmhkh7peD6fwP85V4aEggTdwzpbcmqNw
	 Ozv9sNLuPOsR7gWZW6s/Fsx0iHPYp2zDLRcAQwGo=
Message-ID: <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
Date: Wed, 20 Aug 2025 19:58:22 -0700
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
From: Mukesh R <mrathor@linux.microsoft.com>
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
 <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
In-Reply-To: <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/25 17:31, Mukesh R wrote:
> On 4/15/25 11:07, mhkelley58@gmail.com wrote:
>> From: Michael Kelley <mhklinux@outlook.com>
>>
>> Current code allocates the "hyperv_pcpu_input_arg", and in
>> some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
>> page of memory allocated per-vCPU. A hypercall call site disables
>> interrupts, then uses this memory to set up the input parameters for
>> the hypercall, read the output results after hypercall execution, and
>> re-enable interrupts. The open coding of these steps leads to
>> inconsistencies, and in some cases, violation of the generic
>> requirements for the hypercall input and output as described in the
>> Hyper-V Top Level Functional Spec (TLFS)[1].
>>
> <snip>
> 
>> The new functions are realized as a single inline function that
>> handles the most complex case, which is a hypercall with input
>> and output, both of which contain arrays. Simpler cases are mapped to
>> this most complex case with #define wrappers that provide zero or NULL
>> for some arguments. Several of the arguments to this new function
>> must be compile-time constants generated by "sizeof()"
>> expressions. As such, most of the code in the new function can be
>> evaluated by the compiler, with the result that the code paths are
>> no longer than with the current open coding. The one exception is
>> new code generated to zero the fixed-size portion of the input area
>> in cases where it is not currently done.
> 
> IMHO, this is unnecessary change that just obfuscates code. With status quo
> one has the advantage of seeing what exactly is going on, one can use the
> args any which way, change batch size any which way, and is thus flexible.
> With time these functions only get more complicated and error prone. The
> saving of ram is very minimal, this makes analyzing crash dumps harder,
> and in some cases like in your patch 3/7 disables unnecessarily in error case:
> 
> - if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
> -  pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
> -   HV_MAX_MODIFY_GPA_REP_COUNT);
> + local_irq_save(flags);      <<<<<<<
> ...
> 
> So, this is a nak from me. sorry.
> 

Furthermore, this makes us lose the ability to permanently map
input/output pages in the hypervisor. So, Wei kindly undo.

Thanks,
-Mukesh



> <snip>
> 
>> +/*
>> + * Allocate one page that is shared between input and output args, which is
>> + * sufficient for all current hypercalls. If a future hypercall requires
> 
> That is incorrect. We've iommu map hypercalls that will use up entire page
> for input. More coming as we implement ram withdrawl from the hypervisor.
> 
> Thanks,
> -Mukesh


