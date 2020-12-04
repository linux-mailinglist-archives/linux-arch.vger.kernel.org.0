Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FDB2CEB02
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 10:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLDJgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 04:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLDJgY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Dec 2020 04:36:24 -0500
Date:   Fri, 4 Dec 2020 09:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607074543;
        bh=KiPYOwivri/c/ItidAb+vtLMDjOCyhBGcMSitc7cncU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjN8UC0To43FRm/tsZr8kvb4HKDZZt6WfrVN1DsurESfPe+l2A94uzzhu1vPpsxIE
         SWXV209qIxN9vnROEFL2hbNTbFoFDX2aTz789bdBU7n8IEYjja66swjjuutShEenPk
         HdAj42XjCW4qxd/vLG1PP2j/ZzWjMZOk5uAeayL+wv+giLCOA8bxFRjVaGRHLozHTh
         YlQwRVBgo7c4uojoeCTTzDC1zQLC8umPbJxt9odbBalrhfUgV5LSzI9t2Ue27J/55s
         xclSHIhMn7kaICKKuX/AMEWHc4UQCP5TBXKhUl7az+NuJaijbxMdBxQnu8hmWKcpH/
         GkZxlHDT8oL8A==
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, Jian Cai <jiancai@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
Message-ID: <20201204093535.GB461@willie-the-truck>
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck>
 <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
 <20201203182252.GA32011@willie-the-truck>
 <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 03, 2020 at 02:32:13PM -0800, Nick Desaulniers wrote:
> On Thu, Dec 3, 2020 at 10:23 AM Will Deacon <will@kernel.org> wrote:
> > On Thu, Dec 03, 2020 at 09:07:30AM -0800, Sami Tolvanen wrote:
> > > Without LLVM_IAS=1, Clang uses two different assemblers when LTO is
> > > enabled: the external GNU assembler for stand-alone assembly, and
> > > LLVM's integrated assembler for inline assembly. as-instr tests the
> > > external assembler and makes an admittedly reasonable assumption that
> > > the test is also valid for inline assembly.
> > >
> > > I agree that it would reduce confusion in future if we just always
> > > enabled IAS with LTO. Nick, Nathan, any thoughts about this?
> >
> > That works for me, although I'm happy with anything which means that the
> > assembler checks via as-instr apply to the assembler which will ultimately
> > be used.
> 
> I agree with Will.

[...]

> So I'd recommend to Sami to simply make the Kconfig also depend on
> clang's integrated assembler (not just llvm-nm and llvm-ar).  If
> someone cares about LTO with Clang as the compiler but GAS as the
> assembler, then we can revisit supporting that combination (and the
> changes to KCONFIG), but it shouldn't be something we consider Tier 1
> supported or a combination that need be supported in a minimum viable
> product. And at that point we should make it avoid clang's integrated
> assembler entirely (I suspect LTO won't work at all in that case, so
> maybe even considering it is a waste of time).
> 
> One question I have to Will; if for aarch64 LTO will depend on RCpc,
> but RCpc is an ARMv8.3 extension, what are the implications for LTO on
> pre-ARMv8.3 aarch64 processors?

It doesn't depend on RCpc -- we just emit a more expensive instruction
(an RCsc acquire) if the RCpc one is not supported by both the toolchain
and the CPU. So the implication for those processors is that READ_ONCE()
may be more expensive.

Will
