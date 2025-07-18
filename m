Return-Path: <linux-arch+bounces-12855-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0500DB0A877
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55914E8387
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD322DEA74;
	Fri, 18 Jul 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NN66k+ty"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978481B394F;
	Fri, 18 Jul 2025 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856397; cv=none; b=HvtZZ5kSDGELKbT3r9Rnj3i2DqjburF5j1JtLyOAUHZkUZh9wLgB88gyfq5kh585iHDXP/+AStwlQyEM0/7hQ/9X+SDTw0mu3InJcqXK20O6U0zXvabRresPGdfmxpdPlSIz7wC50dd8al6siRQ8Sqt9Q7rz6nyZsz7MMSTd7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856397; c=relaxed/simple;
	bh=ZyiRT+V1xGV01F5avzlPphqc5scHqC2mrWtuVzXIVlo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VdVkQp/13n3AUQwmrCWj5i/qeDbOqUGH1iNWvc2IzwiQ9uqX9Dn/ka57QMG942v1LPzUwB+fTxgpYUs6UrnXac6CZrxXd3DRYaazzLUyYnnHQaXe27Q1Hb2H2Tci0mK8OVD3QBTjmY9ldvgK2XCpgHbPV4AWAYeCYF1iDsec3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NN66k+ty; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.217] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86249211FEBB;
	Fri, 18 Jul 2025 09:33:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86249211FEBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752856394;
	bh=TiEF0LaKowK7uu0xI1NxJySmU208WrTIU/Xx6Uf3/cg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=NN66k+tyqDjV/QBasSawR7rgDngqoNm2LIjbxw0Wx1pKhXMPpkhYp7Y9+vmdDy5IV
	 77MfxQr558cfCG/GCoxaWHDNIcDqVgc19R2PvBddxfl/Y0KIPPQe5LE5BGI+7xlKnh
	 DLp9qgiYr1TZHGPhKM8wf3rzdlWQX0linlkffHwA=
Message-ID: <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
Date: Fri, 18 Jul 2025 09:33:13 -0700
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
 kw@linux.com, mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
 arnd@arndb.de, eahariha@linux.microsoft.com, x86@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
To: mhklinux@outlook.com
References: <20250718045545.517620-1-mhklinux@outlook.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250718045545.517620-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2025 9:55 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> This patch set introduces a new way to manage the use of the per-vCPU
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
> hypercall input and output, and ensure that the TLFS requirements are
> met (max size of 1 page each for input and output, no overlap of input
> and output, aligned to 8 bytes, etc.).
> 
> With this change, hypercall call sites no longer directly access
> "hyperv_pcpu_input_arg" and "hyperv_pcpu_output_arg". Instead, one of
> a family of new functions provides the per-vCPU memory that a hypercall
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
> calculates and returns how many array entries fit within the per-vCPU
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
> upstream, the net is an add of about 20 lines of code and comments.
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
> Patch 2 to 6: Change existing hypercall call sites to use one of the new
>          functions. In some cases, tweaks to the hypercall argument data
>          structures are necessary, but these tweaks are making the data
>          structures more consistent with the overall pattern. These
>          5 patches are independent of each other, and can go in any
>          order. The breakup into 5 patches is for ease of review.
> 
> Patch 7: Update the name of the variable used to hold the per-vCPU memory
>          used for hypercall arguments. Remove code for managing the
>          per-vCPU output page.
> 
> The new code compiles and runs successfully on x86 and arm64. However,
> basic smoke tests cover only a limited number of hypercall call sites
> that have been modified. I don't have the hardware or Hyper-V
> configurations needed to test running in the Hyper-V root partition
> or running in a VTL other than VTL 0. The related hypercall call sites
> still need to be tested to make sure I didn't break anything. Hopefully
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
> This patch set is built against linux-next20250716.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
> 
> Michael Kelley (7):
>   Drivers: hv: Introduce hv_setup_*() functions for hypercall arguments
>   x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 1
>   x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 2
>   Drivers: hv: Use hv_setup_*() to set up hypercall arguments
>   PCI: hv: Use hv_setup_*() to set up hypercall arguments
>   Drivers: hv: Use hv_setup_*() to set up hypercall arguments for mshv
>     code
>   Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg
> 
>  arch/x86/hyperv/hv_apic.c           |  10 +--
>  arch/x86/hyperv/hv_init.c           |  12 ++-
>  arch/x86/hyperv/hv_vtl.c            |   3 +-
>  arch/x86/hyperv/irqdomain.c         |  17 ++--
>  arch/x86/hyperv/ivm.c               |  18 ++---
>  arch/x86/hyperv/mmu.c               |  19 ++---
>  arch/x86/hyperv/nested.c            |  14 ++--
>  drivers/hv/hv.c                     |   6 +-
>  drivers/hv/hv_balloon.c             |   8 +-
>  drivers/hv/hv_common.c              |  64 +++++----------
>  drivers/hv/hv_proc.c                |  23 +++---
>  drivers/hv/hyperv_vmbus.h           |   2 +-
>  drivers/hv/mshv_common.c            |  31 +++----
>  drivers/hv/mshv_root_hv_call.c      | 121 +++++++++++-----------------
>  drivers/hv/mshv_root_main.c         |   5 +-
>  drivers/pci/controller/pci-hyperv.c |  18 ++---
>  include/asm-generic/mshyperv.h      | 106 +++++++++++++++++++++++-
>  include/hyperv/hvgdk_mini.h         |   4 +-
>  18 files changed, 251 insertions(+), 230 deletions(-)
> 

Thank you for spinning this version!

For the series,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

