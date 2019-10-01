Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33507C3DB1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2019 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfJARBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Oct 2019 13:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbfJARBu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Oct 2019 13:01:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D082054F;
        Tue,  1 Oct 2019 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569949308;
        bh=bJnGJ3RhjW/8aLO07qPZQmJNbpODR84+mvK448XA88o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yaOg32kjz9hD653NvILZdRQ7X/HdYptJmBc184vQlyHSvp23BmDSe5R8zcFK9i0hE
         qw+CdI6NHge3cdjg2NYe1TegjwR7ZTfcmqezNpCBsNxmpCQ//W7UMwX3qgDgVsOAbK
         ID0YrKYPlGuec6Xu+XKji1EYG4cwCBfmgTBjbRjw=
Date:   Tue, 1 Oct 2019 18:01:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20191001170142.x66orounxuln7zs3@willie-the-truck>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
 <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck>
 <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 01, 2019 at 09:32:25AM -0700, Nick Desaulniers wrote:
> On Tue, Oct 1, 2019 at 2:28 AM Will Deacon <will@kernel.org> wrote:
> > On Mon, Sep 30, 2019 at 02:50:10PM -0700, Nick Desaulniers wrote:
> > > In this case, if there's a known codegen bug in a particular compiler
> > > or certain versions of it, I recommend the use of either the C
> > > preprocessor or __attribute__((no_inline)) to get the desired behavior
> > > localized to the function in question, and for us to proceed with
> > > Masahiro's cleanup.
> >
> > Hmm, I don't see how that would help. The problem occurs when things
> > are moved out of line by the compiler (see below).
> 
> It's being moved out of line because __attribute__((always_inline)) or
> just inline provide no guarantees that outlining does not occur.  It
> would help to make functions that need to be inlined macros, because
> the C preprocessor doesn't have that issue.

Hmm, let me try to put it another way: enabling CONFIG_OPTIMIZE_INLINING
has been shown to cause miscompilation with many versions of GCC on arm64
because the compiler moves things out of line that it otherwise doesn't
appear to do. I don't see how __attribute__((no_inline)) helps with that,
and replacing static functions with macros isn't great for type-checking
and argument evaluation.

> > > The comment above the use of CONFIG_OPTIMIZE_INLINING in
> > > include/linux/compiler_types.h says:
> > >   * Force always-inline if the user requests it so via the .config.
> > > Which makes me grimace (__attribute__((always_inline)) doesn't *force*
> > > anything as per above), and the idea that forcing things marked inline
> > > to also be __attribute__((always_inline)) is an "optimization" (re:
> > > the name of the config; CONFIG_OPTIMIZE_INLINING) is also highly
> > > suspect.  Aggressive inlining leads to image size bloat, instruction
> > > cache and register pressure; it is not exclusively an optimization.
> >
> > Agreed on all of this, but the fact remains that GCC has been shown to
> > *miscompile* the arm64 kernel with CONFIG_OPTIMIZE_INLINING=y. Please,
> > look at this thread:
> >
> >         https://www.spinics.net/lists/arm-kernel/msg730329.html
> >         https://www.spinics.net/lists/arm-kernel/msg730512.html
> >
> > GCC decides to pull an atomic operation out-of-line and, in doing so,
> 
> If the function is incorrect unless inlined, use a macro.

The function is correct per the GCC documentation regarding register
variables and inline asm.

> > Reducing the instruction cache footprint is great, but not if the
> > resulting code is broken!
> 
> You don't have to convince compiler folks about correctness. ;)
> Correctness trumps all, especially performance.

Then why is this conversation so difficult? :(

Will
