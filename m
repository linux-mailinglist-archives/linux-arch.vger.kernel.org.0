Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7426463EB
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 23:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiLGWOX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Dec 2022 17:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLGWOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Dec 2022 17:14:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E72E5C757;
        Wed,  7 Dec 2022 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670451260; x=1701987260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6Iw+b7sYxcigcPQIf71g5CO0STZk5hjAYSULaVteNXc=;
  b=f7+rxxk3jn3zxJ7m+i4cUCQ1Etwn5pWR7N5QEwsnD8jiWZM3u94J+28C
   a9ojJyAIt3PqPMxYmAI6LQXNL4tyqArLTEV3reCF4Ga2tZcAARqflET/I
   kHi96yoJdOqFT5nWKyIjNaDoVFqWtB+QIKcyoCY1Bwp7QX5MIZyanhQ24
   HWQLRBC5KGWA3EhC+/JGrGG8KP3Q3TyirzLr5PNpXxNRJGJiGVAPg8nMd
   +hdCv3/3DgNRpcYfCRGtTqr1V8I9eG7Gu102WZtwCC3loaZX1f/s9nSj+
   CWiB0WBXf2PEKhzLwzq6oMiQw6bBEpNLAFlSbBjfuH/pTvBcHSDW0POKu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="300433289"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="300433289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 14:14:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="735552582"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="735552582"
Received: from gjalliso-mobl.amr.corp.intel.com (HELO [10.212.135.231]) ([10.212.135.231])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 14:14:18 -0800
Message-ID: <e6a4aeeb-382f-18cc-64da-7730101282c6@linux.intel.com>
Date:   Wed, 7 Dec 2022 14:14:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/6] x86/tdx: Expand __tdx_hypercall() to handle more
 arguments
Content-Language: en-US
To:     Dexuan Cui <decui@microsoft.com>, ak@linux.intel.com,
        arnd@arndb.de, bp@alien8.de, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, seanjc@google.com, tglx@linutronix.de,
        tony.luck@intel.com, wei.liu@kernel.org, x86@kernel.org,
        mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
References: <20221207003325.21503-1-decui@microsoft.com>
 <20221207003325.21503-5-decui@microsoft.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221207003325.21503-5-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 12/6/22 4:33 PM, Dexuan Cui wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> So far __tdx_hypercall() only handles six arguments for VMCALL.
> Expanding it to six more register would allow to cover more use-cases.
> 
> Using RDI and RSI as VMCALL arguments requires more register shuffling.
> RAX is used to hold tdx_hypercall_args pointer and RBP stores flags.
> 
> While there, fix typo in the comment on panic branch.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> This patch is from Kirill. I'm posting the patch on behalf him:
> https://lwn.net/ml/linux-kernel/20221202214741.7vfmqgvgubxqffen@box.shutemov.name/
> 
> This is actually v1, but let's use v2 in the Subject to be consistent
> with the Subjects of the other patches.
> 
>  arch/x86/coco/tdx/tdcall.S        | 82 ++++++++++++++++++++++---------
>  arch/x86/include/asm/shared/tdx.h |  6 +++
>  arch/x86/kernel/asm-offsets.c     |  6 +++
>  3 files changed, 70 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
> index f9eb1134f22d..64e57739dc9d 100644
> --- a/arch/x86/coco/tdx/tdcall.S
> +++ b/arch/x86/coco/tdx/tdcall.S
> @@ -13,6 +13,12 @@
>  /*
>   * Bitmasks of exposed registers (with VMM).
>   */
> +#define TDX_RDX		BIT(2)
> +#define TDX_RBX		BIT(3)
> +#define TDX_RSI		BIT(6)
> +#define TDX_RDI		BIT(7)
> +#define TDX_R8		BIT(8)
> +#define TDX_R9		BIT(9)
>  #define TDX_R10		BIT(10)
>  #define TDX_R11		BIT(11)
>  #define TDX_R12		BIT(12)
> @@ -27,9 +33,9 @@
>   * details can be found in TDX GHCI specification, section
>   * titled "TDCALL [TDG.VP.VMCALL] leaf".
>   */
> -#define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
> -					  TDX_R12 | TDX_R13 | \
> -					  TDX_R14 | TDX_R15 )
> +#define TDVMCALL_EXPOSE_REGS_MASK	\
> +	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
> +	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
>  

You seem to have expanded the list to include all VMCALL supported
registers except RBP. Why not include it as well? That way, it will be
a complete support.

>  /*
>   * __tdx_module_call()  - Used by TDX guests to request services from
> @@ -124,19 +130,32 @@ SYM_FUNC_START(__tdx_hypercall)
>  	push %r14
>  	push %r13
>  	push %r12
> +	push %rbx
> +	push %rbp
> +
> +	movq %rdi, %rax
> +	movq %rsi, %rbp
> +
> +	/* Copy hypercall registers from arg struct: */
> +	movq TDX_HYPERCALL_r8(%rax),  %r8
> +	movq TDX_HYPERCALL_r9(%rax),  %r9
> +	movq TDX_HYPERCALL_r10(%rax), %r10
> +	movq TDX_HYPERCALL_r11(%rax), %r11
> +	movq TDX_HYPERCALL_r12(%rax), %r12
> +	movq TDX_HYPERCALL_r13(%rax), %r13
> +	movq TDX_HYPERCALL_r14(%rax), %r14
> +	movq TDX_HYPERCALL_r15(%rax), %r15
> +	movq TDX_HYPERCALL_rdi(%rax), %rdi
> +	movq TDX_HYPERCALL_rsi(%rax), %rsi
> +	movq TDX_HYPERCALL_rbx(%rax), %rbx
> +	movq TDX_HYPERCALL_rdx(%rax), %rdx
> +
> +	push %rax
>  
>  	/* Mangle function call ABI into TDCALL ABI: */
>  	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
>  	xor %eax, %eax
>  
> -	/* Copy hypercall registers from arg struct: */
> -	movq TDX_HYPERCALL_r10(%rdi), %r10
> -	movq TDX_HYPERCALL_r11(%rdi), %r11
> -	movq TDX_HYPERCALL_r12(%rdi), %r12
> -	movq TDX_HYPERCALL_r13(%rdi), %r13
> -	movq TDX_HYPERCALL_r14(%rdi), %r14
> -	movq TDX_HYPERCALL_r15(%rdi), %r15
> -
>  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
>  
>  	/*
> @@ -148,14 +167,14 @@ SYM_FUNC_START(__tdx_hypercall)
>  	 * HLT operation indefinitely. Since this is the not the desired
>  	 * result, conditionally call STI before TDCALL.
>  	 */
> -	testq $TDX_HCALL_ISSUE_STI, %rsi
> +	testq $TDX_HCALL_ISSUE_STI, %rbp
>  	jz .Lskip_sti
>  	sti
>  .Lskip_sti:
>  	tdcall
>  
>  	/*
> -	 * RAX==0 indicates a failure of the TDVMCALL mechanism itself and that
> +	 * RAX!=0 indicates a failure of the TDVMCALL mechanism itself and that
>  	 * something has gone horribly wrong with the TDX module.
>  	 *
>  	 * The return status of the hypercall operation is in a separate
> @@ -165,30 +184,45 @@ SYM_FUNC_START(__tdx_hypercall)
>  	testq %rax, %rax
>  	jne .Lpanic
>  
> -	/* TDVMCALL leaf return code is in R10 */
> -	movq %r10, %rax
> +	pop %rax
>  
>  	/* Copy hypercall result registers to arg struct if needed */
> -	testq $TDX_HCALL_HAS_OUTPUT, %rsi
> +	testq $TDX_HCALL_HAS_OUTPUT, %rbp
>  	jz .Lout
>  
> -	movq %r10, TDX_HYPERCALL_r10(%rdi)
> -	movq %r11, TDX_HYPERCALL_r11(%rdi)
> -	movq %r12, TDX_HYPERCALL_r12(%rdi)
> -	movq %r13, TDX_HYPERCALL_r13(%rdi)
> -	movq %r14, TDX_HYPERCALL_r14(%rdi)
> -	movq %r15, TDX_HYPERCALL_r15(%rdi)
> +	movq %r8,  TDX_HYPERCALL_r8(%rax)
> +	movq %r9,  TDX_HYPERCALL_r9(%rax)
> +	movq %r10, TDX_HYPERCALL_r10(%rax)
> +	movq %r11, TDX_HYPERCALL_r11(%rax)
> +	movq %r12, TDX_HYPERCALL_r12(%rax)
> +	movq %r13, TDX_HYPERCALL_r13(%rax)
> +	movq %r14, TDX_HYPERCALL_r14(%rax)
> +	movq %r15, TDX_HYPERCALL_r15(%rax)
> +	movq %rdi, TDX_HYPERCALL_rdi(%rax)
> +	movq %rsi, TDX_HYPERCALL_rsi(%rax)
> +	movq %rbx, TDX_HYPERCALL_rbx(%rax)
> +	movq %rdx, TDX_HYPERCALL_rdx(%rax)
>  .Lout:
> +	/* TDVMCALL leaf return code is in R10 */
> +	movq %r10, %rax
> +
>  	/*
>  	 * Zero out registers exposed to the VMM to avoid speculative execution
>  	 * with VMM-controlled values. This needs to include all registers
> -	 * present in TDVMCALL_EXPOSE_REGS_MASK (except R12-R15). R12-R15
> -	 * context will be restored.
> +	 * present in TDVMCALL_EXPOSE_REGS_MASK, except RBX, and R12-R15 which
> +	 * will be restored.
>  	 */
> +	xor %r8d,  %r8d
> +	xor %r9d,  %r9d
>  	xor %r10d, %r10d
>  	xor %r11d, %r11d
> +	xor %rdi,  %rdi
> +	xor %rsi,  %rsi
> +	xor %rdx,  %rdx
>  
>  	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
> +	pop %rbp
> +	pop %rbx
>  	pop %r12
>  	pop %r13
>  	pop %r14
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index e53f26228fbb..8068faa52de1 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -22,12 +22,18 @@
>   * This is a software only structure and not part of the TDX module/VMM ABI.
>   */
>  struct tdx_hypercall_args {
> +	u64 r8;
> +	u64 r9;
>  	u64 r10;
>  	u64 r11;
>  	u64 r12;
>  	u64 r13;
>  	u64 r14;
>  	u64 r15;
> +	u64 rdi;
> +	u64 rsi;
> +	u64 rbx;
> +	u64 rdx;
>  };
>  
>  /* Used to request services from the VMM */
> diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> index 437308004ef2..9f09947495e2 100644
> --- a/arch/x86/kernel/asm-offsets.c
> +++ b/arch/x86/kernel/asm-offsets.c
> @@ -75,12 +75,18 @@ static void __used common(void)
>  	OFFSET(TDX_MODULE_r11, tdx_module_output, r11);
>  
>  	BLANK();
> +	OFFSET(TDX_HYPERCALL_r8,  tdx_hypercall_args, r8);
> +	OFFSET(TDX_HYPERCALL_r9,  tdx_hypercall_args, r9);
>  	OFFSET(TDX_HYPERCALL_r10, tdx_hypercall_args, r10);
>  	OFFSET(TDX_HYPERCALL_r11, tdx_hypercall_args, r11);
>  	OFFSET(TDX_HYPERCALL_r12, tdx_hypercall_args, r12);
>  	OFFSET(TDX_HYPERCALL_r13, tdx_hypercall_args, r13);
>  	OFFSET(TDX_HYPERCALL_r14, tdx_hypercall_args, r14);
>  	OFFSET(TDX_HYPERCALL_r15, tdx_hypercall_args, r15);
> +	OFFSET(TDX_HYPERCALL_rdi, tdx_hypercall_args, rdi);
> +	OFFSET(TDX_HYPERCALL_rsi, tdx_hypercall_args, rsi);
> +	OFFSET(TDX_HYPERCALL_rbx, tdx_hypercall_args, rbx);
> +	OFFSET(TDX_HYPERCALL_rdx, tdx_hypercall_args, rdx);
>  
>  	BLANK();
>  	OFFSET(BP_scratch, boot_params, scratch);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
