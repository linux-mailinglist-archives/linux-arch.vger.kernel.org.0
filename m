Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24CA2B2931
	for <lists+linux-arch@lfdr.de>; Sat, 14 Nov 2020 00:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKMXbs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 18:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKMXbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 18:31:47 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F958C0617A6
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 15:31:47 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id m16so6097107vsl.8
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2020 15:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJStHOY5Qh2DGFTroegyQhWYQ1MmCmTEUHWIJvas+7M=;
        b=jSNVZO0K7wzWNgivPRsTS23unTlL5xu3JAtfH6tP3wTtqKXHTFxKLDpXglVNKVogCS
         6GN3EBqfM/ZUBQPh9/KXRac8yN3VH0HlBG3quWK6QtaxtiL1rK8O5VK7VVHqo6J7Rt/X
         pLPxkZTYuxt9e7KMQUlSjLI7JuuwGE0+gzwfrHa+KQQiFj8lluSMbarMau3hHsSH1/Ly
         I1ayeKXU+HZyBmmdWsN2DNObwSk0A53WftOV1KjCprrJHCY1GRvxqs5hu+HPHBc4Mr91
         nRjSltnInqcTuCWkLRcwZA5Rf8Mmi9P0lK2FChkaNPICHq6O3gumsgzJMmBvO66F5HQu
         PNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJStHOY5Qh2DGFTroegyQhWYQ1MmCmTEUHWIJvas+7M=;
        b=WtMVs2voR/dSphTx0NARMdldh4FT6kfu5Zn67KFqdpzf8nK/p1Hv/xRnPekOfcU7EQ
         HAMB1aoZCsLDzeWaSzT5Et7t5O2uzUm0VSAkh5y/mpYwuGOgupFfz1Q20vCZ7/bdM7zk
         kB1XpVrL0OMD1CGNInlCpSA0VrYTxJMWv8Jhvtobw+jRy7x7G+GM2ZAJkcGYAmHhDwQC
         ATxP8AHe4kuxRzFKGHtLG4v6DYLludszjf48zht6uRykpTdtr1uYefY7rYR2F7TB6m33
         45QiX3nlrMO7/goz3qkloWIk4rozkkjiBqGa6sW820VMdu2DPADjov/YZAhbrKLejR0m
         BNUw==
X-Gm-Message-State: AOAM532jU2IrbFKe7CHcWEhYcISIVUfOFm8kNn7G0tthhbPw9J7+5BTT
        b7GFgbC8Vq5/qVy1dZ7xUjlQzCLpqmJ/bsq7Dv28jg==
X-Google-Smtp-Source: ABdhPJxSW9RODWqSRFIxVh02sljFGIxaFmVwff0K0MDsmxDUSocAvDQCNoKIe2vb8EcMsPSHfR3I4Mur2BV/pt3dnso=
X-Received: by 2002:a67:ee93:: with SMTP id n19mr3267175vsp.36.1605310306224;
 Fri, 13 Nov 2020 15:31:46 -0800 (PST)
MIME-Version: 1.0
References: <CABCJKucVjFtrOsw58kn4OnW5kdkUh8G7Zs4s6QU9s6O7soRiAA@mail.gmail.com>
 <20201021085606.GZ2628@hirez.programming.kicks-ass.net> <CABCJKufL6=FiaeD8T0P+mK4JeR9J80hhjvJ6Z9S-m9UnCESxVA@mail.gmail.com>
 <20201023173617.GA3021099@google.com> <CABCJKuee7hUQSiksdRMYNNx05bW7pWaDm4fQ__znGQ99z9-dEw@mail.gmail.com>
 <20201110022924.tekltjo25wtrao7z@treble> <20201110174606.mp5m33lgqksks4mt@treble>
 <CABCJKuf+Ev=hpCUfDpCFR_wBACr-539opJsSFrDcpDA9Ctp7rg@mail.gmail.com>
 <20201113195408.atbpjizijnhuinzy@treble> <CABCJKufA-aOcsOqb1NiMQeBGm9Q-JxjoPjsuNpHh0kL4LzfO0w@mail.gmail.com>
 <20201113223412.inono2ekrs7ky7rm@treble>
In-Reply-To: <20201113223412.inono2ekrs7ky7rm@treble>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 13 Nov 2020 15:31:34 -0800
Message-ID: <CABCJKueeL+1ydcZsm2BS4qrX4Wxy7zY7FUQdoN_WLuUxFfqcmQ@mail.gmail.com>
Subject: Re: [PATCH v6 22/25] x86/asm: annotate indirect jumps
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 2:34 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Nov 13, 2020 at 12:24:32PM -0800, Sami Tolvanen wrote:
> > > I still don't see this warning for some reason.
> >
> > Do you have CONFIG_XEN enabled? I can reproduce this on ToT master as follows:
> >
> > $ git rev-parse HEAD
> > 585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > $ make defconfig && \
> > ./scripts/config -e HYPERVISOR_GUEST -e PARAVIRT -e XEN && \
> > make olddefconfig && \
> > make -j110
> > ...
> > $ ./tools/objtool/objtool check -arfld vmlinux.o 2>&1 | grep secondary
> > vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with
> > modified stack frame
> >
> > > Is it fixed by adding cpu_bringup_and_idle() to global_noreturns[] in
> > > tools/objtool/check.c?
> >
> > No, that didn't fix the warning. Here's what I tested:
>
> I think this fixes it:
>
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/xen: Fix objtool vmlinux.o validation of xen hypercalls
>
> Objtool vmlinux.o validation is showing warnings like the following:
>
>   # tools/objtool/objtool check -barfld vmlinux.o
>   vmlinux.o: warning: objtool: __startup_secondary_64()+0x2: return with modified stack frame
>   vmlinux.o: warning: objtool:   xen_hypercall_set_trap_table()+0x0: <=== (sym)
>
> Objtool falls through all the empty hypercall text and gets confused
> when it encounters the first real function afterwards.  The empty unwind
> hints in the hypercalls aren't working for some reason.  Replace them
> with a more straightforward use of STACK_FRAME_NON_STANDARD.
>
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/xen/xen-head.S | 9 ++++-----
>  include/linux/objtool.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index 2d7c8f34f56c..3c538b1ff4a6 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -6,6 +6,7 @@
>
>  #include <linux/elfnote.h>
>  #include <linux/init.h>
> +#include <linux/objtool.h>
>
>  #include <asm/boot.h>
>  #include <asm/asm.h>
> @@ -67,14 +68,12 @@ SYM_CODE_END(asm_cpu_bringup_and_idle)
>  .pushsection .text
>         .balign PAGE_SIZE
>  SYM_CODE_START(hypercall_page)
> -       .rept (PAGE_SIZE / 32)
> -               UNWIND_HINT_EMPTY
> -               .skip 32
> -       .endr
> +       .skip PAGE_SIZE
>
>  #define HYPERCALL(n) \
>         .equ xen_hypercall_##n, hypercall_page + __HYPERVISOR_##n * 32; \
> -       .type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32
> +       .type xen_hypercall_##n, @function; .size xen_hypercall_##n, 32; \
> +       STACK_FRAME_NON_STANDARD xen_hypercall_##n
>  #include <asm/xen-hypercalls.h>
>  #undef HYPERCALL
>  SYM_CODE_END(hypercall_page)
> diff --git a/include/linux/objtool.h b/include/linux/objtool.h
> index 577f51436cf9..746617265236 100644
> --- a/include/linux/objtool.h
> +++ b/include/linux/objtool.h
> @@ -109,6 +109,12 @@ struct unwind_hint {
>         .popsection
>  .endm
>
> +.macro STACK_FRAME_NON_STANDARD func:req
> +       .pushsection .discard.func_stack_frame_non_standard
> +               .long \func - .
> +       .popsection
> +.endm
> +
>  #endif /* __ASSEMBLY__ */
>
>  #else /* !CONFIG_STACK_VALIDATION */
> @@ -123,6 +129,8 @@ struct unwind_hint {
>  .macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
>  .endm
>  #endif
> +.macro STACK_FRAME_NON_STANDARD func:req
> +.endm

This macro needs to be before the #endif, so it's defined only for
assembly code. This breaks my arm64 builds even though x86 curiously
worked just fine.

Sami
