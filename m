Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE30962A2BE
	for <lists+linux-arch@lfdr.de>; Tue, 15 Nov 2022 21:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiKOUX6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Nov 2022 15:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiKOUX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Nov 2022 15:23:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C666E09E;
        Tue, 15 Nov 2022 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gnBvvxVV1UpbhnAgdQuR60qQfn+qU/4SZdVegL+aLWo=; b=LmvA3vAEQOk+haDdY2beDBXSSP
        6AG+A8DZNza9ah+lsNly31dFG5mbH+KdLxVxoe4weSk/onjV1PKnsjqogmTxI0TRkOKwjt76PGfxV
        ryCjwhnCnpxQlWcGw2b8eyoV1LtIALTk0hq2rQtes8YCxLJiEevIb1Td4E/s6uVQdst10xieyUcVC
        LxdQDXqrZU+SR3MZzD902ZPjTWxiAu4GVjChPwBUa50X5FYPJ48nFs9jml3cvb8+1FVVDq2wE5mu4
        dFbUysFVCabBsNmJSpgZalRI4wvO1WrC5+0o3RuMr0DqvxiyzLoNKZn0liARiO28ZulfzwnlPOZSl
        4Y175GZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov2T0-00GbpX-VG; Tue, 15 Nov 2022 20:23:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A64BA300E7E;
        Tue, 15 Nov 2022 13:05:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 953572015BE8A; Tue, 15 Nov 2022 13:05:50 +0100 (CET)
Date:   Tue, 15 Nov 2022 13:05:50 +0100
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v3 20/37] mm/mprotect: Exclude shadow stack from
 preserve_write
Message-ID: <Y3OAnl9nZ4CHvhVr@hirez.programming.kicks-ass.net>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
 <20221104223604.29615-21-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104223604.29615-21-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 04, 2022 at 03:35:47PM -0700, Rick Edgecombe wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 73b9b78f8cf4..7643a4db1b50 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1803,6 +1803,13 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		return 0;
>  
>  	preserve_write = prot_numa && pmd_write(*pmd);
> +
> +	/*
> +	 * Preserve only normal writable huge PMD, but not shadow
> +	 * stack (RW=0, Dirty=1).
> +	 */
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		preserve_write = false;
>  	ret = 1;
>  
>  #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 668bfaa6ed2a..ea82ce5f38fe 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -115,6 +115,13 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  			pte_t ptent;
>  			bool preserve_write = prot_numa && pte_write(oldpte);
>  
> +			/*
> +			 * Preserve only normal writable PTE, but not shadow
> +			 * stack (RW=0, Dirty=1).
> +			 */
> +			if (vma->vm_flags & VM_SHADOW_STACK)
> +				preserve_write = false;
> +
>  			/*
>  			 * Avoid trapping faults against the zero or KSM
>  			 * pages. See similar comment in change_huge_pmd.

These comments lack a why component; someone is going to wonder wtf this
code is doing in the near future -- that someone might be you.
