Return-Path: <linux-arch+bounces-11202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB264A782C4
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 21:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952517A2485
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0061DB54C;
	Tue,  1 Apr 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IS4xfCe0"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD49461;
	Tue,  1 Apr 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743535770; cv=none; b=IWUb4VpvAyUs+r3urBi16mQy9MnKwrJdJWtiO9zNBVaquyNGZHsH09nJz3Py1M6VQCtVSgYynqM0Z0AqRxBiDAqRagurZaZbc0BNKA5Z3X285sfXukD2955JZg9AqPr0+f23fk1rUsspqNhqy2iJjYVbp2WT/OoTmF9ufNjGAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743535770; c=relaxed/simple;
	bh=PPJUXrWwHEytxvARJTQER9IO5PUzIkGAvHb/WJFCSfI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G7upaUgnf3ImPWCufk6E8UaEjsEbp2f0BfxwBGwECow8tnHomgq4tbz9LYt+thurbPArIVE0Q2WC1r6Jg+1zU7QfaJ1QYNWaBST1BtOGUhGlrnAwhDy8r0GIoYq402ixnO5qjNubNBMj8Q9ZGOo12Xex/vfdVcU1BBvng6yRfJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IS4xfCe0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.201.26] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 770B020412F8;
	Tue,  1 Apr 2025 12:29:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 770B020412F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743535768;
	bh=ezzerkdidgGXkpIDYpjhjZMJiJIXbyNZbJ7W3iuDF8M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IS4xfCe0giHmDyLcIvFipVaAd9UszSS8w7B1pP+PUqSJMaj2WBtvuRklG3L7WUTep
	 toPOxSFUsf9FPBXs/mIJFU5ZLR1i3ZWD4dTgeCpOzYOp9g6rhP/BsbPkl2XVb4Z7xo
	 ybkPX4pbGzN/I88snlEjBoYcsCtZS/r8LURZddL8=
Message-ID: <87238331-1ee3-4b92-b200-bd064a55edc7@linux.microsoft.com>
Date: Tue, 1 Apr 2025 12:29:27 -0700
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
Subject: Re: [PATCH v2 0/6] hyperv: Introduce new way to manage hypercall args
To: mhklinux@outlook.com
References: <20250313061911.2491-1-mhklinux@outlook.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250313061911.2491-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> This patch set introduces a new way to manage the use of the per-cpu
> memory that is usually the input and output arguments to Hyper-V
> hypercalls. Current code allocates the "hyperv_pcpu_input_arg", and in
> some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
> page of memory allocated per-vCPU. A hypercall call site disables
> interrupts, then uses this memory to set up the input parameters for
> the hypercall, read the output results after hypercall execution, and
> re-enable interrupts. The open coding of these steps has led to
> inconsistencies, and in some cases, violation of the generic
> requirements for the hypercall input and output as described in the
> Hyper-V Top Level Functional Spec (TLFS)[1]. This patch set introduces
> a new family of inline functions to replace the open coding. The new
> functions encapsulate key aspects of the use of per-vCPU memory for
> hypercall input and output,and ensure that the TLFS requirements are
> met (max size of 1 page each for input and output, no overlap of input
> and output, aligned to 8 bytes, etc.).
> 
> With this change, hypercall call sites no longer directly access
> "hyperv_pcpu_input_arg" and "hyperv_pcpu_output_arg". Instead, one of
> a family of new functions provides the per-cpu memory that a hypercall
> call site uses to set up hypercall input and output areas.
> Conceptually, there is no longer a difference between the "per-vCPU
> input page" and "per-vCPU output page". Only a single per-vCPU page is
> allocated, and it is used to provide both hypercall input and output.
> All current hypercalls can fit their input and output within that single
> page, though the new code allows easy changing to two pages should a
> future hypercall require a full page for each of the input and output.
> 
> The new functions always zero the fixed-size portion of the hypercall
> input area (but not any array portion -- see below) so that
> uninitialized memory isn't inadvertently passed to the hypercall.
> Current open-coded hypercall call sites are inconsistent on this point,
> and use of the new functions addresses that inconsistency. The output
> area is not zero'ed by the new code as it is Hyper-V's responsibility
> to provide legal output.
> 
> When the input or output (or both) contain an array, the new code
> calculates and returns how many array entries fit within the per-cpu
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
> The new family of functions is realized as a single inline function
> that handles the most complex case, which is a hypercall with input
> and output, both of which contain arrays. Simpler cases are mapped to
> this most complex case with #define wrappers that provide zero or NULL
> for some arguments. Several of the arguments to this new function
> must be compile-time constants generated by "sizeof()" expressions.
> As such, most of the code in the new function is evaluated by the
> compiler, with the result that the runtime code paths are no longer
> than with the current open coding. An exception is the new code
> generated to zero the fixed-size portion of the input area in cases
> where it was not previously done.
> 
> Use of the new function typically (but not always) saves a few lines
> of code at each hypercall call site. This is traded off against the
> lines of code added for the new functions. With code currently
> upstream, the net is an add of about 60 lines of code and comments.
> However, as additional hypercall call sites are upstreamed from the
> OpenHCL project[2] in support of Linux running in the Hyper-V root
> partition and in VTLs other than VTL 0, the net lines of code added is
> nearly zero.
> 
> A couple hypercall call sites have requirements that are not 100%
> handled by the new function. These still require some manual open-
> coded adjustment or open-coded batch size calculations -- see the
> individual patches in this series. Suggestions on how to do better
> are welcome.
> 
> The patches in the series do the following:
> 
> Patch 1: Introduce the new family of functions for assigning hypercall
>          input and output arguments.
> 
> Patch 2 to 5: Change existing hypercall call sites to use one of the new
>          functions. In some cases, tweaks to the hypercall argument data
>          structures are necessary, but these tweaks are making the data
>          structures more consistent with the overall pattern. These
>          four patches are independent of each other, and can go in any
>          order. The breakup into 4 patches is for ease of review.
> 
> Patch 6: Update the name of the variable used to hold the per-cpu memory
>          used for hypercall arguments. Remove code for managing the
> 	 per-cpu output page.
> 
> Patch 1 from v1 of the patch set has been dropped in v2. It was a bug
> fix that has already been picked up.
> 
> The new code compiles and runs successfully on x86 and arm64. Separate
> from this patch set, for evaluation purposes I also applied the
> changes to the additional hypercall call sites in the OpenHCL
> project[2]. However, I don't have the hardware or Hyper-V
> configurations needed to test running in the Hyper-V root partition or
> in a VTL other than VTL 0. So the related hypercall call sites still
> need to be tested to make sure I didn't break anything. Hopefully
> someone with the necessary configurations and Hyper-V versions can
> help with that testing.
> 
> For gcc 9.4.0, I've looked at the generated code for a couple of
> hypercall call sites on both x86 and arm64 to ensure that it boils
> down to the equivalent of the current open coding. I have not looked
> at the generated code for later gcc versions or for Clang/LLVM, but
> there's no reason to expect something worse as the code isn't doing
> anything tricky.
> 
> This patch set is built against linux-next20250311.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
> [2] https://github.com/microsoft/OHCL-Linux-Kernel
> 
> Michael Kelley (6):
>   Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
>   x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
>   x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
>   Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
>   PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
>   Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg
> 
>  arch/x86/hyperv/hv_apic.c           |  10 ++-
>  arch/x86/hyperv/hv_init.c           |  12 ++--
>  arch/x86/hyperv/hv_vtl.c            |   9 +--
>  arch/x86/hyperv/irqdomain.c         |  17 +++--
>  arch/x86/hyperv/ivm.c               |  18 ++---
>  arch/x86/hyperv/mmu.c               |  19 ++---
>  arch/x86/hyperv/nested.c            |  14 ++--
>  drivers/hv/hv.c                     |  11 +--
>  drivers/hv/hv_balloon.c             |   4 +-
>  drivers/hv/hv_common.c              |  57 +++++----------
>  drivers/hv/hv_proc.c                |   8 +--
>  drivers/hv/hyperv_vmbus.h           |   2 +-
>  drivers/pci/controller/pci-hyperv.c |  18 +++--
>  include/asm-generic/mshyperv.h      | 103 +++++++++++++++++++++++++++-
>  include/hyperv/hvgdk_mini.h         |   6 +-
>  15 files changed, 184 insertions(+), 124 deletions(-)
> 

I do intend to review this series but it's been hard to get time in between doing
commercial work. I'll leave it to Wei to determine how important my feedback is since
Nuno has reviewed v1.

I do feel that it's important for *someone* to review the series from the Linux
guest perspective.

Thanks,
Easwar (he/him)

