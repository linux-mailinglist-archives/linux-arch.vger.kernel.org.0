Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58845F356F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJCSRW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJCSRR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 14:17:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA3340E32
        for <linux-arch@vger.kernel.org>; Mon,  3 Oct 2022 11:17:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gf8so8030110pjb.5
        for <linux-arch@vger.kernel.org>; Mon, 03 Oct 2022 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DBHYwkpApAIABn5XcTL1sIyH02ALe7H/mB3LgfPMN3k=;
        b=kHzL1DsIZG6UyJD0H4Y2gyQK42lrd46BEA08dhT4984lLZjuZ+t3T6ihFZm7ctHiXT
         FJvnBV/hZHQndEO1qssqPK2WLnC3aEuwgl5O0ItlYjzqIr0fl4pn+au+FCUU2lDsB+KQ
         MRAZSxf7gnx57svX5gYl/RcbrD6H+53B429XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DBHYwkpApAIABn5XcTL1sIyH02ALe7H/mB3LgfPMN3k=;
        b=4xDwni59Ru0QNBeBRJMwnNc4pHMazc+dQQtaRXCxIm/EIFRQHp+xw8EyCCgOBWUB0a
         rODqvzmTib8giKA940bSq9QhxxHEimYoGUAPFIyBfnQ982ZVHGXOBATd73/JVTbxryjH
         HM9jCiYwVZtbed0S0RZcZ7hcjA4Ql6Y9BYTAm6BSldZC/Ga/9ozp/oOCIEjlOqbi3PDD
         f/KMFCq+4XEQsmQy/feZ2oJK4/KfsF4uEncASXidCGle9v1gQH/3yaGnAp0cS6K9em1/
         wMvuFLFjlQTM74Pv6r1w2Qsjl7UBMN1pVHD7+hN5DksTCwPdm4CmzM3lvpISOd5awaQ8
         vwzQ==
X-Gm-Message-State: ACrzQf31pwEZYqs/cayYxmQzjiZaIx62Pwkz9YltW6r6cSyWAh076oep
        JzSpvnVZqCjY9Qewc4bhLkk5rw==
X-Google-Smtp-Source: AMsMyM7R1eYi6BdCJuNjc9yq5g+SkFoqirO1gAwAdKpmAlfGtFdUBZPaQLGRzF2mymr5XfWRjx2KIw==
X-Received: by 2002:a17:903:2309:b0:176:de48:e940 with SMTP id d9-20020a170903230900b00176de48e940mr23282806plh.15.1664821031947;
        Mon, 03 Oct 2022 11:17:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12-20020a65624c000000b0043a1c0a0ab1sm6913582pgv.83.2022.10.03.11.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:17:11 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:17:10 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 14/39] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Message-ID: <202210031113.FCBAD74@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-15-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-15-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:11PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> A shadow stack PTE must be read-only and have _PAGE_DIRTY set.  However,
> read-only and Dirty PTEs also exist for copy-on-write (COW) pages.  These
> two cases are handled differently for page faults. Introduce
> VM_SHADOW_STACK to track shadow stack VMAs.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/filesystems/proc.rst | 1 +
>  arch/x86/mm/mmap.c                 | 2 ++
>  fs/proc/task_mmu.c                 | 3 +++
>  include/linux/mm.h                 | 8 ++++++++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index e7aafc82be99..d54ff397947a 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -560,6 +560,7 @@ encoded manner. The codes are the following:
>      mt    arm64 MTE allocation tags are enabled
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
> +    ss    shadow stack page
>      ==    =======================================
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index c90c20904a60..f3f52c5e2fd6 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -165,6 +165,8 @@ unsigned long get_mmap_base(int is_legacy)
>  
>  const char *arch_vma_name(struct vm_area_struct *vma)
>  {
> +	if (vma->vm_flags & VM_SHADOW_STACK)
> +		return "[shadow stack]";
>  	return NULL;
>  }

I agree with Kirill: this should be in the arch-agnostic code.

-- 
Kees Cook
