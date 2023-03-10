Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FDC6B3E2F
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 12:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCJLlq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 06:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCJLlM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 06:41:12 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659324712;
        Fri, 10 Mar 2023 03:41:02 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E8241EC0505;
        Fri, 10 Mar 2023 12:41:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678448461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aKpednaPACF1732v54TE1hryNVD7OhQPM/LLNaZm8es=;
        b=PkyOcRMZ+D8wX8CPrudIUxN7r3RAUM2G5EaHyz4Wkhd43r68Wqa8HFM4QXt1TMzCBdFu7n
        y++yFwAg6tFulnPDx5FJKV3NYcyRQINJpFEgTQpcCmPAiVIFg/71JqrhsNydRvTJKb26s8
        vo0fFTAD6LwoT9NlYYQGVnvx7iTdbn8=
Date:   Fri, 10 Mar 2023 12:40:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Message-ID: <20230310114055.GAZAsXR8cc3gLAZ8c0@fat_crate.local>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com>
 <ZAhjLAIm91rJ2Lpr@zn.tnic>
 <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
 <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
 <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
 <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local>
 <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e83ee9fc1a6e98cab62b681de7209598394df911.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 10, 2023 at 01:13:42AM +0000, Edgecombe, Rick P wrote:
> See "x86: Expose thread features in /proc/$PID/status" for the patch.
> We could emit something in dmesg I guess? The logic would be:

dmesg is just flaky: ring buffer can get overwritten, users don't see
it, ...

> The compatibility problems are totally the mess in this whole thing.
> When you try to look at a "permissive" mode that actually works it gets
> even more complex. Joao and I have been banging our heads on that
> problem for months.

Oh yeah, I'm soo NOT jealous. :-\

> But there are some expected users of this that say: we compile and
> check our known set of binaries, we won't get any surprises. So it's
> more of a distro problem.

I'm guessing what will happen here is that distros will gradually enable
shstk and once it is ubiquitous, there will be no reason to disable it
at all.

> You mean a late loaded dlopen()ed DSO? The enabling logic can't know
> this will happen ahead of time.

No, I meant the case where you start with shstk enabled and later
disable it when some lib does not support it.

From now on that whole process is marked as "cannot use shstk anymore"
and any other shared object that tries to use shstk simply doesn't get
it.

But meh, this makes the situation even more convoluted as the stuff that
has loaded before the first shstk-not-supporting lib, already uses
shstk.

So you have half and half.

What a mess.

> I hope non-permissive mode is the standard usage eventually.

Yah.

> I think if you trust your libc, glibc could implement this in userspace
> too. It would be useful even as as testing override.

No, you cannot trust any userspace. And there are other libc's beside
glibc.

This should be a kernel parameter. I'm not saying we should do it now
but we should do it at some point.

So that user Boris again, he installs his new shiny distro, he checks
that all the use cases and software he uses there is already
shstk-enabled and then he goes and builds the kernel with

	CONFIG_X86_USER_SHADOW_STACK_STRICT=y

or supplies a cmdline param and from now on, nothing can run without
shstk. No checking, no trusting, no nothing.

We fail any thread creation which doesn't init shstk.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
