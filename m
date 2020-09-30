Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C7227F4E7
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 00:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgI3WND (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 18:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgI3WNC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Sep 2020 18:13:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8BAC061755
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 15:13:01 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l17so3525365edq.12
        for <linux-arch@vger.kernel.org>; Wed, 30 Sep 2020 15:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5JyINSMzWB8voXWZyV8ASlSh5pqRDmgZFl229b53xc=;
        b=vIRIWKYp7RTSUGB8ntUgtpTfuIX9PNECXrtz7OF4WuzjxaB6ucqKe+labxFFw91k3e
         QxLYAkxotsyYRcimIeAn7Z8xictu3hpLg464s+yhLPGoBBznroXq6KWSnvggTT+OKc+4
         aDiohWxi2bv6qcv/jsb8X6MLhFKoc5VlhLVAgI9mvRP+ESLwvXgjzFulM/aycHPXZ43C
         1PZWgQU//0UlvKQQQTsVxdhKKn2R1cZHSse1ucxAjFxlIjoTBB5mxWh5AjLIfsBpQ8Qr
         kwHSrW70qM469yHzjDZCiyJ6JH0YYN8N5o79By5EDLYjMuAR2Pr4Z/ShSwy2ytzZ+9o+
         xxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5JyINSMzWB8voXWZyV8ASlSh5pqRDmgZFl229b53xc=;
        b=Uo9oeEX1IKKOrbKvZsUIQDQ2yU7ENF45YmxIOGZR3VlIcUadXqXZGikhWp9bzGkLT5
         aS94Wdf4OmZw/fBrH8QL+quYYRYn4H4OL1acTA+xtcRjqPE2AGjRpsNNGK4GJnP/kQYA
         xjHYRRrV7PY0Ar+JXWOlrRJBwu6g6KGyCfdJ3oFRBJwuIW2lVT5kjRFWWNKaD94hFV/y
         Tjzkg82r2eJKfNhltjv7d1xSNphHm+Kags7lBHRFHd3v92JMdI9kxVvGabi8sQDLkTif
         edU8hHLsM5i9LO4natYEmD4XU5C8g+kZKgJO3dl8L63nyPrk9og19/dgRkjEZzwrV8Vv
         TbqQ==
X-Gm-Message-State: AOAM5333/orak6eqbhybsg3Vi+iVITx0GNag3KiyND0zixcAH6Gr4jPv
        U5fYofDz99lt4fHlBgOPFhzWz327NTEzCUhToyjjhQ==
X-Google-Smtp-Source: ABdhPJzjWahTDCS64Nwdg2Qz+9IkGNUdbgNKy/rFx3FC7CVjfHrBmMTaxElMCOz9QatJ5KolJbRCcmnwy3926ope18M=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr5304520edp.40.1601503980129;
 Wed, 30 Sep 2020 15:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com> <CAKwvOdnYBkUx9YpY9XLONbNYFD7JrOfGbRFQ8ZTf-sa2GTgQdQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnYBkUx9YpY9XLONbNYFD7JrOfGbRFQ8ZTf-sa2GTgQdQ@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 30 Sep 2020 15:12:49 -0700
Message-ID: <CABCJKufUU=s6GcRCRcmuKnANtyyKEBNJVuaPw416C1OPNgywEQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/29] Add support for Clang LTO
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 30, 2020 at 2:58 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 29, 2020 at 2:46 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is
> > to allow Clang's Control-Flow Integrity (CFI) to be used in the
> > kernel. Google has shipped millions of Pixel devices running three
> > major kernel versions with LTO+CFI since 2018.
> >
> > Most of the patches are build system changes for handling LLVM
> > bitcode, which Clang produces with LTO instead of ELF object files,
> > postponing ELF processing until a later stage, and ensuring initcall
> > ordering.
>
> Sami, thanks for continuing to drive the series. I encourage you to
> keep resending with fixes accumulated or dropped on a weekly cadence.
>
> The series worked well for me on arm64, but for x86_64 on mainline I
> saw a stream of new objtool warnings:
[...]

Objtool normally won't print out these warnings when run on vmlinux.o,
but we can't pass --vmlinux to objtool as that also implies noinstr
validation right now. I think we'd have to split that from --vmlinux
to avoid these. I can include a patch to add a --noinstr flag in v5.
Peter, any thoughts about this?

> I think those should be resolved before I provide any kind of tested
> by tag.  My other piece of feedback was that I like the default
> ThinLTO, but I think the help text in the Kconfig which is visible
> during menuconfig could be improved by informing the user the
> tradeoffs.  For example, if CONFIG_THINLTO is disabled, it should be
> noted that full LTO will be used instead.  Also, that full LTO may
> produce slightly better optimized binaries than ThinLTO, at the cost
> of not utilizing multiple cores when linking and thus significantly
> slower to link.
>
> Maybe explaining that setting it to "n" implies a full LTO build,
> which will be much slower to link but possibly slightly faster would
> be good?  It's not visible unless LTO_CLANG and ARCH_SUPPORTS_THINLTO
> is enabled, so I don't think you need to explain that THINLTO without
> those is *not* full LTO.  I'll leave the precise wording to you. WDYT?

Sure, sounds good. I'll update the help text in the next version.

> Also, when I look at your treewide DISABLE_LTO patch, I think "does
> that need to be a part of this series, or is it a cleanup that can
> stand on its own?"  I think it may be the latter?  Maybe it would help
> shed one more patch than to have to carry it to just send it?  Or did
> I miss something as to why it should remain a part of this series?

I suppose it could be stand-alone, but as these patches are also
disabling LTO by filtering out flags in some of the same files,
removing the unused DISABLE_LTO flags first would reduce confusion.
But I'm fine with sending it separately too if that's preferred.

Sami
