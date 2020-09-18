Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B24D27076E
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIRUuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIRUuQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:50:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAE0C0613CE
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:50:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z22so9804850ejl.7
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4okZ/7bct4uSKwZ6O3z2m5KyitVLtU4XG9WgtUAxwc=;
        b=TxBH8AyvU6HWp66ncdZqEtoRFWD/YTji6mddQAC1tx4KXEeHFtGLdS3R9syxDOr/gw
         EJ35wyT17gb2NJYLGzLi6nzgB21j9JTRzpSNH6ko4dn+slxaKb4IH8Ki7QRFsqI7v9aA
         S87ydkbPm8kuIhgWoL3lKfaG0SLalSIBz1ahIC+ONuQXK7GoSVTs2pnZksirb/CgEcGJ
         dda7cH+5KO+boQPBNW5nn7bmDiexjhjP2RtZPQz3JvCcezgV03AKeN1igjv/uW0ePsfq
         kEgfrqOrvUv6gNdwmh3rNp+rjsPflT1TKKMgiRyTccCH7ogTg/un4wxhA9XtkrhpxfY7
         o61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4okZ/7bct4uSKwZ6O3z2m5KyitVLtU4XG9WgtUAxwc=;
        b=uN4EeB9U+Aj425ldl2Hly8nNaT6uOWA8pjiPGfPfd9nHrhOosNfxA440GETSe4kO2H
         7M6myd8jVUG+P16y/RIaXUSoeZ3V6BF0uNjJdujVsY0qoMhCt56wmOiVdMuhQu4Hke+1
         C8tH8KQQpahV01s9hjXhq1RJB+t4RPKPWD1czM+BTE6HK26CwhNSjtYLeQMtwY+O2MSp
         W8hNgG47Apr3yFVZrO9m/Qidk8MGZgwWgIKdVnEHMFq9PYfk+IACsW+SWa4S3wA1SCJ3
         01NlNqX5rxGLD9K9GJ2uDeO+5LSnWK7sWQh3HfUK7rUwfT+Z7PHQBwKeyJWUuDlgSFhv
         i/8Q==
X-Gm-Message-State: AOAM5301j1UhKXh5PNRpwWVJ8IreBjjECUkVgRohc8GvftBe9JqG09v/
        RrlYaIXDHlxhffJDfWUCIm0axX0FyKCuIor1E1hWWQ==
X-Google-Smtp-Source: ABdhPJxlmp9BJajUv0E4cVIdv3SYp0wheOk/nOpDB3mBZ4a/wfqp4uUfhfc+2gKB4vscqXhsi0M+J+iTaTW/5sPlq3g=
X-Received: by 2002:a17:906:454e:: with SMTP id s14mr38862035ejq.137.1600462214260;
 Fri, 18 Sep 2020 13:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com> <CA+icZUW1MYSUz8jwOaVpi6ib1dyCv1VmG5priw6TTzXGSh_8Gg@mail.gmail.com>
In-Reply-To: <CA+icZUW1MYSUz8jwOaVpi6ib1dyCv1VmG5priw6TTzXGSh_8Gg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Sep 2020 13:50:03 -0700
Message-ID: <CABCJKueyWvNB2MQw_PCLtZb8F1+sA1QOLJi_5qMKwdFCcwSMGg@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Add support for Clang LTO
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 1:22 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Sep 18, 2020 at 10:14 PM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
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
> >
> > Note that patches 1-5 are not directly related to LTO, but are
> > needed to compile LTO kernels with ToT Clang, so I'm including them
> > in the series for your convenience:
> >
> >  - Patches 1-3 fix build issues with LLVM and they are already in
> >    linux-next.
> >
> >  - Patch 4 fixes x86 builds with LLVM IAS, but it hasn't yet been
> >    picked up by maintainers.
> >
> >  - Patch 5 is from Masahiro's kbuild tree and makes the LTO linker
> >    script changes much cleaner.
> >
>
> Hi Sami,
>
> might be good to point to your GitHub tree and corresponding
> release-tag for easy fetching.

Ah, true. You can also pull this series from

  https://github.com/samitolvanen/linux.git lto-v3

Sami
