Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FD62A1F7
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 20:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiKOTeP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 14:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiKOTeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 14:34:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B1D9FF9;
        Tue, 15 Nov 2022 11:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+TZHe91CVKHcCvipG59L2Mt6GN52GFDDf1u+Vof4nE8=; b=Q7ytUqvEOw0JQGQeiFz9eKB7XE
        u6IILmY6Rs0Zc6uh5cIj6pEjW+vBgPo0eHG6v2elnUwRtAC8nPSgOGuujaZpV0hZ79xT2Ivv1PiJD
        KfecqmbHOE6kDo00ZNMG0gOry5tG2JJqS6BGRCZY8ScUi3NDhq5scMHTJw4Eexwu7u38JC0t28g64
        f7pP7BgeWXYSKITT0JtXpYtI8CyJK7AxypPIGUED56wzUpqpau7EuaPA0TuAS3QmwjHxM4dHThNWG
        gtOeX5R7Npcyfo6nvqYo7QPqxmBJaZLla4kr170lwgy6fcX+HTwQ9PSk4orOHlKHOhrFHOH/M8jJd
        e2gNgPOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1gd-00GXs4-9A; Tue, 15 Nov 2022 19:33:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA420300137;
        Tue, 15 Nov 2022 12:47:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E03B2015BE8A; Tue, 15 Nov 2022 12:47:22 +0100 (CET)
Date:   Tue, 15 Nov 2022 12:47:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v3 15/37] x86/mm: Check Shadow Stack page fault errors
Message-ID: <Y3N8Sn65TzyD6jwL@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-16-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-16-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:35:42PM -0700, Rick Edgecombe wrote:
> @@ -1331,6 +1345,18 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * To service shadow stack read faults, unlike normal read faults, the
> +	 * fault handler needs to create a type of memory that will also be
> +	 * writable (with instructions that generate shadow stack writes).
> +	 * In the case of COW memory, the COW needs to take place even with
> +	 * a shadow stack read. Otherwise the shared page will be left (shadow
> +	 * stack) writable in userspace. So to trigger the appropriate behavior
> +	 * by setting FAULT_FLAG_WRITE for shadow stack accesses, even if the
> +	 * access was a shadow stack read.
> +	 */

Clear as mud... So SS pages are 'Write=0,Dirty=1', which, per
construction, lack a RW bit. And these pages are writable (WRUSS).

pte_wrprotect() seems to do: _PAGE_DIRTY->_PAGE_COW (which is really
weird in this situation), resulting in: 'Write=0,Dirty=0,Cow=1'.

That's regular RO memory and won't raise read-faults.

But I'm thinking RET will trip #PF here when it tries to read the SS
because the SSP is not a proper shadow stack page?

And in that case you want to tickle pte_mkwrite() to undo the
pte_wrprotect() above?

So while the #PF is a 'read' fault due to RET not actually writing to
the shadow stack, you want to force a write fault so it will re-instate
the SS page.

Did I get that right?

> +	if (error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_WRITE)
>  		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_INSTR)
> -- 
> 2.17.1
> 
