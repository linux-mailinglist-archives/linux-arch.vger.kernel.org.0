Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58097704987
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 11:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEPJlU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjEPJlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 05:41:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D73826A2;
        Tue, 16 May 2023 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8/4tilrQKiIvB0XfRafYvjplDtXGmdWzz3tJ/hV+6Oo=; b=ERWziaznZS59/P3raJ/oSaU4FO
        5DzH9OMJuMMiTDupib/I5+sd2VAdnjXu0PaIjSknwMx+MNgg4Ub6bviM0g8QnvZrV1xbO3jQyIdcU
        1jafU4KSEKHxEBtMhCnvbRZMEcgIsUbZS7QRLLxAAFKvPEtZRUiR0oCsfRqyPn72qgUOZKgMv20Uc
        z81G3YOnoR1ANp5XYuNZ2kGnBrY8u0EwPntOBjNng1V4ZXrtTJj1hrgyUBETn5D7ElQsuCN4j34Gs
        c2Vn2kKovXSm6B7BZjC4/KTXifk7pbFGYutQEQ216e28uLuIQJ5TP5QLSuS+seFD/h1/W7IdXukC6
        8C4peoRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyrAn-0048tQ-F2; Tue, 16 May 2023 09:40:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 771B93003CF;
        Tue, 16 May 2023 11:40:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 593AE20118D79; Tue, 16 May 2023 11:40:48 +0200 (CEST)
Date:   Tue, 16 May 2023 11:40:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, ashish.kalra@amd.com,
        srutherford@google.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, pawan.kumar.gupta@linux.intel.com,
        adrian.hunter@intel.com, daniel.sneddon@linux.intel.com,
        alexander.shishkin@linux.intel.com, sandipan.das@amd.com,
        ray.huang@amd.com, brijesh.singh@amd.com, michael.roth@amd.com,
        thomas.lendacky@amd.com, venu.busireddy@oracle.com,
        sterritt@google.com, tony.luck@intel.com, samitolvanen@google.com,
        fenghua.yu@intel.com, pangupta@amd.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH V6 03/14] x86/sev: Add AMD sev-snp enlightened guest
 support on hyperv
Message-ID: <20230516094048.GE2587705@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-4-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515165917.1306922-4-ltykernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 12:59:05PM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Enable #HV exception to handle interrupt requests from hypervisor.
> 
> Co-developed-by: Lendacky Thomas <thomas.lendacky@amd.com>
> Co-developed-by: Kalra Ashish <ashish.kalra@amd.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V5:
>        * Merge patch "x86/sev: Fix interrupt exit code paths from
>         #HV exception" with this commit.
> 
> Change since RFC V3:
>        * Check NMI event when irq is disabled.
>        * Remove redundant variable
> ---
>  arch/x86/include/asm/idtentry.h    |  12 +-
>  arch/x86/include/asm/mem_encrypt.h |   2 +
>  arch/x86/include/uapi/asm/svm.h    |   4 +
>  arch/x86/kernel/sev.c              | 349 ++++++++++++++++++++++++-----
>  arch/x86/kernel/traps.c            |   2 +
>  5 files changed, 310 insertions(+), 59 deletions(-)
> 
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index b0f3501b2767..867073ccf1d1 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -13,6 +13,12 @@
>  
>  #include <asm/irq_stack.h>
>  
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +noinstr void irqentry_exit_hv_cond(struct pt_regs *regs, irqentry_state_t state);
> +#else
> +#define irqentry_exit_hv_cond(regs, state)	irqentry_exit(regs, state)
> +#endif
> +
>  /**
>   * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
>   *		      No error code pushed by hardware
> @@ -201,7 +207,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
>  	kvm_set_cpu_l1tf_flush_l1d();					\
>  	run_irq_on_irqstack_cond(__##func, regs, vector);		\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	irqentry_exit_hv_cond(regs, state);				\
>  }									\
>  									\
>  static noinline void __##func(struct pt_regs *regs, u32 vector)
> @@ -241,7 +247,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  	kvm_set_cpu_l1tf_flush_l1d();					\
>  	run_sysvec_on_irqstack_cond(__##func, regs);			\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	irqentry_exit_hv_cond(regs, state);				\
>  }									\
>  									\
>  static noinline void __##func(struct pt_regs *regs)
> @@ -270,7 +276,7 @@ __visible noinstr void func(struct pt_regs *regs)			\
>  	__##func (regs);						\
>  	__irq_exit_raw();						\
>  	instrumentation_end();						\
> -	irqentry_exit(regs, state);					\
> +	irqentry_exit_hv_cond(regs, state);				\
>  }									\
>  									\
>  static __always_inline void __##func(struct pt_regs *regs)

WTF is this supposed to do and why is this the right way to achieve the
desired result?

Your changelog gives me 0 clues -- guess how much I then care about your
patches?
