Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DFC53902A
	for <lists+linux-arch@lfdr.de>; Tue, 31 May 2022 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344064AbiEaMAJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 May 2022 08:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiEaL77 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2022 07:59:59 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E514B876;
        Tue, 31 May 2022 04:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6DBFCE0E9F;
        Tue, 31 May 2022 11:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAAAC385A9;
        Tue, 31 May 2022 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653998394;
        bh=7Lbe2zyNQ0rV/hxwT06A/1O3dq6x6sIy9gX8/rG0xtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tmy2IrqB7ccOQs5HHqYf6TgLGfnXAIJZtPc+/nGbbCvo8aX1LEZimBe88wqFy9V+C
         uvtv6axBqQslJIEcqCmHaJugkFIWb+Z1TGJf0qmIzfM29u5W8NMrAAmC8ktgIpl75E
         gcrEmiqK0XFNQKuFpsGTYvYggWUWTxW87kTg+bDnnxhtC5uR2wiybPoB/pGb0zaA8x
         i+jCSOkZjgQgg9JGDLRgGwvKGGOSuZ8dg7B5XT3N41k+vwPDtPOWUa8GUiBlAGdxy4
         tonA882Bd2BjYe9bNLmfo/ws8UnfaLAUVImqoIdDISbcSTFxR642KkhZQ769WLFSed
         swLqoEFb/vljQ==
Date:   Tue, 31 May 2022 14:59:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
        "bp@alien8.de" <bp@alien8.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.martin@arm.com" <dave.martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YpYDKVjMEYVlV6Ya@kernel.org>
References: <Yh0wIMjFdDl8vaNM@kernel.org>
 <5a792e77-0072-4ded-9f89-e7fcc7f7a1d6@www.fastmail.com>
 <Yh0+9cFyAfnsXqxI@kernel.org>
 <05df964f-552e-402e-981c-a8bea11c555c@www.fastmail.com>
 <YiEZyTT/UBFZd6Am@kernel.org>
 <CALCETrWacW8SC2tpPxQSaLtxsOXfXHueyuwLcXpNF4aG-0ZvhA@mail.gmail.com>
 <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
 <YiZVbPwlgSFnhadv@kernel.org>
 <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

On Mon, Mar 07, 2022 at 11:07:01AM -0800, H.J. Lu wrote:
> On Mon, Mar 7, 2022 at 10:57 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Mar 04, 2022 at 11:13:19AM -0800, Andy Lutomirski wrote:
> > > On 3/3/22 17:30, Edgecombe, Rick P wrote:
> 
> Here is the CET ptrace patch on CET 5.16 kernel branch:
> 
> https://github.com/hjl-tools/linux/commit/3a43ec29ddac56f87807161b5aeafa80f632363d

It took me a while, but at last I have a version of CRIU that knows how to
handle shadow stack. For the shadow stack manipulation during dump and for
the creation of the sigframe for sigreturn I used the CET ptrace patch for
5.16 (thanks H.J).

For the restore I had to add two modifications to the kernel APIs on top of
this version of the shadow stack series:

* add address parameter to map_shadow_stack() so that it'll call mmap()
with MAP_FIXED if the address is requested. This is required to restore the
shadow stack at the same address as it was at dump time.

* add ability to unlock shadow stack features using ptrace. This is
required because the current glibc (or at least in the version I used for
tests) locks shadow stack state when it loads a program. This locking means
that a process will either have shadow stack disabled without an ability to
enable it or it will have shadow stack enabled with WRSS disabled and
again, there is no way to re-enable WRSS. With that, ptrace looked like the
most sensible interface to interfere with the shadow stack locking.

I've pushed the kernel modifications here:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=cet/kvm

and CRIU modifications here:

https://github.com/rppt/criu/tree/cet/v0.1

-- 
Sincerely yours,
Mike.
