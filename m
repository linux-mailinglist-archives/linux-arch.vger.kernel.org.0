Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242975F3385
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 18:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJCQ00 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 12:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJCQ0Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 12:26:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924BE2B273;
        Mon,  3 Oct 2022 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664814384; x=1696350384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swCjk5aBIHIQCZtdbrAcSo1PiTWyf4fjhzdNzOBH0No=;
  b=lmD8sN0vbmswqfIABJMzSHRnctgnGbgtJLNX3L9QtBpj9zGCh39F4NBP
   O/vGQmeVnimHD6fHYlohM/B+28BVYFP09PwdXn7WQgmE4rX5KQR+29hYM
   7lF5YYuWZoAFSQXw4DKQD+Z+Z4y8MLytKUU/OsUxizw+0xy2KZQuYYhgr
   4ShBS1oa8sIpBr2XEm9rWqT8ybB+Qh8F/4DVCVN7MDnyo8pmPQQywhu73
   hcB72BQbVDOVm3/B2vGV0X2EEwmSe3l+3tqzaFR6md3UCuedq0EgSqIwE
   9xgw3CfM0bRlAecDkBuDY6CGNwnu1Y4T7cqk/MJkvnYSe0D/I1iZgzvpX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301403590"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="301403590"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:26:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="692126892"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="692126892"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 09:26:16 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C4D61104CE4; Mon,  3 Oct 2022 19:26:13 +0300 (+03)
Date:   Mon, 3 Oct 2022 19:26:13 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <20221003162613.2yvhvb6hmnae2awz@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:07PM -0700, Rick Edgecombe wrote:
> +/*
> + * Normally the Dirty bit is used to denote COW memory on x86. But
> + * in the case of X86_FEATURE_SHSTK, the software COW bit is used,
> + * since the Dirty=1,Write=0 will result in the memory being treated
> + * as shaodw stack by the HW. So when creating COW memory, a software
> + * bit is used _PAGE_BIT_COW. The following functions pte_mkcow() and
> + * pte_clear_cow() take a PTE marked conventially COW (Dirty=1) and
> + * transition it to the shadow stack compatible version of COW (Cow=1).
> + */
> +
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
> +	/*
> +	 * _PAGE_COW is unnecessary on !X86_FEATURE_SHSTK kernels.
> +	 * See the _PAGE_COW definition for more details.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
> +		return pte;
> +
> +	/*
> +	 * PTE is getting copied-on-write, so it will be dirtied
> +	 * if writable, or made shadow stack if shadow stack and
> +	 * being copied on access. Set they dirty bit for both
> +	 * cases.
> +	 */
> +	pte = pte_set_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_COW);
> +}

These X86_FEATURE_SHSTK checks make me uneasy. Maybe use the _PAGE_COW
logic for all machines with 64-bit entries. It will get you much more
coverage and more universal rules.

> +
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>  static inline int pte_uffd_wp(pte_t pte)
>  {
> @@ -319,7 +381,7 @@ static inline pte_t pte_clear_uffd_wp(pte_t pte)
>  
>  static inline pte_t pte_mkclean(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_DIRTY_BITS);
>  }
>  
>  static inline pte_t pte_mkold(pte_t pte)
> @@ -329,7 +391,16 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> -	return pte_clear_flags(pte, _PAGE_RW);
> +	pte = pte_clear_flags(pte, _PAGE_RW);
> +
> +	/*
> +	 * Blindly clearing _PAGE_RW might accidentally create
> +	 * a shadow stack PTE (Write=0,Dirty=1). Move the hardware
> +	 * dirty value to the software bit.
> +	 */
> +	if (pte_dirty(pte))
> +		pte = pte_mkcow(pte);
> +	return pte;
>  }

Hm. What about ptep/pmdp_set_wrprotect()? They clear _PAGE_RW blindly.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
