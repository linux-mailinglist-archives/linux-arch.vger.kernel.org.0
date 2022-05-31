Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5C539504
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 18:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiEaQgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 12:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbiEaQgr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 12:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CFF10D9;
        Tue, 31 May 2022 09:36:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C26160C92;
        Tue, 31 May 2022 16:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F6C385A9;
        Tue, 31 May 2022 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654015004;
        bh=Jcf1LuIwLWTXb1UhNVq0s7bFhNLHcRBB6iSYLTBW6r8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KSUdPURNff9EOMnCrpAuHsisbAE06T/UFYIm/LLXzE73yoHFoGUuI+4Y9Xpz0LvOa
         73bUC8f7imE8c/IhdCz+utlUwRSSUyLEwTJDNfHucgV+0464kkpZX1oMroDJBj5Lu8
         Ni8j70RezIuXkkG0ZJEtyNSfHNVSj32aH0iQ0DDSBw9JNhN9jqeyR9/oP6K3sCHzzC
         1trtk5oB0X9wu7YqVnVLhOlFyhDk/B/pU9zZgJ1VdaP8pARhYDIetGw/Lyk8FZ6JHh
         FX6VwivaYatuK+qD9yykDNLFmyyVpm0VjNGNUnbJG8otTNbJRO1XX1Ze7v/IhsQALd
         am/5S2QNwmIWw==
Date:   Tue, 31 May 2022 19:36:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "adrian@lisas.de" <adrian@lisas.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "avagin@gmail.com" <avagin@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YpZEDjxSPxUfMxDZ@kernel.org>
References: <Yh0+9cFyAfnsXqxI@kernel.org>
 <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
 <YiEZyTT/UBFZd6Am@kernel.org>
 <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
 <YiZVbPwlgSFnhadv@kernel.org>
 <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
 <YpYDKVjMEYVlV6Ya@kernel.org>
 <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 31, 2022 at 04:25:13PM +0000, Edgecombe, Rick P wrote:
> Mike,
> 
> Thanks for doing this. Glad to hear this is solvable with the current
> paradigm.
> 
> On Tue, 2022-05-31 at 14:59 +0300, Mike Rapoport wrote:
> > * add ability to unlock shadow stack features using ptrace. This is
> > required because the current glibc (or at least in the version I used
> > for
> > tests) locks shadow stack state when it loads a program. This locking
> > means
> > that a process will either have shadow stack disabled without an
> > ability to
> > enable it or it will have shadow stack enabled with WRSS disabled and
> > again, there is no way to re-enable WRSS. With that, ptrace looked
> > like the
> > most sensible interface to interfere with the shadow stack locking.
> 
> So whatever glibc you have lock's features even if it doesn't enable
> shadow stack? Hmm, I've not encountered this. Which glibc is it?

I use glibc from here:
https://gitlab.com/x86-glibc/glibc/, commit b6f9a22a00c1f8ae8c0991886f0a714f2f5da002

AFAIU, it's H.J cet work.

 
> WRSS is a feature where you would usually want to lock it as disabled,
> but WRSS cannot be enabled if shadow stack is not enabled. Locking
> shadow stack and WRSS off together doesn't have any security benefits
> in theory. so I'm thinking glibc doesn't need to do this. The kernel
> could even refuse to lock WRSS without shadow stack being enabled.
> Could we avoid the extra ptrace functionality then?

What I see for is that a program can support shadow stack, glibc enables
shadow stack, does not enable WRSS and than calls

	arch_prctl(ARCH_X86_FEATURE_LOCK,
		   LINUX_X86_FEATURE_SHSTK | LINUX_X86_FEATURE_WRSS);

so that WRSS cannot be re-enabled.

For the programs that do not support shadow stack, both SHSTK and WRSS are
disabled, but still there is the same call to
arch_prctl(ARCH_X86_FEATURE_LOCK, ...) and then neither shadow stack nor
WRSS can be enabled.

My original plan was to run CRIU with no shadow stack, enable shadow stack
and WRSS in the restored tasks using arch_prct() and after the shadow stack
contents is restored disable WRSS.

Obviously, this didn't work with glibc I have :)

On the bright side, having a ptrace call to unlock shadow stack and wrss
allows running CRIU itself with shadow stack.
 
> Rick

-- 
Sincerely yours,
Mike.
