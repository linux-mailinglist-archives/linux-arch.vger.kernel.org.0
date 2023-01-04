Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6053365D5B3
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jan 2023 15:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbjADOc1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Jan 2023 09:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjADOcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Jan 2023 09:32:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4E373B3;
        Wed,  4 Jan 2023 06:32:12 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 978331EC02FE;
        Wed,  4 Jan 2023 15:32:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672842730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mGAc1hvVkdgwx67qTNes4TeLVQF5ZYZruSeDLPAGn0s=;
        b=Xqn4rhA3RQh8ReQBXtLkJ3CyiJPGmS7JH7ngZ6z4RhyyGaedtIU5vIfqqUqEt+qN4f+VeA
        twAtwhN7jpXEV0mQK0MXBLdAmOgBzoF1mCclxLj1W1dKo++TdeWBftWfJvVf3quvS4uX0e
        +c2sc3vVioheJW4dMkIh2G6zpdom/tE=
Date:   Wed, 4 Jan 2023 15:32:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 16/39] x86/mm: Check Shadow Stack page fault errors
Message-ID: <Y7WN5WxENBrhkJXU@zn.tnic>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-17-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:43PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The CPU performs "shadow stack accesses" when it expects to encounter
> shadow stack mappings. These accesses can be implicit (via CALL/RET
> instructions) or explicit (instructions like WRSS).
> 
> Shadow stacks accesses to shadow-stack mappings can see faults in normal,
> valid operation just like regular accesses to regular mappings. Shadow
> stacks need some of the same features like delayed allocation, swap and
> copy-on-write. The kernel needs to use faults to implement those features.
> 
> The architecture has concepts of both shadow stack reads and shadow stack
> writes. Any shadow stack access to non-shadow stack memory will generate
> a fault with the shadow stack error code bit set.

You lost me here: by "shadow stack access to non-shadow stack memory" you mean
the explicit one using WRU*SS?

> This means that, unlike normal write protection, the fault handler needs
> to create a type of memory that can be written to (with instructions that
> generate shadow stack writes), even to fulfill a read access. So in the
> case of COW memory, the COW needs to take place even with a shadow stack
> read.

I guess I'm missing an example here: are we talking here about a user process
getting its shadow stack pages allocated and them being COW first and on the
first shstk operation, it would generate that fault?

> @@ -1331,6 +1345,30 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * When a page becomes COW it changes from a shadow stack permissioned

Unknown word [permissioned] in comment.

> +	 * page (Write=0,Dirty=1) to (Write=0,Dirty=0,CoW=1), which is simply
> +	 * read-only to the CPU. When shadow stack is enabled, a RET would
> +	 * normally pop the shadow stack by reading it with a "shadow stack
> +	 * read" access. However, in the COW case the shadow stack memory does
> +	 * not have shadow stack permissions, it is read-only. So it will
> +	 * generate a fault.
> +	 *
> +	 * For conventionally writable pages, a read can be serviced with a
> +	 * read only PTE, and COW would not have to happen. But for shadow
> +	 * stack, there isn't the concept of read-only shadow stack memory.
> +	 * If it is shadow stack permissioned, it can be modified via CALL and

Ditto.

> +	 * RET instructions. So COW needs to happen before any memory can be
> +	 * mapped with shadow stack permissions.
> +	 *
> +	 * Shadow stack accesses (read or write) need to be serviced with
> +	 * shadow stack permissioned memory, so in the case of a shadow stack

Is this some new formulation I haven't heard about yet?

"Permissioned <something>"?

> +	 * read access, treat it as a WRITE fault so both COW will happen and
> +	 * the write fault path will tickle maybe_mkwrite() and map the memory
> +	 * shadow stack.
> +	 */
> +	if (error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_WRITE)
>  		flags |= FAULT_FLAG_WRITE;
>  	if (error_code & X86_PF_INSTR)
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
