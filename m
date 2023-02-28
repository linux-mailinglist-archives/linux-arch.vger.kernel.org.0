Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53D6A5754
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 11:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjB1K6u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 05:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjB1K6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 05:58:40 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7130F3;
        Tue, 28 Feb 2023 02:58:32 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D566B1EC067E;
        Tue, 28 Feb 2023 11:58:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1677581910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8M3tlnbS9Pz471dSvOzN4aKK6qk+Uej9KAtfSfq3hVM=;
        b=AoiltTMvFbe/f/ypMXgOnhHwt+phRCl8mXS5lx3DkxlOxvdf31/yUuFf6amM69Bov1xqnP
        44Md0Q+v9X6VCHe229Cfao5EsmCUhy/O+5uqW3SelHzpFRnaj/yN+ErabZpQAMGomc7Rfb
        noGKmIIfKLYOoiyBdkJwLQWaY5b+Os8=
Date:   Tue, 28 Feb 2023 11:58:25 +0100
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
Subject: Re: [PATCH v6 28/41] x86: Introduce userspace API for shadow stack
Message-ID: <Y/3eUQEV95gZEoaF@zn.tnic>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-29-rick.p.edgecombe@intel.com>
 <Y/irg8d6OZ+OCFml@zn.tnic>
 <9c67abd16cce9251bfdb87bcc7e47bbf32e4a9f2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c67abd16cce9251bfdb87bcc7e47bbf32e4a9f2.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 24, 2023 at 06:37:57PM +0000, Edgecombe, Rick P wrote:
> In the first patch:
> 
> https://lore.kernel.org/lkml/20230218211433.26859-2-rick.p.edgecombe@intel.com/
> 
> Then some more documentation is added about ARCH_SHSTK_UNLOCK and
> ARCH_SHSTK_STATUS (which are for CRIU) in those patches.

Right, I was thinking more about ARCH_PRCTL(2), the man page.

But you can send that to the manpages folks later. I.e., it should be
nearly impossible to be missed. :)

> There are glibc patches prepared by HJ to use the new interface and
> it's my understanding that he has discussed the changes with the other
> glibc folks. Those glibc patches are used for testing these kernel
> patches, but will not get upstream until the kernel patches to avoid
> repeating the past problems. So I think it's as prepared as it can be.

Good.

> One future thing that might come up... Glibc has this mode called
> "permissive mode". When glibc is configured this way (compile time or
> env var), it is supposed to disable shadow stack when dlopen()ing any
> DSO that doesn't have the shadow stack elf header bit.

Maybe I don't understand all the possible use cases but if I were
interested in using shadow stack, then I'd enable it for all objects.
And if I want permissive, I'd disable it for all. A mixed thing sounds
like a mixed can of worms waiting to be opened.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
