Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B269C279
	for <lists+linux-arch@lfdr.de>; Sun, 19 Feb 2023 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBSUpD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Feb 2023 15:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjBSUpC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Feb 2023 15:45:02 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F4B14492
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:45:01 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a19so680548pfv.11
        for <linux-arch@vger.kernel.org>; Sun, 19 Feb 2023 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ivbvfQbVG34mV5fGNdTXCKeRtWO6+zGGPz2rG7C0C6w=;
        b=a0WqQeTkbEtGlN+AAh0UBcplRe3Mq1/PhtZRmrjopxv2t4we9NJa16H9gVO5Nt9zq6
         M+hSLcbgLF7KlsCjphoqcVh36Tytu3ViR0yC0vU2D0roilgekeIRwZ59kfbQjm4Cycxv
         NoW3HvSF0n4nuAnCmwMOZZCBMBfln0uOi6eYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivbvfQbVG34mV5fGNdTXCKeRtWO6+zGGPz2rG7C0C6w=;
        b=UV0fMT+KtsqtYXaiGpzg1qTKxtDw137iMHTekWfTtdQw28CjTsKYOvDUCpPLiTiiyo
         +cEgP3B/9Uez9RcBPvxGnAGUXN/Es3FqfHq147lgERjEEFmIyc5bta4ltg8Gqv7s4bAg
         m6esY3fBOn3vjh2PcnauJOCsvO/uqFng110xWcjGvD+afsuWAEeLXG1oMBdbprQqum5x
         noc2x+2G5ZIkwLXs1Q6jXQZ6me+ozMj+ruFvQDb/ey4PanhQOJMJzWgFICG1jv2Q43TK
         gjAMKRegboCnPQBtaCtCbzUnJZSpyczEUfslVF7XCRTRUK7+i6OVhktEDhGlzV78/cBR
         9kgg==
X-Gm-Message-State: AO0yUKXnZovsgpFyR4YnmHg81MCmorc38R0zcyI/8gFr1Yo337wdJeIj
        VmmRUj4N5jpX8MB1vlue0DPp1Q==
X-Google-Smtp-Source: AK7set/IGqCk6VROgNeNmOOU78n8oFKLxXKiLNswklcmwgoePRvTjTd1R1Aqt+oSmIUX0KDigV58WQ==
X-Received: by 2002:aa7:8429:0:b0:5a8:ae97:2273 with SMTP id q9-20020aa78429000000b005a8ae972273mr1008006pfn.25.1676839500996;
        Sun, 19 Feb 2023 12:45:00 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n11-20020a62e50b000000b00586fbbdf6e4sm6246179pff.34.2023.02.19.12.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 12:45:00 -0800 (PST)
Message-ID: <63f28a4c.620a0220.cf190.b2fa@mx.google.com>
X-Google-Original-Message-ID: <202302191244.@keescook>
Date:   Sun, 19 Feb 2023 12:45:00 -0800
From:   Kees Cook <keescook@chromium.org>
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
        david@redhat.com, debug@rivosinc.com
Subject: Re: [PATCH v6 27/41] x86/mm: Warn if create Write=0,Dirty=1 with raw
 prot
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-28-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-28-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:19PM -0800, Rick Edgecombe wrote:
> When user shadow stack is use, Write=0,Dirty=1 is treated by the CPU as
> shadow stack memory. So for shadow stack memory this bit combination is
> valid, but when Dirty=1,Write=1 (conventionally writable) memory is being
> write protected, the kernel has been taught to transition the Dirty=1
> bit to SavedDirty=1, to avoid inadvertently creating shadow stack
> memory. It does this inside pte_wrprotect() because it knows the PTE is
> not intended to be a writable shadow stack entry, it is supposed to be
> write protected.
> 
> However, when a PTE is created by a raw prot using mk_pte(), mk_pte()
> can't know whether to adjust Dirty=1 to SavedDirty=1. It can't
> distinguish between the caller intending to create a shadow stack PTE or
> needing the SavedDirty shift.
> 
> The kernel has been updated to not do this, and so Write=0,Dirty=1
> memory should only be created by the pte_mkfoo() helpers. Add a warning
> to make sure no new mk_pte() start doing this.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v6:
>  - New patch (Note, this has already been a useful warning, it caught the
>    newly added set_memory_rox() doing this)
> ---
>  arch/x86/include/asm/pgtable.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index f3dc16fc4389..db8fe5511c74 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1032,7 +1032,15 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>   * (Currently stuck as a macro because of indirect forward reference
>   * to linux/mm.h:page_to_nid())
>   */
> -#define mk_pte(page, pgprot)   pfn_pte(page_to_pfn(page), (pgprot))
> +#define mk_pte(page, pgprot)						 \
> +({									 \
> +	pgprot_t __pgprot = pgprot;					 \
> +									 \
> +	WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_USER_SHSTK) &&	 \
> +		    (pgprot_val(__pgprot) & (_PAGE_DIRTY | _PAGE_RW)) == \
> +		    _PAGE_DIRTY);					 \
> +	pfn_pte(page_to_pfn(page), __pgprot);				 \
> +})

This only warns? Should it also enforce the state?

-- 
Kees Cook
