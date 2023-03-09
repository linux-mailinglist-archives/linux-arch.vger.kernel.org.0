Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D9F6B24C2
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 13:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjCIM7U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 07:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCIM6p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 07:58:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259C613DDA;
        Thu,  9 Mar 2023 04:57:57 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3A8A1EC06C2;
        Thu,  9 Mar 2023 13:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678366675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xQyqIfhwDtsH4v2hzkG71ZUDZ3mfvpSPc21bFOtyc8o=;
        b=fDFEvQtHUkVd5hg2jwozRJNNeYEmJDaydIMnUV32Y1pbRgJfDXS1H4M5nX/CfYRKoCVihb
        3ILX6KDKna6HwzKfng8Lw9jZ4oJyDn4iE9ih6v1/O7oCyW0hud4Jdm2vA1Y/q2Yt7FNSO6
        8eSpKHVFnsUjVrFxdxE+EIORJXWBCZw=
Date:   Thu, 9 Mar 2023 13:57:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH v7 28/41] x86: Introduce userspace API for shadow stack
Message-ID: <20230309125739.GCZAnXw5T1dfzwtqh8@fat_crate.local>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-29-rick.p.edgecombe@intel.com>
 <ZAhjLAIm91rJ2Lpr@zn.tnic>
 <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e00b2a3d988f7b24d274a108d31f5f0096eeaae.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 08, 2023 at 11:32:36PM +0000, Edgecombe, Rick P wrote:
> This would be for things like the "permissive mode", where glibc
> determines that it has to do something like dlopen() an unsupporting
> DSO much later.
> 
> But being able to late lock the features is required for the working
> behavior of glibc as well. Glibc enables shadow stack very early, then
> disables it later if it finds that any of the normal dynamic libraries
> don't support it. It only locks shadow stack after this point even in
> non-permissive mode.

So this all sounds weird. Especially from a user point of view.

Now let's imagine there's a Linux user called Boris and he goes and buys
a CPU which supports shadow stack, gets a distro which has shadow stack
enabled. All good.

Now, at some point he loads a program which pulls in an old library
which hasn't been enabled for shadow stack yet.

In the name of not breaking stuff, his glibc is configured in permissive
mode by default so that program loads and shadow stack for it is
disabled.

And Boris doesn't even know and continues on his merry way thinking that
he has all that cool ROP protection.

So where is the knob that says, "disable permissive mode"?

Or at least where does the user get a warning saying, "hey, this app
doesn't do shadow stack and we disabled it for ya so that it can still
work"?

Or am I way off?

I hope you're catching my drift. Because if there's no enforcement of
shstk and we do this permissive mode by default, this whole overhead is
just a unnecessary nuisance...

But maybe that'll come later and I should keep going through the set...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
