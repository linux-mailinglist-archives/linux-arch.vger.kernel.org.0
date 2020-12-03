Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F842CDD4D
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 19:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgLCSXl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 13:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgLCSXk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Dec 2020 13:23:40 -0500
Date:   Thu, 3 Dec 2020 18:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607019780;
        bh=5a8ME2oAXsKqPoeqJfEFvJGi2qwglFd3HcH42x+ZJqE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4tuv3canVKeGWPc00whrPf+yMo+rCeJBSSu9hQ8JKopGOeh22g/l4jLBxki+Q3S4
         GSy6xiQfH2GEr5ORIucdbbEVNr0+FmT1NytvINuFt62ibIHSwQQe+XYxmKQbFUBoQm
         Pe3O1nyWoKMJPEEb4rf10UT8GM0TMsNCoKs0CA1Y6VDqMD3Fa15DWO2+8KzDpouaH/
         jk1NY9n6DPz7lGFPTSZZ3NhJoqHMrLxT9UBGdtIKfzs7C+/Z/dfeNnE5pmTpJgadKr
         WuTbKHZQrQHeug6qVN5E7eo5w7WLqpt9nlELvChtCWZI3JyjnMxiQXEC4zYRHhnct0
         /Nj+EdgBLhJYA==
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
Message-ID: <20201203182252.GA32011@willie-the-truck>
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck>
 <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 03, 2020 at 09:07:30AM -0800, Sami Tolvanen wrote:
> On Thu, Dec 3, 2020 at 3:26 AM Will Deacon <will@kernel.org> wrote:
> > On Tue, Dec 01, 2020 at 01:36:51PM -0800, Sami Tolvanen wrote:
> > > This patch series adds support for building the kernel with Clang's
> > > Link Time Optimization (LTO). In addition to performance, the primary
> > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> > > to be used in the kernel. Google has shipped millions of Pixel
> > > devices running three major kernel versions with LTO+CFI since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM
> > > bitcode, which Clang produces with LTO instead of ELF object files,
> > > postponing ELF processing until a later stage, and ensuring initcall
> > > ordering.
> > >
> > > Note that arm64 support depends on Will's memory ordering patches
> > > [1]. I will post x86_64 patches separately after we have fixed the
> > > remaining objtool warnings [2][3].
> >
> > I took this series for a spin, with my for-next/lto branch merged in but
> > I see a failure during the LTO stage with clang 11.0.5 because it doesn't
> > understand the '.arch_extension rcpc' directive we throw out in READ_ONCE().
> 
> I just tested this with Clang 11.0.0, which I believe is the latest
> 11.x version, and the current Clang 12 development branch, and both
> work for me. Godbolt confirms that '.arch_extension rcpc' is supported
> by the integrated assembler starting with Clang 11 (the example fails
> with 10.0.1):
> 
> https://godbolt.org/z/1csGcT
> 
> What does running clang --version and ld.lld --version tell you?

I'm using some Android prebuilts I had kicking around:

Android (6875598, based on r399163b) clang version 11.0.5 (https://android.googlesource.com/toolchain/llvm-project 87f1315dfbea7c137aa2e6d362dbb457e388158d)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/google/home/willdeacon/work/android/repo/android-kernel/prebuilts-master/clang/host/linux-x86/clang-r399163b/bin

and:

LLD 11.0.5 (/buildbot/tmp/tmpx1DlI_ 87f1315dfbea7c137aa2e6d362dbb457e388158d) (compatible with GNU linkers)

> > We actually check that this extension is available before using it in
> > the arm64 Kconfig:
> >
> >         config AS_HAS_LDAPR
> >                 def_bool $(as-instr,.arch_extension rcpc)
> >
> > so this shouldn't happen. I then realised, I wasn't passing LLVM_IAS=1
> > on my Make command line; with that, then the detection works correctly
> > and the LTO step succeeds.
> >
> > Why is it necessary to pass LLVM_IAS=1 if LTO is enabled? I think it
> > would be _much_ better if this was implicit (or if LTO depended on it).
> 
> Without LLVM_IAS=1, Clang uses two different assemblers when LTO is
> enabled: the external GNU assembler for stand-alone assembly, and
> LLVM's integrated assembler for inline assembly. as-instr tests the
> external assembler and makes an admittedly reasonable assumption that
> the test is also valid for inline assembly.
> 
> I agree that it would reduce confusion in future if we just always
> enabled IAS with LTO. Nick, Nathan, any thoughts about this?

That works for me, although I'm happy with anything which means that the
assembler checks via as-instr apply to the assembler which will ultimately
be used.

Will
