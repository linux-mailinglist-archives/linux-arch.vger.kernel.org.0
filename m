Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6186F3282D7
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 16:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhCAPxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Mar 2021 10:53:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44432 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237394AbhCAPx3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Mar 2021 10:53:29 -0500
Received: from zn.tnic (p200300ec2f03de000c49bde6bf5f8ea0.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:de00:c49:bde6:bf5f:8ea0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89E871EC0105;
        Mon,  1 Mar 2021 16:52:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614613963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a4oJdFpxQg9VwC++9PZ/n66EH9Uyg5uXgGcU17/8q6g=;
        b=P2oo+rDN9qTQYwJH3/qzEiUUhEZuT5Y2oGLpKajp7d9lOdwBvDV86OTX1BSAcVyL/bZ1Jb
        z4xpMqdSczHw4fudawj7lpdSOAH1N9atj52HxDhaTyftc+XA2ELNMoXMa8aCjo0PWqBeO4
        N6kITEOCjeOLapteI23oeWqaRg1tXXM=
Date:   Mon, 1 Mar 2021 16:52:34 +0100
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v21 08/26] x86/mm: Introduce _PAGE_COW
Message-ID: <20210301155234.GF6699@zn.tnic>
References: <20210217222730.15819-1-yu-cheng.yu@intel.com>
 <20210217222730.15819-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217222730.15819-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 17, 2021 at 02:27:12PM -0800, Yu-cheng Yu wrote:
> @@ -182,7 +206,7 @@ static inline int pud_young(pud_t pud)
>  
>  static inline int pte_write(pte_t pte)
>  {
> -	return pte_flags(pte) & _PAGE_RW;

Put here a comment along the lines of:

	/*
	 * Shadow stack pages are always writable - but not by normal
	 * instructions but only by shadow stack operations. Therefore, the
	 * W=0, D=1 test.
	 */

to make it clear what this means.

> +	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
>  }
>  
>  static inline int pte_huge(pte_t pte)
> @@ -314,6 +338,24 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>  	return native_make_pte(v & ~clear);
>  }
>  
> +static inline pte_t pte_make_cow(pte_t pte)

pte_mkcow like the rest of the "pte_mkX" functions.

And below too, for the other newly added pXd_make_* helpers.


>  static inline pmd_t pmd_mkdirty(pmd_t pmd)
>  {
> -	return pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> +	pmdval_t dirty = _PAGE_DIRTY;
> +
> +	/* Avoid creating (HW)Dirty=1, Write=0 PMDs */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pmd_flags(pmd) & _PAGE_RW))

						      !(pmd_write(pmd))

> +		dirty = _PAGE_COW;
> +
> +	return pmd_set_flags(pmd, dirty | _PAGE_SOFT_DIRTY);
> +}

...

>  static inline pud_t pud_mkdirty(pud_t pud)
>  {
> -	return pud_set_flags(pud, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
> +	pudval_t dirty = _PAGE_DIRTY;
> +
> +	/* Avoid creating (HW)Dirty=1, Write=0 PUDs */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK) && !(pud_flags(pud) & _PAGE_RW))

						      !(pud_write(pud))


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
