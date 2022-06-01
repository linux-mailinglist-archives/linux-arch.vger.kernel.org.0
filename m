Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA8539EF9
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 10:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348043AbiFAIGZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiFAIGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 04:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD2A45AD5;
        Wed,  1 Jun 2022 01:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7876261457;
        Wed,  1 Jun 2022 08:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2B1C385A5;
        Wed,  1 Jun 2022 08:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654070781;
        bh=Pe+xqjlEZkEvfqPm0TvyzYDROtRhOytTmfU9fiGZws8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fffsVtEMEyvvzETBbzbLRANw5qSpp7g2hTxlgYQz+92zoX1gJ4zXLlEruzzqTTYSf
         N2BAoyYsXpTHyVPmtOwTYApytoYIJPfrTIBwv2gyDHOq/5r47nwIHZPTWZzz9zoHk9
         HIW68lMuS6J2BG6fNBdQzDZqpTs5jqdA1xRDTgQvl/O0vFZsBgZr0IZcc+8/f7VoHM
         mBF2JE0x8Ik5pv3aB1Imh9Gv7aUytp6d1jtbut/qaDi9XZTuqB7BqQSbE4OFZACvzW
         oy5d4OXtHdvuB+Q9kGqn/gRGVFqYIR5IuOvAiNdNdhEzfcmmRJPg/FEZRFrjXI8zOL
         HJ48ltR8tywIg==
Date:   Wed, 1 Jun 2022 11:06:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
Message-ID: <Ypcd8HQtrn7T41LF@kernel.org>
References: <YiEZyTT/UBFZd6Am@kernel.org>
 <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
 <YiZVbPwlgSFnhadv@kernel.org>
 <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
 <YpYDKVjMEYVlV6Ya@kernel.org>
 <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
 <YpZEDjxSPxUfMxDZ@kernel.org>
 <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 31, 2022 at 05:34:50PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2022-05-31 at 19:36 +0300, Mike Rapoport wrote:
> > > WRSS is a feature where you would usually want to lock it as
> > > disabled,
> > > but WRSS cannot be enabled if shadow stack is not enabled. Locking
> > > shadow stack and WRSS off together doesn't have any security
> > > benefits
> > > in theory. so I'm thinking glibc doesn't need to do this. The
> > > kernel
> > > could even refuse to lock WRSS without shadow stack being enabled.
> > > Could we avoid the extra ptrace functionality then?
> > 
> > What I see for is that a program can support shadow stack, glibc
> > enables
> > shadow stack, does not enable WRSS and than calls
> > 
> >         arch_prctl(ARCH_X86_FEATURE_LOCK,
> >                    LINUX_X86_FEATURE_SHSTK | LINUX_X86_FEATURE_WRSS);
> 
> I see the logic is glibc will lock SHSTK|IBT if either is enabled in
> the elf header. I guess that is why I didn't see the locking happening
> for me, because my manual enablement test doesn't have either set in
> the header.

The locking was quite a surprise for me when I moved from standalone test
to a system with CET-enabled glibc :)
 
> It can't see where that glibc knows about WRSS though...

Right, it was my mistake, as H.J. said glibc locks SHSTK and IBT.
 
> The glibc logic seems wrong to me also, because shadow stack or IBT
> could be force-disabled via glibc tunables. I don't see why the elf
> header bit should exclusively control the feature locking. Or why both
> should be locked if only one is in the header.
> 
> > 
> > so that WRSS cannot be re-enabled.
> > 
> > For the programs that do not support shadow stack, both SHSTK and
> > WRSS are
> > disabled, but still there is the same call to
> > arch_prctl(ARCH_X86_FEATURE_LOCK, ...) and then neither shadow stack
> > nor
> > WRSS can be enabled.
> > 
> > My original plan was to run CRIU with no shadow stack, enable shadow
> > stack
> > and WRSS in the restored tasks using arch_prct() and after the shadow
> > stack
> > contents is restored disable WRSS.
> > 
> > Obviously, this didn't work with glibc I have :)
> 
> Were you disabling shadow stack via glibc tunnable? Or was the elf
> header marked for IBT? If it was a plain old binary, the code looks to
> me like it should not lock any features.

I built criu as a plain old binary, there were no SHSTK or IBT markers. And
I've seen that there was a call to arch_prctl that locked the features as
disabled. 
 
> > On the bright side, having a ptrace call to unlock shadow stack and
> > wrss
> > allows running CRIU itself with shadow stack.
> 
> Yea, having something working is really great. My only hesitancy is
> that, per a discussion on the LAM patchset, we are going to make this
> enabling API CET only (same semantics for though). I suppose the
> locking API arch_prctl() could still be support other arch features,
> but it might be a second CET only regset. It's not the end of the
> world.

The support for CET in criu is anyway experimental for now, if the kernel
API will be slightly different in the end, we'll update criu.
The important things are the ability to control tracee shadow stack
from ptrace, the ability to map the shadow stack at fixed address and the
ability to control the features at least from ptrace.
As long as we have APIs that provide those, it should be Ok.
 
> I guess the other consideration is tieing CRIU to glibc peculiarities.
> Like even if we fix glibc, then CRIU may not work with some other libc
> or app that force disables for some weird reason. Is it supposed to be
> libc-agnostic?

Actually using the ptrace to control the CET features does not tie criu to
glibc. The current proposal for the arch_prctl() allows libc to lock CET
features and having a ptrace call to control the lock makes criu agnostic
to libc behaviour.

-- 
Sincerely yours,
Mike.
