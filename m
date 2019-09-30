Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013FEC207C
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2019 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfI3MSL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Sep 2019 08:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfI3MSL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 08:18:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762D62054F;
        Mon, 30 Sep 2019 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569845889;
        bh=c2OUYeKYbDh5+GWE2NV/OFHkpMhJmyVCeS5+QVpDpqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pa580s/woPLR4Dgg5jdNQ+yBigWHsZgIUlbw6ahDCv3DyWkNlG37VVXX9e1Iif3NU
         Xlrfa/addvc1VsJY6kzFvJY+U6eXAM/MFIIU3wimHEDZF34bVMz3qrZ5kGlZGeVL22
         wrx0r1+WH1cdYgaa7BdvYoqzhbo849gnBS1Gqzmo=
Date:   Mon, 30 Sep 2019 13:18:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Stefan Wahren <wahrenst@gmx.net>,
        Kees Cook <keescook@google.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20190930121803.n34i63scet2ec7ll@willie-the-truck>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
 <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 30, 2019 at 09:05:11PM +0900, Masahiro Yamada wrote:
> On Mon, Sep 30, 2019 at 8:26 PM Will Deacon <will@kernel.org> wrote:
> > On Fri, Sep 27, 2019 at 03:38:44PM -0700, Linus Torvalds wrote:
> > > Soem of that code is pretty subtle. They have fixed register usage
> > > (but the asm macros actually check them). And the inline asms clobber
> > > the link register, but they do seem to clearly _state_ that they
> > > clobber it, so who knows.
> > >
> > > Just based on the EFAULT, I'd _guess_ that it's some interaction with
> > > the domain access control register (so that get/set_domain() thing).
> > > But I'm not even sure that code is enabled for the Rpi2, so who
> > > knows..
> >
> > FWIW, we've run into issues with CONFIG_OPTIMIZE_INLINING and local
> > variables marked as 'register' where GCC would do crazy things and end
> > up corrupting data, so I suspect the use of fixed registers in the arm
> > uaccess functions is hitting something similar:
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
> 
> No. Not similar at all.

They're similar in that enabling CONFIG_OPTIMIZE_INLINING causes register
variables to go wrong. I agree that the ARM code looks dodgy with
that call to uaccess_save_and_enable(), but there are __asmeq macros
in there to try to catch that, so it's still very fishy.

> I fixed it already. See
> https://lore.kernel.org/patchwork/patch/1132459/

You fixed the specific case above for 32-bit ARM, but the arm64 case
is due to a compiler bug. As it happens, we've reworked our atomics
in 5.4 so that particular issue no longer triggers, but the fact remains
that GCC has been shown to screw up explicit register allocation for
perfectly legitimate code when giving the flexibility to move code out
of line.

> The problems are fixable by writing correct code.

Right, in the compiler ;)

> I think we discussed this already.

We did?

> - There is nothing arch-specific in CONFIG_OPTIMIZE_INLINING

Apart from the bugs... and even then, that's just based on reports.

> - 'inline' is just a hint. It does not guarantee function inlining.
>   This is standard.
> 
> - The kernel macrofies 'inline' to add __attribute__((__always_inline__))
>   This terrible hack must end.

I'm all for getting rid of hacks, but not at the cost of correctness.

> -  __attribute__((__always_inline__)) takes aways compiler's freedom,
>    and prevents it from optimizing the code for -O2, -Os, or whatever.

s/whatever/miscompiling the code/

If it helps, here is more information about the arm64 failure which
triggered the GCC bugzilla:

https://www.spinics.net/lists/arm-kernel/msg730329.html

Will
