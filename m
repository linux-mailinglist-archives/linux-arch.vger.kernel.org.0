Return-Path: <linux-arch+bounces-13819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F27BAF29D
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 08:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48A8189F087
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 06:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78C22D6620;
	Wed,  1 Oct 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJoNubzx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8827F74B;
	Wed,  1 Oct 2025 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759298404; cv=none; b=XdB6R+01Gdx1XYmkdFPbzAnHfRV8SIcXpJ4+I5iR5HXb3fju/x9986J/fuL79dZ8w/HWBfzWmA+rHSXycZhXXMEo85t8KkZIff8tcCFBf8N2g8d6wtM0URKdZB2a18GLtQzvhwnkyWzCxFCADAYEkCVYdWzYdHnGc6kZttU2HHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759298404; c=relaxed/simple;
	bh=BL+aFBzA9dlLWjXJCXVuikVhV/kBThl2YlDnC4VRyxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUiY9C3qrGu/IC8NMLp5SxteNLp4+hE/Vf3lqjQmF5XMCAi6n+RSlVET/8BkNmvKXG61C6ebGEdrkcC0U4JrNTo/i6gp/4PcCvPSviA3v7IEK3XaFDU0EGOOlnM6ABS4nkVZwj18pCB6kC0B/wotYYk2vJXVB3kqp7vQjfNOw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJoNubzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7E2C4CEF5;
	Wed,  1 Oct 2025 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759298404;
	bh=BL+aFBzA9dlLWjXJCXVuikVhV/kBThl2YlDnC4VRyxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJoNubzxfsFRjlfmaL9Hnx11xwd97uKJuurs+fRG1FTDKyEaac+39+u/vd73SpdmL
	 wVlmUCwqd4LB4tpS4ic173g1xVisffNBLtRfUbsO23h5hAE4txXOOxD1+I3TtmOVEq
	 OgKe8sgYqk1XyFuKqIETnxQ9TAul3I/9bZw3/R2ywFva6K06ndhpGjBfRh8vGuaYZX
	 QoLx++WPUTAMvQ/7k9U1rmXGCHt5tEmhcav7CcuVZA6Y9OQD4E49H/FQJJHZfBCf4v
	 WlgnVJrBMA4rBDDTQ8M2ILo0yZ03YUkCjIIBJEbNXTUNPlajhNgmuz0bWn3bWrqgfk
	 0umhPVtI+0nVA==
Date: Wed, 1 Oct 2025 06:00:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Subject: Re: [PATCH v2 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Message-ID: <20251001060002.GA603271@liuwe-devbox-debian-v2.local>
References: <20250923214609.4101554-1-mrathor@linux.microsoft.com>
 <20250923214609.4101554-5-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923214609.4101554-5-mrathor@linux.microsoft.com>

On Tue, Sep 23, 2025 at 02:46:07PM -0700, Mukesh Rathor wrote:
> Introduce a small asm stub to transition from the hypervisor to Linux
> after devirtualization. Devirtualization means disabling hypervisor on
> the fly, so after it is done, the code is running on physical processor
> instead of virtual, and hypervisor is gone. This can be done by a
> root/dom0 vm only.

I want to scrub "dom0" from comments and commit messages. We drew
parallels to Xen when we first wrote this code, but it's not a useful
term externally. "root" or "root partition" should be sufficient.

> 
> At a high level, during panic of either the hypervisor or the dom0 (aka
> root), the NMI handler asks hypervisor to devirtualize. As part of that,
> the arguments include an entry point to return back to Linux. This asm
> stub implements that entry point.
> 
> The stub is entered in protected mode, uses temporary gdt and page table
> to enable long mode and get to kernel entry point which then restores full
> kernel context to resume execution to kexec.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_trampoline.S | 101 ++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
> 
> diff --git a/arch/x86/hyperv/hv_trampoline.S b/arch/x86/hyperv/hv_trampoline.S
> new file mode 100644
> index 000000000000..25f02ff12286
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_trampoline.S
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * X86 specific Hyper-V kdump/crash related code.
> + *
> + * Copyright (C) 2025, Microsoft, Inc.
> + *
> + */
> +#include <linux/linkage.h>
> +#include <asm/alternative.h>
> +#include <asm/msr.h>
> +#include <asm/processor-flags.h>
> +#include <asm/nospec-branch.h>
> +
> +/*
> + * void noreturn hv_crash_asm32(arg1)
> + *    arg1 == edi == 32bit PA of struct hv_crash_tramp_data
> + *
> + * The hypervisor jumps here upon devirtualization in protected mode. This
> + * code gets copied to a page in the low 4G ie, 32bit space so it can run
> + * in the protected mode. Hence we cannot use any compile/link time offsets or
> + * addresses. It restores long mode via temporary gdt and page tables and
> + * eventually jumps to kernel code entry at HV_CRASHDATA_OFFS_C_entry.
> + *
> + * PreCondition (ie, Hypervisor call back ABI):
> + *  o CR0 is set to 0x0021: PE(prot mode) and NE are set, paging is disabled
> + *  o CR4 is set to 0x0
> + *  o IA32_EFER is set to 0x901 (SCE and NXE are set)
> + *  o EDI is set to the Arg passed to HVCALL_DISABLE_HYP_EX.
> + *  o CS, DS, ES, FS, GS are all initialized with a base of 0 and limit 0xFFFF
> + *  o IDTR, TR and GDTR are initialized with a base of 0 and limit of 0xFFFF
> + *  o LDTR is initialized as invalid (limit of 0)
> + *  o MSR PAT is power on default.
> + *  o Other state/registers are cleared. All TLBs flushed.
> + */
> +
> +#define HV_CRASHDATA_OFFS_TRAMPCR3    0x0    /*  0 */
> +#define HV_CRASHDATA_OFFS_KERNCR3     0x8    /*  8 */
> +#define HV_CRASHDATA_OFFS_GDTRLIMIT  0x12    /* 18 */
> +#define HV_CRASHDATA_OFFS_CS_JMPTGT  0x28    /* 40 */
> +#define HV_CRASHDATA_OFFS_C_entry    0x30    /* 48 */
> +
> +	.text
> +	.code32
> +

I recently learned that instrumentation may be problematic for context
switching code. I have not studied this code and noinstr usage in tree
extensively so cannot make a judgement here.

It is worth checking out the recent discussion on the VTL transition
code.

https://lore.kernel.org/linux-hyperv/27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com/

And check out the in-tree document Documentation/core-api/entry.rst.

Wei

> +SYM_CODE_START(hv_crash_asm32)
> +	UNWIND_HINT_UNDEFINED
> +	ENDBR
> +	movl	$X86_CR4_PAE, %ecx
> +	movl	%ecx, %cr4
> +
> +	movl %edi, %ebx
> +	add $HV_CRASHDATA_OFFS_TRAMPCR3, %ebx
> +	movl %cs:(%ebx), %eax
> +	movl %eax, %cr3
> +
> +	/* Setup EFER for long mode now */
> +	movl	$MSR_EFER, %ecx
> +	rdmsr
> +	btsl	$_EFER_LME, %eax
> +	wrmsr
> +
> +	/* Turn paging on using the temp 32bit trampoline page table */
> +	movl %cr0, %eax
> +	orl $(X86_CR0_PG), %eax
> +	movl %eax, %cr0
> +
> +	/* since kernel cr3 could be above 4G, we need to be in the long mode
> +	 * before we can load 64bits of the kernel cr3. We use a temp gdt for
> +	 * that with CS.L=1 and CS.D=0 */
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_GDTRLIMIT, %eax
> +	lgdtl %cs:(%eax)
> +
> +	/* not done yet, restore CS now to switch to CS.L=1 */
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_CS_JMPTGT, %eax
> +	ljmp %cs:*(%eax)
> +SYM_CODE_END(hv_crash_asm32)
> +
> +	/* we now run in full 64bit IA32-e long mode, CS.L=1 and CS.D=0 */
> +	.code64
> +	.balign 8
> +SYM_CODE_START(hv_crash_asm64)
> +	UNWIND_HINT_UNDEFINED
> +	ENDBR
> +	/* restore kernel page tables so we can jump to kernel code */
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_KERNCR3, %eax
> +	movq %cs:(%eax), %rbx
> +	movq %rbx, %cr3
> +
> +	mov %edi, %eax
> +	add $HV_CRASHDATA_OFFS_C_entry, %eax
> +	movq %cs:(%eax), %rbx
> +	ANNOTATE_RETPOLINE_SAFE
> +	jmp *%rbx
> +
> +	int $3
> +
> +SYM_INNER_LABEL(hv_crash_asm_end, SYM_L_GLOBAL)
> +SYM_CODE_END(hv_crash_asm64)
> -- 
> 2.36.1.vfs.0.0
> 
> 

