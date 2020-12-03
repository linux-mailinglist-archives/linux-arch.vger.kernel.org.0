Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A832CE1B8
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 23:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbgLCWdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 17:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731814AbgLCWdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 17:33:12 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E74C061A53
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 14:32:26 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id h7so2754241pjk.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 14:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmvlHcKNE+BZSUGjT3sP+ZmkJmCYLaFZSs3K50hnDTw=;
        b=gelHd6qaInh1+0Ext8zSHtUHA0CRpyIahoLn7HMwpL88FRPuaOJbHgbvpU/mPnv6rc
         JDmq1lWcfLdHTHiW00ab84WZNWfxmRBQdMiRfwSCmhqVYfVK5BYC+jzJU7rzJIs63vlg
         4t4kXgHOxFDqDGk0AKqezaMriyoNAl4vb9FOekxl0nHGJadf9FLoo96xUurzNHwNm/he
         0anFKH0KDDy3IngDl5k0x78t3yl2R9D30RaM3UIfOXIHCdHKhpBCv6hJccxGRlABn5lT
         y8E0+YuzIYohvblOUc1A6w+Ys1iicN7jTt9oKLgAVuIQuL86jUXOf77ZRXjMlrjWTfsp
         eM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmvlHcKNE+BZSUGjT3sP+ZmkJmCYLaFZSs3K50hnDTw=;
        b=CN7yn1oItx35TnrUWlJJr4vxEaYcOpKoptQXMGrRn+uqfy09E4GdiJ/TJZfp+jkFKe
         /VifGkd5vXZEa2OgiSK/XLjSLoeVB7nTqtkabY1/C5pWovhMHNPq63kxXnLJJkb1vbav
         hmxwPoLXtCIuR4esq26lsz4uD3eH4EwVeCWR7cJrx4olBv2Zy53otGwz9PzWokjO2HxU
         pWO9NllVwuVyF7s9bF5QCnk8+iL819EsHS8AiKPJeGNdBwtT/+bl3lf7vIXPBUfkCGiJ
         mKWlIKB9SgpFt12At3WkQdT2FSfPWSW/2MEMNZOnBG34uGzEXHvNcrLncV7+tSJYdeEW
         WOxw==
X-Gm-Message-State: AOAM531qPApyNPk2B4F7iatJtgpjrZJDbIj4NXHDVo/H/xUzDl3oz4C3
        ubROuWZVrLtsrUv6ubbMh5WN5YnlSqiZ8JWQ7n4egQ==
X-Google-Smtp-Source: ABdhPJzyYa88Ck16OMfiImWjHg1saqlns5SObijasI5cunzYv9BUS/0tCPp8OwEvAmWGMt4Qlfzg3sgkI3wzEjOJNX0=
X-Received: by 2002:a17:90a:6fa1:: with SMTP id e30mr1244326pjk.32.1607034745179;
 Thu, 03 Dec 2020 14:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <20201203112622.GA31188@willie-the-truck> <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
 <20201203182252.GA32011@willie-the-truck>
In-Reply-To: <20201203182252.GA32011@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Dec 2020 14:32:13 -0800
Message-ID: <CAKwvOdnvq=L=gQMv9MHaStmKMOuD5jvffzMedhp3gytYB6R7TQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 3, 2020 at 10:23 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Dec 03, 2020 at 09:07:30AM -0800, Sami Tolvanen wrote:
> > On Thu, Dec 3, 2020 at 3:26 AM Will Deacon <will@kernel.org> wrote:
> > > I took this series for a spin, with my for-next/lto branch merged in but
> > > I see a failure during the LTO stage with clang 11.0.5 because it doesn't
> > > understand the '.arch_extension rcpc' directive we throw out in READ_ONCE().
> >
> > I just tested this with Clang 11.0.0, which I believe is the latest
> > 11.x version, and the current Clang 12 development branch, and both
> > work for me. Godbolt confirms that '.arch_extension rcpc' is supported
> > by the integrated assembler starting with Clang 11 (the example fails
> > with 10.0.1):
> >
> > https://godbolt.org/z/1csGcT
> >
> > What does running clang --version and ld.lld --version tell you?
>
> I'm using some Android prebuilts I had kicking around:
>
> Android (6875598, based on r399163b) clang version 11.0.5 (https://android.googlesource.com/toolchain/llvm-project 87f1315dfbea7c137aa2e6d362dbb457e388158d)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /usr/local/google/home/willdeacon/work/android/repo/android-kernel/prebuilts-master/clang/host/linux-x86/clang-r399163b/bin
>
> and:
>
> LLD 11.0.5 (/buildbot/tmp/tmpx1DlI_ 87f1315dfbea7c137aa2e6d362dbb457e388158d) (compatible with GNU linkers)

On Thu, Dec 3, 2020 at 10:22 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> 11.0.5 is AOSP's clang, which is behind the upstream 11.0.0 release so
> it is most likely the case that it is missing the patch that added rcpc.
> I think that a version based on the development branch (12.0.0) is in
> the works but I am not sure.

Yep, I have a lot of thoughts on the AOSP LLVM versioning scheme, but
they're not for LKML.  That's yet another reason to prefer feature
detection as opposed to brittle version checks.  Of course, as Will
points out, if your feature detection is broken, that helps no
one...more thoughts below.

> > > We actually check that this extension is available before using it in
> > > the arm64 Kconfig:
> > >
> > >         config AS_HAS_LDAPR
> > >                 def_bool $(as-instr,.arch_extension rcpc)
> > >
> > > so this shouldn't happen. I then realised, I wasn't passing LLVM_IAS=1
> > > on my Make command line; with that, then the detection works correctly
> > > and the LTO step succeeds.
> > >
> > > Why is it necessary to pass LLVM_IAS=1 if LTO is enabled? I think it
> > > would be _much_ better if this was implicit (or if LTO depended on it).
> >
> > Without LLVM_IAS=1, Clang uses two different assemblers when LTO is
> > enabled: the external GNU assembler for stand-alone assembly, and
> > LLVM's integrated assembler for inline assembly. as-instr tests the
> > external assembler and makes an admittedly reasonable assumption that
> > the test is also valid for inline assembly.
> >
> > I agree that it would reduce confusion in future if we just always
> > enabled IAS with LTO. Nick, Nathan, any thoughts about this?
>
> That works for me, although I'm happy with anything which means that the
> assembler checks via as-instr apply to the assembler which will ultimately
> be used.

I agree with Will.

I think interoperability of tools is important.  We should be able to
mix tools from GNU and LLVM and produce working images. Specifically,
combinations like gcc+llvm-nm+as+llvm-objcopy, or clang+nm+as+objcopy
as two examples.  There's a combinatorial explosion of combinations to
test/validate, which we're not doing today, but if for some reason
someone wants to use some varied combination and it doesn't work, it's
worthwhile to understand the differences and issues and try to fix
them.  That is a win for optionality and loose coupling.

That's not what's going on here though.

While I think it's ok to select a compiler and assembler and linker
etc from ecosystem or another, I think trying to support a build that
mixes or uses different assemblers (or linkers, compilers, etc) from
both for the same build is something we should draw a line in the sand
and explicitly not support (except for the compat vdso's*...).  ie. if
I say `make LD=ld.bfd` and ld.lld gets invoked somehow (or vice
versa); I consider that a bug in KBUILD.

That is what's happening here, it's why as-instr feature detection is
broken; because two different assemblers were used in the same build.
One for inline asm, a different one for out of line asm.  At the very
least, it violates the Principle of Least Surprise (or is it the Law
of Equivalent Exchange, I forget).

In fact, lots of the work we've been doing to enable LLVM tools to
build the kernel have been identifying places throughout KBUILD where
tools were hardcoded rather than using what make was told to use, and
we've been making progress fixing those.  The ultimate test of Linux
kernel build hermiticity IMO is that I should be able to build a
kernel in an environment that only has one version of either
GCC/binutils or LLVM, and the kernel should build without failure.
That's not the case today for all arch's; cross compiling compat vdsos
again are a major pain point*, but we're making progress.  In that
sense, the mixing of an individual GNU and LLVM utility is what I
would consider a bug in KBUILD.  I want to emphasize that's distinct
from mixing and matching tools when invoking make, which I consider
OK, if under-tested.

Ok (mixes GNU and LLVM tools; gcc is the only compiler invoked, ld.lld
is the only linker invoked):
$ make CC=gcc LD=ld.lld

Not ok (if ld.bfd or both are invoked)
$ make LD=ld.lld

Not ok (if ld.lld or both are invoked)
$ make LD=ld.bfd

Not ok (if clang's integrated assembler and GAS are invoked)
$ ./scripts/config -e LTO_CLANG
$ make LLVM=1 LLVM_IAS=1

The mixing of GAS and clang's integrated assembler for kernel LTO
builds is a relic of a time when this series was first written when
Clang's integrated assembler was in no form ready to assemble the
entire Linux kernel, but could handle the inline asm for aarch64.
Fortunately, ARM's LLVM team has done great work to ensure the latest
extensions like RCpc are supported and compatible, and Jian has done
the hard work ironing out the last mile issues in clang's assembler to
get the ball in the end zone.  Removing mixing GAS and clang's IA here
ups the ante and removes a fallback/pressure relief valve, but I'm
fine with that.  Requiring clang's integrated assembler here aligns
incentives to keep this working and to continue investing here.

Just because it's possible to mix the use of clang's integrated
assembler with GNU assembler for LTO (for some combination of versions
of these tools) doesn't mean we should support it, or encourage it,
for all of the reasons above.  We should make this config depend on
clang's integrated assembler, and not support the mixing of assemblers
in one build.

Thou shalt not support invoking of different tools than what's
specified*.  Do not pass go, do not collect $200. Full stop.

* The compat vdso's are again a special case; when cross compiling
using GNU tools, a separate binary with a different target triple
prefix will typically get invoked than what's used to build the rest
of the kernel image.  This still doesn't cross the GNU/LLVM boundary
though, and most importantly doesn't involve linking together object
files that were built with distinct assemblers (for example).

So I'd recommend to Sami to simply make the Kconfig also depend on
clang's integrated assembler (not just llvm-nm and llvm-ar).  If
someone cares about LTO with Clang as the compiler but GAS as the
assembler, then we can revisit supporting that combination (and the
changes to KCONFIG), but it shouldn't be something we consider Tier 1
supported or a combination that need be supported in a minimum viable
product. And at that point we should make it avoid clang's integrated
assembler entirely (I suspect LTO won't work at all in that case, so
maybe even considering it is a waste of time).

One question I have to Will; if for aarch64 LTO will depend on RCpc,
but RCpc is an ARMv8.3 extension, what are the implications for LTO on
pre-ARMv8.3 aarch64 processors?
-- 
Thanks,
~Nick Desaulniers
