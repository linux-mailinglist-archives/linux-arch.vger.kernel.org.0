Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3D86B3267
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 00:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjCIXwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 18:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjCIXwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 18:52:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22281102A5;
        Thu,  9 Mar 2023 15:51:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7096C1EC01CE;
        Fri, 10 Mar 2023 00:51:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678405917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2DAEMT8RlTvZl2+BqR845kghr2jrP8dvdCHxG77kors=;
        b=sNT2LjHr1xLCN8Hf+/O17MPOKXi8ykZLPI6+jeKeL8xBpnmXy8pmPgMKial0vCUmOIZ4Wn
        bykEQ5qA2QURxyKkcsl6dKoxr1bpvbycgolJ7SH8Jb81EfLPGAYWA9fSWN7qB6lmEiYVoi
        gUxgyBMJWKuf708XZCKlWUw/EPvJaAM=
Date:   Fri, 10 Mar 2023 00:51:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Message-ID: <20230309235152.GBZApxGNnXLvkGXCet@fat_crate.local>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com>
 <ZAhjLAIm91rJ2Lpr@zn.tnic>
 <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
 <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
 <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4dd415ac908450b09b9abbd4421a9132b3c34cc.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 09, 2023 at 04:56:37PM +0000, Edgecombe, Rick P wrote:
> There is a proc that shows if shadow stack is enabled in a thread. It
> does indeed come later in the series.

Not good enough:

1. buried somewhere in proc where no one knows about it

2. it is per thread so user needs to grep *all*

>  ... We previously tried to add some batch operations to improve the
>  performance, but tglx had suggested to start with something simple.
>  So we end up with this simple composable API.

I agree with starting simple and thanks for explaining this in detail.

TBH, though, it already sounds like a mess to me. I guess a mess we'll
have to deal with because there will always be this case of some
shared object/lib not being enabled for shstk because of raisins.

And TBH #2, I would've done it even simpler: if some shared object can't
do shadow stack, we disable it for the whole process. I mean, what's the
point? Only some of the stack is shadowed so an attacker could find
a way to keep the process perhaps run this shstk-unsupporting shared
object more/longer and ROP its way around the system.

But I tend to oversimplify things sometimes so...

What I'd like to have, though, is a kernel cmdline param which disables
permissive mode and userspace can't do anything about it. So that once
you boot your kernel, you can know that everything that runs on the
machine has shstk and is properly protected.

Also, it'll allow for faster fixing of all those shared objects to use
shstk by way of political pressure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
