Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FAD728137
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 15:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbjFHNWb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 09:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjFHNWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 09:22:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E875530D3;
        Thu,  8 Jun 2023 06:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PWoXpUmlC45fg1IpqI9CEjVwcpGlHdFT1Fkl0ZaYbyQ=; b=nIW8kQyI7IAqekwsHeAYisHbpb
        3GisiixqCf6RDzaBUTVnWt+aNvye5Dz6QhDT1RQJvCwAMhydTBsU0ieikGZNP8qN+Xg9ZlXrlHO5p
        NbFsIpeMwY6d08ji/nheXkQNlMoejJxRUbSTyG5wqTrdQP/ljqS5fpUziq5N533bfQwqlT4up1T88
        KVlXCPgrqyGHW1Ff6xqLkEIcP+cCJ+yO4lY2mioNfItPmH49bNBA5Cq5Cxv+PdMApJ1d+L5fECu9E
        yXrKenzdPGaCeCcIb626ssp7AGZvpb+WNdL7K/oDe8Ni86nhD2twXXo/SdG8DJ6lch4b91w8snLwL
        bWvCiQZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7FZx-00FUw2-GQ; Thu, 08 Jun 2023 13:21:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 623A4300274;
        Thu,  8 Jun 2023 15:21:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4864D23FF6AD1; Thu,  8 Jun 2023 15:21:27 +0200 (CEST)
Date:   Thu, 8 Jun 2023 15:21:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, Tianyu Lan <tiala@microsoft.com>,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Message-ID: <20230608132127.GK998233@hirez.programming.kicks-ass.net>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-6-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601151624.1757616-6-ltykernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 01, 2023 at 11:16:18AM -0400, Tianyu Lan wrote:
> From: Tianyu Lan <tiala@microsoft.com>
> 
> In sev-snp enlightened guest, Hyper-V hypercall needs
> to use vmmcall to trigger vmexit and notify hypervisor
> to handle hypercall request.
> 
> There is no x86 SEV SNP feature flag support so far and
> hardware provides MSR_AMD64_SEV register to check SEV-SNP
> capability with MSR_AMD64_SEV_ENABLED bit. ALTERNATIVE can't
> work without SEV-SNP x86 feature flag. May add later when
> the associated flag is introduced. 
> 
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 44 ++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 31c476f4e656..d859d7c5f5e8 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -61,16 +61,25 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  	u64 hv_status;
>  
>  #ifdef CONFIG_X86_64
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	} else {
> +		if (!hv_hypercall_pg)
> +			return U64_MAX;
>  
> -	__asm__ __volatile__("mov %4, %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     :  "r" (output_address),
> -				THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     CALL_NOSPEC
> +				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address),
> +					THUNK_TARGET(hv_hypercall_pg)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	}
>  #else

Remains unanswered:

https://lkml.kernel.org/r/20230516102912.GG2587705%40hirez.programming.kicks-ass.net

Would this not generate better code with an alternative?
