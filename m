Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE5470495C
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 11:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjEPJcy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 05:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjEPJcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 05:32:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98F194;
        Tue, 16 May 2023 02:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oIgdPmCXqhee1g0Lx56Hm3vkEJAyrRi5e5AhyWtrob0=; b=n/VYDl/PQcihzNTecId77NAldK
        KJAhVDr0oAEc/h9vb6CVq5anxiOQnebjGIZ0CIQOImMGPY8Wl8z7zO+6josV1thiTLTRkrEo4c5fE
        tCtfpg8VY6IiWp3WgpDILTRNSu3aBv1oHxg1mQtVpKZ7BY1fvF60+0O9CqPp7MN61bPBuHqQCxQbI
        gtEYlW4v7FKwUUqNCsva4Gjw+hdxV8KEY3RDgJXtxA71g6KldYSrkoxKWDRtARC2XzpXbCnx0/AZg
        4LnB4ouTcL1gJ/wNIUpRxrr1gTDn4FZVqcDBpwu4coiQEOViIxHBewma+VbUC3Rc2P+4JbcoNeBBN
        F7NOGbRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyr2g-00C4ZW-1t;
        Tue, 16 May 2023 09:32:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3EC630008D;
        Tue, 16 May 2023 11:32:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D9F9520118D79; Tue, 16 May 2023 11:32:25 +0200 (CEST)
Date:   Tue, 16 May 2023 11:32:25 +0200
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
Subject: Re: [RFC PATCH V6 02/14] x86/sev: Add Check of #HV event in path
Message-ID: <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-3-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515165917.1306922-3-ltykernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 12:59:04PM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> Add check_hv_pending() and check_hv_pending_after_irq() to
> check queued #HV event when irq is disabled.
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/entry/entry_64.S       | 18 ++++++++++++++++
>  arch/x86/include/asm/irqflags.h | 14 +++++++++++-
>  arch/x86/kernel/sev.c           | 38 +++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 653b1f10699b..147b850babf6 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1019,6 +1019,15 @@ SYM_CODE_END(paranoid_entry)
>   * R15 - old SPEC_CTRL
>   */
>  SYM_CODE_START_LOCAL(paranoid_exit)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * If a #HV was delivered during execution and interrupts were
> +	 * disabled, then check if it can be handled before the iret
> +	 * (which may re-enable interrupts).
> +	 */
> +	mov     %rsp, %rdi
> +	call    check_hv_pending
> +#endif
>  	UNWIND_HINT_REGS
>  
>  	/*
> @@ -1143,6 +1152,15 @@ SYM_CODE_START(error_entry)
>  SYM_CODE_END(error_entry)
>  
>  SYM_CODE_START_LOCAL(error_return)
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	/*
> +	 * If a #HV was delivered during execution and interrupts were
> +	 * disabled, then check if it can be handled before the iret
> +	 * (which may re-enable interrupts).
> +	 */
> +	mov     %rsp, %rdi
> +	call    check_hv_pending
> +#endif
>  	UNWIND_HINT_REGS
>  	DEBUG_ENTRY_ASSERT_IRQS_OFF
>  	testb	$3, CS(%rsp)

Oh hell no... do now you're adding unconditional calls to every single
interrupt and nmi exit path, with the grand total of 0 justification.

