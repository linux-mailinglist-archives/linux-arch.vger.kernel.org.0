Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB51B67773D
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 10:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjAWJR2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 04:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAWJR1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 04:17:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21846E91
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674465403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k8JcC6eIt+iMfSq8qeJsa8sN2OBxI65CeQDKnD44YXg=;
        b=AYBf8vU+Xd7/EoOazxC8CWHn+8OgsIE6PrFgpnKQk21C50K6H0SIY5ZE/kbLcklQOwHAkg
        J3sfC9nfJAwOCxd3NPcTf/gNWnIduNcgPC37RPjOZFRlnguy39cLtn1KVAho2X1N2i3wcj
        e+q+LVwtjUcrPMRyusP6Eu07u8zXqPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-mVuIxofeMTCLEroK1UGEAw-1; Mon, 23 Jan 2023 04:16:41 -0500
X-MC-Unique: mVuIxofeMTCLEroK1UGEAw-1
Received: by mail-wr1-f70.google.com with SMTP id b15-20020adfc74f000000b002be276d2052so1784606wrh.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 01:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8JcC6eIt+iMfSq8qeJsa8sN2OBxI65CeQDKnD44YXg=;
        b=M8MwBgP+OPZQftTnJhYUV5Hj8IdbUEsKLokHSeDcPTnWqAIGnA+d1iKYSMDoK9iKvg
         k1FmqklG+2Fs1FTZPV+0WUojhHTaelf3a8W/6R6PpNpCbLta1wFN5MsTkvnJpqSoiqlK
         gzsV+44dutKZC94im2UYHAdvstn+zXeMJrdvRn4dlW31d4CTCy+NVslThnyOPBoeFood
         Fs+DJ1fbUnAwUiO4cG7e1PRx6kCLLrBzrgGkn9/QjVciZjbfOzcwpH4xObgVnwNl/lSB
         HS9b6TgIOn2c5gq/I+FDQvnmYHz+AnjZPcKd9ZWnjfbt0VVm7GpfTY9VgJk1CXxak9k2
         wdCw==
X-Gm-Message-State: AFqh2kqvt9cZP57RkjDDpjaVbMjnvmLSoJNe8Vt9qj3T6fJCQcdNLoY5
        9mJaShIRU/Gv5rf4PEO0m0WYXo9A8Te2tSwRMwKmRjMSeXbCKhX8YEbMfi15ID48ZOp9ap6LTOW
        kKZ4cRKhnX0DwrFHNLlqgOQ==
X-Received: by 2002:a05:600c:1c86:b0:3da:fa75:ce58 with SMTP id k6-20020a05600c1c8600b003dafa75ce58mr26719032wms.21.1674465400477;
        Mon, 23 Jan 2023 01:16:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuupSrdeuharN/DJudQsmcwvHAen3BCVSbfnv8VMnK/LetCsRFdTz9vm9krb5wqXvP+aX6kLg==
X-Received: by 2002:a05:600c:1c86:b0:3da:fa75:ce58 with SMTP id k6-20020a05600c1c8600b003dafa75ce58mr26718979wms.21.1674465400042;
        Mon, 23 Jan 2023 01:16:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id bi13-20020a05600c3d8d00b003daf98d7e35sm10026313wmb.14.2023.01.23.01.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:16:39 -0800 (PST)
Message-ID: <5ddbd710-1b4d-71ed-8dfe-928449a6f635@redhat.com>
Date:   Mon, 23 Jan 2023 10:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 10/39] x86/mm: Introduce _PAGE_COW
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-11-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230119212317.8324-11-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 19.01.23 22:22, Rick Edgecombe wrote:
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
> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY. In other
> words, whenever Linux needs to create Write=0,Dirty=1, it instead creates
> Write=0,Cow=1 except for shadow stack, which is Write=0,Dirty=1.
> Further differentiated by VMA flags, these PTE bit combinations would be
> set as follows for various types of memory:
> 
> (Write=0,Cow=1,Dirty=0):
>   - A modified, copy-on-write (COW) page. Previously when a typical
>     anonymous writable mapping was made COW via fork(), the kernel would
>     mark it Write=0,Dirty=1. Now it will instead use the Cow bit. This
>     happens in copy_present_pte().
>   - A R/O page that has been COW'ed. The user page is in a R/O VMA,
>     and get_user_pages(FOLL_FORCE) needs a writable copy. The page fault
>     handler creates a copy of the page and sets the new copy's PTE as
>     Write=0 and Cow=1.
>   - A shared shadow stack PTE. When a shadow stack page is being shared
>     among processes (this happens at fork()), its PTE is made Dirty=0, so
>     the next shadow stack access causes a fault, and the page is
>     duplicated and Dirty=1 is set again. This is the COW equivalent for
>     shadow stack pages, even though it's copy-on-access rather than
>     copy-on-write.
> 
> (Write=0,Cow=0,Dirty=1):
>   - A shadow stack PTE.
>   - A Cow PTE created when a processor without shadow stack support set
>     Dirty=1.
> 
> There are six bits left available to software in the 64-bit PTE after
> consuming a bit for _PAGE_COW. No space is consumed in 32-bit kernels
> because shadow stacks are not enabled there.
> 
> Implement only the infrastructure for _PAGE_COW. Changes to start
> creating _PAGE_COW PTEs will follow once other pieces are in place.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
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
> 
> v2:
>   - Update commit log with comments (Dave Hansen)
>   - Add comments in code to explain pte modification code better (Dave)
>   - Clarify info on the meaning of various Write,Cow,Dirty combinations
> 
>   arch/x86/include/asm/pgtable.h       | 78 ++++++++++++++++++++++++++++
>   arch/x86/include/asm/pgtable_types.h | 59 +++++++++++++++++++--
>   arch/x86/include/asm/tlbflush.h      |  3 +-
>   3 files changed, 134 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index b39f16c0d507..6d2f612c04b5 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -301,6 +301,44 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>   	return native_make_pte(v & ~clear);
>   }
>   
> +/*
> + * Normally COW memory can result in Dirty=1,Write=0 PTEs. But in the case
> + * of X86_FEATURE_USER_SHSTK, the software COW bit is used, since the
> + * Dirty=1,Write=0 will result in the memory being treated as shadow stack
> + * by the HW. So when creating COW memory, a software bit is used
> + * _PAGE_BIT_COW. The following functions pte_mkcow() and pte_clear_cow()
> + * take a PTE marked conventionally COW (Dirty=1) and transition it to the
> + * shadow stack compatible version of COW (Cow=1).
> + */
> +static inline pte_t pte_mkcow(pte_t pte)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pte;
> +
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY);
> +	return pte_set_flags(pte, _PAGE_COW);
> +}
> +
> +static inline pte_t pte_clear_cow(pte_t pte)
> +{
> +	/*
> +	 * _PAGE_COW is unnecessary on !X86_FEATURE_USER_SHSTK kernels, since
> +	 * the HW dirty bit can be used without creating shadow stack memory.
> +	 * See the _PAGE_COW definition for more details.
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
> +	return pte_clear_flags(pte, _PAGE_COW);
> +}
> +
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   static inline int pte_uffd_wp(pte_t pte)
>   {
> @@ -413,6 +451,26 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
>   	return native_make_pmd(v & ~clear);
>   }
>   
> +/* See comments above pte_mkcow() */
> +static inline pmd_t pmd_mkcow(pmd_t pmd)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pmd;
> +
> +	pmd = pmd_clear_flags(pmd, _PAGE_DIRTY);
> +	return pmd_set_flags(pmd, _PAGE_COW);
> +}
> +
> +/* See comments above pte_mkcow() */
> +static inline pmd_t pmd_clear_cow(pmd_t pmd)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pmd;
> +
> +	pmd = pmd_set_flags(pmd, _PAGE_DIRTY);
> +	return pmd_clear_flags(pmd, _PAGE_COW);
> +}
> +
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
>   static inline int pmd_uffd_wp(pmd_t pmd)
>   {
> @@ -484,6 +542,26 @@ static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
>   	return native_make_pud(v & ~clear);
>   }
>   
> +/* See comments above pte_mkcow() */
> +static inline pud_t pud_mkcow(pud_t pud)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pud;
> +
> +	pud = pud_clear_flags(pud, _PAGE_DIRTY);
> +	return pud_set_flags(pud, _PAGE_COW);
> +}
> +
> +/* See comments above pte_mkcow() */
> +static inline pud_t pud_clear_cow(pud_t pud)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
> +		return pud;
> +
> +	pud = pud_set_flags(pud, _PAGE_DIRTY);
> +	return pud_clear_flags(pud, _PAGE_COW);
> +}
> +
>   static inline pud_t pud_mkold(pud_t pud)
>   {
>   	return pud_clear_flags(pud, _PAGE_ACCESSED);
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0646ad00178b..5c3f942865d9 100644
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
> + * Indicates a copy-on-write page.
> + */
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#define _PAGE_BIT_COW		_PAGE_BIT_SOFTW5 /* copy-on-write */
> +#else
> +#define _PAGE_BIT_COW		0
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
> + * _PAGE_COW is a software-only bit used to separate copy-on-write PTEs
> + * from shadow stack PTEs:

Is that really required?

For anon pages, we have PG_anon_exclusive, that can tell you whether the 
page is "certainly exclusive" (now cow necessary) vs. "maybe shared" 
(cow maybe necessary).

Why isn't that sufficient to make the same decisions here?

-- 
Thanks,

David / dhildenb

