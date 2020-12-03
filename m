Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AED2CDBE5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgLCRIZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 12:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbgLCRIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 12:08:24 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691D0C061A51
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 09:07:44 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id r24so3769311lfm.8
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MQyiUOcMt6gFRBNfnN0H07pYjhZgF4qm1+bZjvfjTY=;
        b=Cx6oEw3asYjWnT8nYuCvr3UMa7sC7zqGfjZH+6NM/LRsctzlYBq4jWYT5t+CTuzy81
         ufA/35gbWjoyI3GR4sHKJJ/dXIYNWsy/BxrQVF9OwKV8d6p4mG8Br2zZ9qAR1jhR1sR5
         XFtBts/povF4EP6Ny/d1T5ZXYf5b7sm8jc1Iq+39jvlvaKhZ804pJUPhzTdzV+xw97qN
         T4REXRSQqTMIj7T7Nw8GXA7uRLUe6tmfZ+hAOZ2AadWxtejiV4KjYgBy29l+9CK6RmgP
         /m7bEmZBumCr+ghR9RTNKJtACi6yZ1mK18q6oD/IvZz6axncMy9glbpDQAxZ3Bj+bHAk
         275w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MQyiUOcMt6gFRBNfnN0H07pYjhZgF4qm1+bZjvfjTY=;
        b=QDeRr0oT3DEEYeOpcssoJz7ZzE8nNjteV1V2hjn2LNJAyxrGP6I7RD8S2HOQWoDcHB
         uVe9MztK3T/MUc2bPGghZHgLEq2Ys6F2zIXy3M6R0Qwd+4Jgw50BgdOURfbH80u+Gqqi
         19hec9rntQSwmIMpL/e3OGLMwBvhNHXLhMGZHNFoqhzwc4PQHj5KSs+/mOn0evKnRjfg
         alQqv6bvijQx2bJgyiuxX8g3vdJ1exJ/K/SbtBDPct/SRMF3naS8iwcqO80VYTgmOTP6
         Vejx+rk1DeSjqaeidttgE1oWaWK5Ru5i4DH3+XWGUy6rUKVtiscr8ZhCPoeWklpx46FO
         TNFw==
X-Gm-Message-State: AOAM5311y5b6eoRE7ubab55E7/J3fASXi545+11Qjs0yWG9SNM/OicRl
        qS7KxS7ERxMOcUyalRqcUJEm7Ivvh+vm3fgG+/HeKg==
X-Google-Smtp-Source: ABdhPJyeNpRimBzFqDhGioLOrE5ouq1kJk4Pby6GpAHMXjB75Cnj+2lIjlrUJWt+qddSs9EdyIaV3e9wcFRpPEdvaH8=
X-Received: by 2002:a19:c815:: with SMTP id y21mr1656793lff.589.1607015262357;
 Thu, 03 Dec 2020 09:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com> <20201203112622.GA31188@willie-the-truck>
In-Reply-To: <20201203112622.GA31188@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 3 Dec 2020 09:07:30 -0800
Message-ID: <CABCJKueby8pUoN7f5=6RoyLSt4PgWNx8idUej0sNwAi0F3Xqzw@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 3, 2020 at 3:26 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Sami,
>
> On Tue, Dec 01, 2020 at 01:36:51PM -0800, Sami Tolvanen wrote:
> > This patch series adds support for building the kernel with Clang's
> > Link Time Optimization (LTO). In addition to performance, the primary
> > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> > to be used in the kernel. Google has shipped millions of Pixel
> > devices running three major kernel versions with LTO+CFI since 2018.
> >
> > Most of the patches are build system changes for handling LLVM
> > bitcode, which Clang produces with LTO instead of ELF object files,
> > postponing ELF processing until a later stage, and ensuring initcall
> > ordering.
> >
> > Note that arm64 support depends on Will's memory ordering patches
> > [1]. I will post x86_64 patches separately after we have fixed the
> > remaining objtool warnings [2][3].
>
> I took this series for a spin, with my for-next/lto branch merged in but
> I see a failure during the LTO stage with clang 11.0.5 because it doesn't
> understand the '.arch_extension rcpc' directive we throw out in READ_ONCE().

I just tested this with Clang 11.0.0, which I believe is the latest
11.x version, and the current Clang 12 development branch, and both
work for me. Godbolt confirms that '.arch_extension rcpc' is supported
by the integrated assembler starting with Clang 11 (the example fails
with 10.0.1):

https://godbolt.org/z/1csGcT

What does running clang --version and ld.lld --version tell you?

> We actually check that this extension is available before using it in
> the arm64 Kconfig:
>
>         config AS_HAS_LDAPR
>                 def_bool $(as-instr,.arch_extension rcpc)
>
> so this shouldn't happen. I then realised, I wasn't passing LLVM_IAS=1
> on my Make command line; with that, then the detection works correctly
> and the LTO step succeeds.
>
> Why is it necessary to pass LLVM_IAS=1 if LTO is enabled? I think it
> would be _much_ better if this was implicit (or if LTO depended on it).

Without LLVM_IAS=1, Clang uses two different assemblers when LTO is
enabled: the external GNU assembler for stand-alone assembly, and
LLVM's integrated assembler for inline assembly. as-instr tests the
external assembler and makes an admittedly reasonable assumption that
the test is also valid for inline assembly.

I agree that it would reduce confusion in future if we just always
enabled IAS with LTO. Nick, Nathan, any thoughts about this?

Sami
