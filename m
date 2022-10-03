Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CCD5F3530
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJCSDf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJCSDe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:03:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97027FE1;
        Mon,  3 Oct 2022 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664820213; x=1696356213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cjgd5Rwu0UYo06yOUVIVHZGW70aBVle99QVapUa4l8I=;
  b=kslf2F4yc8fM1brBWQEd4E6mZtGHz8T4UyfkuhtG2ZpzSrhjG/srE1+1
   MrQ9T9u9nCDpoTGXYwq71ejbAxqqvqgZQL4SOlZeonNxvylvHrzDku/MS
   rT4gAuPHmodlTpIst7EhX3yiaLimwUn5m9Eetypqy2vZdZmLPfqE0kxMq
   DVd/ZrPA7dwzL/RHx5H8ujH6kdLWqQZALrpiUeR296y12g8SZqV+BAD5v
   R+ZUxzubInV3IlBMeZ27wo2UrsY7afupjgYYGN7W57W/zv6pRW50CvP/i
   4IEeKK4Nf6OHWBpN9Zu1Vn03BUbDYwK1jklAipv2hVZ9Jdn7yGRAIKS6Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="285885074"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="285885074"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 10:43:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="574724070"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="574724070"
Received: from bandrei-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.219])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 10:43:45 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D42D2104CE4; Mon,  3 Oct 2022 20:43:41 +0300 (+03)
Date:   Mon, 3 Oct 2022 20:43:41 +0300
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
Subject: Re: [PATCH v2 12/39] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Message-ID: <20221003174341.oqpypr4lsdrfga7f@box.shutemov.name>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-13-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-13-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:09PM -0700, Rick Edgecombe wrote:
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2f2963429f48..58c7bf9d7392 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1287,6 +1287,23 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +#ifdef CONFIG_X86_SHADOW_STACK
> +	/*
> +	 * Avoid accidentally creating shadow stack PTEs
> +	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
> +	 * the hardware setting Dirty=1.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
> +		pte_t old_pte, new_pte;
> +
> +		old_pte = READ_ONCE(*ptep);
> +		do {
> +			new_pte = pte_wrprotect(old_pte);
> +		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
> +
> +		return;
> +	}
> +#endif
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>  }

Okay, this addresses my previous question. The need in cmpxchg is
unfortunate, but well.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
