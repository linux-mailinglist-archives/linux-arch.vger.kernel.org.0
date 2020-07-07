Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1899721752C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 19:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgGGRaP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 13:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgGGRaO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 13:30:14 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E542075B;
        Tue,  7 Jul 2020 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594143014;
        bh=y/nx2A612UM8oaRHFRt0pVJEofy/MD08EpnGh5tjD2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vPwLy/dZrsf2lKc6xY5QZhb/lBO3J7u2UOg6Z2mZZrHboN5O1gXQJch4ETtg93Thk
         PKaf7C8MJrbvEHq3g7RsJbQsdoIzLcGWhcKnBK+3YH/JpTgls0dA33TnIblRELXwPn
         TrJEP18+dbybB5rl0khvQJt0tNqdZ6h0juyVMOtk=
Date:   Tue, 7 Jul 2020 10:30:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200707103011.173d38c1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAKwvOd=z0n2+1voMCzC6Hft9EBdLM+6PUi9qBVTVvea_3kM91w@mail.gmail.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
        <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
        <20200629232059.GA3787278@google.com>
        <20200707155107.GA3357035@google.com>
        <20200707160528.GA1300535@google.com>
        <20200707095651.422f0b22@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CAKwvOd=z0n2+1voMCzC6Hft9EBdLM+6PUi9qBVTVvea_3kM91w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 7 Jul 2020 10:17:25 -0700 Nick Desaulniers wrote:
> On Tue, Jul 7, 2020 at 9:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >  
> > > On Tue, Jul 07, 2020 at 08:51:07AM -0700, Sami Tolvanen wrote:  
> > > > After spending some time debugging this with Nick, it looks like the
> > > > error is caused by a recent optimization change in LLVM, which together
> > > > with the inlining of ur_load_imm_any into jeq_imm, changes a runtime
> > > > check in FIELD_FIT that would always fail, to a compile-time check that
> > > > breaks the build. In jeq_imm, we have:
> > > >
> > > >     /* struct bpf_insn: _s32 imm */
> > > >     u64 imm = insn->imm; /* sign extend */
> > > >     ...
> > > >     if (imm >> 32) { /* non-zero only if insn->imm is negative */
> > > >             /* inlined from ur_load_imm_any */
> > > >     u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
> > > >
> > > >         /*
> > > >      * __imm has a value known at compile-time, which means
> > > >      * __builtin_constant_p(__imm) is true and we end up with
> > > >      * essentially this in __BF_FIELD_CHECK:
> > > >      */
> > > >     if (__builtin_constant_p(__imm) && __imm > 255)  
> >
> > I think FIELD_FIT() should not pass the value into __BF_FIELD_CHECK().
> >
> > So:
> >
> > diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> > index 48ea093ff04c..4e035aca6f7e 100644
> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -77,7 +77,7 @@
> >   */
> >  #define FIELD_FIT(_mask, _val)                                         \
> >         ({                                                              \
> > -               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");     \
> > +               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");     \
> >                 !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
> >         })
> >
> > It's perfectly legal to pass a constant which does not fit, in which
> > case FIELD_FIT() should just return false not break the build.
> >
> > Right?  
> 
> I see the value of the __builtin_constant_p check; this is just a very
> interesting case where rather than an integer literal appearing in the
> source, the compiler is able to deduce that the parameter can only
> have one value in one case, and allows __builtin_constant_p to
> evaluate to true for it.
> 
> I had definitely asked Sami about the comment above FIELD_FIT:
> """
>  76  * Return: true if @_val can fit inside @_mask, false if @_val is
> too big.
> """
> in which FIELD_FIT doesn't return false if @_val is too big and a
> compile time constant. (Rather it breaks the build).
> 
> Of the 14 expansion sites of FIELD_FIT I see in mainline, it doesn't
> look like any integral literals are passed, so maybe the compile time
> checks of _val are of little value for FIELD_FIT.

Also I just double checked and all FIELD_FIT() uses check the return
value.

> So I think your suggested diff is the most concise fix.

Feel free to submit that officially as a patch if it fixes the build
for you, here's my sign-off:

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
