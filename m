Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053FB5277F3
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 16:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiEOOOI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiEOOOH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 10:14:07 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE9B26111;
        Sun, 15 May 2022 07:14:04 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id o132so6328068vko.11;
        Sun, 15 May 2022 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyqdEmY4lb5SUgNMhMbTWjWbPT9d2sz+Ay4X20jjk4Q=;
        b=MyM/slIfeO4t9eI+NAPHEoJO03uR/K4dPiYHGjpbMnkRoMb21onFGVmn0g2Wm8biU/
         JgYI75ZMmlc8L4CKU444jFP5vjdHgPSSZT2YESPT5W5LgiXyT57w9KMbdmaaGhYcfUpo
         n9QF8qMn5sAwcHHjPJ2m2ho83jx1E9XrqIWBNaFMQbn9TOspdBufpWgorUkHd3pGUjVv
         D/5J2jT4sSOmIXHL920wKzPDGcedBhf5RTnlZ1g0lfC8u90VZU/Xq+CIRmtnxBz3+2UQ
         1w7DCmSpGoze7oHsjEX6ajK4OF+IZXVrPVzL4Knd1ovRy5hUiILBWu09vkiWcwDPxmRs
         qpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyqdEmY4lb5SUgNMhMbTWjWbPT9d2sz+Ay4X20jjk4Q=;
        b=AwjxNk7NRTuXZ1yo1g9+10IcU4K9tVGWsHUCLsATOFChzoPnrTU1e8wyWJfryMicmi
         +pBjQQ/m+4fmh9DE2QRbU6eZWj5NG7Ka6U0vwEP9kre6rXFIZ+J03t8wrIZe1yPpheIM
         KDESPeUlYBSvO8/B+AIuziLig26wRg3+E89fFKnAaxOoeUcms15tTg8RcVgT/VmxDkN2
         TfMKAHr6ttHy4q49P5HWgRj/xrEa+AdSmmAPZSdWDTisxZd7IuDiuLBJ85lOx4BxeS4r
         0A2W5DOK1VRIFnAWAFLkO9tpUyhB1ThJRk5Iv80mBfK4TQoCcTOHRslZwip0OgKznf8e
         y6Ig==
X-Gm-Message-State: AOAM531vcBBIIAVWVirkvTkB2egduVp5BQvE5U+g/18tICLXlpSZIA33
        Bky3Kt1YzeCm+6RthE/snGbpA2nDbZa55x+QIaw=
X-Google-Smtp-Source: ABdhPJxrfGVJLBYRJPMN0W1434VQmGfiPnasDhuIXcsQ0vBlDIv/4SibxYlLUwhXhAlml4DL4PPlugMzRqjtOWzrc2c=
X-Received: by 2002:a1f:1609:0:b0:34d:ff24:30ef with SMTP id
 9-20020a1f1609000000b0034dff2430efmr4985181vkw.14.1652624042932; Sun, 15 May
 2022 07:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-16-chenhuacai@loongson.cn> <f24176bb-8ecc-0ee5-02c5-bafba1c0b348@xen0n.name>
In-Reply-To: <f24176bb-8ecc-0ee5-02c5-bafba1c0b348@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 22:13:50 +0800
Message-ID: <CAAhV-H72kaJKH=TzLGFuTfgBEBk-A-hDoBbTr+-Xu1qV3HZZjg@mail.gmail.com>
Subject: Re: [PATCH V10 15/22] LoongArch: Add ELF and module support
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sun, May 15, 2022 at 7:03 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add ELF-related definition and module relocate codes for basic LoongArch
> > support.
> "module relocation code"
OK, thanks.

> >
> > Cc: Jessica Yu <jeyu@kernel.org>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/cpufeature.h  |  24 ++
> >   arch/loongarch/include/asm/elf.h         | 299 ++++++++++++++++++
> >   arch/loongarch/include/asm/exec.h        |  10 +
> >   arch/loongarch/include/asm/module.h      |  80 +++++
> >   arch/loongarch/include/asm/module.lds.h  |   7 +
> >   arch/loongarch/include/asm/vermagic.h    |  19 ++
> >   arch/loongarch/include/uapi/asm/auxvec.h |  17 ++
> >   arch/loongarch/include/uapi/asm/hwcap.h  |  20 ++
> >   arch/loongarch/kernel/elf.c              |  30 ++
> >   arch/loongarch/kernel/inst.c             |  40 +++
> >   arch/loongarch/kernel/module-sections.c  | 121 ++++++++
> >   arch/loongarch/kernel/module.c           | 374 +++++++++++++++++++++++
> >   12 files changed, 1041 insertions(+)
> >   create mode 100644 arch/loongarch/include/asm/cpufeature.h
> >   create mode 100644 arch/loongarch/include/asm/elf.h
> >   create mode 100644 arch/loongarch/include/asm/exec.h
> >   create mode 100644 arch/loongarch/include/asm/module.h
> >   create mode 100644 arch/loongarch/include/asm/module.lds.h
> >   create mode 100644 arch/loongarch/include/asm/vermagic.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/auxvec.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/hwcap.h
> >   create mode 100644 arch/loongarch/kernel/elf.c
> >   create mode 100644 arch/loongarch/kernel/inst.c
> >   create mode 100644 arch/loongarch/kernel/module-sections.c
> >   create mode 100644 arch/loongarch/kernel/module.c
> >
> > diff --git a/arch/loongarch/include/asm/cpufeature.h b/arch/loongarch/include/asm/cpufeature.h
> > new file mode 100644
> > index 000000000000..4da22a8e63de
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/cpufeature.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * CPU feature definitions for module loading, used by
> > + * module_cpu_feature_match(), see uapi/asm/hwcap.h for LoongArch CPU features.
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef __ASM_CPUFEATURE_H
> > +#define __ASM_CPUFEATURE_H
> > +
> > +#include <uapi/asm/hwcap.h>
> > +#include <asm/elf.h>
> > +
> > +#define MAX_CPU_FEATURES (8 * sizeof(elf_hwcap))
> > +
> > +#define cpu_feature(x)               ilog2(HWCAP_ ## x)
> > +
> > +static inline bool cpu_have_feature(unsigned int num)
> > +{
> > +     return elf_hwcap & (1UL << num);
> > +}
> > +
> > +#endif /* __ASM_CPUFEATURE_H */
> > diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
> > new file mode 100644
> > index 000000000000..52734d705545
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/elf.h
> > @@ -0,0 +1,299 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_ELF_H
> > +#define _ASM_ELF_H
> > +
> > +#include <linux/auxvec.h>
> > +#include <linux/fs.h>
> > +#include <uapi/linux/elf.h>
> > +
> > +#include <asm/current.h>
> > +#include <asm/vdso.h>
> > +
> > +/* ELF header e_flags defines. */
> > +
> > +/* The ABI of a file. */
> > +#define EF_LARCH_ABI_LP32            0x00000001      /* LP32 ABI.  */
> > +#define EF_LARCH_ABI_LP64            0x00000003      /* LP64 ABI  */
> > +#define EF_LARCH_ABI                 0x00000003
>
> These 3 constants are unused anywhere else, in addition they're from the
> old-world. (New-world definitions can be checked at [1]; and it'll soon
> get amended *again*, discussion at [2] in Chinese.)
>
> It seems we could just remove the definitions for now.
I want to define the correct macros as binutils.

>
> [1]:
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=include/elf/loongarch.h;h=b7aa4ff069c4ce9c60d046274ad9cc74cb2e5d6b;hb=HEAD#l95
> [2]: https://github.com/loongson/LoongArch-Documentation/pull/47
>
> > +
> > +/* LoongArch relocation types used by the dynamic linker */
> > +#define R_LARCH_NONE                         0
> > +#define R_LARCH_32                           1
> > +#define R_LARCH_64                           2
> > +#define R_LARCH_RELATIVE                     3
> > +#define R_LARCH_COPY                         4
> > +#define R_LARCH_JUMP_SLOT                    5
> > +#define R_LARCH_TLS_DTPMOD32                 6
> > +#define R_LARCH_TLS_DTPMOD64                 7
> > +#define R_LARCH_TLS_DTPREL32                 8
> > +#define R_LARCH_TLS_DTPREL64                 9
> > +#define R_LARCH_TLS_TPREL32                  10
> > +#define R_LARCH_TLS_TPREL64                  11
> > +#define R_LARCH_IRELATIVE                    12
> > +#define R_LARCH_MARK_LA                              20
> > +#define R_LARCH_MARK_PCREL                   21
> > +#define R_LARCH_SOP_PUSH_PCREL                       22
> > +#define R_LARCH_SOP_PUSH_ABSOLUTE            23
> > +#define R_LARCH_SOP_PUSH_DUP                 24
> > +#define R_LARCH_SOP_PUSH_GPREL                       25
> > +#define R_LARCH_SOP_PUSH_TLS_TPREL           26
> > +#define R_LARCH_SOP_PUSH_TLS_GOT             27
> > +#define R_LARCH_SOP_PUSH_TLS_GD                      28
> > +#define R_LARCH_SOP_PUSH_PLT_PCREL           29
> > +#define R_LARCH_SOP_ASSERT                   30
> > +#define R_LARCH_SOP_NOT                              31
> > +#define R_LARCH_SOP_SUB                              32
> > +#define R_LARCH_SOP_SL                               33
> > +#define R_LARCH_SOP_SR                               34
> > +#define R_LARCH_SOP_ADD                              35
> > +#define R_LARCH_SOP_AND                              36
> > +#define R_LARCH_SOP_IF_ELSE                  37
> > +#define R_LARCH_SOP_POP_32_S_10_5            38
> > +#define R_LARCH_SOP_POP_32_U_10_12           39
> > +#define R_LARCH_SOP_POP_32_S_10_12           40
> > +#define R_LARCH_SOP_POP_32_S_10_16           41
> > +#define R_LARCH_SOP_POP_32_S_10_16_S2                42
> > +#define R_LARCH_SOP_POP_32_S_5_20            43
> > +#define R_LARCH_SOP_POP_32_S_0_5_10_16_S2    44
> > +#define R_LARCH_SOP_POP_32_S_0_10_10_16_S2   45
> > +#define R_LARCH_SOP_POP_32_U                 46
> > +#define R_LARCH_ADD8                         47
> > +#define R_LARCH_ADD16                                48
> > +#define R_LARCH_ADD24                                49
> > +#define R_LARCH_ADD32                                50
> > +#define R_LARCH_ADD64                                51
> > +#define R_LARCH_SUB8                         52
> > +#define R_LARCH_SUB16                                53
> > +#define R_LARCH_SUB24                                54
> > +#define R_LARCH_SUB32                                55
> > +#define R_LARCH_SUB64                                56
> > +#define R_LARCH_GNU_VTINHERIT                        57
> > +#define R_LARCH_GNU_VTENTRY                  58
> > +
> > +#ifndef ELF_ARCH
> > +
> > +/* ELF register definitions */
> > +
> > +/*
> > + * General purpose have the following registers:
> > + *   Register        Number
> > + *   GPRs            32
> > + *   ORIG_A0         1
> > + *   ERA             1
> > + *   BADVADDR        1
> > + *   CRMD            1
> > + *   PRMD            1
> > + *   EUEN            1
> > + *   ECFG            1
> > + *   ESTAT           1
> > + *   Reserved        5
> > + */
> > +#define ELF_NGREG    45
> > +
> > +/*
> > + * Floating point have the following registers:
> > + *   Register        Number
> > + *   FPR             32
> > + *   FCC             1
> > + *   FCSR            1
> > + */
> > +#define ELF_NFPREG   34
> > +
> > +typedef unsigned long elf_greg_t;
> > +typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> > +
> > +typedef double elf_fpreg_t;
> > +typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
> > +
> > +void loongarch_dump_regs64(u64 *uregs, const struct pt_regs *regs);
> > +
> > +#ifdef CONFIG_32BIT
> > +/*
> > + * This is used to ensure we don't load something for the wrong architecture.
> > + */
> > +#define elf_check_arch elf32_check_arch
> > +
> > +/*
> > + * These are used to set parameters in the core dumps.
> > + */
> > +#define ELF_CLASS    ELFCLASS32
> > +
> > +#define ELF_CORE_COPY_REGS(dest, regs) \
> > +     loongarch_dump_regs32((u32 *)&(dest), (regs));
> > +
> > +#endif /* CONFIG_32BIT */
> > +
> > +#ifdef CONFIG_64BIT
> > +/*
> > + * This is used to ensure we don't load something for the wrong architecture.
> > + */
> > +#define elf_check_arch elf64_check_arch
> > +
> > +/*
> > + * These are used to set parameters in the core dumps.
> > + */
> > +#define ELF_CLASS    ELFCLASS64
> > +
> > +#define ELF_CORE_COPY_REGS(dest, regs) \
> > +     loongarch_dump_regs64((u64 *)&(dest), (regs));
> > +
> > +#endif /* CONFIG_64BIT */
> > +
> > +/*
> > + * These are used to set parameters in the core dumps.
> > + */
> > +#define ELF_DATA     ELFDATA2LSB
> > +#define ELF_ARCH     EM_LOONGARCH
> > +
> > +#endif /* !defined(ELF_ARCH) */
> > +
> > +#define loongarch_elf_check_machine(x) ((x)->e_machine == EM_LOONGARCH)
> > +
> > +#define vmcore_elf32_check_arch loongarch_elf_check_machine
> > +#define vmcore_elf64_check_arch loongarch_elf_check_machine
> > +
> > +/*
> > + * Return non-zero if HDR identifies an 32bit ELF binary.
> > + */
> > +#define elf32_check_arch(hdr)                                                \
> > +({                                                                   \
> > +     int __res = 1;                                                  \
> > +     struct elfhdr *__h = (hdr);                                     \
> > +                                                                     \
> > +     if (!loongarch_elf_check_machine(__h))                          \
> > +             __res = 0;                                              \
> > +     if (__h->e_ident[EI_CLASS] != ELFCLASS32)                       \
> > +             __res = 0;                                              \
> > +                                                                     \
> > +     __res;                                                          \
> > +})
> > +
> > +/*
> > + * Return non-zero if HDR identifies an 64bit ELF binary.
> > + */
> > +#define elf64_check_arch(hdr)                                                \
> > +({                                                                   \
> > +     int __res = 1;                                                  \
> > +     struct elfhdr *__h = (hdr);                                     \
> > +                                                                     \
> > +     if (!loongarch_elf_check_machine(__h))                          \
> > +             __res = 0;                                              \
> > +     if (__h->e_ident[EI_CLASS] != ELFCLASS64)                       \
> > +             __res = 0;                                              \
> > +                                                                     \
> > +     __res;                                                          \
> > +})
> > +
> > +#ifdef CONFIG_32BIT
> > +
> > +#define SET_PERSONALITY2(ex, state)                                  \
> > +do {                                                                 \
> > +     current->thread.vdso = &vdso_info;                              \
> > +                                                                     \
> > +     loongarch_set_personality_fcsr(state);                          \
> > +                                                                     \
> > +     if (personality(current->personality) != PER_LINUX)             \
> > +             set_personality(PER_LINUX);                             \
> > +} while (0)
> > +
> > +#endif /* CONFIG_32BIT */
> > +
> > +#ifdef CONFIG_64BIT
> > +
> > +#define SET_PERSONALITY2(ex, state)                                  \
> > +do {                                                                 \
> > +     unsigned int p;                                                 \
> > +                                                                     \
> > +     clear_thread_flag(TIF_32BIT_REGS);                              \
> > +     clear_thread_flag(TIF_32BIT_ADDR);                              \
> > +                                                                     \
> > +     current->thread.vdso = &vdso_info;                              \
> > +     loongarch_set_personality_fcsr(state);                          \
> > +                                                                     \
> > +     p = personality(current->personality);                          \
> > +     if (p != PER_LINUX32 && p != PER_LINUX)                         \
> > +             set_personality(PER_LINUX);                             \
> > +} while (0)
> > +
> > +#endif /* CONFIG_64BIT */
> > +
> > +#define CORE_DUMP_USE_REGSET
> > +#define ELF_EXEC_PAGESIZE    PAGE_SIZE
> > +
> > +/*
> > + * This yields a mask that user programs can use to figure out what
> > + * instruction set this cpu supports. This could be done in userspace,
> > + * but it's not easy, and we've already done it here.
> > + */
> > +
> > +#define ELF_HWCAP    (elf_hwcap)
> > +extern unsigned int elf_hwcap;
> > +#include <asm/hwcap.h>
> > +
> > +/*
> > + * This yields a string that ld.so will use to load implementation
> > + * specific libraries for optimization.       This is more specific in
> > + * intent than poking at uname or /proc/cpuinfo.
> > + */
> > +
> > +#define ELF_PLATFORM  __elf_platform
> > +extern const char *__elf_platform;
> > +
> > +#define ELF_PLAT_INIT(_r, load_addr) do { \
> > +     _r->regs[1] = _r->regs[2] = _r->regs[3] = _r->regs[4] = 0;      \
> > +     _r->regs[5] = _r->regs[6] = _r->regs[7] = _r->regs[8] = 0;      \
> > +     _r->regs[9] = _r->regs[10] = _r->regs[11] = _r->regs[12] = 0;   \
> > +     _r->regs[13] = _r->regs[14] = _r->regs[15] = _r->regs[16] = 0;  \
> > +     _r->regs[17] = _r->regs[18] = _r->regs[19] = _r->regs[20] = 0;  \
> > +     _r->regs[21] = _r->regs[22] = _r->regs[23] = _r->regs[24] = 0;  \
> > +     _r->regs[25] = _r->regs[26] = _r->regs[27] = _r->regs[28] = 0;  \
> > +     _r->regs[29] = _r->regs[30] = _r->regs[31] = 0;                 \
> > +} while (0)
> > +
> > +/*
> > + * This is the location that an ET_DYN program is loaded if exec'ed. Typical
> > + * use of this is to invoke "./ld.so someprog" to test out a new version of
> > + * the loader. We need to make sure that it is out of the way of the program
> > + * that it will "exec", and that there is sufficient room for the brk.
> > + */
> > +
> > +#define ELF_ET_DYN_BASE              (TASK_SIZE / 3 * 2)
> > +
> > +/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
> > +#define ARCH_DLINFO                                                  \
> > +do {                                                                 \
> > +     NEW_AUX_ENT(AT_SYSINFO_EHDR,                                    \
> > +                 (unsigned long)current->mm->context.vdso);          \
> > +} while (0)
> > +
> > +#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
> > +struct linux_binprm;
> > +extern int arch_setup_additional_pages(struct linux_binprm *bprm,
> > +                                    int uses_interp);
> > +
> > +struct arch_elf_state {
> > +     int fp_abi;
> > +     int interp_fp_abi;
> > +};
> > +
> > +#define LOONGARCH_ABI_FP_ANY (0)
> > +
> > +#define INIT_ARCH_ELF_STATE {                        \
> > +     .fp_abi = LOONGARCH_ABI_FP_ANY,         \
> > +     .interp_fp_abi = LOONGARCH_ABI_FP_ANY,  \
> > +}
> > +
> > +#define elf_read_implies_exec(ex, exec_stk) (exec_stk == EXSTACK_DEFAULT)
> > +
> > +extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
> > +                         bool is_interp, struct arch_elf_state *state);
> > +
> > +extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
> > +                       struct arch_elf_state *state);
> > +
> > +extern void loongarch_set_personality_fcsr(struct arch_elf_state *state);
> > +
> > +#endif /* _ASM_ELF_H */
> > diff --git a/arch/loongarch/include/asm/exec.h b/arch/loongarch/include/asm/exec.h
> > new file mode 100644
> > index 000000000000..ba0220812ebb
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/exec.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_EXEC_H
> > +#define _ASM_EXEC_H
> > +
> > +extern unsigned long arch_align_stack(unsigned long sp);
> > +
> > +#endif /* _ASM_EXEC_H */
> > diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
> > new file mode 100644
> > index 000000000000..5f716a851083
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/module.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_MODULE_H
> > +#define _ASM_MODULE_H
> > +
> > +#include <asm/inst.h>
> > +#include <asm-generic/module.h>
> > +
> > +#define RELA_STACK_DEPTH 16
> > +
> > +struct mod_section {
> > +     Elf_Shdr *shdr;
> > +     int num_entries;
> > +     int max_entries;
> > +};
> > +
> > +struct mod_arch_specific {
> > +     struct mod_section plt;
> > +     struct mod_section plt_idx;
> > +};
> > +
> > +struct plt_entry {
> > +     u32 inst_lu12iw;
> > +     u32 inst_lu32id;
> > +     u32 inst_lu52id;
> > +     u32 inst_jirl;
> > +};
> > +
> > +struct plt_idx_entry {
> > +     unsigned long symbol_addr;
> > +};
> > +
> > +Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val);
> > +
> > +static inline struct plt_entry emit_plt_entry(unsigned long val)
> > +{
> > +     u32 lu12iw, lu32id, lu52id, jirl;
> > +
> > +     lu12iw = (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) | LOONGARCH_GPR_T1),
>
> And here's that instruction, famously ubiquitous while not belonging to
> any of the 9 "basic" formats (hence no helper for emitting it).
>
> We can adopt the loongarch-opcodes [3] scheme and make everything
> consistent later. ;-)
>
> [3]: https://github.com/loongson-community/loongarch-opcodes
>
> (Disclaimer: I'm the creator and maintainer of said community scheme,
> although that doesn't make the "official" or "ISA manual" scheme more
> correct.)
>
> > +     lu32id = larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val, LU32ID));
> > +     lu52id = larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1, ADDR_IMM(val, LU52ID));
> > +     jirl = larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
> > +
> > +     return (struct plt_entry) { lu12iw, lu32id, lu52id, jirl };
> > +}
> > +
> > +static inline struct plt_idx_entry emit_plt_idx_entry(unsigned long val)
> > +{
> > +     return (struct plt_idx_entry) { val };
> > +}
> > +
> > +static inline int get_plt_idx(unsigned long val, const struct mod_section *sec)
> > +{
> > +     int i;
> > +     struct plt_idx_entry *plt_idx = (struct plt_idx_entry *)sec->shdr->sh_addr;
> > +
> > +     for (i = 0; i < sec->num_entries; i++) {
> > +             if (plt_idx[i].symbol_addr == val)
> > +                     return i;
> > +     }
> > +
> > +     return -1;
> > +}
> > +
> > +static inline struct plt_entry *get_plt_entry(unsigned long val,
> > +                                   const struct mod_section *sec_plt,
> > +                                   const struct mod_section *sec_plt_idx)
> > +{
> > +     int plt_idx = get_plt_idx(val, sec_plt_idx);
> > +     struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
> > +
> > +     if (plt_idx < 0)
> > +             return NULL;
> > +
> > +     return plt + plt_idx;
> > +}
> > +
> > +#endif /* _ASM_MODULE_H */
> > diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
> > new file mode 100644
> > index 000000000000..31c1c0db11a3
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/module.lds.h
> > @@ -0,0 +1,7 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2020-2022 Loongson Technology Corporation Limited */
> > +SECTIONS {
> > +     . = ALIGN(4);
> > +     .plt : { BYTE(0) }
> > +     .plt.idx : { BYTE(0) }
> > +}
> > diff --git a/arch/loongarch/include/asm/vermagic.h b/arch/loongarch/include/asm/vermagic.h
> > new file mode 100644
> > index 000000000000..8b47ccfe3aad
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/vermagic.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_VERMAGIC_H
> > +#define _ASM_VERMAGIC_H
> > +
> > +#define MODULE_PROC_FAMILY "LOONGARCH "
> > +
> > +#ifdef CONFIG_32BIT
> > +#define MODULE_KERNEL_TYPE "32BIT "
> > +#elif defined CONFIG_64BIT
> > +#define MODULE_KERNEL_TYPE "64BIT "
> > +#endif
> > +
> > +#define MODULE_ARCH_VERMAGIC \
> > +     MODULE_PROC_FAMILY MODULE_KERNEL_TYPE
> > +
> > +#endif /* _ASM_VERMAGIC_H */
> > diff --git a/arch/loongarch/include/uapi/asm/auxvec.h b/arch/loongarch/include/uapi/asm/auxvec.h
> > new file mode 100644
> > index 000000000000..922d9e6b5058
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/auxvec.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef __ASM_AUXVEC_H
> > +#define __ASM_AUXVEC_H
> > +
> > +/* Location of VDSO image. */
> > +#define AT_SYSINFO_EHDR              33
> > +
> > +#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
> > +
> > +#endif /* __ASM_AUXVEC_H */
> > diff --git a/arch/loongarch/include/uapi/asm/hwcap.h b/arch/loongarch/include/uapi/asm/hwcap.h
> > new file mode 100644
> > index 000000000000..8840b72fa8e8
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/hwcap.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_ASM_HWCAP_H
> > +#define _UAPI_ASM_HWCAP_H
> > +
> > +/* HWCAP flags */
> > +#define HWCAP_LOONGARCH_CPUCFG               (1 << 0)
> > +#define HWCAP_LOONGARCH_LAM          (1 << 1)
> > +#define HWCAP_LOONGARCH_UAL          (1 << 2)
> > +#define HWCAP_LOONGARCH_FPU          (1 << 3)
> > +#define HWCAP_LOONGARCH_LSX          (1 << 4)
> > +#define HWCAP_LOONGARCH_LASX         (1 << 5)
> > +#define HWCAP_LOONGARCH_CRC32                (1 << 6)
> > +#define HWCAP_LOONGARCH_COMPLEX              (1 << 7)
> > +#define HWCAP_LOONGARCH_CRYPTO               (1 << 8)
> > +#define HWCAP_LOONGARCH_LVZ          (1 << 9)
> > +#define HWCAP_LOONGARCH_LBT_X86              (1 << 10)
> > +#define HWCAP_LOONGARCH_LBT_ARM              (1 << 11)
> > +#define HWCAP_LOONGARCH_LBT_MIPS     (1 << 12)
> > +
> > +#endif /* _UAPI_ASM_HWCAP_H */
> > diff --git a/arch/loongarch/kernel/elf.c b/arch/loongarch/kernel/elf.c
> > new file mode 100644
> > index 000000000000..183e94fc9c69
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/elf.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Author: Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/binfmts.h>
> > +#include <linux/elf.h>
> > +#include <linux/export.h>
> > +#include <linux/sched.h>
> > +
> > +#include <asm/cpu-features.h>
> > +#include <asm/cpu-info.h>
> > +
> > +int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
> > +                  bool is_interp, struct arch_elf_state *state)
> > +{
> > +     return 0;
> > +}
> > +
> > +int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
> > +                struct arch_elf_state *state)
> > +{
> > +     return 0;
> > +}
> > +
> > +void loongarch_set_personality_fcsr(struct arch_elf_state *state)
> > +{
> > +     current->thread.fpu.fcsr = boot_cpu_data.fpu_csr0;
> > +}
> > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
> > new file mode 100644
> > index 000000000000..b1df0ec34bd1
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/inst.c
> > @@ -0,0 +1,40 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#include <asm/inst.h>
> > +
> > +u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
> > +{
> > +     union loongarch_instruction insn;
> > +
> > +     insn.reg1i20_format.opcode = lu32id_op;
> > +     insn.reg1i20_format.rd = rd;
> > +     insn.reg1i20_format.immediate = imm;
> > +
> > +     return insn.word;
> > +}
> > +
> > +u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
> > +{
> > +     union loongarch_instruction insn;
> > +
> > +     insn.reg2i12_format.opcode = lu52id_op;
> > +     insn.reg2i12_format.rd = rd;
> > +     insn.reg2i12_format.rj = rj;
> > +     insn.reg2i12_format.immediate = imm;
> > +
> > +     return insn.word;
> > +}
> > +
> > +u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest)
> > +{
> > +     union loongarch_instruction insn;
> > +
> > +     insn.reg2i16_format.opcode = jirl_op;
> > +     insn.reg2i16_format.rd = rd;
> > +     insn.reg2i16_format.rj = rj;
> > +     insn.reg2i16_format.immediate = (dest - pc) >> 2;
> > +
> > +     return insn.word;
> > +}
> > diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
> > new file mode 100644
> > index 000000000000..6d498288977d
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/module-sections.c
> > @@ -0,0 +1,121 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#include <linux/elf.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val)
> > +{
> > +     int nr;
> > +     struct mod_section *plt_sec = &mod->arch.plt;
> > +     struct mod_section *plt_idx_sec = &mod->arch.plt_idx;
> > +     struct plt_entry *plt = get_plt_entry(val, plt_sec, plt_idx_sec);
> > +     struct plt_idx_entry *plt_idx;
> > +
> > +     if (plt)
> > +             return (Elf_Addr)plt;
> > +
> > +     nr = plt_sec->num_entries;
> > +
> > +     /* There is no duplicate entry, create a new one */
> > +     plt = (struct plt_entry *)plt_sec->shdr->sh_addr;
> > +     plt[nr] = emit_plt_entry(val);
> > +     plt_idx = (struct plt_idx_entry *)plt_idx_sec->shdr->sh_addr;
> > +     plt_idx[nr] = emit_plt_idx_entry(val);
> > +
> > +     plt_sec->num_entries++;
> > +     plt_idx_sec->num_entries++;
> > +     BUG_ON(plt_sec->num_entries > plt_sec->max_entries);
> > +
> > +     return (Elf_Addr)&plt[nr];
> > +}
> > +
> > +static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
> > +{
> > +     return x->r_info == y->r_info && x->r_addend == y->r_addend;
> > +}
> > +
> > +static bool duplicate_rela(const Elf_Rela *rela, int idx)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < idx; i++) {
> > +             if (is_rela_equal(&rela[i], &rela[idx]))
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts)
> > +{
> > +     unsigned int i, type;
> > +
> > +     for (i = 0; i < num; i++) {
> > +             type = ELF_R_TYPE(relas[i].r_info);
> > +             if (type == R_LARCH_SOP_PUSH_PLT_PCREL) {
> > +                     if (!duplicate_rela(relas, i))
> > +                             (*plts)++;
> > +             }
> > +     }
> > +}
> > +
> > +int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> > +                           char *secstrings, struct module *mod)
> > +{
> > +     unsigned int i, num_plts = 0;
> > +
> > +     /*
> > +      * Find the empty .plt sections.
> > +      */
> > +     for (i = 0; i < ehdr->e_shnum; i++) {
> > +             if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> > +                     mod->arch.plt.shdr = sechdrs + i;
> > +             else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
> > +                     mod->arch.plt_idx.shdr = sechdrs + i;
> > +     }
> > +
> > +     if (!mod->arch.plt.shdr) {
> > +             pr_err("%s: module PLT section(s) missing\n", mod->name);
> > +             return -ENOEXEC;
> > +     }
> > +     if (!mod->arch.plt_idx.shdr) {
> > +             pr_err("%s: module PLT.IDX section(s) missing\n", mod->name);
> > +             return -ENOEXEC;
> > +     }
> > +
> > +     /* Calculate the maxinum number of entries */
> > +     for (i = 0; i < ehdr->e_shnum; i++) {
> > +             int num_rela = sechdrs[i].sh_size / sizeof(Elf_Rela);
> > +             Elf_Rela *relas = (void *)ehdr + sechdrs[i].sh_offset;
> > +             Elf_Shdr *dst_sec = sechdrs + sechdrs[i].sh_info;
> > +
> > +             if (sechdrs[i].sh_type != SHT_RELA)
> > +                     continue;
> > +
> > +             /* ignore relocations that operate on non-exec sections */
> > +             if (!(dst_sec->sh_flags & SHF_EXECINSTR))
> > +                     continue;
> > +
> > +             count_max_entries(relas, num_rela, &num_plts);
> > +     }
> > +
> > +     mod->arch.plt.shdr->sh_type = SHT_NOBITS;
> > +     mod->arch.plt.shdr->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> > +     mod->arch.plt.shdr->sh_addralign = L1_CACHE_BYTES;
> > +     mod->arch.plt.shdr->sh_size = (num_plts + 1) * sizeof(struct plt_entry);
> > +     mod->arch.plt.num_entries = 0;
> > +     mod->arch.plt.max_entries = num_plts;
> > +
> > +     mod->arch.plt_idx.shdr->sh_type = SHT_NOBITS;
> > +     mod->arch.plt_idx.shdr->sh_flags = SHF_ALLOC;
> > +     mod->arch.plt_idx.shdr->sh_addralign = L1_CACHE_BYTES;
> > +     mod->arch.plt_idx.shdr->sh_size = (num_plts + 1) * sizeof(struct plt_idx_entry);
> > +     mod->arch.plt_idx.num_entries = 0;
> > +     mod->arch.plt_idx.max_entries = num_plts;
> > +
> > +     return 0;
> > +}
> > diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> > new file mode 100644
> > index 000000000000..f2d3bcd35a39
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/module.c
> > @@ -0,0 +1,374 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +
> > +#define pr_fmt(fmt) "kmod: " fmt
> > +
> > +#include <linux/moduleloader.h>
> > +#include <linux/elf.h>
> > +#include <linux/mm.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/slab.h>
> > +#include <linux/fs.h>
> > +#include <linux/string.h>
> > +#include <linux/kernel.h>
> > +
> > +static inline bool signed_imm_check(long val, unsigned int bit)
> > +{
> > +     return -(1L << (bit - 1)) <= val && val < (1L << (bit - 1));
> > +}
> > +
> > +static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
> > +{
> > +     return val < (1UL << bit);
> > +}
> > +
> > +static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
> > +{
> > +     if (*rela_stack_top >= RELA_STACK_DEPTH)
> > +             return -ENOEXEC;
> > +
> > +     rela_stack[(*rela_stack_top)++] = stack_value;
> > +     pr_debug("%s stack_value = 0x%llx\n", __func__, stack_value);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rela_stack_pop(s64 *stack_value, s64 *rela_stack, size_t *rela_stack_top)
> > +{
> > +     if (*rela_stack_top == 0)
> > +             return -ENOEXEC;
> > +
> > +     *stack_value = rela_stack[--(*rela_stack_top)];
> > +     pr_debug("%s stack_value = 0x%llx\n", __func__, *stack_value);
> > +
> > +     return 0;
> > +}
> > +
> > +static int apply_r_larch_none(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     return 0;
> > +}
> > +
> > +static int apply_r_larch_error(struct module *me, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     pr_err("%s: Unsupport relocation type %u, please add its support.\n", me->name, type);
> > +     return -EINVAL;
> > +}
> > +
> > +static int apply_r_larch_32(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     *location = v;
> > +     return 0;
> > +}
> > +
> > +static int apply_r_larch_64(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     *(Elf_Addr *)location = v;
> > +     return 0;
> > +}
> > +
> > +static int apply_r_larch_sop_push_pcrel(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     return rela_stack_push(v - (u64)location, rela_stack, rela_stack_top);
> > +}
> > +
> > +static int apply_r_larch_sop_push_absolute(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     return rela_stack_push(v, rela_stack, rela_stack_top);
> > +}
> > +
> > +static int apply_r_larch_sop_push_dup(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     int err = 0;
> > +     s64 opr1;
> > +
> > +     err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
> > +     if (err)
> > +             return err;
> > +     err = rela_stack_push(opr1, rela_stack, rela_stack_top);
> > +     if (err)
> > +             return err;
> > +     err = rela_stack_push(opr1, rela_stack, rela_stack_top);
> > +     if (err)
> > +             return err;
> > +
> > +     return 0;
> > +}
> > +
> > +static int apply_r_larch_sop_push_plt_pcrel(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     ptrdiff_t offset = (void *)v - (void *)location;
> > +
> > +     if (offset >= SZ_128M)
> > +             v = module_emit_plt_entry(mod, v);
> > +
> > +     if (offset < -SZ_128M)
> > +             v = module_emit_plt_entry(mod, v);
> > +
> > +     return apply_r_larch_sop_push_pcrel(mod, location, v, rela_stack, rela_stack_top, type);
> > +}
> > +
> > +static int apply_r_larch_sop(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     int err = 0;
> > +     s64 opr1, opr2, opr3;
> > +
> > +     if (type == R_LARCH_SOP_IF_ELSE) {
> > +             err = rela_stack_pop(&opr3, rela_stack, rela_stack_top);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     err = rela_stack_pop(&opr2, rela_stack, rela_stack_top);
> > +     if (err)
> > +             return err;
> > +     err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
> > +     if (err)
> > +             return err;
> > +
> > +     switch (type) {
> > +     case R_LARCH_SOP_AND:
> > +             err = rela_stack_push(opr1 & opr2, rela_stack, rela_stack_top);
> > +             break;
> > +     case R_LARCH_SOP_ADD:
> > +             err = rela_stack_push(opr1 + opr2, rela_stack, rela_stack_top);
> > +             break;
> > +     case R_LARCH_SOP_SUB:
> > +             err = rela_stack_push(opr1 - opr2, rela_stack, rela_stack_top);
> > +             break;
> > +     case R_LARCH_SOP_SL:
> > +             err = rela_stack_push(opr1 << opr2, rela_stack, rela_stack_top);
> > +             break;
> > +     case R_LARCH_SOP_SR:
> > +             err = rela_stack_push(opr1 >> opr2, rela_stack, rela_stack_top);
> > +             break;
> > +     case R_LARCH_SOP_IF_ELSE:
> > +             err = rela_stack_push(opr1 ? opr2 : opr3, rela_stack, rela_stack_top);
> > +             break;
> > +     default:
> > +             pr_err("%s: Unsupport relocation type %u handler\n", mod->name, type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static int apply_r_larch_sop_imm_field(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     int err = 0;
> > +     s64 opr1;
> > +     union loongarch_instruction *insn = (union loongarch_instruction *)location;
> > +
> > +     err = rela_stack_pop(&opr1, rela_stack, rela_stack_top);
> > +     if (err)
> > +             return err;
> > +
> > +     switch (type) {
> > +     case R_LARCH_SOP_POP_32_U_10_12:
> > +             if (!unsigned_imm_check(opr1, 12))
> > +                     goto overflow;
> > +
> > +             /* (*(uint32_t *) PC) [21 ... 10] = opr [11 ... 0] */
> > +             insn->reg2i12_format.immediate = opr1 & 0xfff;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_S_10_12:
> > +             if (!signed_imm_check(opr1, 12))
> > +                     goto overflow;
> > +
> > +             insn->reg2i12_format.immediate = opr1 & 0xfff;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_S_10_16:
> > +             if (!signed_imm_check(opr1, 16))
> > +                     goto overflow;
> > +
> > +             insn->reg2i16_format.immediate = opr1 & 0xffff;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_S_10_16_S2:
> > +             if (opr1 % 4)
> > +                     goto unaligned;
> > +
> > +             if (!signed_imm_check(opr1, 18))
> > +                     goto overflow;
> > +
> > +             insn->reg2i16_format.immediate = (opr1 >> 2) & 0xffff;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_S_5_20:
> > +             if (!signed_imm_check(opr1, 20))
> > +                     goto overflow;
> > +
> > +             insn->reg1i20_format.immediate = (opr1) & 0xfffff;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_S_0_5_10_16_S2:
> > +             if (opr1 % 4)
> > +                     goto unaligned;
> > +
> > +             if (!signed_imm_check(opr1, 23))
> > +                     goto overflow;
> > +
> > +             opr1 >>= 2;
> > +             insn->reg1i21_format.immediate_l = opr1 & 0xffff;
> > +             insn->reg1i21_format.immediate_h = (opr1 >> 16) & 0x1f;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_S_0_10_10_16_S2:
> > +             if (opr1 % 4)
> > +                     goto unaligned;
> > +
> > +             if (!signed_imm_check(opr1, 28))
> > +                     goto overflow;
> > +
> > +             opr1 >>= 2;
> > +             insn->reg0i26_format.immediate_l = opr1 & 0xffff;
> > +             insn->reg0i26_format.immediate_h = (opr1 >> 16) & 0x3ff;
> > +             return 0;
> > +     case R_LARCH_SOP_POP_32_U:
> > +             if (!unsigned_imm_check(opr1, 32))
> > +                     goto overflow;
> > +
> > +             /* (*(uint32_t *) PC) = opr */
> > +             *location = (u32)opr1;
> > +             return 0;
> > +     default:
> > +             pr_err("%s: Unsupport relocation type %u handler\n", mod->name, type);
> "%s: Unsupported relocation type %u" would be enough.
OK, thanks.

Huacai
> > +             return -EINVAL;
> > +     }
> > +
> > +overflow:
> > +     pr_err("module %s: opr1 = 0x%llx overflow! dangerous %s (%u) relocation\n",
> > +             mod->name, opr1, __func__, type);
> > +     return -ENOEXEC;
> > +
> > +unaligned:
> > +     pr_err("module %s: opr1 = 0x%llx unaligned! dangerous %s (%u) relocation\n",
> > +             mod->name, opr1, __func__, type);
> > +     return -ENOEXEC;
> > +}
> > +
> > +static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> > +{
> > +     switch (type) {
> > +     case R_LARCH_ADD32:
> > +             *(s32 *)location += v;
> > +             return 0;
> > +     case R_LARCH_ADD64:
> > +             *(s64 *)location += v;
> > +             return 0;
> > +     case R_LARCH_SUB32:
> > +             *(s32 *)location -= v;
> > +             return 0;
> > +     case R_LARCH_SUB64:
> > +             *(s64 *)location -= v;
> > +             return 0;
> > +     default:
> > +             pr_err("%s: Unsupport relocation type %u handler\n", mod->name, type);
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +/*
> > + * reloc_handlers_rela() - Apply a particular relocation to a module
> > + * @mod: the module to apply the reloc to
> > + * @location: the address at which the reloc is to be applied
> > + * @v: the value of the reloc, with addend for RELA-style
> > + * @rela_stack: the stack used for store relocation info, LOCAL to THIS module
> > + * @rela_stac_top: where the stack operation(pop/push) applies to
> > + *
> > + * Return: 0 upon success, else -ERRNO
> > + */
> > +typedef int (*reloc_rela_handler)(struct module *mod, u32 *location, Elf_Addr v,
> > +                     s64 *rela_stack, size_t *rela_stack_top, unsigned int type);
> > +
> > +/* The handlers for known reloc types */
> > +static reloc_rela_handler reloc_rela_handlers[] = {
> > +     [R_LARCH_NONE ... R_LARCH_SUB64]                     = apply_r_larch_error,
> > +
> > +     [R_LARCH_NONE]                                       = apply_r_larch_none,
> > +     [R_LARCH_32]                                         = apply_r_larch_32,
> > +     [R_LARCH_64]                                         = apply_r_larch_64,
> > +     [R_LARCH_MARK_LA]                                    = apply_r_larch_none,
> > +     [R_LARCH_MARK_PCREL]                                 = apply_r_larch_none,
> > +     [R_LARCH_SOP_PUSH_PCREL]                             = apply_r_larch_sop_push_pcrel,
> > +     [R_LARCH_SOP_PUSH_ABSOLUTE]                          = apply_r_larch_sop_push_absolute,
> > +     [R_LARCH_SOP_PUSH_DUP]                               = apply_r_larch_sop_push_dup,
> > +     [R_LARCH_SOP_PUSH_PLT_PCREL]                         = apply_r_larch_sop_push_plt_pcrel,
> > +     [R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE]            = apply_r_larch_sop,
> > +     [R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
> > +     [R_LARCH_ADD32 ... R_LARCH_SUB64]                    = apply_r_larch_add_sub,
> > +};
> > +
> > +int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> > +                    unsigned int symindex, unsigned int relsec,
> > +                    struct module *mod)
> > +{
> > +     int i, err;
> > +     unsigned int type;
> > +     s64 rela_stack[RELA_STACK_DEPTH];
> > +     size_t rela_stack_top = 0;
> > +     reloc_rela_handler handler;
> > +     void *location;
> > +     Elf_Addr v;
> > +     Elf_Sym *sym;
> > +     Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
> > +
> > +     pr_debug("%s: Applying relocate section %u to %u\n", __func__, relsec,
> > +            sechdrs[relsec].sh_info);
> > +
> > +     rela_stack_top = 0;
> > +     for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
> > +             /* This is where to make the change */
> > +             location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr + rel[i].r_offset;
> > +             /* This is the symbol it is referring to */
> > +             sym = (Elf_Sym *)sechdrs[symindex].sh_addr + ELF_R_SYM(rel[i].r_info);
> > +             if (IS_ERR_VALUE(sym->st_value)) {
> > +                     /* Ignore unresolved weak symbol */
> > +                     if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
> > +                             continue;
> > +                     pr_warn("%s: Unknown symbol %s\n", mod->name, strtab + sym->st_name);
> > +                     return -ENOENT;
> > +             }
> > +
> > +             type = ELF_R_TYPE(rel[i].r_info);
> > +
> > +             if (type < ARRAY_SIZE(reloc_rela_handlers))
> > +                     handler = reloc_rela_handlers[type];
> > +             else
> > +                     handler = NULL;
> > +
> > +             if (!handler) {
> > +                     pr_err("%s: Unknown relocation type %u\n", mod->name, type);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             pr_debug("type %d st_value %llx r_addend %llx loc %llx\n",
> > +                    (int)ELF_R_TYPE(rel[i].r_info),
> > +                    sym->st_value, rel[i].r_addend, (u64)location);
> > +
> > +             v = sym->st_value + rel[i].r_addend;
> > +             err = handler(mod, location, v, rela_stack, &rela_stack_top, type);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void *module_alloc(unsigned long size)
> > +{
> > +     return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> > +                     GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
> > +}
>
> Overall good; with the comments and nits addressed,
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
