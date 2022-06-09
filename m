Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345E45453A5
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jun 2022 20:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243660AbiFISE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jun 2022 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiFISE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2022 14:04:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEDC20014D;
        Thu,  9 Jun 2022 11:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68E1661D06;
        Thu,  9 Jun 2022 18:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27328C34114;
        Thu,  9 Jun 2022 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654797889;
        bh=pASgOkIhhI/ZJTQJiOxQQ7BetAsfgOyqGy5+OxBbrvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BTB64wygOFCsPdDhaQrt8ga2Ig64u/kXZw4tZeGJT0YWnHOFEVrA9wtMwDaA4po75
         tHkRwZ4Z1OS5DEp1vz0DLZjhsVFXOj9cWFGJqF8h1e4ExnGDlLM66vc852A7UGTVkV
         yEz7FlAClMKRrohieUz/v2D/e1sIUfPAptFYdXD6e5jM5B9XSjou+kMB5JSzyCWkav
         Vy3bM2wpcA65mdDfoHZTzmvQ2m/dzKtFKO6ebtcmQ6ve9Ss5LpTv7FPNvFa0fZq3IE
         X+WdUzskIEX0iCxmt+US9NfG657DMkWYw8HIeB0mVRrH72fJJ6NrdiTApIn1c/+71Q
         Z1MZF3k8udZcQ==
Date:   Thu, 9 Jun 2022 21:04:34 +0300
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
Message-ID: <YqI2MgV9S1iQR9Mq@kernel.org>
References: <fb7d6e4da58ae77be2c6321ee3f3487485b2886c.camel@intel.com>
 <40a3500c-835a-60b0-15bf-40c6622ad013@kernel.org>
 <YiZVbPwlgSFnhadv@kernel.org>
 <CAMe9rOrSLPKdL2gL=yx84zrs-u6ch1AVvjk3oqUe3thR5ZD=dQ@mail.gmail.com>
 <YpYDKVjMEYVlV6Ya@kernel.org>
 <d0c94eed6e3c7f35b78bab3f00aadebd960ee0d8.camel@intel.com>
 <YpZEDjxSPxUfMxDZ@kernel.org>
 <7c637f729e14f03d0df744568800fc986542e33d.camel@intel.com>
 <Ypcd8HQtrn7T41LF@kernel.org>
 <1d77dcab5d5ee7c565cfc62601d3a28ecf5a6bed.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d77dcab5d5ee7c565cfc62601d3a28ecf5a6bed.camel@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 01, 2022 at 05:24:26PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2022-06-01 at 11:06 +0300, Mike Rapoport wrote:
> > > Yea, having something working is really great. My only hesitancy is
> > > that, per a discussion on the LAM patchset, we are going to make
> > > this
> > > enabling API CET only (same semantics for though). I suppose the
> > > locking API arch_prctl() could still be support other arch
> > > features,
> > > but it might be a second CET only regset. It's not the end of the
> > > world.
> > 
> > The support for CET in criu is anyway experimental for now, if the
> > kernel
> > API will be slightly different in the end, we'll update criu.
> > The important things are the ability to control tracee shadow stack
> > from ptrace, the ability to map the shadow stack at fixed address and
> > the
> > ability to control the features at least from ptrace.
> > As long as we have APIs that provide those, it should be Ok.
> >  
> > > I guess the other consideration is tieing CRIU to glibc
> > > peculiarities.
> > > Like even if we fix glibc, then CRIU may not work with some other
> > > libc
> > > or app that force disables for some weird reason. Is it supposed to
> > > be
> > > libc-agnostic?
> > 
> > Actually using the ptrace to control the CET features does not tie
> > criu to
> > glibc. The current proposal for the arch_prctl() allows libc to lock
> > CET
> > features and having a ptrace call to control the lock makes criu
> > agnostic
> > to libc behaviour.
> 
> From staring at the glibc code, I'm suspicious something was weird with
> your test setup, as I don't think it should be locking. But I guess to
> be completely proper you would need to save and restore the lock state
> anyway. So, ok yea, on balance probably better to have an extra
> interface.
> 
> Should we make it a GET/SET interface?

Yes, I think so.

-- 
Sincerely yours,
Mike.
