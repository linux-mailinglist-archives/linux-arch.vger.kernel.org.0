Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E88B677766
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 10:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjAWJ3O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 04:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWJ3N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 04:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F03D193D8
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 01:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674466108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrIFJvTmapK03tMxp/EwcaTsAgwZAa+tcZ42A86+Ees=;
        b=QjwAbzyUNFnlQ9za3+Rkq99srmhiunAPMQYnky5oqLA3ICH9SaUVh/8KE540Ld+r51OaS1
        /BlVeN9lx2LKM/NJoH0foxX9wnLvtMFtczItWpQCuEdF5LSaxitlVIqcmgcFP/Kx3K23qQ
        tCrHG3xyhK43WqcgmHZuhNU1tWPwxGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-kO-ZKCXDOIekicVvxI2goQ-1; Mon, 23 Jan 2023 04:28:27 -0500
X-MC-Unique: kO-ZKCXDOIekicVvxI2goQ-1
Received: by mail-wm1-f71.google.com with SMTP id k20-20020a05600c1c9400b003db2e916b3aso5738416wms.6
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 01:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrIFJvTmapK03tMxp/EwcaTsAgwZAa+tcZ42A86+Ees=;
        b=jmvfTJ96fvjC8RiB/v4e5sqsdLjAGBrs+xQ18aGfi7g0/14C1ZnuAyIQZjrYSbOigB
         ipAUBc15tAN+nsAk8UgyxQLPvUh6OY/a1uOYDewkHBJuBF1jo4BnNNomTlIRPPgWnyvf
         ImPEdPhRQXtYaPAXFmx55iOxv0GAhLfVprSl1j5bCSmXb5DE0G6k4h43S5r73mdTzfGn
         f6me2QHe/sQ/hC5U25mBozVSy7lBu2HJ0e+OQ5QzkCrStsUztzcTSSEKudgFVh7cTL6H
         DxncvqdsyBG3O9FqoAOktBZvON/yrkQH52OWtinqpQ7OKeP1386beeE55jbMV8LPmkqW
         D6qg==
X-Gm-Message-State: AFqh2kpQya83//AAwxpKZKoSE1Tv6edztxhSPha2jF2FMtq/96lSyiqE
        woDnmkmo0ksuLMq5mRAWmuufWK1Wkd4JJRHKvGS2nrtIQqPccZLdO+4WxToMpWEs+2FUfFtnXpC
        NhLclCejHnB8/cPbc2nZ53Q==
X-Received: by 2002:a05:600c:4b9a:b0:3da:fcdc:cafd with SMTP id e26-20020a05600c4b9a00b003dafcdccafdmr22698487wmp.13.1674466105749;
        Mon, 23 Jan 2023 01:28:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs/vdJO4rUgmUUDJGfJogv0+NRnslbNv9uG5arGuXj/93En31RKOdaZ76Y8MzQdaM5yO+HgXg==
X-Received: by 2002:a05:600c:4b9a:b0:3da:fcdc:cafd with SMTP id e26-20020a05600c4b9a00b003dafcdccafdmr22698448wmp.13.1674466105328;
        Mon, 23 Jan 2023 01:28:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id b10-20020a05600c4e0a00b003db0cab0844sm10235533wmq.40.2023.01.23.01.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:28:24 -0800 (PST)
Message-ID: <634aa365-1f51-8684-24ae-3b68aba1e12a@redhat.com>
Date:   Mon, 23 Jan 2023 10:28:23 +0100
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

TBH, I find that all highly confusing.

Dirty=1,Write=0 does not indicate a COW page reliably. You could have 
both, false negatives and false positives.

False negative: fork() on a clean anon page.

False positives: wrpotect() of a dirty anon page.


I wonder if it really has to be that complicated: what you really want 
to achieve is to disallow "Dirty=1,Write=0" if it's not a shadow stack 
page, correct?

-- 
Thanks,

David / dhildenb

