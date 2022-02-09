Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12194AF8DF
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiBISAd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 13:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiBISAc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 13:00:32 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E6C0613C9;
        Wed,  9 Feb 2022 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644429635; x=1675965635;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=zo/OsIOkajIY3h3Rm1bLta5Xyt2Nd1Fi9wy9oJvB0kA=;
  b=Hkz76RubyrY1sKA2z1oO1q38qGmnEnpwkpkjnuwJd7vJCXRMb45AGnth
   Nop/5OaHB81vCCSDsu7JWOW/geyYdxe9QvtfVsrz9JgeypSQVqE3EfIw/
   XYSTWhR/wGtAyJGK7ogxL7TtAotFk83rJnPJV54RUA3M0nxQHIiMRJDLl
   shLGEJBsItERrDSEB8N0X7sUY+DyPUWqFn+l8w81VQz6dLnR5FWjUDFzB
   CFWNyPck/eFXPpLBysq0YwpZ2PbHdIiA8uVN6AlXlKm9sY+RqRqynZrT2
   kDJuVC0VtV4P02Bw5wj6oYT40ScUR6RXGFzFBSY3enQ7svgHcTUrHcI+k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="335693226"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="335693226"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:00:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485347306"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:00:33 -0800
Message-ID: <95299e90-245b-61c5-8ef0-5e6da3c37c5e@intel.com>
Date:   Wed, 9 Feb 2022 10:00:30 -0800
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
 <20220130211838.8382-12-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 11/35] x86/mm: Update pte_modify for _PAGE_COW
In-Reply-To: <20220130211838.8382-12-rick.p.edgecombe@intel.com>
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

On 1/30/22 13:18, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The read-only and Dirty PTE has been used to indicate copy-on-write pages.

Nit: This is another opportunity to use consistent terminology
     for these Write=0,Dirty=1 PTEs.

> However, newer x86 processors also regard a read-only and Dirty PTE as a
> shadow stack page.  In order to separate the two, the software-defined
> _PAGE_COW is created to replace _PAGE_DIRTY for the copy-on-write case, and
> pte_*() are updated.

The tense here is weird.  "_PAGE_COW is created" is present tense, but
it refers to something that happened earlier in the series.

> Pte_modify() changes a PTE to 'newprot', but it doesn't use the pte_*().

I'm not seeing a clear problem statement in there.  It looks something
like this to me:

	pte_modify() takes a "raw" pgprot_t which was not necessarily
	created with any of the existing PTE bit helpers.  That means
	that it can return a pte_t with Write=0,Dirty=1: a shadow stack
	PTE when it did not intend to create one.

But, this kinda looks like a hack to me.

It all boils down to _PAGE_CHG_MASK.  If pte_modify() can change the
bit's value, it is not included in _PAGE_CHG_MASK.  But, pte_modify()
*CAN* change the _PAGE_DIRTY value now.

Another way of saying it is that _PAGE_DIRTY is now a permission bit
(part-time, at least).


> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index a4a75e78a934..5c3886f6ccda 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -773,6 +773,23 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>  
>  static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
>  
> +static inline pteval_t fixup_dirty_pte(pteval_t pteval)
> +{
> +	pte_t pte = __pte(pteval);
> +
> +	/*
> +	 * Fix up potential shadow stack page flags because the RO, Dirty
> +	 * PTE is special.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		if (pte_dirty(pte)) {
> +			pte = pte_mkclean(pte);
> +			pte = pte_mkdirty(pte);
> +		}
> +	}
> +	return pte_val(pte);
> +}
> +
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  {
>  	pteval_t val = pte_val(pte), oldval = val;
> @@ -783,16 +800,36 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	 */
>  	val &= _PAGE_CHG_MASK;
>  	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
> +	val = fixup_dirty_pte(val);
>  	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
>  	return __pte(val);
>  }

Maybe something like this?  We can take _PAGE_DIRTY out of
_PAGE_CHG_MASK, then the p*_modify() functions look like this:

static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
{
        pteval_t val = pte_val(pte), oldval = val;
+	pte_t pte_result;

        /* Chop off any bits that might change with 'newprot':  */
        val &= _PAGE_CHG_MASK;
        val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
        val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);

+       pte_result = __pte(val);
+
+	if (pte_dirty(oldval))
+		pte_result = pte_mkdirty(pte_result));
+	
+	return pte_result;
}


This:

1. Makes logical sense: the dirty bit *IS* special in that it has to be
   logically preserved across permission changes.
2. Would work with or without shadow stacks.  That exact code would even
   work on a non-shadow-stack kernel
3. Doesn't introduce *any* new shadow-stack conditional code; the one
   already hidden in pte_mkdirty() is sufficient.
4. Avoids silly things like setting a bit and then immediately clearing
   it in a "fixup".
5. Removes the opaque "fixup" abstraction function.

That's way better if I do say so myself.
