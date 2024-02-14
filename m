Return-Path: <linux-arch+bounces-2349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF5854D32
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 16:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF3F1C25A33
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7395D91D;
	Wed, 14 Feb 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGO7lM4H"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B555D913;
	Wed, 14 Feb 2024 15:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925509; cv=none; b=qdOHyvLFkJfD+ImEn3VKA9Dps36Fu2W6yijZw/2R1SK6JkY6Ls0E5efYskD8gBqyL8LtvZFe7h3T9T1863Aoz0P9SW8SXWJQtPuQzwbbRWi4o6DDpkMG8IYY8hjgOUfdougcMjbG6ANpMorjboBbJLar0tA1n6kgDGGhZfctg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925509; c=relaxed/simple;
	bh=y/YseAlbFStfyC5/x6Wgpk62mLEvMymc9X6KcW4hIOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYyIR/rHdoRYUqAS0RZFq6cRiQJpvlcqd/0axHGxsAupNAtufzC+Rdg6xjclVh61LnIU4idt1K/jDzbDz9bnEud6ER02lqJxCTswTBDpQGHHMbNno5923868XwSRtPYpBN5JyLpI2BvUqonU30ttz5He/TQHcJrXtw2XvC+Uz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGO7lM4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D17EC43143;
	Wed, 14 Feb 2024 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707925508;
	bh=y/YseAlbFStfyC5/x6Wgpk62mLEvMymc9X6KcW4hIOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hGO7lM4HYIa8cn2K3wKk/CHlq2nsziMAabXo3waBUr7MQX3DOAiajg0VIoxhaxVDR
	 csl4f1qWAujqSn+Eq2zBJCz+PVJJziHKft9zP3l2edQ0CQJ6hIhMEwe0Bwq1MakQjR
	 hjqJlrIxTIotjY54yXy0DQY8iJABzelES80mR1Cv3gy5vQuaHJhryMDWm3eC3QghQ/
	 6AeuSztOx7UJg/IBoI4emcH0dWDRZFejVoXeoxJmWDVB7JvWns3tSS8FicLwnj/OQQ
	 XmAre7hG1iacDCAFsl5DcLUj982K7QW+ExniW7MTBdkzOgENVXmWB76ZGfU6beN/a1
	 Pt1gVLKj+2hng==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-511ac32fe38so757227e87.1;
        Wed, 14 Feb 2024 07:45:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMrnD0xjrVX3errYrweibljLg1htCLtoorwc91s4ACvOvHH5iT1QM5Yjmk0CEniF1w3WVENmN1mJQ71mrjGIRhK1QpAn3rtJtsCQ==
X-Gm-Message-State: AOJu0YzcJxcjjorHhI4Ntko9YlLCIPWQAEGwbXxHRdmBRRKtmexFul9u
	AfN8QHLP8qjFyNlLRiEaB+FdOr9khb0Osch6w8dT6Q1PVI3olAgcwG3XYB2Ua/6cqSqR4Y/4pb6
	8jmXOPk7dilVppJYNCkiKwBgoIJY=
X-Google-Smtp-Source: AGHT+IFgkzGYGretm1q6sj2tBMKJFCtgJ8NhF6XJ5u57pkikzLAtk8J3sLWu/ENM5H2iuY+jZjwJgXJ2njlB8etgBk8=
X-Received: by 2002:a05:6512:53a:b0:511:5994:2c92 with SMTP id
 o26-20020a056512053a00b0051159942c92mr2327562lfc.7.1707925506771; Wed, 14 Feb
 2024 07:45:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-24-ardb+git@google.com> <CAMzpN2jt3nTmDJ4y6zRFJMSGTcD8eQJY_MjbsnJ7my3hH8d9HA@mail.gmail.com>
In-Reply-To: <CAMzpN2jt3nTmDJ4y6zRFJMSGTcD8eQJY_MjbsnJ7my3hH8d9HA@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Feb 2024 16:44:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG6sYAVkKMA9EJk7+NmsbrDBL82xYpMon1WEeB_34SRuA@mail.gmail.com>
Message-ID: <CAMj1kXG6sYAVkKMA9EJk7+NmsbrDBL82xYpMon1WEeB_34SRuA@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] x86/startup_64: Drop global variables keeping
 track of LA57 state
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 16:24, Brian Gerst <brgerst@gmail.com> wrote:
>
> On Tue, Feb 13, 2024 at 7:42=E2=80=AFAM Ard Biesheuvel <ardb+git@google.c=
om> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > On x86_64, the core kernel is entered in long mode, which implies that
> > paging is enabled. This means that the CR4.LA57 control bit is
> > guaranteed to be in sync with the number of paging levels used by the
> > kernel, and there is no need to store this in a variable.
> >
> > There is also no need to use variables for storing the calculations of
> > pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.
> >
> > This removes the need for two different sources of truth for determinin=
g
> > whether 5-level paging is in use: CR4.LA57 always reflects the actual
> > state, and never changes from the point of view of the 64-bit core
> > kernel. The only potential concern is the cost of CR4 accesses, which
> > can be mitigated using alternatives patching based on feature detection=
.
> >
> > Note that even the decompressor does not manipulate any page tables
> > before updating CR4.LA57, so it can also avoid the associated global
> > variables entirely. However, as it does not implement alternatives
> > patching, the associated ELF sections need to be discarded.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/x86/boot/compressed/misc.h         |  4 --
> >  arch/x86/boot/compressed/pgtable_64.c   | 12 ----
> >  arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
> >  arch/x86/include/asm/pgtable_64_types.h | 58 ++++++++------------
> >  arch/x86/kernel/cpu/common.c            |  2 -
> >  arch/x86/kernel/head64.c                | 33 +----------
> >  arch/x86/mm/kasan_init_64.c             |  3 -
> >  arch/x86/mm/mem_encrypt_identity.c      |  9 ---
> >  8 files changed, 27 insertions(+), 95 deletions(-)
> >
> > diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed=
/misc.h
> > index bc2f0f17fb90..2b15ddd0e177 100644
> > --- a/arch/x86/boot/compressed/misc.h
> > +++ b/arch/x86/boot/compressed/misc.h
> > @@ -16,9 +16,6 @@
> >
> >  #define __NO_FORTIFY
> >
> > -/* cpu_feature_enabled() cannot be used this early */
> > -#define USE_EARLY_PGTABLE_L5
> > -
> >  /*
> >   * Boot stub deals with identity mappings, physical and virtual addres=
ses are
> >   * the same, so override these defines.
> > @@ -178,7 +175,6 @@ static inline int count_immovable_mem_regions(void)=
 { return 0; }
> >  #endif
> >
> >  /* ident_map_64.c */
> > -extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
> >  extern void kernel_add_identity_map(unsigned long start, unsigned long=
 end);
> >
> >  /* Used by PAGE_KERN* macros: */
> > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/comp=
ressed/pgtable_64.c
> > index 51f957b24ba7..ae72f53f5e77 100644
> > --- a/arch/x86/boot/compressed/pgtable_64.c
> > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > @@ -9,13 +9,6 @@
> >  #define BIOS_START_MIN         0x20000U        /* 128K, less than this=
 is insane */
> >  #define BIOS_START_MAX         0x9f000U        /* 640K, absolute maxim=
um */
> >
> > -#ifdef CONFIG_X86_5LEVEL
> > -/* __pgtable_l5_enabled needs to be in .data to avoid being cleared al=
ong with .bss */
> > -unsigned int __section(".data") __pgtable_l5_enabled;
> > -unsigned int __section(".data") pgdir_shift =3D 39;
> > -unsigned int __section(".data") ptrs_per_p4d =3D 1;
> > -#endif
> > -
> >  /* Buffer to preserve trampoline memory */
> >  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
> >
> > @@ -125,11 +118,6 @@ asmlinkage void configure_5level_paging(struct boo=
t_params *bp, void *pgtable)
> >                         native_cpuid_eax(0) >=3D 7 &&
> >                         (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 =
& 31)))) {
> >                 l5_required =3D true;
> > -
> > -               /* Initialize variables for 5-level paging */
> > -               __pgtable_l5_enabled =3D 1;
> > -               pgdir_shift =3D 48;
> > -               ptrs_per_p4d =3D 512;
> >         }
> >
> >         /*
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/com=
pressed/vmlinux.lds.S
> > index 083ec6d7722a..06358bb067fe 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -81,6 +81,7 @@ SECTIONS
> >                 *(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
> >                 *(.hash) *(.gnu.hash)
> >                 *(.note.*)
> > +               *(.altinstructions .altinstr_replacement)
> >         }
> >
> >         .got.plt (INFO) : {
> > diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include=
/asm/pgtable_64_types.h
> > index 38b54b992f32..6a57bfdff52b 100644
> > --- a/arch/x86/include/asm/pgtable_64_types.h
> > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > @@ -6,7 +6,10 @@
> >
> >  #ifndef __ASSEMBLY__
> >  #include <linux/types.h>
> > +#include <asm/alternative.h>
> > +#include <asm/cpufeatures.h>
> >  #include <asm/kaslr.h>
> > +#include <asm/processor-flags.h>
> >
> >  /*
> >   * These are used to make use of C type-checking..
> > @@ -21,63 +24,50 @@ typedef unsigned long       pgprotval_t;
> >  typedef struct { pteval_t pte; } pte_t;
> >  typedef struct { pmdval_t pmd; } pmd_t;
> >
> > -#ifdef CONFIG_X86_5LEVEL
> > -extern unsigned int __pgtable_l5_enabled;
> > -
> > -#ifdef USE_EARLY_PGTABLE_L5
> > -/*
> > - * cpu_feature_enabled() is not available in early boot code.
> > - * Use variable instead.
> > - */
> > -static inline bool pgtable_l5_enabled(void)
> > +static __always_inline __pure bool pgtable_l5_enabled(void)
> >  {
> > -       return __pgtable_l5_enabled;
> > -}
> > -#else
> > -#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
> > -#endif /* USE_EARLY_PGTABLE_L5 */
> > +       unsigned long r;
> > +       bool ret;
> >
> > -#else
> > -#define pgtable_l5_enabled() 0
> > -#endif /* CONFIG_X86_5LEVEL */
> > +       if (!IS_ENABLED(CONFIG_X86_5LEVEL))
> > +               return false;
> > +
> > +       asm(ALTERNATIVE_TERNARY(
> > +               "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c=
),
> > +               %P[feat], "stc", "clc")
> > +               : [reg] "=3D&r" (r), CC_OUT(c) (ret)
> > +               : [feat] "i"  (X86_FEATURE_LA57),
> > +                 [la57] "i"  (X86_CR4_LA57_BIT)
> > +               : "cc");
>
> This should be more like _static_cpu_has(), where the runtime test is
> out of line in a discardable section, and the inline part is just a
> JMP or NOP.
>

Why exactly? It matters very little in terms of space, a cross-section
jump is 5 bytes, and movq+btl is 7 bytes.

If you are referring to the use of the C flag: this way, it is left up
to the compiler to decide whether a branch or a conditional move is
more suitable, rather than forcing the use of a branch in one of the
two cases.

