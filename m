Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB65FEC42
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 12:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJNKHt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 06:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJNKHt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 06:07:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D0E10537D;
        Fri, 14 Oct 2022 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L4LcT7d4jLsOBvjwIUOPjvR1C67SbCP8S9zjCTw+b2o=; b=MneAwRNqK978+qReSDZqbf8fim
        UdRSbq7lmjHyTh35JQdV6EthH34ObvMUiYYfpj08BShsMWHF52K0JjuOTlmahD6SHbiKfXPYikKYV
        /rzOQsR970gScpCntYCd7TwW+Y1ek1sy6mnIhepsW2PRKZPYCmg9olf8WL9MHREItELXqwt8xH88+
        sna8Sc1k3lsXdvajEvbeYrzoZPTpaGoPCiPWLnVgG9VKn06Xu/S6aRRczUI0TQa8IU/K99NPKOfOF
        doqNcbA62hoHANW7n2c416I1Ts35IaJB6KhkkkQ+erlEeGR8rwDBQz+wplE1UT4Gf6pWByPcPIEci
        BPFiM9UQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojHaw-003NqY-0V; Fri, 14 Oct 2022 10:07:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C4E830008D;
        Fri, 14 Oct 2022 12:07:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDBD22C164D35; Fri, 14 Oct 2022 12:07:08 +0200 (CEST)
Date:   Fri, 14 Oct 2022 12:07:08 +0200
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 15/39] x86/mm: Check Shadow Stack page fault errors
Message-ID: <Y0k0zJK7biH+EMlO@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-16-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-16-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:12PM -0700, Rick Edgecombe wrote:

> The architecture has concepts of both shadow stack reads and shadow stack
> writes. Any shadow stack access to non-shadow stack memory will generate
> a fault with the shadow stack error code bit set.
> 
> This means that, unlike normal write protection, the fault handler needs
> to create a type of memory that can be written to (with instructions that
> generate shadow stack writes), even to fulfill a read access. So in the
> case of COW memory, the COW needs to take place even with a shadow stack
> read. Otherwise the page will be left (shadow stack) writable in
> userspace. So to trigger the appropriate behavior, set FAULT_FLAG_WRITE
> for shadow stack accesses, even if the access was a shadow stack read.

That ^ should be moved into the comment below

>  - Clarify reasoning for FAULT_FLAG_WRITE for all shadow stack accesses

> @@ -1300,6 +1314,13 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * In order to fullfull a shadow stack access, the page needs
> +	 * to be made (shadow stack) writable. So treat all shadow stack
> +	 * accesses as writes.
> +	 */

Because that's impenetrable.

> +	if (error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_WRITE)
>  		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_INSTR)
> -- 
> 2.17.1
> 
