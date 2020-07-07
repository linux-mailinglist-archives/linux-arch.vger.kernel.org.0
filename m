Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2E2174F5
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 19:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGGRRi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 13:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGRRh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 13:17:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A576C061755
        for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2020 10:17:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so16108901plm.10
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2020 10:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1l5foeggCPnvjxEutFU8wFN3OGjiNb8LVGar6Q0E2bk=;
        b=p+taEDukDZunYk2YVvDirVBFCS5gqPr2R9RnKJfnddhTGc20YU572SKyACE7vpcaTR
         F5HFH2fMBR8VjtEEwiyQ74CmsVRSj4Ad4FLU1To0K6z4ULdO3jvbHZeeGBHBRmSu0PTW
         UbccsCiQebhN4H0b9EnPYPa5Ai8Ws0KmyU4TI5o1FFt5ZLgZIreDV3fb67rOGyWIfR6/
         oou2xq9qwW2pgE28CTCAGQHvyAbBx2Fzy3ylMs664PbsO+zz4aI2MU8QtAAJwDXtirLI
         6B9dfNDIOTNJp7sWV70NHM21ivLgatQ2mrd5vfPNJba12U8BMEgM7EeQ3t2Y2FedZETc
         ViTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l5foeggCPnvjxEutFU8wFN3OGjiNb8LVGar6Q0E2bk=;
        b=fyWHPQJfJZMtdMsVeWImM0lFYl7AKPp4PVFnX2xGBF9yO1BUOJyZKh6PAysfCdGFIK
         6ln4ZRIzyUVDgAAA0Cyc1oxtUn1DiznrCNkK8TZmcul1LMzWyXhvxuDq1Q3v0En4i+RK
         Dj3v+eU2s5pMBa0ymGJrSFfQx6VL0uS6bfwe/nbeqY4YwVOg1JKVERcZW75FFyE9Uikp
         gFC7DDniNF1hlvsBBvQjzJks0Dt/jc40V0PCmjsI0Qg28iqxlz3vspC/FFzamPZmPwzK
         UjuWs2Jz8sqFIXtsWJXIj0L1Vm2ULfA0EgilyTGWOc3pb+T5abWcG4VQJp+qZNEm1STp
         nz5A==
X-Gm-Message-State: AOAM533Cr21ULGizTTR1+kwXBXrHWzkZeBFIGGrNmSSiqGR8KLx9Hti9
        2TW93DWkJsn73K+WsUr7j6BWLzRbDswMlG5xMpP1XQ==
X-Google-Smtp-Source: ABdhPJzimEYKgjGUXrlBaLBBjIq4MiI2yDdoA4ahjq7vNkr0ok0O/VlCBrFDIeS1Bs6yHN7Uv+XaLt7SQoM3eHhtWPo=
X-Received: by 2002:a17:90a:21ef:: with SMTP id q102mr5585509pjc.101.1594142256771;
 Tue, 07 Jul 2020 10:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <CAK7LNASvb0UDJ0U5wkYYRzTAdnEs64HjXpEUL7d=V0CXiAXcNw@mail.gmail.com>
 <20200629232059.GA3787278@google.com> <20200707155107.GA3357035@google.com>
 <20200707160528.GA1300535@google.com> <20200707095651.422f0b22@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200707095651.422f0b22@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 7 Jul 2020 10:17:25 -0700
Message-ID: <CAKwvOd=z0n2+1voMCzC6Hft9EBdLM+6PUi9qBVTVvea_3kM91w@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Jakub Kicinski <kuba@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 7, 2020 at 9:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> > On Tue, Jul 07, 2020 at 08:51:07AM -0700, Sami Tolvanen wrote:
> > > After spending some time debugging this with Nick, it looks like the
> > > error is caused by a recent optimization change in LLVM, which together
> > > with the inlining of ur_load_imm_any into jeq_imm, changes a runtime
> > > check in FIELD_FIT that would always fail, to a compile-time check that
> > > breaks the build. In jeq_imm, we have:
> > >
> > >     /* struct bpf_insn: _s32 imm */
> > >     u64 imm = insn->imm; /* sign extend */
> > >     ...
> > >     if (imm >> 32) { /* non-zero only if insn->imm is negative */
> > >             /* inlined from ur_load_imm_any */
> > >     u32 __imm = imm >> 32; /* therefore, always 0xffffffff */
> > >
> > >         /*
> > >      * __imm has a value known at compile-time, which means
> > >      * __builtin_constant_p(__imm) is true and we end up with
> > >      * essentially this in __BF_FIELD_CHECK:
> > >      */
> > >     if (__builtin_constant_p(__imm) && __imm > 255)
>
> I think FIELD_FIT() should not pass the value into __BF_FIELD_CHECK().
>
> So:
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index 48ea093ff04c..4e035aca6f7e 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -77,7 +77,7 @@
>   */
>  #define FIELD_FIT(_mask, _val)                                         \
>         ({                                                              \
> -               __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_FIT: ");     \
> +               __BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");     \
>                 !((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
>         })
>
> It's perfectly legal to pass a constant which does not fit, in which
> case FIELD_FIT() should just return false not break the build.
>
> Right?

I see the value of the __builtin_constant_p check; this is just a very
interesting case where rather than an integer literal appearing in the
source, the compiler is able to deduce that the parameter can only
have one value in one case, and allows __builtin_constant_p to
evaluate to true for it.

I had definitely asked Sami about the comment above FIELD_FIT:
"""
 76  * Return: true if @_val can fit inside @_mask, false if @_val is
too big.
"""
in which FIELD_FIT doesn't return false if @_val is too big and a
compile time constant. (Rather it breaks the build).

Of the 14 expansion sites of FIELD_FIT I see in mainline, it doesn't
look like any integral literals are passed, so maybe the compile time
checks of _val are of little value for FIELD_FIT.

So I think your suggested diff is the most concise fix.
-- 
Thanks,
~Nick Desaulniers
