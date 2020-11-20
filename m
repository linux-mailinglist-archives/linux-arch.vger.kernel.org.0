Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDD2BB6B2
	for <lists+linux-arch@lfdr.de>; Fri, 20 Nov 2020 21:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgKTUZW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 15:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgKTUZW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 15:25:22 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF99C061A04
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 12:25:22 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id k12so3516189uae.13
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=984nJeLydsE3/GDg3HBO6Z6L/1lt0gFfqkKrV/lzSfk=;
        b=nQ48JfzXRyNDknHGCh3KFKjURhf06zzRND+V/pJL/fMRQP6lLOU4+KjKu6MWYvNGLA
         u/GGSVGE3kgxtbIMz5PxE83KRGKSZySAWIrCVeitIKgVg4oGgHd7hM0MclX/o0xA6iM7
         0TjfjF8WKDBiTvlY0PE7KxWfiT12N620kb+jYUJpJQnbHzG2Y3yDy80EStVPPkzsPuX8
         bdbm2U6exJndNtMvOE62BvjnmwhCNTdLYsvSFa7Pnlfa76FT693PoaC9m6in5Jl5pjA+
         pLXxKB786iLdW3LX7Ve2TlFLslpMT2/zDAEyjn27o3Ofet4vrVt0LEU4XrMBd4DoJ1cH
         vg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=984nJeLydsE3/GDg3HBO6Z6L/1lt0gFfqkKrV/lzSfk=;
        b=eCJ1EOpm3Rm2fi7YFm+yuIcoDiJg/s88lS/iltOPEDyx4a98I4RhNxbuRX2tOAbXgF
         7OGfmnC0uYhVW8mv/0gbdJmJUZOZL6KBBd5A9J4HlNcEWBDfI+ETmg0POL1jxK6XcMPH
         8Mx+CorjKrjnuwxy4ZsnlPqp27H+pNuYLvXw2MZdPaBiGOBu8qPNMfRFNPiEXb5FSMuc
         VPktNaQ1f3sgGQ8z8kTshGSWwojm7egft6jiRmqgIh6+EJ+Vo/Yp229Xfzis8R+fhFmd
         QR9ojhsAUJoqk8IkfFcUodOyYg4S0tSHolL/NZEk0n0V+4yOSdNZRoh3bhQAY8t5jvDI
         thmA==
X-Gm-Message-State: AOAM5339D2kIue5lSIiZDyvR0+3sXntZZ0KydrT9SshX/vpauTXWho7j
        ULarU9+jQEYXbhJc4O+k4LUnmtqavecqBeEKnf0xOQ==
X-Google-Smtp-Source: ABdhPJxCT20kCKg82r2GF6byyQKxIJWZrkcRHsjZAfiHsHplg/RwP3f21qH6ZHRA+utWdlmz3m8dxOiRg7Ud36B+6lo=
X-Received: by 2002:a9f:2595:: with SMTP id 21mr10567817uaf.33.1605903921022;
 Fri, 20 Nov 2020 12:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com> <20201120040424.a3wctajzft4ufoiw@treble>
In-Reply-To: <20201120040424.a3wctajzft4ufoiw@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 20 Nov 2020 12:25:09 -0800
Message-ID: <CABCJKueTjhjSY=oOD3bWqn7E_1X9k-MK+6r_Z35AiCKDTNK18g@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 8:04 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > This patch series adds support for building the kernel with Clang's
> > Link Time Optimization (LTO). In addition to performance, the primary
> > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > be used in the kernel. Google has shipped millions of Pixel devices
> > running three major kernel versions with LTO+CFI since 2018.
> >
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> >
> > Note that v7 brings back arm64 support as Will has now staged the
> > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > on fixing the remaining objtool warnings [2].
>
> Sami,
>
> Here are some patches to fix the objtool issues (other than crypto which
> I'll work on next).
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux

Thanks, Josh! I can confirm that these fix all the non-crypto objtool
warnings with LTO as well.

Sami
