Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38EA690B5A
	for <lists+linux-arch@lfdr.de>; Thu,  9 Feb 2023 15:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBIOI6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Feb 2023 09:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBIOI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2023 09:08:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB215DC0D;
        Thu,  9 Feb 2023 06:08:46 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 732E81EC06C0;
        Thu,  9 Feb 2023 15:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675951725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xou1RB46SDCgtcotYrQGJuKVYx7el1N56OECne0l+5Q=;
        b=DlH5Jenzb+b48eoxSOSc/kjrv112GJSGTCU9Q9mdQSdRgxeL9ZhklF4x+j5/OTdI/oVPtQ
        gX3ifob7NPiXXNoUJ964/uOTG2j1sf1Uv5GUecaxLhjXHdOMjeNW9hFjFGQdJrjlMpY0au
        M8VjkBac09LEvoBcFVh9jkVrgJ/GBuE=
Date:   Thu, 9 Feb 2023 15:08:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v5 11/39] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <Y+T+ZxydCZS1Yjmz@zn.tnic>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-12-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-12-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:49PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The Write=0,Dirty=1 PTE has been used to indicate copy-on-write pages.
> However, newer x86 processors also regard a Write=0,Dirty=1 PTE as a
> shadow stack page. In order to separate the two, the software-defined
> _PAGE_DIRTY is changed to _PAGE_COW for the copy-on-write case, and
> pte_*() are updated to do this.

"In order to separate the two, change the software-defined ..."

From section "2) Describe your changes" in
Documentation/process/submitting-patches.rst:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

> +static inline pte_t __pte_mkdirty(pte_t pte, bool soft)
> +{
> +	pteval_t dirty = _PAGE_DIRTY;
> +
> +	if (soft)
> +		dirty |= _PAGE_SOFT_DIRTY;
> +
> +	return pte_set_flags(pte, dirty);
> +}

Dunno, do you even need that __pte_mkdirty() helper?

AFAIU, pte_mkdirty() will always set _PAGE_SOFT_DIRTY too so whatever
the __pte_mkdirty() thing needs to do, you can simply do it by foot in
the two callsites.

And this way you won't have the confusion: should I use pte_mkdirty() or
__pte_mkdirty()?

Ditto for the pmd variants.

Otherwise, this is starting to make more sense now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
