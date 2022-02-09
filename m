Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288214AFAC1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 19:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiBISjy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 13:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiBISjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 13:39:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B0C050CFA;
        Wed,  9 Feb 2022 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644431944; x=1675967944;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=gzDP3bKlNEdaxBl3I199taLYxCzYF6uSO57sfhfmuKE=;
  b=neUdap2cEHD8CfDO449futtLaLobtS5EZPb1FNguEXCTWst4YvHgfLGT
   gi/UxulIzmNrU0YNbCPEqnG0AlxPlqwnXWB6lv+Jk4f/fo8Vlf3Qv74o7
   Hdp0+iSJxGUsCySypvZiAauPxQ0DwVXGljmt0Z+0UUlXyb3dfXOK7/c/8
   sraiFeI8SNykjrJfWjGj97+uquj7CozNLzW158Qi03tjRwS9q2PA3f6Kv
   SqMLA++7YYgjuQv5FAW6so5v8SeWxp2zMpPWOv4m9crhCnQ+NQIt2cHmA
   Gv/GxMhXc5iVJyNRo+Ay1GQDAO7knx0y4NUYiBsVhRy46wgt9WjM2cCtY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="312592652"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="312592652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:30:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="485362361"
Received: from sanvery-mobl.amr.corp.intel.com (HELO [10.212.232.139]) ([10.212.232.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:30:40 -0800
Message-ID: <21f5b129-e52a-74b7-6c8b-2bf0ab3db649@intel.com>
Date:   Wed, 9 Feb 2022 10:30:37 -0800
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
 <20220130211838.8382-13-rick.p.edgecombe@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 12/35] x86/mm: Update ptep_set_wrprotect() and
 pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
In-Reply-To: <20220130211838.8382-13-rick.p.edgecombe@intel.com>
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
> When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
> shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].

<sigh>  Another way to refer to these PTEs.  In the last patch, it was:

	"read-only and Dirty PTE"
and now:
	"[R/O + _PAGE_DIRTY]"

> When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
> become a transient shadow stack PTE in two cases:
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> shadow stack PTE.  However, this will not occur on processors supporting
> Shadow Stack, and a TLB flush is not necessary.
> 
> The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
> atomically, a transient shadow stack PTE can be created as a result.
> Thus, prevent that with cmpxchg.

== Background ==

Shadow stack PTEs always have [Write=0,Dirty=1].

As currently implemented, ptep_set_wrprotect() simply clears _PAGE_RW:
(Write=1 -> Write=0).

== Problem ==

This could cause a problem if ptep_set_wrprotect() caused a PTE to
transition from:

	[Write=1,Dirty=1]
to
	[Write=0,Dirty=1]

Which would inadvertently create a shadow stack PTE instead of
write-protecting it.  ptep_set_wrprotect() can not simply check for the
Dirty=1 bit because the hardware can set it at any time.

== Solution ==

Perform a compare-and-exchange operation on the PTE to avoid racing with
the hardware.  The cmpxchg is expected to be more expensive than the
existing clear_bit().  Continue using the cheaper clear_bit() on when
shadow stacks are not in play.

> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 5c3886f6ccda..e1061b9cba6a 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1295,6 +1295,24 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +	/*
> +	 * If Shadow Stack is enabled, pte_wrprotect() moves _PAGE_DIRTY
> +	 * to _PAGE_COW (see comments at pte_wrprotect()).
> +	 * When a thread reads a RW=1, Dirty=0 PTE and before changing it
> +	 * to RW=0, Dirty=0, another thread could have written to the page
> +	 * and the PTE is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
> +	 * PTE changes and update old_pte, then try again.
> +	 */

I think we can trim that down.  We don't need to explain what cmpxchg
does or why it loops.  That's way too much detail that we don't need.
Maybe:

	/*
	 * Avoid accidentally creating shadow stack PTEs
	 * (Write=0,Dirty=1).  Use cmpxchg() to prevent races with
	 * the hardware setting Dirty=1.
	 */

BTW, is it *really* a problem with other threads setting Dirty=1?  This
is happening under the page table lock on this side at least.

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
>  	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
>  }



