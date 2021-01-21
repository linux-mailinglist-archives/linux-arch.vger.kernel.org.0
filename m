Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524D92FF393
	for <lists+linux-arch@lfdr.de>; Thu, 21 Jan 2021 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbhAUSvN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jan 2021 13:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUSoy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2021 13:44:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD2C0613D6;
        Thu, 21 Jan 2021 10:44:13 -0800 (PST)
Received: from zn.tnic (p200300ec2f1575000bca919cfb20ab7c.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7500:bca:919c:fb20:ab7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5826E1EC01E0;
        Thu, 21 Jan 2021 19:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611254650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FD6FQ6tukOCLwD6fNln6IY5OGb/JtEuN8OVZbhIeo5o=;
        b=C+ixRZOWUtm8yEAwwAKy0C/ygFqQvTETyMjJ0OwfhMpBAgwFydfj7120JKzkaTwVrFxde/
        Oj8iKaH8j7vf/WYo85cHloFwNwzslaLwe7lW0Nb9cPQ9wdOsllCoE4u9d94EJv6HuV13HT
        arxbhF7qcqokTpmq1wXUDgm9Cf8k2SQ=
Date:   Thu, 21 Jan 2021 19:44:05 +0100
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
Subject: Re: [PATCH v17 08/26] x86/mm: Introduce _PAGE_COW
Message-ID: <20210121184405.GE32060@zn.tnic>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
 <20201229213053.16395-9-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201229213053.16395-9-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 29, 2020 at 01:30:35PM -0800, Yu-cheng Yu wrote:
> @@ -182,6 +182,12 @@ static inline int pud_young(pud_t pud)
>  
>  static inline int pte_write(pte_t pte)
>  {
> +	/*
> +	 * If _PAGE_DIRTY is set, the PTE must either have _PAGE_RW or be
> +	 * a shadow stack PTE, which is logically writable.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY);
>  	return pte_flags(pte) & _PAGE_RW;

        if (cpu_feature_enabled(X86_FEATURE_SHSTK))
                return pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY);
        else
                return pte_flags(pte) & _PAGE_RW;

The else makes it ballanced and easier to read.


> @@ -333,7 +339,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
>  
>  static inline pte_t pte_mkclean(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pte_t pte_mkold(pte_t pte)
> @@ -343,6 +349,16 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PTE (RW=0, Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pte.pte |= (pte.pte & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;

Why the unreadable shifting when you can simply do:

                if (pte.pte & _PAGE_DIRTY)
                        pte.pte |= _PAGE_COW;

?

> @@ -434,16 +469,40 @@ static inline pmd_t pmd_mkold(pmd_t pmd)
>  
>  static inline pmd_t pmd_mkclean(pmd_t pmd)
>  {
> -	return pmd_clear_flags(pmd, _PAGE_DIRTY);
> +	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pmd_t pmd_wrprotect(pmd_t pmd)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PMD (RW=0, Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pmdval_t v = native_pmd_val(pmd);
> +
> +		v |= (v & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;

As above.

> @@ -488,17 +554,35 @@ static inline pud_t pud_mkold(pud_t pud)
>  
>  static inline pud_t pud_mkclean(pud_t pud)
>  {
> -	return pud_clear_flags(pud, _PAGE_DIRTY);
> +	return pud_clear_flags(pud, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pud_t pud_wrprotect(pud_t pud)
>  {
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PUD (RW=0, Dirty=1).  Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pudval_t v = native_pud_val(pud);
> +
> +		v |= (v & _PAGE_DIRTY) >> _PAGE_BIT_DIRTY << _PAGE_BIT_COW;

Ditto.

> @@ -1131,6 +1222,12 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  #define pmd_write pmd_write
>  static inline int pmd_write(pmd_t pmd)
>  {
> +	/*
> +	 * If _PAGE_DIRTY is set, then the PMD must either have _PAGE_RW or
> +	 * be a shadow stack PMD, which is logically writable.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pmd_flags(pmd) & (_PAGE_RW | _PAGE_DIRTY);

	else


>  	return pmd_flags(pmd) & _PAGE_RW;
>  }
>  
-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
