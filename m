Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D14ACDE3
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 02:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbiBHBJs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 20:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbiBHBH5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 20:07:57 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649BDC03FEC1;
        Mon,  7 Feb 2022 17:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644282356; x=1675818356;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=RmcEBt/Tc2ZNpDmtkpC+8Teoj0FX4XdvKx/tePya/LE=;
  b=YLpuo49U9T6Ttv5z0xswjk4u7YO65Spj6T72/14AXFJOV96rsF8h4OOq
   r1C2V9NBZe7L0KmxMZXISIhXwz88ob1Pz32j9gWVswLrP7FqvpaLl5AE5
   ws/t9L10lUV8MMj1N1NnwcIxiNHkoF8oAFvbsNtugzAXlhbUv3BOcs1m6
   6enJYR5citXhk4B77AOG9hm6/uV+436wO9YVDxlyagVfYmNb8tj+izWxC
   y/w/ho/7SmQKOPzJFA8kW26aMUywsTtZBShR6z2SeDdQCXhGq5QwdpJnm
   sJx2tOhRN4CapO+FdQw8LGHZey+F1Q717MzQrndiZJNHYnlacp8CqrGkp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249053192"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="249053192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:05:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="525348020"
Received: from hgrunes-mobl1.amr.corp.intel.com (HELO [10.251.3.57]) ([10.251.3.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:05:53 -0800
Message-ID: <9b6878b0-433e-b52a-caa1-aa306595c51a@intel.com>
Date:   Mon, 7 Feb 2022 17:05:50 -0800
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
 <20220130211838.8382-10-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 09/35] x86/mm: Introduce _PAGE_COW
In-Reply-To: <20220130211838.8382-10-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 1/30/22 13:18, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> There is essentially no room left in the x86 hardware PTEs on some OSes
> (not Linux).  That left the hardware architects looking for a way to
> represent a new memory type (shadow stack) within the existing bits.
> They chose to repurpose a lightly-used state: Write=0, Dirty=1.
> 
> The reason it's lightly used is that Dirty=1 is normally set by hardware
> and cannot normally be set by hardware on a Write=0 PTE.  Software must
> normally be involved to create one of these PTEs, so software can simply
> opt to not create them.

This is kinda skipping over something important:

	The reason it's lightly used is that Dirty=1 is normally set
	_before_ a write.  A write with a Write=0 PTE would typically
	only generate a fault, not set Dirty=1.  Hardware can (rarely)
	both set Write=1 *and* generate the fault, resulting in a
	Dirty=0,Write=1 PTE.  Hardware which supports shadow stacks
	will no longer exhibit this oddity.

> In places where Linux normally creates Write=0, Dirty=1, it can use the
> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY.  In other
> words, whenever Linux needs to create Write=0, Dirty=1, it instead creates
> Write=0, Cow=1, except for shadow stack, which is Write=0, Dirty=1.  This
> clearly separates shadow stack from other data, and results in the
> following:

Following _what_...  What are these?  I think they're PTE states.  Best
to say that.

> (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)

Could you give an example of this?  Would this be a typical anonymous
page which was Write=1,Dirty=1, then historically made Write=0,Dirty=1
at fork()?

> (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
>     The user page is in a R/O VMA, and get_user_pages() needs a writable
>     copy.  The page fault handler creates a copy of the page and sets
>     the new copy's PTE as Write=0 and Cow=1.
> (c) A shadow stack PTE: (Write=0, Dirty=1)
> (d) A shared shadow stack PTE: (Write=0, Cow=1)
>     When a shadow stack page is being shared among processes (this happens
>     at fork()), its PTE is made Dirty=0, so the next shadow stack access
>     causes a fault, and the page is duplicated and Dirty=1 is set again.
>     This is the COW equivalent for shadow stack pages, even though it's
>     copy-on-access rather than copy-on-write.

Just like code, it's also nice to format these in a way which allows
them to be visually compared, trivially.  So, let's expand all the bits
and vertically align everything.  To break this down a bit, we have two
old states:

[a] (Write=0, Dirty=0, Cow=1)
[b] (Write=0, Dirty=0, Cow=1)

And two new ones:

[c] (Write=0, Dirty=1, Cow=0)
[d] (Write=0, Dirty=0, Cow=1)

That makes me wonder what the difference is between [a] and [b] and why
they are separate.  Is their handling different?  How are those two
states differentiated?

> (e) A page where the processor observed a Write=1 PTE, started a write, set
>     Dirty=1, but then observed a Write=0 PTE.  That's possible today, but
>     will not happen on processors that support shadow stack.

This left me wondering how you are going to detangle the mess where PTEs
look like shadow-stack PTEs on non-shadow-stack hardware.  Could you
cover that here?

You can shorten that above bullet to this to help make the space:

	(e) (Write=0, Dirty=1, Cow=0) PTE created when a processor
	    without shadow stack support set Dirty=1.


> Define _PAGE_COW and update pte_*() helpers and apply the same changes to
> pmd and pud.
> 
> After this, there are six free bits left in the 64-bit PTE, and no more
> free bits in the 32-bit PTE (except for PAE) and Shadow Stack is not
> implemented for the 32-bit kernel.

Just say:

	There are six bits left available to software in the 64-bit PTE
	after consuming a bit for _PAGE_COW.  No space is consumed in
	32-bit kernels because shadow stacks are not enabled there.

There's no need to rub it in that 32-bit is out of space.

> -static inline int pte_dirty(pte_t pte)
> +static inline bool pte_dirty(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_DIRTY;
> +	/*
> +	 * A dirty PTE has Dirty=1 or Cow=1.
> +	 */

I don't really like that comment because "Cow" isn't anywhere to be found.

> +	return pte_flags(pte) & _PAGE_DIRTY_BITS;
> +}
> +
> +static inline bool pte_shstk(pte_t pte)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return false;
> +
> +	return (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
>  }
>  
>  static inline int pte_young(pte_t pte)
> @@ -133,9 +144,20 @@ static inline int pte_young(pte_t pte)
>  	return pte_flags(pte) & _PAGE_ACCESSED;
>  }
>  
> -static inline int pmd_dirty(pmd_t pmd)
> +static inline bool pmd_dirty(pmd_t pmd)
>  {
> -	return pmd_flags(pmd) & _PAGE_DIRTY;
> +	/*
> +	 * A dirty PMD has Dirty=1 or Cow=1.
> +	 */
> +	return pmd_flags(pmd) & _PAGE_DIRTY_BITS;
> +}
> +
> +static inline bool pmd_shstk(pmd_t pmd)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return false;
> +
> +	return (pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
>  }
>  
>  static inline int pmd_young(pmd_t pmd)
> @@ -143,9 +165,12 @@ static inline int pmd_young(pmd_t pmd)
>  	return pmd_flags(pmd) & _PAGE_ACCESSED;
>  }
>  
> -static inline int pud_dirty(pud_t pud)
> +static inline bool pud_dirty(pud_t pud)
>  {
> -	return pud_flags(pud) & _PAGE_DIRTY;
> +	/*
> +	 * A dirty PUD has Dirty=1 or Cow=1.
> +	 */
> +	return pud_flags(pud) & _PAGE_DIRTY_BITS;
>  }
>  
>  static inline int pud_young(pud_t pud)
> @@ -155,13 +180,23 @@ static inline int pud_young(pud_t pud)
>  
>  static inline int pte_write(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_RW;
> +	/*
> +	 * Shadow stack pages are always writable - but not by normal
> +	 * instructions, and only by shadow stack operations.  Therefore,
> +	 * the W=0,D=1 test with pte_shstk().
> +	 */

I think that comment is off a bit.  It's not really connected to the
code.  We don't, for instance need to know what the bit combination is
inside pte_shstk().  Further, it's a bit mean to talk about "W" in the
comment and _PAGE_RW in the code.  How about:

	/*
	 * Shadow stack pages are logically writable, but do not have
	 * _PAGE_RW.  Check for them separately from _PAGE_RW itself.
	 */

> +	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
>  }
>  
>  #define pmd_write pmd_write
>  static inline int pmd_write(pmd_t pmd)
>  {
> -	return pmd_flags(pmd) & _PAGE_RW;
> +	/*
> +	 * Shadow stack pages are always writable - but not by normal
> +	 * instructions, and only by shadow stack operations.  Therefore,
> +	 * the W=0,D=1 test with pmd_shstk().
> +	 */
> +	return (pmd_flags(pmd) & _PAGE_RW) || pmd_shstk(pmd);
>  }

Ditto on the comment.  Please copy the pte_write() one here too.

>  
>  #define pud_write pud_write
> @@ -299,6 +334,24 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>  	return native_make_pte(v & ~clear);
>  }
>  
> +static inline pte_t pte_mkcow(pte_t pte)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pte;
> +
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_set_flags(pte, _PAGE_COW);
> +}
> +
> +static inline pte_t pte_clear_cow(pte_t pte)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pte;
> +
> +	pte = pte_set_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_COW);
> +}

I think we need to say *SOMETHING* about the X86_FEATURE_SHSTK and
_PAGE_COW connection here.  Otherwise they look like two random features
that are interacting in an unknown way.

Maybe even something this simple:

/*
 * _PAGE_COW is unnecessary on !X86_FEATURE_SHSTK kernels.
 * See the _PAGE_COW definition for more details.
 */

Also, the manipulation of _PAGE_DIRTY is not clear here.  It's obvious
why we have to:

	pte_clear_flags(pte, _PAGE_COW);

in a function called pte_clear_cow() but, again, how does _PAGE_DIRTY fit?

>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  static inline int pte_uffd_wp(pte_t pte)
>  {
> @@ -318,7 +371,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
>  
>  static inline pte_t pte_mkclean(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pte_t pte_mkold(pte_t pte)
> @@ -328,7 +381,16 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_RW);
> +	pte = pte_clear_flags(pte, _PAGE_RW);
> +
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware

Could you grep this series and try to be consistent about the formatting
here?  (Not that I've been perfect in this regard either).  I think we
have at least:

	Write=X,Dirty=Y
	W=X,D=Y
	RW=X,Dirty=Y

> +	 * dirty value to the software bit.
> +	 */
> +	if (pte_dirty(pte))
> +		pte = pte_mkcow(pte);
> +	return pte;
>  }

One of my logical checks for this is "does it all go away when this is
compiled out".  Because of this:

+static inline pte_t pte_mkcow(pte_t pte)
+{
+       if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+               return pte;
...

the answer is yes!  So, this looks good to me.  Just thought I'd share a
bit of my thought process.

>  static inline pte_t pte_mkexec(pte_t pte)
> @@ -338,7 +400,18 @@ static inline pte_t pte_mkexec(pte_t pte)
>  
>  static inline pte_t pte_mkdirty(pte_t pte)
>  {
> -	return pte_set_flags(pte, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> +	pteval_t dirty = _PAGE_DIRTY;
> +
> +	/* Avoid creating (HW)Dirty=1, Write=0 PTEs */

The "(HW)" thing doesn't make a lot of sense any longer.  I think we had
a set of HWDirty and SWDirty bits, but SWDirty ended up being morphed
over to _PAGE_COW.

> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !pte_write(pte))
> +		dirty = _PAGE_COW;
> +
> +	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
> +}
> +
> +static inline pte_t pte_mkwrite_shstk(pte_t pte)
> +{
> +	return pte_clear_cow(pte);
>  }

This one is a bit of black magic.  This is taking a PTE from
(presumably) states [c]->[d] from earlier in the changelog.

	Write=0,Dirty=0,Cow=1
to
	Write=0,Dirty=1,Cow=0

It's hard to wrap my head around how clearing a software bit (from the
naming) will make this PTE writable.

There's either something wrong with the naming, or something wrong with
my mental model of what "COW clearing" is.

>  static inline pte_t pte_mkyoung(pte_t pte)
> @@ -348,7 +421,12 @@ static inline pte_t pte_mkyoung(pte_t pte)
>  
>  static inline pte_t pte_mkwrite(pte_t pte)
>  {
> -	return pte_set_flags(pte, _PAGE_RW);
> +	pte = pte_set_flags(pte, _PAGE_RW);
> +
> +	if (pte_dirty(pte))
> +		pte = pte_clear_cow(pte);
> +
> +	return pte;
>  }

Along the same lines as the last few comments, this leaves me wondering
why a pte_dirty() can't also be a "COW PTE".

... <snipping the pmd/pud copies> ...
>  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 3781a79b6388..1bfab70ff9ac 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -21,7 +21,8 @@
>  #define _PAGE_BIT_SOFTW2	10	/* " */
>  #define _PAGE_BIT_SOFTW3	11	/* " */
>  #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>  #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>  #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>  #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> @@ -34,6 +35,15 @@
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
> +/*
> + * Indicates a copy-on-write page.
> + */
> +#ifdef CONFIG_X86_SHADOW_STACK
> +#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
> +#else
> +#define _PAGE_BIT_COW		0
> +#endif
> +
>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
>  /* - if the user mapped it with PROT_NONE; pte_present gives true */
>  #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
> @@ -115,6 +125,36 @@
>  #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
>  #endif
>  
> +/*
> + * The hardware requires shadow stack to be read-only and Dirty.
> + * _PAGE_COW is a software-only bit used to separate copy-on-write PTEs
> + * from shadow stack PTEs:
> + * (a) A modified, copy-on-write (COW) page: (Write=0, Cow=1)
> + * (b) A R/O page that has been COW'ed: (Write=0, Cow=1)
> + *     The user page is in a R/O VMA, and get_user_pages() needs a
> + *     writable copy.  The page fault handler creates a copy of the page
> + *     and sets the new copy's PTE as Write=0, Cow=1.
> + * (c) A shadow stack PTE: (Write=0, Dirty=1)
> + * (d) A shared (copy-on-access) shadow stack PTE: (Write=0, Cow=1)
> + *     When a shadow stack page is being shared among processes (this
> + *     happens at fork()), its PTE is cleared of _PAGE_DIRTY, so the next
> + *     shadow stack access causes a fault, and the page is duplicated and
> + *     _PAGE_DIRTY is set again.  This is the COW equivalent for shadow
> + *     stack pages, even though it's copy-on-access rather than
> + *     copy-on-write.
> + * (e) A page where the processor observed a Write=1 PTE, started a write,
> + *     set Dirty=1, but then observed a Write=0 PTE (changed by another
> + *     thread).  That's possible today, but will not happen on processors
> + *     that support shadow stack.

This info, again, is great.  Let's keep it, but please do reformat it
like the changelog version to make the bit states easier to grok.
