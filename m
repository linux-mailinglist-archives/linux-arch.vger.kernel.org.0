Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF65F5CF6
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 00:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJEW75 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 18:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEW74 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 18:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB4813CF4;
        Wed,  5 Oct 2022 15:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A5A0617A8;
        Wed,  5 Oct 2022 22:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA613C4347C;
        Wed,  5 Oct 2022 22:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665010793;
        bh=rEsBUoM6as5O5NE68AneNJulvIV8bh7APc5gzGTSh9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tzl1pgYgpnY/90uUd4mxkL0cx3M5nQVaKd3h2wsorKBt0Kf1KcNCYS1ueOaH8aDuG
         kfb1Y7lB/etnN4Asil92Izs/8Y8JeLwXzBs/aunSfcSt2PrmoJxkZksPit1J1lgbDW
         MEhprXkQPmapSOLn+puxht//yl2tvOhfYG7NaerDb4qg01HejP8YB3+ao9o4foKllJ
         nVeh1E9AZRbxW5/RDyssZHq8PVP6/ui5OtJpz6f3CtEHzh95tCZefuh7uWm0Sac32Z
         QPjXtUwIXF8lcU8fjR1gZTgypaN1ya0jDaC+AdzjnJEhsdHqBTEQC+5wvcuzcyvgQ8
         73QICKFPIL3xg==
Received: by mail-lj1-f172.google.com with SMTP id j23so195538lji.8;
        Wed, 05 Oct 2022 15:59:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf2SnQP2pf3+GVgz+IIPvwXuJDPFRW/LaUNWTp2jCUvL6FWldu+l
        zoCMBaAJHM7cm7fjzQ9DU1wA2G6U5QTxY6PSVDk=
X-Google-Smtp-Source: AMsMyM7j+a9QGFjkrXJULvPg4LyZlo4d52eAiyuW9ZTdw6lUoxr9hd3DYQbq2T9V1HFGEWfJxNnsLlbeEnFSrOjnHtk=
X-Received: by 2002:a05:651c:1a26:b0:26c:4c0d:b10a with SMTP id
 by38-20020a05651c1a2600b0026c4c0db10amr620033ljb.415.1665010791465; Wed, 05
 Oct 2022 15:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkCCyP8W2pHf9ETKMgUtKCgcSwUb6=bMJ_8riwjyknpCw@mail.gmail.com>
 <20220926183725.1112298-1-ndesaulniers@google.com>
In-Reply-To: <20220926183725.1112298-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 6 Oct 2022 00:59:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCGjb-mWHh37wv2mgZvLEsRA=f_Y-7UMom-QiRjTJ_Nw@mail.gmail.com>
Message-ID: <CAMj1kXHCGjb-mWHh37wv2mgZvLEsRA=f_Y-7UMom-QiRjTJ_Nw@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: move __kretprobe_trampoline to out of line assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        sparkhuang <huangshaobo6@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Logan Chien <loganchien@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi NIck,

On Mon, 26 Sept 2022 at 20:37, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> commit 1069c1dd20a3 ("ARM: 9231/1: Recover kretprobes return address for
> EABI stack unwinder")
> tickled a bug in clang's integrated assembler where the .save and .pad
> directives must have corresponding .fnstart directives. The integrated
> assembler is unaware that the compiler will be generating the .fnstart
> directive.
>
>   arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
>   .save or .vsave directives
>   <inline asm>:3:2: note: instantiated into assembly here
>   .save   {sp, lr, pc}
>   ^
>   arch/arm/probes/kprobes/core.c:412:29: error: .fnstart must precede
>   .pad directive
>   <inline asm>:6:2: note: instantiated into assembly here
>   .pad    #52
>   ^
>
> __kretprobe_trampoline's definition is already entirely inline asm. Move
> it to out-of-line asm to avoid breaking the build.
>

I think this is the right approach. I don't think is is even specified
what exactly attribute((naked)) entails in the context of unwind
information

Some nits below, but regardless:

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> Link: https://github.com/llvm/llvm-project/issues/57993
> Link: https://github.com/ClangBuiltLinux/linux/issues/1718
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Logan Chien <loganchien@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Note: I wasn't quite sure if a Fixes tag against 1069c1dd20a3 was
> appropriate here? Either way, if 1069c1dd20a3 gets picked up for stable
> without this, it will break clang builds.
>
>  arch/arm/probes/kprobes/Makefile              |  1 +
>  arch/arm/probes/kprobes/core.c                | 54 ++----------------
>  .../arm/probes/kprobes/kretprobe-trampoline.S | 55 +++++++++++++++++++
>  include/asm-generic/kprobes.h                 | 13 +++--
>  4 files changed, 69 insertions(+), 54 deletions(-)
>  create mode 100644 arch/arm/probes/kprobes/kretprobe-trampoline.S
>
> diff --git a/arch/arm/probes/kprobes/Makefile b/arch/arm/probes/kprobes/Makefile
> index 6159010dac4a..cdbe9dd99e28 100644
> --- a/arch/arm/probes/kprobes/Makefile
> +++ b/arch/arm/probes/kprobes/Makefile
> @@ -3,6 +3,7 @@ KASAN_SANITIZE_actions-common.o := n
>  KASAN_SANITIZE_actions-arm.o := n
>  KASAN_SANITIZE_actions-thumb.o := n
>  obj-$(CONFIG_KPROBES)          += core.o actions-common.o checkers-common.o
> +obj-$(CONFIG_KPROBES)          += kretprobe-trampoline.o
>  obj-$(CONFIG_ARM_KPROBES_TEST) += test-kprobes.o
>  test-kprobes-objs              := test-core.o
>
> diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
> index 1435b508aa36..17d7e0259e63 100644
> --- a/arch/arm/probes/kprobes/core.c
> +++ b/arch/arm/probes/kprobes/core.c
> @@ -375,58 +375,10 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>         return NOTIFY_DONE;
>  }
>
> -/*
> - * When a retprobed function returns, trampoline_handler() is called,
> - * calling the kretprobe's handler. We construct a struct pt_regs to
> - * give a view of registers r0-r11, sp, lr, and pc to the user
> - * return-handler. This is not a complete pt_regs structure, but that
> - * should be enough for stacktrace from the return handler with or
> - * without pt_regs.
> - */
> -void __naked __kprobes __kretprobe_trampoline(void)
> -{
> -       __asm__ __volatile__ (
> -               "ldr    lr, =__kretprobe_trampoline     \n\t"
> -#ifdef CONFIG_FRAME_POINTER
> -       /* __kretprobe_trampoline makes a framepointer on pt_regs. */
> -#ifdef CONFIG_CC_IS_CLANG
> -               "stmdb  sp, {sp, lr, pc}        \n\t"
> -               "sub    sp, sp, #12             \n\t"
> -               /* In clang case, pt_regs->ip = lr. */
> -               "stmdb  sp!, {r0 - r11, lr}     \n\t"
> -               /* fp points regs->r11 (fp) */
> -               "add    fp, sp, #44             \n\t"
> -#else /* !CONFIG_CC_IS_CLANG */
> -               /* In gcc case, pt_regs->ip = fp. */
> -               "stmdb  sp, {fp, sp, lr, pc}    \n\t"
> -               "sub    sp, sp, #16             \n\t"
> -               "stmdb  sp!, {r0 - r11}         \n\t"
> -               /* fp points regs->r15 (pc) */
> -               "add    fp, sp, #60             \n\t"
> -#endif /* CONFIG_CC_IS_CLANG */
> -#else /* !CONFIG_FRAME_POINTER */
> -               /* store SP, LR on stack and add EABI unwind hint */
> -               "stmdb  sp, {sp, lr, pc}        \n\t"
> -               ".save  {sp, lr, pc}    \n\t"
> -               "sub    sp, sp, #16             \n\t"
> -               "stmdb  sp!, {r0 - r11}         \n\t"
> -               ".pad   #52                             \n\t"
> -#endif /* CONFIG_FRAME_POINTER */
> -               "mov    r0, sp                  \n\t"
> -               "bl     trampoline_handler      \n\t"
> -               "mov    lr, r0                  \n\t"
> -               "ldmia  sp!, {r0 - r11}         \n\t"
> -               "add    sp, sp, #16             \n\t"
> -#ifdef CONFIG_THUMB2_KERNEL
> -               "bx     lr                      \n\t"
> -#else
> -               "mov    pc, lr                  \n\t"
> -#endif
> -               : : : "memory");
> -}
> +/*void __kretprobe_trampoline(void);*/
>
>  /* Called from __kretprobe_trampoline */
> -static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
> +__kprobes void *trampoline_handler(struct pt_regs *regs)
>  {
>         return (void *)kretprobe_trampoline_handler(regs, (void *)regs->TRAMP_FP);
>  }
> @@ -434,6 +386,8 @@ static __used __kprobes void *trampoline_handler(struct pt_regs *regs)
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>                                       struct pt_regs *regs)
>  {
> +       extern void __kretprobe_trampoline(void);
> +
>         ri->ret_addr = (kprobe_opcode_t *)regs->ARM_lr;
>         ri->fp = (void *)regs->TRAMP_FP;
>
> diff --git a/arch/arm/probes/kprobes/kretprobe-trampoline.S b/arch/arm/probes/kprobes/kretprobe-trampoline.S
> new file mode 100644
> index 000000000000..261c99b8c17f
> --- /dev/null
> +++ b/arch/arm/probes/kprobes/kretprobe-trampoline.S
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/linkage.h>
> +#include <asm/unwind.h>
> +#include <asm-generic/kprobes.h>
> +
> +/*
> + * When a retprobed function returns, trampoline_handler() is called,
> + * calling the kretprobe's handler. We construct a struct pt_regs to
> + * give a view of registers r0-r11, sp, lr, and pc to the user
> + * return-handler. This is not a complete pt_regs structure, but that
> + * should be enough for stacktrace from the return handler with or
> + * without pt_regs.
> + */
> +__KPROBE
> +SYM_FUNC_START(__kretprobe_trampoline)
> +UNWIND(.fnstart)
> +       ldr     lr, =__kretprobe_trampoline

Nit: adr lr, __kretprobe_trampoline

Now that you made a clean spot, might as well clean this up a bit
(although perhaps not in the same patch). I'd merge the
!CONFIG_FRAME_POINTER and CC_IS_CLANG cases, and just put the UNWIND()
directives in there.

> +#ifdef CONFIG_FRAME_POINTER

Drop this

> +       /* __kretprobe_trampoline makes a framepointer on pt_regs. */
> +#ifdef CONFIG_CC_IS_CLANG

|| !defined(CONFIG_FRAME_POINTER)

> +       stmdb   sp, {sp, lr, pc}
> +       sub     sp, sp, #12

UNWIND(.save   {sp, lr, pc})

> +       /* In clang case, pt_regs->ip = lr. */

For .S, it is more idiomatic to put the comments in a column on the
right. This reduces visual clutter a lot, so I think it would be worth
the effort.

> +       stmdb   sp!, {r0 - r11, lr}

UNWIND(.pad    #52)

> +       /* fp points regs->r11 (fp) */
> +       add     fp, sp, #44
> +#else /* !CONFIG_CC_IS_CLANG */
> +       /* In gcc case, pt_regs->ip = fp. */
> +       stmdb   sp, {fp, sp, lr, pc}
> +       sub     sp, sp, #16
> +       stmdb   sp!, {r0 - r11}
> +       /* fp points regs->r15 (pc) */
> +       add     fp, sp, #60
> +#endif /* CONFIG_CC_IS_CLANG */
> +#else /* !CONFIG_FRAME_POINTER */
> +       /* store SP, LR on stack and add EABI unwind hint */
> +       stmdb   sp, {sp, lr, pc}
> +UNWIND(.save   {sp, lr, pc})
> +       sub     sp, sp, #16
> +       stmdb   sp!, {r0 - r11}
> +UNWIND(.pad    #52)
> +#endif /* CONFIG_FRAME_POINTER */
> +       mov     r0, sp
> +       bl      trampoline_handler
> +       mov     lr, r0
> +       ldmia   sp!, {r0 - r11}
> +       add     sp, sp, #16
> +#ifdef CONFIG_THUMB2_KERNEL
> +       bx      lr
> +#else
> +       mov     pc, lr
> +#endif

Please use 'ret lr' here. Note that this code does not even compile
for Thumb2, but 'bx lr' should be used at least on v6+ in any case.

> +UNWIND(.fnend)
> +SYM_FUNC_END(__kretprobe_trampoline)
> diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
> index 060eab094e5a..1509daa281b8 100644
> --- a/include/asm-generic/kprobes.h
> +++ b/include/asm-generic/kprobes.h
> @@ -2,7 +2,11 @@
>  #ifndef _ASM_GENERIC_KPROBES_H
>  #define _ASM_GENERIC_KPROBES_H
>
> -#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
> +#ifdef __KERNEL__
> +
> +#ifdef __ASSEMBLY__
> +# define __KPROBE .section ".kprobes.text", "ax"
> +#else
>  #ifdef CONFIG_KPROBES
>  /*
>   * Blacklist ganerating macro. Specify functions which is not probed
> @@ -16,11 +20,12 @@ static unsigned long __used                                 \
>  /* Use this to forbid a kprobes attach on very low level functions */
>  # define __kprobes     __section(".kprobes.text")
>  # define nokprobe_inline       __always_inline
> -#else
> +#else /* !defined(CONFIG_KPROBES) */
>  # define NOKPROBE_SYMBOL(fname)
>  # define __kprobes
>  # define nokprobe_inline       inline
> -#endif
> -#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
> +#endif /* defined(CONFIG_KPROBES) */
> +#endif /* defined(__ASSEMBLY__) */
> +#endif /* defined(__KERNEL__) */
>
>  #endif /* _ASM_GENERIC_KPROBES_H */
> --
> 2.37.3.998.g577e59143f-goog
>
