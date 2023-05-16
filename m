Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA1704A6E
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 12:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjEPKYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 06:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjEPKYS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 06:24:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FE59FB;
        Tue, 16 May 2023 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eW1zTzluRyqIINnOs8VCUy4pxgzgc9V9Y6G7uV7MxuQ=; b=NcnPY4RB8yYqW9VjiQjCFMVTEx
        PyloglVA0lSckZnGCcKmkZ2Slyvomc6r63BDwgu9hb7+fZn8oYerUNRw0VppdBaQiNSaKLHHIwzvZ
        kqjvaP73hu1BC6hnojADsEmeTPcRO8z2zDGrEfhPH3kDIJJHe6oOE+itSZqT5zjlPlZEwcisSFkd7
        d90j6kcjUfyNzBAn6Ka25DP8LnBfnOv1X0r6Q0cCKZyKoRGDB52lo4OuA4Sx3FMNZr6QAziPa7mqR
        RXHYQ9JZDqvZBb5gHucltoVkO4/ti3E3YLajQ8CFaQzecFiWp2mKB1IWmZlZ0dhzQQ66Pb6eU2V0B
        ZLZpmDtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyrpk-004AIk-3R; Tue, 16 May 2023 10:23:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 376D230008D;
        Tue, 16 May 2023 12:23:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DEF920118D79; Tue, 16 May 2023 12:23:06 +0200 (CEST)
Date:   Tue, 16 May 2023 12:23:05 +0200
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
Subject: Re: [RFC PATCH V6 04/14] x86/sev: optimize system vector processing
 invoked from #HV exception
Message-ID: <20230516102305.GF2587705@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-5-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515165917.1306922-5-ltykernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 12:59:06PM -0400, Tianyu Lan wrote:

So your subject states:

> Subject: [RFC PATCH V6 04/14] x86/sev: optimize system vector processing invoked from #HV exception
                                         ^^^^^^^^

> @@ -228,51 +238,11 @@ static void do_exc_hv(struct pt_regs *regs)
>  		} else if (pending_events.vector == IA32_SYSCALL_VECTOR) {
>  			WARN(1, "syscall shouldn't happen\n");
>  		} else if (pending_events.vector >= FIRST_SYSTEM_VECTOR) {
> -			switch (pending_events.vector) {
> -#if IS_ENABLED(CONFIG_HYPERV)
> -			case HYPERV_STIMER0_VECTOR:
> -				sysvec_hyperv_stimer0(regs);
> -				break;
> -			case HYPERVISOR_CALLBACK_VECTOR:
> -				sysvec_hyperv_callback(regs);
> -				break;
> -#endif
> -#ifdef CONFIG_SMP
> -			case RESCHEDULE_VECTOR:
> -				sysvec_reschedule_ipi(regs);
> -				break;
> -			case IRQ_MOVE_CLEANUP_VECTOR:
> -				sysvec_irq_move_cleanup(regs);
> -				break;
> -			case REBOOT_VECTOR:
> -				sysvec_reboot(regs);
> -				break;
> -			case CALL_FUNCTION_SINGLE_VECTOR:
> -				sysvec_call_function_single(regs);
> -				break;
> -			case CALL_FUNCTION_VECTOR:
> -				sysvec_call_function(regs);
> -				break;
> -#endif
> -#ifdef CONFIG_X86_LOCAL_APIC
> -			case ERROR_APIC_VECTOR:
> -				sysvec_error_interrupt(regs);
> -				break;
> -			case SPURIOUS_APIC_VECTOR:
> -				sysvec_spurious_apic_interrupt(regs);
> -				break;
> -			case LOCAL_TIMER_VECTOR:
> -				sysvec_apic_timer_interrupt(regs);
> -				break;
> -			case X86_PLATFORM_IPI_VECTOR:
> -				sysvec_x86_platform_ipi(regs);
> -				break;
> -#endif
> -			case 0x0:
> -				break;
> -			default:
> -				panic("Unexpected vector %d\n", vector);
> -				unreachable();
> +			if (!(sysvec_table[pending_events.vector - FIRST_SYSTEM_VECTOR])) {
> +				WARN(1, "system vector entry 0x%x is NULL\n",
> +				     pending_events.vector);
> +			} else {
> +				(*sysvec_table[pending_events.vector - FIRST_SYSTEM_VECTOR])(regs);
>  			}
>  		} else {
>  			common_interrupt(regs, pending_events.vector);

But your code replace direct calls with an indirect call. Now AFAIK,
this SNP shit came with Zen3, and Zen3 still uses retpolines for
indirect calls.

Can you connect the dots?
