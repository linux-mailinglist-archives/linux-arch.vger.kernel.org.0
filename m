Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FE5FEBEE
	for <lists+linux-arch@lfdr.de>; Fri, 14 Oct 2022 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiJNJmI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Oct 2022 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJNJlw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2022 05:41:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36BD1C69FD;
        Fri, 14 Oct 2022 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cDuxjcCIkfQXBHxEziGaNIflAudAGusXs+3PecRNCV4=; b=bD5QITAaj83TFVLwAT1dsGPwBB
        ftlzocySEN2acPKAHoaII5bSggpkHTza1oW3UH03GXzXSxH2i75IhDKVBAJbTDG1V1XZiPMMV5zOw
        DAXRFx6Xq9mzOeJ17jaL/cnqSNRBWWMvLeKeQVhpAmOnckAbt+ljtVwN0u9/csW807gEgMZNO3fe6
        QxyBw8vJ9juiJcXcGSJzbXl+umz4/59a37wesfZziNb/HzqBAVKYVVs/+LLFpXLSJws9i84xJkYps
        2m3/ADjpGOk4GFVzdYMyHPwa0smEXnLjJHN0VV7dYveJY4oFIRfSmIcCJd2TdatQlNRhdmGmrjhU1
        6e3OucOw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojHBp-007W5e-7x; Fri, 14 Oct 2022 09:41:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C02630015F;
        Fri, 14 Oct 2022 11:41:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FA042BDDD449; Fri, 14 Oct 2022 11:41:06 +0200 (CEST)
Date:   Fri, 14 Oct 2022 11:41:06 +0200
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
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <Y0kusvhDIRQxB2+h@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:07PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> There is essentially no room left in the x86 hardware PTEs on some OSes
> (not Linux). That left the hardware architects looking for a way to
> represent a new memory type (shadow stack) within the existing bits.
> They chose to repurpose a lightly-used state: Write=0,Dirty=1.
> 
> The reason it's lightly used is that Dirty=1 is normally set _before_ a
> write. A write with a Write=0 PTE would typically only generate a fault,
> not set Dirty=1. Hardware can (rarely) both set Write=1 *and* generate the

s/Write/Dirty/

> fault, resulting in a Dirty=0,Write=1 PTE. Hardware which supports shadow

s/Dirty=0,Write=1/Write=0,Dirty=1/

> stacks will no longer exhibit this oddity.
> 
> The kernel should avoid inadvertently creating shadow stack memory because
> it is security sensitive. So given the above, all it needs to do is avoid
> manually crating Write=0,Dirty=1 PTEs in software.

Whichever way around you choose, please be consistent.

> In places where Linux normally creates Write=0,Dirty=1, it can use the
> software-defined _PAGE_COW in place of the hardware _PAGE_DIRTY. In other
> words, whenever Linux needs to create Write=0,Dirty=1, it instead creates
> Write=0,Cow=1 except for shadow stack, which is Write=0,Dirty=1. This
> clearly separates shadow stack from other data, and results in the
> following:
> 
> (a) (Write=0,Cow=1,Dirty=0) A modified, copy-on-write (COW) page.
>     Previously when a typical anonymous writable mapping was made COW via
>     fork(), the kernel would mark it Write=0,Dirty=1. Now it will instead
>     use the Cow bit.
> (b) (Write=0,Cow=1,Dirty=0) A R/O page that has been COW'ed. The user page
>     is in a R/O VMA, and get_user_pages() needs a writable copy. The page
>     fault handler creates a copy of the page and sets the new copy's PTE
>     as Write=0 and Cow=1.
> (c) (Write=0,Cow=0,Dirty=1) A shadow stack PTE.
> (d) (Write=0,Cow=1,Dirty=0) A shared shadow stack PTE. When a shadow stack
>     page is being shared among processes (this happens at fork()), its PTE
>     is made Dirty=0, so the next shadow stack access causes a fault, and
>     the page is duplicated and Dirty=1 is set again. This is the COW
>     equivalent for shadow stack pages, even though it's copy-on-access
>     rather than copy-on-write.
> (e) (Write=0,Cow=0,Dirty=1) A Cow PTE created when a processor without
>     shadow stack support set Dirty=1.

Please restureture this (and the comment) something like:


  (Write=0,Dirty=0,Cow=1):

	- copy_present_pte(): A modified copy-on-write page.
	- ...


  (Write=0,Dirty=1,Cow=0):

	- FEATURE_CET:  Shadow Stack entry
	- !FEATURE_CET: see the above Cow=1 cases


