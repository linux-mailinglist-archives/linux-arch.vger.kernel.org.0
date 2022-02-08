Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D904AD500
	for <lists+linux-arch@lfdr.de>; Tue,  8 Feb 2022 10:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355100AbiBHJb7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Feb 2022 04:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354933AbiBHJb5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Feb 2022 04:31:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DBEC03FECE;
        Tue,  8 Feb 2022 01:31:41 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644312700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/6XqdlLk396Y2QV/u0CviHdgHbavtEEfHO99e5VpJc=;
        b=CmLoRoLkw9ZPal5/x5vYmdWovEEjkL22TdXDf3Bz5mlZfXlyt/sMLDc0uEJIVAodf+LWrE
        HgkJZludL/EhO9uJA0YLtM8QVA4heoIJNY1NefW+kfLlckpXfiAP7lO2Dcku6F66XMwMRq
        o/wVlYgTrmhT2C5SWnBcyAqQGVrrJDAOWdLCmZSb+M5A0ReRjGX/poGxnMwDe8HlVuOzfG
        HsvCPtALHi0fb0j4MvIFLzL//G/nsR0nxEgLhD0plKyEHHOHFo0+X8BOqt7BaP8TvXZcXA
        E63QNZ+qJ51B7WlphbW+fJCrUi5OW8k3WD42qk3vQ1PqWrlOfX4PK0b65cozlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644312700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H/6XqdlLk396Y2QV/u0CviHdgHbavtEEfHO99e5VpJc=;
        b=bHhv8L+M3WgmMTbcDFVYRJHeq1WUkvHtzrNL3+LG8QxP8fqsZV0dX9MvnHHnd0sc5AgSIO
        Oga7MeFeLvO8DpDg==
To:     Andy Lutomirski <luto@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        Adrian Reber <adrian@lisas.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
In-Reply-To: <6ba06196-0756-37a4-d6c4-2e47e6601dcd@kernel.org>
References: <87fsozek0j.ffs@tglx>
 <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
 <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
 <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
 <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
 <6ba06196-0756-37a4-d6c4-2e47e6601dcd@kernel.org>
Date:   Tue, 08 Feb 2022 10:31:39 +0100
Message-ID: <87mtj1vh50.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 07 2022 at 17:31, Andy Lutomirski wrote:
> So this leaves altshadowstack.  If we want to allow userspace to handle 
> a shstk overflow, I think we need altshadowstack.  And I can easily 
> imagine signal handling in a coroutine or user-threading evironment (Go? 
> UMCG or whatever it's called?) wanting this.  As noted, this obnoxious 
> Andy person didn't like putting any shstk-related extensions in the FPU 
> state.
>
> For better or for worse, altshadowstack is (I think) fundamentally a new 
> API.  No amount of ucontext magic is going to materialize an entire 
> shadow stack out of nowhere when someone calls sigaltstack().  So the 
> questions are: should we support altshadowstack from day one and, if so, 
> what should it look like?

I think we should support them from day one.

> So I don't have a complete or even almost complete design in mind, but I 
> think we do need to make a conscious decision either to design this 
> right or to skip it for v1.

Skipping it might create a fundamental design fail situation as it might
require changes to the shadow stack signal handling in general which
becomes a nightmare once a non-altstack API is exposed.

> As for CRIU, I don't think anyone really expects a new kernel, running 
> new userspace that takes advantage of features in the new kernel, to 
> work with old CRIU.

Yes, CRIU needs updates, but what ensures that CRIU managed user space
does not use SHSTK if CRIU is not updated yet?

> Upgrading to a SHSTK kernel should still allow using CRIU with
> non-SHSTK userspace, but I don't see how it's possible for CRIU to
> handle SHSTK without updates.  We should certainly do our best to make
> CRIU's life easy, though.

Handling CRIU with SHSTK enabled has to be part of the overall design
otherwise we'll either end up with horrible hacks or with a requirement
to change the V1 UAPI....

Thanks,

        tglx
