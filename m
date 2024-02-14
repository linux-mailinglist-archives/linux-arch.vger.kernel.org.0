Return-Path: <linux-arch+bounces-2368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4B8553F3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 21:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709421C2363E
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 20:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27A113DBB7;
	Wed, 14 Feb 2024 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLw9eMwG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1513DBBA;
	Wed, 14 Feb 2024 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942367; cv=none; b=KCD1rt96/+kf5RyZNmw2jUx/zvt6gt0CAdPkuivRwgFi++KeuHISXjYyhkHJYKBgIRmDzqYFhozdTQcKHdaAI4cWiwNlKw66gH3dQe9+3pUhDlh6ovXbqpov9g2Yh6NJMV8IQgkZ4/w1/Sa/Jk7/rqQVLPABRCilj5O0X96ag3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942367; c=relaxed/simple;
	bh=RSBoGUpVAORMibTU+6w28wDAlaZ2hGNXjn6Mh92cl5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5clnJ2QUVEGxNlpoYFv5HF1NS5GqQb5PMsZlf1e+V8QxppnmMBDZw/8cerxfSSRmTknpeb/ed5RVNgVKHY9ZBnawS0Ch21TUvSVJKq+sXnKPf2cx5dnEX6AXT89aE1Ngz6yw7zorlUchq3XqftBDY9+mj45sAkA3UEc+M4FATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLw9eMwG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0fd07ba8bso1247971fa.1;
        Wed, 14 Feb 2024 12:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707942364; x=1708547164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJTmEarOOIisJHwVOIwDkzWvnO3yHtyBfSCwVWrhYuY=;
        b=WLw9eMwGqtxUrTz0A43ThDxprU4e1mDetMQ5ri6gQQi7U+QzmBXIdA0u1t/5+QYLGt
         +s9d14pPfuM1ONecOZfwxZ+YHsBy72rnlngOqopbnPrgPEFaRMeewx9tL6R7NeCxr26y
         xUvCiAWMOH4hoYK2hEXL0CLcII2djLQDx0h7jXrcW34cveof7pMNI+22dicbsGYetd7W
         iMRGyvDZfcaGkueCqh0KGThIrXYTsoGSXRs6RuRuvEBLzrg2zUuCOphD0WpMtevdwnqG
         Wo5+8NydEoCwEPEN4PWjNu0VjsRItTgbFTG4i9dWagCwxiS4aVQvIgXhO/PDGwTZ45n7
         ziQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707942364; x=1708547164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJTmEarOOIisJHwVOIwDkzWvnO3yHtyBfSCwVWrhYuY=;
        b=eQ1fu8s5LLSXzjb8/DKNZd1RIGeB1r8T+vkRQJ8RxxWrOzdef27fkU0nF0uyZfnTIS
         /QSL2yjBLA0drgayJf3l2NfAodsdAQ7vxiDOTjbPEYQyozoHyneZxJDc8juGMhJzazGI
         VwaJCSHJ1W3Bl4jLwIRBWn1cIROKxdZmrAMBRmhW7zKiJUrLFSKClt9Oq8px/l8tJvBo
         0fF6rOYu3CM7423Q8Lzlr+jjbt8lX1pRwHUCHrNBLMb8KkzqBMq94iBCRkoW3La78JOS
         vDoa4dbxCIbIEy8nHf79JAIfVYZNnJdTJtNU+FbhFAzdzi8UjLVcLVvkvZmNFZSd4D6Z
         I+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVAgY5HjK0eu63+ckDOaMH4wx5KOKNUK7B85ZoEvcnc07cXkId/gphHJOIXpjcMl1x33RZgvsFswL0j3RKHJrHmH8zK0i3gFDNr1g==
X-Gm-Message-State: AOJu0YxkMjQEDSRCyF8g+bmjukbsFd6/lUxS+xNn/MKqTTc9kk6cJrpP
	sZK//Oi9GKJZHw8/91D06B1upBom/L5tnPmQT/uiOaM7r9CIQVzO+Z5M2Qo8Y68Lk6RV1myRmbB
	OUupa9cH+tr2BzF9RIdNgdMPVTg==
X-Google-Smtp-Source: AGHT+IHeiYMWXYHT0AAdJ1OLaWpLndVd2p6ME2G410bACvwU9iFrp4Tq1e762shfPu5vyJ3dvgjJOVL21KtbzdniOvA=
X-Received: by 2002:a2e:8ece:0:b0:2d0:ff21:29fb with SMTP id
 e14-20020a2e8ece000000b002d0ff2129fbmr2756784ljl.35.1707942363563; Wed, 14
 Feb 2024 12:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-24-ardb+git@google.com> <CAMzpN2jt3nTmDJ4y6zRFJMSGTcD8eQJY_MjbsnJ7my3hH8d9HA@mail.gmail.com>
 <CAMj1kXG6sYAVkKMA9EJk7+NmsbrDBL82xYpMon1WEeB_34SRuA@mail.gmail.com>
In-Reply-To: <CAMj1kXG6sYAVkKMA9EJk7+NmsbrDBL82xYpMon1WEeB_34SRuA@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 14 Feb 2024 15:25:52 -0500
Message-ID: <CAMzpN2gD1+6rz35STqo19TXQAAVPYjdsDQHkwB9Yske6W1RcQg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] x86/startup_64: Drop global variables keeping
 track of LA57 state
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 10:45=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 14 Feb 2024 at 16:24, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Tue, Feb 13, 2024 at 7:42=E2=80=AFAM Ard Biesheuvel <ardb+git@google=
.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > On x86_64, the core kernel is entered in long mode, which implies tha=
t
> > > paging is enabled. This means that the CR4.LA57 control bit is
> > > guaranteed to be in sync with the number of paging levels used by the
> > > kernel, and there is no need to store this in a variable.
> > >
> > > There is also no need to use variables for storing the calculations o=
f
> > > pgdir_shift and ptrs_per_p4d, as they are easily determined on the fl=
y.
> > >
> > > This removes the need for two different sources of truth for determin=
ing
> > > whether 5-level paging is in use: CR4.LA57 always reflects the actual
> > > state, and never changes from the point of view of the 64-bit core
> > > kernel. The only potential concern is the cost of CR4 accesses, which
> > > can be mitigated using alternatives patching based on feature detecti=
on.
> > >
> > > Note that even the decompressor does not manipulate any page tables
> > > before updating CR4.LA57, so it can also avoid the associated global
> > > variables entirely. However, as it does not implement alternatives
> > > patching, the associated ELF sections need to be discarded.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/boot/compressed/misc.h         |  4 --
> > >  arch/x86/boot/compressed/pgtable_64.c   | 12 ----
> > >  arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
> > >  arch/x86/include/asm/pgtable_64_types.h | 58 ++++++++------------
> > >  arch/x86/kernel/cpu/common.c            |  2 -
> > >  arch/x86/kernel/head64.c                | 33 +----------
> > >  arch/x86/mm/kasan_init_64.c             |  3 -
> > >  arch/x86/mm/mem_encrypt_identity.c      |  9 ---
> > >  8 files changed, 27 insertions(+), 95 deletions(-)
> > >
> > > diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compress=
ed/misc.h
> > > index bc2f0f17fb90..2b15ddd0e177 100644
> > > --- a/arch/x86/boot/compressed/misc.h
> > > +++ b/arch/x86/boot/compressed/misc.h
> > > @@ -16,9 +16,6 @@
> > >
> > >  #define __NO_FORTIFY
> > >
> > > -/* cpu_feature_enabled() cannot be used this early */
> > > -#define USE_EARLY_PGTABLE_L5
> > > -
> > >  /*
> > >   * Boot stub deals with identity mappings, physical and virtual addr=
esses are
> > >   * the same, so override these defines.
> > > @@ -178,7 +175,6 @@ static inline int count_immovable_mem_regions(voi=
d) { return 0; }
> > >  #endif
> > >
> > >  /* ident_map_64.c */
> > > -extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
> > >  extern void kernel_add_identity_map(unsigned long start, unsigned lo=
ng end);
> > >
> > >  /* Used by PAGE_KERN* macros: */
> > > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/co=
mpressed/pgtable_64.c
> > > index 51f957b24ba7..ae72f53f5e77 100644
> > > --- a/arch/x86/boot/compressed/pgtable_64.c
> > > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > > @@ -9,13 +9,6 @@
> > >  #define BIOS_START_MIN         0x20000U        /* 128K, less than th=
is is insane */
> > >  #define BIOS_START_MAX         0x9f000U        /* 640K, absolute max=
imum */
> > >
> > > -#ifdef CONFIG_X86_5LEVEL
> > > -/* __pgtable_l5_enabled needs to be in .data to avoid being cleared =
along with .bss */
> > > -unsigned int __section(".data") __pgtable_l5_enabled;
> > > -unsigned int __section(".data") pgdir_shift =3D 39;
> > > -unsigned int __section(".data") ptrs_per_p4d =3D 1;
> > > -#endif
> > > -
> > >  /* Buffer to preserve trampoline memory */
> > >  static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
> > >
> > > @@ -125,11 +118,6 @@ asmlinkage void configure_5level_paging(struct b=
oot_params *bp, void *pgtable)
> > >                         native_cpuid_eax(0) >=3D 7 &&
> > >                         (native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA5=
7 & 31)))) {
> > >                 l5_required =3D true;
> > > -
> > > -               /* Initialize variables for 5-level paging */
> > > -               __pgtable_l5_enabled =3D 1;
> > > -               pgdir_shift =3D 48;
> > > -               ptrs_per_p4d =3D 512;
> > >         }
> > >
> > >         /*
> > > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/c=
ompressed/vmlinux.lds.S
> > > index 083ec6d7722a..06358bb067fe 100644
> > > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > > @@ -81,6 +81,7 @@ SECTIONS
> > >                 *(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
> > >                 *(.hash) *(.gnu.hash)
> > >                 *(.note.*)
> > > +               *(.altinstructions .altinstr_replacement)
> > >         }
> > >
> > >         .got.plt (INFO) : {
> > > diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/inclu=
de/asm/pgtable_64_types.h
> > > index 38b54b992f32..6a57bfdff52b 100644
> > > --- a/arch/x86/include/asm/pgtable_64_types.h
> > > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > > @@ -6,7 +6,10 @@
> > >
> > >  #ifndef __ASSEMBLY__
> > >  #include <linux/types.h>
> > > +#include <asm/alternative.h>
> > > +#include <asm/cpufeatures.h>
> > >  #include <asm/kaslr.h>
> > > +#include <asm/processor-flags.h>
> > >
> > >  /*
> > >   * These are used to make use of C type-checking..
> > > @@ -21,63 +24,50 @@ typedef unsigned long       pgprotval_t;
> > >  typedef struct { pteval_t pte; } pte_t;
> > >  typedef struct { pmdval_t pmd; } pmd_t;
> > >
> > > -#ifdef CONFIG_X86_5LEVEL
> > > -extern unsigned int __pgtable_l5_enabled;
> > > -
> > > -#ifdef USE_EARLY_PGTABLE_L5
> > > -/*
> > > - * cpu_feature_enabled() is not available in early boot code.
> > > - * Use variable instead.
> > > - */
> > > -static inline bool pgtable_l5_enabled(void)
> > > +static __always_inline __pure bool pgtable_l5_enabled(void)
> > >  {
> > > -       return __pgtable_l5_enabled;
> > > -}
> > > -#else
> > > -#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
> > > -#endif /* USE_EARLY_PGTABLE_L5 */
> > > +       unsigned long r;
> > > +       bool ret;
> > >
> > > -#else
> > > -#define pgtable_l5_enabled() 0
> > > -#endif /* CONFIG_X86_5LEVEL */
> > > +       if (!IS_ENABLED(CONFIG_X86_5LEVEL))
> > > +               return false;
> > > +
> > > +       asm(ALTERNATIVE_TERNARY(
> > > +               "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET=
(c),
> > > +               %P[feat], "stc", "clc")
> > > +               : [reg] "=3D&r" (r), CC_OUT(c) (ret)
> > > +               : [feat] "i"  (X86_FEATURE_LA57),
> > > +                 [la57] "i"  (X86_CR4_LA57_BIT)
> > > +               : "cc");
> >
> > This should be more like _static_cpu_has(), where the runtime test is
> > out of line in a discardable section, and the inline part is just a
> > JMP or NOP.
> >
>
> Why exactly? It matters very little in terms of space, a cross-section
> jump is 5 bytes, and movq+btl is 7 bytes.
>
> If you are referring to the use of the C flag: this way, it is left up
> to the compiler to decide whether a branch or a conditional move is
> more suitable, rather than forcing the use of a branch in one of the
> two cases.

You're probably right in that many uses of pgtable_l5_enabled() are
choosing between two constants, and static_cpu_has() does not handle
that case very efficiently.  Something like static_cpu_choose(feature,
yes_val, no_val) would be a possible idea to explore.

Brian Gerst

