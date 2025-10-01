Return-Path: <linux-arch+bounces-13826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F74BB1C72
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C03D3BA60B
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 21:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C7B30F804;
	Wed,  1 Oct 2025 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="csH1HTd3"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CA72F1FE9;
	Wed,  1 Oct 2025 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352881; cv=none; b=e0KinV6uetxOuX7It8mW63s14BIUZSy1W0wU+SwuRLOyEZj7IG7vO4TgeWwULqSxcoP6M6qajxq8A2WOeDbGiGd8DWHeRgBGi1KdzVdoZgsLi+GpK/9zYSt5z4OX6SddCPm0+3PJnRYWVHu/tUwJGWWxtzuw6HEc7rAygJOgQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352881; c=relaxed/simple;
	bh=AgrXHVUfy3P6MkepdZZsw9a3y9UwNLb4qp6DRk/W2Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nf86xYyTpZtfdxMfBj9lycX3z5OmUEfVpTtpDTSQ5HQG2qTp0S03S17G6xKlLinxms/hTFZZmH/o114qcbXhpzdgHwCfYDW0kAqfYQED/ITdD5CRjr1HXatHPCsA9f6QZf6LUUaFYiMs64jOxKEh8QDb0lW7o68XV40Yzi+nC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=csH1HTd3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7E225211AF3D;
	Wed,  1 Oct 2025 14:07:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E225211AF3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759352872;
	bh=elyMXb8jGOWroYPdIuHQYJfY8Pr+kpb+LH8J/hAkkrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=csH1HTd3z7JaahxCmV86fhtXZ+a6UP/H0lLQSOJCq0khLPXmawRUkvpTZdC8JXmJO
	 4VlQGCfDSTnPYkMoF19WTn9cEVwMr274+0PgetflGNEUpSvtJ7lVlca9V2WCUxSXA7
	 J7X091HbZc+3zqoTWNvR/L0/90lZGA++9uSjf5PU=
Message-ID: <c74ad4a7-fcf0-6276-ee50-a3cb255e3f5b@linux.microsoft.com>
Date: Wed, 1 Oct 2025 14:07:52 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
References: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
 <20250923214609.4101554-5-mrathor@linux.microsoft.com>
 <20251001060002.GA603271@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20251001060002.GA603271@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 23:00, Wei Liu wrote:
> On Tue, Sep 23, 2025 at 02:46:07PM -0700, Mukesh Rathor wrote:
>> Introduce a small asm stub to transition from the hypervisor to Linux
>> after devirtualization. Devirtualization means disabling hypervisor on
>> the fly, so after it is done, the code is running on physical processor
>> instead of virtual, and hypervisor is gone. This can be done by a
>> root/dom0 vm only.
> 
> I want to scrub "dom0" from comments and commit messages. We drew
> parallels to Xen when we first wrote this code, but it's not a useful
> term externally. "root" or "root partition" should be sufficient.
> 
>>
>> At a high level, during panic of either the hypervisor or the dom0 (aka
>> root), the NMI handler asks hypervisor to devirtualize. As part of that,
>> the arguments include an entry point to return back to Linux. This asm
>> stub implements that entry point.
>>
>> The stub is entered in protected mode, uses temporary gdt and page table
>> to enable long mode and get to kernel entry point which then restores full
>> kernel context to resume execution to kexec.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_trampoline.S | 101 ++++++++++++++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
>>
>> diff --git a/arch/x86/hyperv/hv_trampoline.S b/arch/x86/hyperv/hv_trampoline.S
>> new file mode 100644
>> index 000000000000..25f02ff12286
>> --- /dev/null
>> +++ b/arch/x86/hyperv/hv_trampoline.S
>> @@ -0,0 +1,101 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * X86 specific Hyper-V kdump/crash related code.
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
>> + *    arg1 == edi == 32bit PA of struct hv_crash_tramp_data
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
>> + */
>> +
>> +#define HV_CRASHDATA_OFFS_TRAMPCR3    0x0    /*  0 */
>> +#define HV_CRASHDATA_OFFS_KERNCR3     0x8    /*  8 */
>> +#define HV_CRASHDATA_OFFS_GDTRLIMIT  0x12    /* 18 */
>> +#define HV_CRASHDATA_OFFS_CS_JMPTGT  0x28    /* 40 */
>> +#define HV_CRASHDATA_OFFS_C_entry    0x30    /* 48 */
>> +
>> +	.text
>> +	.code32
>> +
> 
> I recently learned that instrumentation may be problematic for context
> switching code. I have not studied this code and noinstr usage in tree
> extensively so cannot make a judgement here.
> 
> It is worth checking out the recent discussion on the VTL transition
> code.
> 
> https://lore.kernel.org/linux-hyperv/27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com/
> 
> And check out the in-tree document Documentation/core-api/entry.rst.

Thanks, we should be ok here because this is actually copied to another
below 4G page for protected mode transfer. It is then executed from there,
and not the default section it is linked in. For example, 

arch/x86/kernel/relocate_kernel_64.S

does not have .noinstr. 

Thanks,
-Mukesh


> Wei
> 
>> +SYM_CODE_START(hv_crash_asm32)
>> +	UNWIND_HINT_UNDEFINED
>> +	ENDBR
>> +	movl	$X86_CR4_PAE, %ecx
>> +	movl	%ecx, %cr4
>> +
>> +	movl %edi, %ebx
>> +	add $HV_CRASHDATA_OFFS_TRAMPCR3, %ebx
>> +	movl %cs:(%ebx), %eax
>> +	movl %eax, %cr3
>> +
>> +	/* Setup EFER for long mode now */
>> +	movl	$MSR_EFER, %ecx
>> +	rdmsr
>> +	btsl	$_EFER_LME, %eax
>> +	wrmsr
>> +
>> +	/* Turn paging on using the temp 32bit trampoline page table */
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
>> +	ENDBR
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
>>


