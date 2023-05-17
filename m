Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0417068F4
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 15:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjEQNKh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjEQNKd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 09:10:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDCF7698;
        Wed, 17 May 2023 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dJETB9f7Nqe+HOH3BOmXiDEcHvWstWKy2YicjaZUW0s=; b=JpKrjkfPe5RqgHCC70RjQzItBL
        pS4EPhVMClGTrX/KYYtj8ujVK8sN6IPfcj5q1A3ohetGE2Jjk0puuPpD7mUxVSQmBwghToXBoRYw0
        cmo+OraluLD2yV3NpVwoeUMmR0eq3wKdUXG1BXDhZilhhS5UkDJ+IJFyBaxczovGaUGi1yNs67Nvz
        rapz0ENUgsu5uEsNVLzWuoi7oTO6Lwar3CSZ79VAhxDmCO/EncSRPm4c/wVUc59rDFumvG8yPLUFn
        7tIF+AUXI5hhZMcKtdM21ERChp3hpsexxqmeV3d6pI9ZIcl3yPQunAqbFcVgDtwL3+FrFWK+bajP+
        DjWzXB4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pzGuX-0056Q0-0W; Wed, 17 May 2023 13:09:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B14A30003A;
        Wed, 17 May 2023 15:09:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F891202F952C; Wed, 17 May 2023 15:09:43 +0200 (CEST)
Date:   Wed, 17 May 2023 15:09:43 +0200
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
Message-ID: <20230517130943.GE2665450@hirez.programming.kicks-ass.net>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
 <20230515165917.1306922-3-ltykernel@gmail.com>
 <20230516093225.GD2587705@hirez.programming.kicks-ass.net>
 <851f6305-2145-d756-91e3-55ab89bfcd42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <851f6305-2145-d756-91e3-55ab89bfcd42@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 17, 2023 at 05:55:45PM +0800, Tianyu Lan wrote:
> On 5/16/2023 5:32 PM, Peter Zijlstra wrote:
> > > --- a/arch/x86/entry/entry_64.S
> > > +++ b/arch/x86/entry/entry_64.S
> > > @@ -1019,6 +1019,15 @@ SYM_CODE_END(paranoid_entry)
> > >    * R15 - old SPEC_CTRL
> > >    */
> > >   SYM_CODE_START_LOCAL(paranoid_exit)
> > > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > > +	/*
> > > +	 * If a #HV was delivered during execution and interrupts were
> > > +	 * disabled, then check if it can be handled before the iret
> > > +	 * (which may re-enable interrupts).
> > > +	 */
> > > +	mov     %rsp, %rdi
> > > +	call    check_hv_pending
> > > +#endif
> > >   	UNWIND_HINT_REGS
> > >   	/*
> > > @@ -1143,6 +1152,15 @@ SYM_CODE_START(error_entry)
> > >   SYM_CODE_END(error_entry)
> > >   SYM_CODE_START_LOCAL(error_return)
> > > +#ifdef CONFIG_AMD_MEM_ENCRYPT
> > > +	/*
> > > +	 * If a #HV was delivered during execution and interrupts were
> > > +	 * disabled, then check if it can be handled before the iret
> > > +	 * (which may re-enable interrupts).
> > > +	 */
> > > +	mov     %rsp, %rdi
> > > +	call    check_hv_pending
> > > +#endif
> > >   	UNWIND_HINT_REGS
> > >   	DEBUG_ENTRY_ASSERT_IRQS_OFF
> > >   	testb	$3, CS(%rsp)
> > Oh hell no... do now you're adding unconditional calls to every single
> > interrupt and nmi exit path, with the grand total of 0 justification.
> > 
> 
> Sorry to Add check inside of check_hv_pending(). Will move the check before
> calling check_hv_pending() in the next version. Thanks.

You will also explain, in the Changelog, in excruciating detail, *WHY*
any of this is required.

Any additional code in these paths that are only required for some
random hypervisor had better proof that they are absolutely required and
no alternative solution exists and have no performance impact on normal
users.

If this is due to Hyper-V design idiocies over something fundamentally
required by the hardware design you'll get a NAK.
