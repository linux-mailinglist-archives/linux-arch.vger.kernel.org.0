Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76315FF1C2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJNPwv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiJNPwu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 11:52:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB671C77CC;
        Fri, 14 Oct 2022 08:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uURYEhJNF/y4ef2ytvd2xFiDhwfWuIdCXYX1RDrMcEU=; b=FI8zrVaVC/8UN/s+IiozYmQHKy
        Y557SBFHLKXCkrCnS2qkGQO6WBcuTY9UCgzKthC5OYmAmaNRDidzUfdySBCzwEmZak48g63V7W0se
        harj0CbOOajx4M9COGuuEFZB31SGwzSyEhtOzDzwtY/UdMeFeYkVkbJUgsabjCu3o8WnPFWYW7VJX
        yhyvlOKxkjg0twaCH2fp4fjBU+DMUPJ3kNPjuOsacZZWAZ+xrgJ9JXv7/akKIdWxrls5DXgfpU87E
        eQT1cZyX4+yNpZBCtP+moPbnXDOYLTwpdr6p37FiH/BfjURSfu6BObNi1jef0hOl3BRHNT5bYE6+j
        +NS805UA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojMys-007jm1-O0; Fri, 14 Oct 2022 15:52:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E68A30008D;
        Fri, 14 Oct 2022 17:52:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67EF92C1B1259; Fri, 14 Oct 2022 17:52:08 +0200 (CEST)
Date:   Fri, 14 Oct 2022 17:52:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 17/39] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <Y0mFqGvtSrw/kS4b@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-18-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-18-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:14PM -0700, Rick Edgecombe wrote:
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 7327b2573f7c..b49372c7de41 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -63,6 +63,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  	int ret;
>  	pte_t _dst_pte, *dst_pte;
>  	bool writable = dst_vma->vm_flags & VM_WRITE;
> +	bool shstk = dst_vma->vm_flags & VM_SHADOW_STACK;
>  	bool vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	bool page_in_cache = page->mapping;
>  	spinlock_t *ptl;
> @@ -83,9 +84,12 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
>  		writable = false;
>  	}
>  
> -	if (writable)
> -		_dst_pte = pte_mkwrite(_dst_pte);
> -	else
> +	if (writable) {
> +		if (shstk)
> +			_dst_pte = pte_mkwrite_shstk(_dst_pte);
> +		else
> +			_dst_pte = pte_mkwrite(_dst_pte);
> +	} else
>  		/*
>  		 * We need this to make sure write bit removed; as mk_pte()
>  		 * could return a pte with write bit set.

Urgh.. that's unfortunate. But yeah, I don't see a way to make that
pretty either.
