Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE04AFF19
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 22:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiBIVQ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 16:16:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiBIVQz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 16:16:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7FBC0DE7F8;
        Wed,  9 Feb 2022 13:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644441418; x=1675977418;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=aXGhdB7/S/Sfe6z0D5nuv8iSXKIxW6oQrnd4HjbGcpI=;
  b=MkV2o6ffagkn8+j7qQfTAcU1RIrMB6PMn6ZLsgM5zCEOEDlIgk8LmE/M
   xyP4bpHsdYx+o/7aKS8DvdV1vckhScr4FvZzueqmKPyyJX6hGyb6ZJMeh
   AP0ZfxSzP6b8h+VElyb++GaF4EbGpRV3KJRGUShRTMtPvUkgc/W3A/L8B
   R3VWD61HDGqbBzEC3NXptjHbMYcDRrld2WBJeQqsqnAyS5A1r43W4BO1f
   xy5t5tPqgJmcRrutbNqpreoghiMYO5VfxjKdtSBazcbxga5QfhW0KKsmj
   aarb5lKmjbZQi7gGjIs8hqiJCb1vc+n3G2gmgbLgIgCkpQZl8r5CygfIg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249284114"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249284114"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 13:16:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="585721023"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 13:16:52 -0800
Message-ID: <c6b03c7d-14ee-9ffa-19e6-ee78cf186e38@intel.com>
Date:   Wed, 9 Feb 2022 13:16:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
 <20220130211838.8382-17-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 16/35] x86/mm: Update maybe_mkwrite() for shadow stack
In-Reply-To: <20220130211838.8382-17-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

First of all, that changelog doesn't really explain the problem.  It's
all background and no "why".

*Why* does maybe_mkwrite() take a VMA?  What's the point?


>  #endif /* _ASM_X86_PGTABLE_H */
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3481b35cb4ec..c22c8e9c37e8 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -610,6 +610,26 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_WRITE)
> +		pte = pte_mkwrite(pte);
> +	else if (vma->vm_flags & VM_SHADOW_STACK)
> +		pte = pte_mkwrite_shstk(pte);
> +	return pte;
> +}

First, this makes me wonder why we need pte_mkwrite() *AND*
pte_mkwrite_shstk().  Is there a difference in their behavior that matters?

Second, I don't like the copy-and-paste to make an arch-specific "hook"
for a function.  This is a very good way to ensure that arch code and
generic code fork and accumulate separate bugs.

I'd much rather have this do (in generic code):

 pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
 {
	if (vma->vm_flags & VM_WRITE)
		pte = pte_mkwrite(pte);

	pte = arch_maybe_mkwrite(pte, vma);

	return pte;
+}

Actually, is there a reason the generic code could not even just add:

	if (vma->vm_flags & VM_ARCH_MAYBE_MKWRITE_MASK)
		pte = arch_maybe_mkwrite(pte, vma);

or heck even just the x86-specific code itself:

	if (vma->vm_flags & VM_SHADOW_STACK)
		pte = pte_mkwrite_shstk(pte);

with a stub defined for pte_mkwrite_shstk()?

In the end, it's just a question of whether the generic code wants
something to say "arch" or "shstk".  But, I don't think we need a forked
x86 copy of these functions.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 311c6018d503..b3cb3a17037b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -955,12 +955,14 @@ void free_compound_page(struct page *page);
>   * pte_mkwrite.  But get_user_pages can cause write faults for mappings
>   * that do not have writing enabled, when used by access_process_vm.
>   */
> +#ifndef maybe_mkwrite

maybe_mkwrite is defined in asm/pgtable.h.  Where is the #include?

>  static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>  {
>  	if (likely(vma->vm_flags & VM_WRITE))
>  		pte = pte_mkwrite(pte);
>  	return pte;
>  }
> +#endif
>  
>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
>  void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 406a3c28c026..2adedcfca00b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -491,12 +491,14 @@ static int __init setup_transparent_hugepage(char *str)
>  }
>  __setup("transparent_hugepage=", setup_transparent_hugepage);
>  
> +#ifndef maybe_pmd_mkwrite
>  pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  {
>  	if (likely(vma->vm_flags & VM_WRITE))
>  		pmd = pmd_mkwrite(pmd);
>  	return pmd;
>  }
> +#endif
>  
>  #ifdef CONFIG_MEMCG
>  static inline struct deferred_split *get_deferred_split_queue(struct page *page)

