Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321DD69C9E9
	for <lists+linux-arch@lfdr.de>; Mon, 20 Feb 2023 12:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjBTLc7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Feb 2023 06:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTLcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Feb 2023 06:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E404816338
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676892727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGUAqGZuHySNKcTWS5lZ8e1XRk6pjzzmAavRmf+Uad4=;
        b=dJhKHRBfS7390IA2U3faremFCu4aHb1FRvWwK3GNzN1q7SfYacx8EAxP1KuTa4JjAHdssg
        ehtJVcfeF6sxtU6H8Kjdra9Yr0L2/c/RqDkwe0TJW8nBZPMqnWWF+fMKGa4BQ/Xx81K6MD
        R/pM2X7Bt8K0jGk5RYS1GFBURyYZowg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-110-30SsdbM7NaKtYlnUcJG_fA-1; Mon, 20 Feb 2023 06:32:05 -0500
X-MC-Unique: 30SsdbM7NaKtYlnUcJG_fA-1
Received: by mail-wm1-f70.google.com with SMTP id m22-20020a05600c4f5600b003dffc7343c3so409699wmq.0
        for <linux-arch@vger.kernel.org>; Mon, 20 Feb 2023 03:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGUAqGZuHySNKcTWS5lZ8e1XRk6pjzzmAavRmf+Uad4=;
        b=1zOSJgzKpQfOGHwQAX0+i+EohLrLwnlkF6zWsEvN6vU7JibzSPDv9CEUKHUU7mM+FH
         395wLg8iktou2+BpTtDT1LOKW70HvashGI9C67uPK4jqnBUl56MS0UQcJ7rRTENUMmhU
         TBgdqScXuV7fLcAXULh/M0etH0wGVHYWLWdApfHyFkvvqasFSM6RIWt3SWCZDr52qrg1
         MYHqO1yEMsnVGkubXzFieNb5g2wodV84WqkbKX0RxFhERMTGy0ISDEtAkeiEYC8MlmVj
         2Eo0GhDB7MEVlKJ+r5LUvJYAH0qXwkIhLOu1QkUfGQzex5kE991RT9xR/gNF1rguQkms
         J3JA==
X-Gm-Message-State: AO0yUKX87GAh6nn9usYjbDYTOfYNomLZhSj90h12Z1DnS0Th+p08cu3O
        QBMH1BNKx3XGOAtCQkaZv6NJBIkCgGhu1qTh9WTD1C3BZo6SCSySLU5gZRszhAMvYsMoYC3TrM+
        Dx3l4s+xDHTPo2AjKatJ0sQ==
X-Received: by 2002:a5d:5701:0:b0:2c5:6081:5b3f with SMTP id a1-20020a5d5701000000b002c560815b3fmr901749wrv.69.1676892724655;
        Mon, 20 Feb 2023 03:32:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/NFU7JGQbqG55n2sHfhL75xOIN0M7AYIlE8IoiB51HxlWGfZtCue3e4OtIyQ5HcCV08bejOg==
X-Received: by 2002:a5d:5701:0:b0:2c5:6081:5b3f with SMTP id a1-20020a5d5701000000b002c560815b3fmr901701wrv.69.1676892724163;
        Mon, 20 Feb 2023 03:32:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id y16-20020a056000109000b002c596e4b3dasm1636352wrw.55.2023.02.20.03.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:32:03 -0800 (PST)
Message-ID: <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
Date:   Mon, 20 Feb 2023 12:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-15-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
In-Reply-To: <20230218211433.26859-15-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> Some OSes have a greater dependence on software available bits in PTEs than
> Linux. That left the hardware architects looking for a way to represent a
> new memory type (shadow stack) within the existing bits. They chose to
> repurpose a lightly-used state: Write=0,Dirty=1. So in order to support
> shadow stack memory, Linux should avoid creating memory with this PTE bit
> combination unless it intends for it to be shadow stack.
> 
> The reason it's lightly used is that Dirty=1 is normally set by HW
> _before_ a write. A write with a Write=0 PTE would typically only generate
> a fault, not set Dirty=1. Hardware can (rarely) both set Dirty=1 *and*
> generate the fault, resulting in a Write=0,Dirty=1 PTE. Hardware which
> supports shadow stacks will no longer exhibit this oddity.
> 
> So that leaves Write=0,Dirty=1 PTEs created in software. To achieve this,
> in places where Linux normally creates Write=0,Dirty=1, it can use the
> software-defined _PAGE_SAVED_DIRTY in place of the hardware _PAGE_DIRTY.
> In other words, whenever Linux needs to create Write=0,Dirty=1, it instead
> creates Write=0,SavedDirty=1 except for shadow stack, which is
> Write=0,Dirty=1. Further differentiated by VMA flags, these PTE bit
> combinations would be set as follows for various types of memory:
I would simplify (see below) and not repeat what the patch contains as 
comments already that detailed.

> 
> (Write=0,SavedDirty=1,Dirty=0):
>   - A modified, copy-on-write (COW) page. Previously when a typical
>     anonymous writable mapping was made COW via fork(), the kernel would
>     mark it Write=0,Dirty=1. Now it will instead use the SavedDirty bit.
>     This happens in copy_present_pte().
>   - A R/O page that has been COW'ed. The user page is in a R/O VMA,
>     and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
>     handler creates a copy of the page and sets the new copy's PTE as
>     Write=0 and SavedDirty=1.
>   - A shared shadow stack PTE. When a shadow stack page is being shared
>     among processes (this happens at fork()), its PTE is made Dirty=0, so
>     the next shadow stack access causes a fault, and the page is
>     duplicated and Dirty=1 is set again. This is the COW equivalent for
>     shadow stack pages, even though it's copy-on-access rather than
>     copy-on-write.
> 
> (Write=0,SavedDirty=0,Dirty=1):
>   - A shadow stack PTE.
>   - A Cow PTE created when a processor without shadow stack support set
>     Dirty=1.
> 
> There are six bits left available to software in the 64-bit PTE after
> consuming a bit for _PAGE_SAVED_DIRTY. No space is consumed in 32-bit
> kernels because shadow stacks are not enabled there.
> 
> Implement only the infrastructure for _PAGE_SAVED_DIRTY. Changes to start
> creating _PAGE_SAVED_DIRTY PTEs will follow once other pieces are in place.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v6:
>   - Rename _PAGE_COW to _PAGE_SAVED_DIRTY (David Hildenbrand)
>   - Add _PAGE_SAVED_DIRTY to _PAGE_CHG_MASK
> 
> v5:
>   - Fix log, comments and whitespace (Boris)
>   - Remove capitalization on shadow stack (Boris)
> 
> v4:
>   - Teach pte_flags_need_flush() about _PAGE_COW bit
>   - Break apart patch for better bisectability
> 
> v3:
>   - Add comment around _PAGE_TABLE in response to comment
>     from (Andrew Cooper)
>   - Check for PSE in pmd_shstk (Andrew Cooper)
>   - Get to the point quicker in commit log (Andrew Cooper)
>   - Clarify and reorder commit log for why the PTE bit examples have
>     multiple entries. Apply same changes for comment. (peterz)
>   - Fix comment that implied dirty bit for COW was a specific x86 thing
>     (peterz)
>   - Fix swapping of Write/Dirty (PeterZ)
> ---
>   arch/x86/include/asm/pgtable.h       | 79 ++++++++++++++++++++++++++++
>   arch/x86/include/asm/pgtable_types.h | 65 ++++++++++++++++++++---
>   arch/x86/include/asm/tlbflush.h      |  3 +-
>   3 files changed, 138 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2b423d697490..110e552eb602 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -301,6 +301,45 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>   	return native_make_pte(v & ~clear);
>   }
>   
> +/*
> + * COW and other write protection operations can result in Dirty=1,Write=0
> + * PTEs. But in the case of X86_FEATURE_USER_SHSTK, the software SavedDirty bit
> + * is used, since the Dirty=1,Write=0 will result in the memory being treated as
> + * shadow stack by the HW. So when creating dirty, write-protected memory, a
> + * software bit is used _PAGE_BIT_SAVED_DIRTY. The following functions
> + * pte_mksaveddirty() and pte_clear_saveddirty() take a conventional dirty,
> + * write-protected PTE (Write=0,Dirty=1) and transition it to the shadow stack
> + * compatible version. (Write=0,SavedDirty=1).
> + */
> +static inline pte_t pte_mksaveddirty(pte_t pte)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pte;
> +
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_set_flags(pte, _PAGE_SAVED_DIRTY);
> +}
> +
> +static inline pte_t pte_clear_saveddirty(pte_t pte)
> +{
> +	/*
> +	 * _PAGE_SAVED_DIRTY is unnecessary on !X86_FEATURE_USER_SHSTK kernels,
> +	 * since the HW dirty bit can be used without creating shadow stack
> +	 * memory. See the _PAGE_SAVED_DIRTY definition for more details.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pte;
> +
> +	/*
> +	 * PTE is getting copied-on-write, so it will be dirtied
> +	 * if writable, or made shadow stack if shadow stack and
> +	 * being copied on access. Set the dirty bit for both
> +	 * cases.
> +	 */
> +	pte = pte_set_flags(pte, _PAGE_DIRTY);
> +	return pte_clear_flags(pte, _PAGE_SAVED_DIRTY);
> +}
> +
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   static inline int pte_uffd_wp(pte_t pte)
>   {
> @@ -420,6 +459,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
>   	return native_make_pmd(v & ~clear);
>   }
>   
> +/* See comments above pte_mksaveddirty() */
> +static inline pmd_t pmd_mksaveddirty(pmd_t pmd)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pmd;
> +
> +	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
> +	return pmd_set_flags(pmd, _PAGE_SAVED_DIRTY);
> +}
> +
> +/* See comments above pte_mksaveddirty() */
> +static inline pmd_t pmd_clear_saveddirty(pmd_t pmd)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pmd;
> +
> +	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
> +	return pmd_clear_flags(pmd, _PAGE_SAVED_DIRTY);
> +}
> +
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   static inline int pmd_uffd_wp(pmd_t pmd)
>   {
> @@ -491,6 +550,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
>   	return native_make_pud(v & ~clear);
>   }
>   
> +/* See comments above pte_mksaveddirty() */
> +static inline pud_t pud_mksaveddirty(pud_t pud)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pud;
> +
> +	pud = pud_clear_flags(pud, _PAGE_DIRTY);
> +	return pud_set_flags(pud, _PAGE_SAVED_DIRTY);
> +}
> +
> +/* See comments above pte_mksaveddirty() */
> +static inline pud_t pud_clear_saveddirty(pud_t pud)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pud;
> +
> +	pud = pud_set_flags(pud, _PAGE_DIRTY);
> +	return pud_clear_flags(pud, _PAGE_SAVED_DIRTY);
> +}
> +
>   static inline pud_t pud_mkold(pud_t pud)
>   {
>   	return pud_clear_flags(pud, _PAGE_ACCESSED);
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0646ad00178b..3b420b6c0584 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -21,7 +21,8 @@
>   #define _PAGE_BIT_SOFTW2	10	/* " */
>   #define _PAGE_BIT_SOFTW3	11	/* " */
>   #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>   #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>   #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>   #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> @@ -34,6 +35,15 @@
>   #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>   #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>   
> +/*
> + * Indicates a Saved Dirty bit page.
> + */
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#define _PAGE_BIT_SAVED_DIRTY		_PAGE_BIT_SOFTW5 /* copy-on-write */

Nope, not "copy-on-write" :) It's more like "dirty bit when the hw-dirty 
bit cannot be used". Maybe simply drop the comment.

> +#else
> +#define _PAGE_BIT_SAVED_DIRTY		0
> +#endif
> +
>   /* If _PAGE_BIT_PRESENT is clear, we use these: */
>   /* - if the user mapped it with PROT_NONE; pte_present gives true */
>   #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
> @@ -117,6 +127,40 @@
>   #define _PAGE_SOFTW4	(_AT(pteval_t, 0))
>   #endif
>   
> +/*
> + * The hardware requires shadow stack to be read-only and Dirty.
> + * _PAGE_SAVED_DIRTY is a software-only bit used to separate copy-on-write
> + * PTEs from shadow stack PTEs:

I'd suggest phrasing this differently. COW is just one scenario where 
this can happen. Also, I don't think that the description of 
"separation" is correct.

Something like the following maybe?

"
However, there are valid cases where the kernel might create read-only 
PTEs that are dirty (e.g., fork(), mprotect(), uffd-wp(), soft-dirty 
tracking). In this case, the _PAGE_SAVED_DIRTY bit is used instead of 
the HW-dirty bit, to avoid creating a wrong "shadow stack" PTEs. Such 
PTEs have (Write=0,SavedDirty=1,Dirty=0) set.

Note that on processors without shadow stack support, the 
_PAGE_SAVED_DIRTY remains unused.
"

The I would simply drop below (which is also too COW-specific I think).

> + *
> + * (Write=0,SavedDirty=1,Dirty=0):
> + *  - A modified, copy-on-write (COW) page. Previously when a typical
> + *    anonymous writable mapping was made COW via fork(), the kernel would
> + *    mark it Write=0,Dirty=1. Now it will instead use the Cow bit. This
> + *    happens in copy_present_pte().
> + *  - A R/O page that has been COW'ed. The user page is in a R/O VMA,
> + *    and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
> + *    handler creates a copy of the page and sets the new copy's PTE as
> + *    Write=0 and SavedDirty=1.
> + *  - A shared shadow stack PTE. When a shadow stack page is being shared
> + *    among processes (this happens at fork()), its PTE is made Dirty=0, so
> + *    the next shadow stack access causes a fault, and the page is
> + *    duplicated and Dirty=1 is set again. This is the COW equivalent for
> + *    shadow stack pages, even though it's copy-on-access rather than
> + *    copy-on-write.
> + *
> + * (Write=0,SavedDirty=0,Dirty=1):
> + *  - A shadow stack PTE.
> + *  - A Cow PTE created when a processor without shadow stack support set
> + *    Dirty=1.
> + */


-- 
Thanks,

David / dhildenb

