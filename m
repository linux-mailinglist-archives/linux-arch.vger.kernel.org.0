Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDB4B00A5
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 23:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiBIWub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 17:50:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbiBIWua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 17:50:30 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDDE01925B;
        Wed,  9 Feb 2022 14:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644447032; x=1675983032;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=4Pwqb82pRVxdynG25KCR6umaUemEEUALqmeKoSY7z9M=;
  b=XCpCH/3Td0KFvE4yaMT6TS9hx1cEETvcDzl4o8R9X8atUDJAsi8Tr33i
   t01Go6d8A5PzjQJU0VHAT7enZLKRImwWFNk0eyxd82e/VAbE0uV7DOIYh
   0GfBbJWb4NL0WN9b8CVLJKbns9CSv8KZzgS5CVWYKrQbnC8vLVxxiPJ4I
   /5IM7ulccWLpI7u+1JKEsrLe84rF9h1l+VUBFlqQUsLy47HglmiFNQcBY
   pzPRyR3Wwd7/27hyGXdcY59jU2Lvw5mldIfl0do4aC2S8RN693duW/Jsz
   vnZ7lL47aKWywTwTyRsBAL1eIAeErAJy45CwhN3Wxn7pfrbyKp8XBshIM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="312652486"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="312652486"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:50:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="701445624"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 14:50:31 -0800
Message-ID: <74038286-6ff3-7eb2-ea65-2e223a894900@intel.com>
Date:   Wed, 9 Feb 2022 14:50:27 -0800
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
 <20220130211838.8382-21-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 20/35] mm: Update can_follow_write_pte() for shadow stack
In-Reply-To: <20220130211838.8382-21-rick.p.edgecombe@intel.com>
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
> Can_follow_write_pte() ensures a read-only page is COWed by checking the
> FOLL_COW flag, and uses pte_dirty() to validate the flag is still valid.
> 
> Like a writable data page, a shadow stack page is writable, and becomes
> read-only during copy-on-write,

I thought we could not have read-only shadow stack pages.  What does a
read-only shadow stack PTE look like? ;)

> but it is always dirty.  Thus, in the
> can_follow_write_pte() check, it belongs to the writable page case and
> should be excluded from the read-only page pte_dirty() check.  Apply
> the same changes to can_follow_write_pmd().
> 
> While at it, also split the long line into smaller ones.

FWIW, I probably would have had a preparatory patch for this part.  The
advantage is that if you break existing code, it's a lot easier to
figure it out if you have a separate refactoring patch.  Also, for a
patch like this, the refactoring might result in the same exact binary.
 It's a pretty good sign that your patch won't cause regressions if it
results in the same binary.

> diff --git a/mm/gup.c b/mm/gup.c
> index f0af462ac1e2..95b7d1084c44 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -464,10 +464,18 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>   * FOLL_FORCE can write to even unwritable pte's, but only
>   * after we've gone through a COW cycle and they are dirty.
>   */
> -static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> +static inline bool can_follow_write_pte(pte_t pte, unsigned int flags,
> +					struct vm_area_struct *vma)
>  {
> -	return pte_write(pte) ||
> -		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
> +	if (pte_write(pte))
> +		return true;
> +	if ((flags & (FOLL_FORCE | FOLL_COW)) != (FOLL_FORCE | FOLL_COW))
> +		return false;
> +	if (!pte_dirty(pte))
> +		return false;
> +	if (is_shadow_stack_mapping(vma->vm_flags))
> +		return false;

You had me up until this is_shadow_stack_mapping().  It wasn't mentioned
at all in the changelog.  Logically, I think it's trying to say that a
shadow stack VMA never allows a FOLL_FORCE override.

That makes some sense, but it's a pretty big point not to mention in the
changelog.

> +	return true;
>  }
>  
>  static struct page *follow_page_pte(struct vm_area_struct *vma,
> @@ -510,7 +518,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  	}
>  	if ((flags & FOLL_NUMA) && pte_protnone(pte))
>  		goto no_page;
> -	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags)) {
> +	if ((flags & FOLL_WRITE) && !can_follow_write_pte(pte, flags, vma)) {
>  		pte_unmap_unlock(ptep, ptl);
>  		return NULL;
>  	}


