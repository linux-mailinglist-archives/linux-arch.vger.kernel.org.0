Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797BA2D317A
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgLHRvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 12:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHRvD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 12:51:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A3C061749;
        Tue,  8 Dec 2020 09:50:22 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f0800de0994b63dbef0e2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:800:de09:94b6:3dbe:f0e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EA5661EC053C;
        Tue,  8 Dec 2020 18:50:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607449820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Wll8a/0W46BCEqmGk8dxucjixTUIbOAnwRfJKIjdQCc=;
        b=XaFS6azD6t5Xr9XLknktT4H2gC2aKHD100ijn2oQAJPTqPsYb68kxYhjhUTn6bste02pBy
        v6XpqQK7/HJVLGnAlcfsLC4eIBw2MPYnBz5Sr4KTYV27ZIYues1CiD0CFpBO9LwdogTO1c
        YBw3l/PmIywECt9wztleEqpoBpFzKVE=
Date:   Tue, 8 Dec 2020 18:50:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v15 08/26] x86/mm: Introduce _PAGE_COW
Message-ID: <20201208175014.GD27920@zn.tnic>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
 <20201110162211.9207-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110162211.9207-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 08:21:53AM -0800, Yu-cheng Yu wrote:
> There is essentially no room left in the x86 hardware PTEs on some OSes
> (not Linux).  That left the hardware architects looking for a way to
> represent a new memory type (shadow stack) within the existing bits.
> They chose to repurpose a lightly-used state: Write=0,Dirty=1.

It is not clear to me what the definition and semantics of that bit is.

+#define _PAGE_BIT_COW          _PAGE_BIT_SOFTW5 /* copy-on-write */

Is it set by hw or by sw and hw uses it to know it is a shadow stack
page, and so on.

I think you should lead with its definition.

> The reason it's lightly used is that Dirty=1 is normally set by hardware
> and cannot normally be set by hardware on a Write=0 PTE.  Software must
> normally be involved to create one of these PTEs, so software can simply
> opt to not create them.
> 
> But that leaves us with a Linux problem: we need to ensure we never create

Please use passive voice in your commit message: no "we" or "I", etc.

> Write=0,Dirty=1 PTEs.  In places where we do create them, we need to find
> an alternative way to represent them _without_ using the same hardware bit
> combination.  Thus, enter _PAGE_COW.  This results in the following:
> 
> (a) A modified, copy-on-write (COW) page: (R/O + _PAGE_COW)
> (b) A R/O page that has been COW'ed: (R/O + _PAGE_COW)

Both are "R/O + _PAGE_COW". Where's the difference? The dirty bit?

>     The user page is in a R/O VMA, and get_user_pages() needs a writable
>     copy.  The page fault handler creates a copy of the page and sets
>     the new copy's PTE as R/O and _PAGE_COW.
> (c) A shadow stack PTE: (R/O + _PAGE_DIRTY_HW)

So W=0, D=1 ?

> (d) A shared shadow stack PTE: (R/O + _PAGE_COW)
>     When a shadow stack page is being shared among processes (this happens
>     at fork()), its PTE is cleared of _PAGE_DIRTY_HW, so the next shadow
>     stack access causes a fault, and the page is duplicated and
>     _PAGE_DIRTY_HW is set again.  This is the COW equivalent for shadow
>     stack pages, even though it's copy-on-access rather than copy-on-write.
> (e) A page where the processor observed a Write=1 PTE, started a write, set
>     Dirty=1, but then observed a Write=0 PTE.

How does that happen? Something changed the PTE's W bit to 0 in-between?

> That's possible today, but
>     will not happen on processors that support shadow stack.
> 
> Use _PAGE_COW in pte_wrprotect() and _PAGE_DIRTY_HW in pte_mkwrite().
> Apply the same changes to pmd and pud.
> 
> When this patch is applied, there are six free bits left in the 64-bit PTE.

s/When this patch is applied/After this/

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> There are no more free bits in the 32-bit PTE (except for PAE) and shadow
> stack is not implemented for the 32-bit kernel.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/pgtable.h       | 120 ++++++++++++++++++++++++---
>  arch/x86/include/asm/pgtable_types.h |  41 ++++++++-
>  2 files changed, 150 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index b23697658b28..c88c7ccf0318 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -121,9 +121,9 @@ extern pmdval_t early_pmd_flags;
>   * The following only work if pte_present() is true.
>   * Undefined behaviour if not..
>   */
> -static inline int pte_dirty(pte_t pte)
> +static inline bool pte_dirty(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_DIRTY_HW;
> +	return pte_flags(pte) & _PAGE_DIRTY_BITS;

Why?

Does _PAGE_COW mean dirty too?

> @@ -343,6 +349,17 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PTE (RW=0,Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pte.pte |= (pte.pte & _PAGE_DIRTY_HW) >>
> +			   _PAGE_BIT_DIRTY_HW << _PAGE_BIT_COW;

Let that line stick out. And that shifting is not grokkable at a quick
glance, at least not to me. Simplify?

>  static inline pmd_t pmd_wrprotect(pmd_t pmd)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PMD (RW=0,Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.

This whole carefully sidestepping the possiblity of creating a shadow
stack pXd is kinda sucky...

> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 7462a574fc93..5f764d8d9bae 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -23,7 +23,8 @@
>  #define _PAGE_BIT_SOFTW2	10	/* " */
>  #define _PAGE_BIT_SOFTW3	11	/* " */
>  #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>  #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>  #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>  #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> @@ -36,6 +37,16 @@
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
> +/*
> + * This bit indicates a copy-on-write page, and is different from
> + * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
> + */
> +#ifdef CONFIG_X86_64

CONFIG_X86_64 ? Do all x86 machines out there support CET?

If anything, CONFIG_X86_CET...

> +#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
> +#else
> +#define _PAGE_BIT_COW		0
> +#endif
> +
>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
>  /* - if the user mapped it with PROT_NONE; pte_present gives true */
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
