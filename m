Return-Path: <linux-arch+bounces-13661-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96747B5A3FC
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 23:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2323BAA9B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 21:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429927AC3E;
	Tue, 16 Sep 2025 21:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UCJ7K+1f"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B129A30E;
	Tue, 16 Sep 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058256; cv=none; b=uHaKz85fo9eBNHC/vBozAxO8pX2l2zfQbBfkWZTZ3wugU5TwcjGPY4gk98wqCvRcSRz/dAYXjnKyirolrMpiaTIcPCtSbNrkP4ZLa1YRfu5s9xDfDxlkzJV1BMYnfEImN0a7OY/KdaTTmpmaIGmEkYF6drMxbiUYc1+IrI528TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058256; c=relaxed/simple;
	bh=gJ9wZRVbw3udYzRjVbZa++IA+J+QJ8U5tc09EX/KI5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrlPJpeSjYsbFLYu6XqjGZMOobFOZTQdi9+ar8dSAdieGwvSpslm6EVDjGCeZsZiG4xpAWOsLF1NMVXu8h0bJ8yDikFO1wGf2oKD8kj8D+60C8aKkwZav6CrYQm+I/CCsUw/8nCN8szLSgF67nwNWaWzz+1BXYJ+VRcKB6Qx250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UCJ7K+1f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id E3BAB20171A9;
	Tue, 16 Sep 2025 14:30:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3BAB20171A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758058252;
	bh=QMrQd7BUWalzmb/hq+iMlexb31ti2rSYy0sE6qUO1AI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UCJ7K+1fN8x4tc0jV34ovb7Z+/a+h3a6Zsc0CRzpo+BXxyMu2F4o/sM/Tx310uwuh
	 kgXPHMY3ohT1L/SnCR/ocVTEE7FgfuprXm6Ub98s2JwftWAmJIdf9nGsWabAsVa6hp
	 JXi0TgH9tmR3OYopjspICMT6fkJYTnttLjxJe4/k=
Message-ID: <79f5d0ac-0b3e-70fc-2cbe-8a2352642746@linux.microsoft.com>
Date: Tue, 16 Sep 2025 14:30:51 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-5-mrathor@linux.microsoft.com>
 <SN6PR02MB41570D14679ED23C930878CCD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41570D14679ED23C930878CCD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 10:55, Michael Kelley wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
>>
>> Introduce a small asm stub to transition from the hypervisor to linux
> 
> I'd argue for capitalizing "Linux" here and in other places in commit
> text and code comments throughout this patch set.

I'd argue against it. A quick grep indicates it is a common practice,
and in the code world goes easy on the eyes :).

>> upon devirtualization.
> 
> In this patch and subsequent patches, you've used the phrase "upon
> devirtualization", which seems a little vague to me. Does this mean
> "when devirtualization is complete" or perhaps "when the hypervisor
> completes devirtualization"? Since there's no spec on any of this,
> being as precise as possible will help future readers.

since control comes back to linux at the callback here, i fail to 
understand what is vague about it. when hyp completes devirt, 
devirt is complete.

>>
>> At a high level, during panic of either the hypervisor or the dom0 (aka
>> root), the nmi handler asks hypervisor to devirtualize.
> 
> Suggest:
> 
> At a high level, during panic of either the hypervisor or Linux running
> in dom0 (a.k.a. the root partition), the Linux NMI handler asks the
> hypervisor to devirtualize.
> 
>> As part of that,
>> the arguments include an entry point to return back to linux. This asm
>> stub implements that entry point.
>>
>> The stub is entered in protected mode, uses temporary gdt and page table
>> to enable long mode and get to kernel entry point which then restores full
>> kernel context to resume execution to kexec.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_trampoline.S | 105 ++++++++++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
>>
>> diff --git a/arch/x86/hyperv/hv_trampoline.S b/arch/x86/hyperv/hv_trampoline.S
>> new file mode 100644
>> index 000000000000..27a755401a42
>> --- /dev/null
>> +++ b/arch/x86/hyperv/hv_trampoline.S
>> @@ -0,0 +1,105 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * X86 specific Hyper-V kdump/crash related code.
> 
> Add a qualification that this is for root partition only, and not for
> general guests?

i don't think it is needed, it would be odd for guests to collect hyp
core. besides makefile/kconfig shows this is root vm only

>> + *
>> + * Copyright (C) 2025, Microsoft, Inc.
>> + *
>> + */
>> +#include <linux/linkage.h>
>> +#include <asm/alternative.h>
>> +#include <asm/msr.h>
>> +#include <asm/processor-flags.h>
>> +#include <asm/nospec-branch.h>
>> +
>> +/*
>> + * void noreturn hv_crash_asm32(arg1)
>> + *    arg1 == edi == 32bit PA of struct hv_crash_trdata
> 
> I think this is "struct hv_crash_tramp_data".

correct

>> + *
>> + * The hypervisor jumps here upon devirtualization in protected mode. This
>> + * code gets copied to a page in the low 4G ie, 32bit space so it can run
>> + * in the protected mode. Hence we cannot use any compile/link time offsets or
>> + * addresses. It restores long mode via temporary gdt and page tables and
>> + * eventually jumps to kernel code entry at HV_CRASHDATA_OFFS_C_entry.
>> + *
>> + * PreCondition (ie, Hypervisor call back ABI):
>> + *  o CR0 is set to 0x0021: PE(prot mode) and NE are set, paging is disabled
>> + *  o CR4 is set to 0x0
>> + *  o IA32_EFER is set to 0x901 (SCE and NXE are set)
>> + *  o EDI is set to the Arg passed to HVCALL_DISABLE_HYP_EX.
>> + *  o CS, DS, ES, FS, GS are all initialized with a base of 0 and limit 0xFFFF
>> + *  o IDTR, TR and GDTR are initialized with a base of 0 and limit of 0xFFFF
>> + *  o LDTR is initialized as invalid (limit of 0)
>> + *  o MSR PAT is power on default.
>> + *  o Other state/registers are cleared. All TLBs flushed.
> 
> Clarification about "Other state/registers are cleared":  What about
> processor features that Linux may have enabled or disabled during its
> initial boot? Are those still in the states Linux set? Or are they reset to
> power-on defaults? For example, if Linux enabled x2apic, is x2apic
> still enabled when the stub is entered?

correct, if linux set x2apic, x2apic would still be enabled.

>> + *
>> + * See Intel SDM 10.8.5
> 
> Hmmm. I downloaded the latest combined SDM, and section 10.8.5
> in Volume 3A is about Microcode Update Resources, which doesn't
> seem applicable here. Other volumes don't have a section 10.8.5.

google ai found it right away upon searching: intel sdm 10.8.5 ia-32e

>> + */
>> +
>> +#define HV_CRASHDATA_OFFS_TRAMPCR3    0x0    /*	 0 */
>> +#define HV_CRASHDATA_OFFS_KERNCR3     0x8    /*	 8 */
>> +#define HV_CRASHDATA_OFFS_GDTRLIMIT  0x12    /* 18 */
>> +#define HV_CRASHDATA_OFFS_CS_JMPTGT  0x28    /* 40 */
>> +#define HV_CRASHDATA_OFFS_C_entry    0x30    /* 48 */
> 
> It seems like these offsets should go in a #include file along
> with the definition of struct hv_crash_tramp_data. Then the
> BUILD_BUG_ON() calls in hv_crash_setup_trampdata() could
> check against these symbolic names instead of hardcoding
> numbers that must match these.

yeah, that works too and was the first cut. but given the small
number of these, and that they are not used/needed anywhere else,
and that they will almost never change, creating another tiny header
in a non-driver directory didn't seem worth it.. but i could go
either way.

>> +#define HV_CRASHDATA_TRAMPOLINE_CS    0x8
> 
> This #define isn't used anywhere.

removed

>> +
>> +	.text
>> +	.code32
>> +
>> +SYM_CODE_START(hv_crash_asm32)
>> +	UNWIND_HINT_UNDEFINED
>> +	ANNOTATE_NOENDBR
> 
> No ENDBR here, presumably because this function is entered via other
> than an indirect CALL or JMP instruction. Right?
> 
>> +	movl	$X86_CR4_PAE, %ecx
>> +	movl	%ecx, %cr4
>> +
>> +	movl %edi, %ebx
>> +	add $HV_CRASHDATA_OFFS_TRAMPCR3, %ebx
>> +	movl %cs:(%ebx), %eax
>> +	movl %eax, %cr3
>> +
>> +	# Setup EFER for long mode now.
>> +	movl	$MSR_EFER, %ecx
>> +	rdmsr
>> +	btsl	$_EFER_LME, %eax
>> +	wrmsr
>> +
>> +	# Turn paging on using the temp 32bit trampoline page table.
>> +	movl %cr0, %eax
>> +	orl $(X86_CR0_PG), %eax
>> +	movl %eax, %cr0
>> +
>> +	/* since kernel cr3 could be above 4G, we need to be in the long mode
>> +	 * before we can load 64bits of the kernel cr3. We use a temp gdt for
>> +	 * that with CS.L=1 and CS.D=0 */
>> +	mov %edi, %eax
>> +	add $HV_CRASHDATA_OFFS_GDTRLIMIT, %eax
>> +	lgdtl %cs:(%eax)
>> +
>> +	/* not done yet, restore CS now to switch to CS.L=1 */
>> +	mov %edi, %eax
>> +	add $HV_CRASHDATA_OFFS_CS_JMPTGT, %eax
>> +	ljmp %cs:*(%eax)
>> +SYM_CODE_END(hv_crash_asm32)
>> +
>> +	/* we now run in full 64bit IA32-e long mode, CS.L=1 and CS.D=0 */
>> +	.code64
>> +	.balign 8
>> +SYM_CODE_START(hv_crash_asm64)
>> +	UNWIND_HINT_UNDEFINED
>> +	ANNOTATE_NOENDBR
> 
> But this *is* entered via an indirect JMP, right? So back to my
> earlier question about the state of processor feature enablement.
> If Linux enabled IBT, is it still enabled after devirtualization and
> the hypervisor invokes this entry point? Linux guests on Hyper-V
> have historically not enabled IBT, but patches that enable it are
> now in linux-next, and will go into the 6.18 kernel. So maybe
> this needs an ENDBR64.

IBT would be disabled in the transition here.... so doesn't really
matter. ENDBR ok too..

>> +SYM_INNER_LABEL(hv_crash_asm64_lbl, SYM_L_GLOBAL)
>> +	/* restore kernel page tables so we can jump to kernel code */
>> +	mov %edi, %eax
>> +	add $HV_CRASHDATA_OFFS_KERNCR3, %eax
>> +	movq %cs:(%eax), %rbx
>> +	movq %rbx, %cr3
>> +
>> +	mov %edi, %eax
>> +	add $HV_CRASHDATA_OFFS_C_entry, %eax
>> +	movq %cs:(%eax), %rbx
>> +	ANNOTATE_RETPOLINE_SAFE
>> +	jmp *%rbx
>> +
>> +	int $3
>> +
>> +SYM_INNER_LABEL(hv_crash_asm_end, SYM_L_GLOBAL)
>> +SYM_CODE_END(hv_crash_asm64)
>> --
>> 2.36.1.vfs.0.0
>>
> 


