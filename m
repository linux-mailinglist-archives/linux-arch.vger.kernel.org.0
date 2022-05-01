Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1E51639C
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbiEAKUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiEAKUx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 06:20:53 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5206EC65;
        Sun,  1 May 2022 03:17:23 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id bl31so3858678vsb.12;
        Sun, 01 May 2022 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ccEkxmrgmNsyfyAyf5ZXjoHkUwfbPLEXN6CMxKzackc=;
        b=qIcWiPxEoOMfvVWk4WTjGzG6GfOTZNGbJkr+jfLLVNfCXm5RmEdMe4lwyG2O8fy4Xp
         VjQxBNwfyiWKPwEQC3hRwBn2MV8g8wn06r2b4u55DzUjH/j068QjXWsElH62sDL2S35P
         jAqVca9DbvqOGI1aQxnsu4133H3nZ/XA/Zx5TlK0+hxNtSUVls/dLkDKbDqheDMrruR8
         NYUt+uSOzJQulGdpUsIrJNfxdubR3dWE72OxSDKEXM+oiMpOjoytrFJVhcUPVxKuT3gA
         EDFB8fCEJNo47qQXR75WFDU62ptswQBJLSYpCEAydfEexnBiPuyoyuL8uBuFglC8557h
         oj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ccEkxmrgmNsyfyAyf5ZXjoHkUwfbPLEXN6CMxKzackc=;
        b=Fwo0H2rDkVo2zg8TGp1puRQqAC8Fplat0uanfgk5KGyie+OIispzcDvA4ZD1RnT2UB
         Px/tjA+jRUfpWGvMMi7zE7SOWTHeh3R9uhlj4TGvGmUsEgj7Uf58SITSxiRRGhjq+kpA
         CUNUZRSXrMxz407Z9MIERXtB609up1D184+AJlJMBjTd0JipPDAuqwqtuV5S5pHYElIh
         uwtQHs67p1eBrqvuwZUX9gWjAD0rpVrChc6YsJ795WQdwe4mSWq5IjPTfNPHVFuYCH7i
         Z/QNI8tzxaOxcmkexcCvTY9xj6+9YoCGcT3Q27+hB7ZW2qVAA5D8MP5pHmj54G74xudd
         42Uw==
X-Gm-Message-State: AOAM5324LSMZTN1URfFxBY9X/woijecxY7lCarDV6Yu3jRbbS3z9qV55
        0mKMqQ37lr+gYSmp0jCZg0MdW4qURvkWim7aZNeeOHxE
X-Google-Smtp-Source: ABdhPJxC4g7Gm+H4zAD5dDrS3+PtY6Rw+WuPiAHF/4JMdbXjdVtWhtph3IogxvI3gqECe3WaNY4kFsjCP95cbY4KcYE=
X-Received: by 2002:a67:2e91:0:b0:32c:df82:9ad3 with SMTP id
 u139-20020a672e91000000b0032cdf829ad3mr1938078vsu.40.1651400242385; Sun, 01
 May 2022 03:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-2-chenhuacai@loongson.cn> <150d439e-093c-e512-c1fb-a297ce30c1b8@xen0n.name>
In-Reply-To: <150d439e-093c-e512-c1fb-a297ce30c1b8@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 1 May 2022 18:17:10 +0800
Message-ID: <CAAhV-H5mVChLT-JEY5XJuZmnfDK6+-bHjPVDxoDFGuRi03xJFg@mail.gmail.com>
Subject: Re: [PATCH V9 01/24] Documentation: LoongArch: Add basic documentations
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, May 1, 2022 at 5:32 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> Here's some rough review on the documentation bits, both semantic-wise
> and English-wise; I'm not native English speaker though, so more eyes
> are welcome.
>
>
> On 4/30/22 17:04, Huacai Chen wrote:
> > Add some basic documentation for LoongArch. LoongArch is a new RISC ISA=
,
> > which is a bit like MIPS or RISC-V. LoongArch includes a reduced 32-bit
> > version (LA32R), a standard 32-bit version (LA32S) and a 64-bit version
> > (LA64).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   Documentation/arch.rst                     |   1 +
> >   Documentation/loongarch/features.rst       |   3 +
> >   Documentation/loongarch/index.rst          |  21 ++
> >   Documentation/loongarch/introduction.rst   | 345 ++++++++++++++++++++=
+
> >   Documentation/loongarch/irq-chip-model.rst | 168 ++++++++++
> >   5 files changed, 538 insertions(+)
> >   create mode 100644 Documentation/loongarch/features.rst
> >   create mode 100644 Documentation/loongarch/index.rst
> >   create mode 100644 Documentation/loongarch/introduction.rst
> >   create mode 100644 Documentation/loongarch/irq-chip-model.rst
> >
> > diff --git a/Documentation/arch.rst b/Documentation/arch.rst
> > index 14bcd8294b93..41a66a8b38e4 100644
> > --- a/Documentation/arch.rst
> > +++ b/Documentation/arch.rst
> > @@ -13,6 +13,7 @@ implementation.
> >      arm/index
> >      arm64/index
> >      ia64/index
> > +   loongarch/index
> >      m68k/index
> >      mips/index
> >      nios2/index
> > diff --git a/Documentation/loongarch/features.rst b/Documentation/loong=
arch/features.rst
> > new file mode 100644
> > index 000000000000..ebacade3ea45
> > --- /dev/null
> > +++ b/Documentation/loongarch/features.rst
> > @@ -0,0 +1,3 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +.. kernel-feat:: $srctree/Documentation/features loongarch
> > diff --git a/Documentation/loongarch/index.rst b/Documentation/loongarc=
h/index.rst
> > new file mode 100644
> > index 000000000000..d127e07a7ed3
> > --- /dev/null
> > +++ b/Documentation/loongarch/index.rst
> > @@ -0,0 +1,21 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +LoongArch-specific Documentation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +   :numbered:
> > +
> > +   introduction
> > +   irq-chip-model
> > +
> > +   features
> > +
> > +.. only::  subproject and html
> > +
> > +   Indices
> > +   =3D=3D=3D=3D=3D=3D=3D
> > +
> > +   * :ref:`genindex`
> > diff --git a/Documentation/loongarch/introduction.rst b/Documentation/l=
oongarch/introduction.rst
> > new file mode 100644
> > index 000000000000..420c0d2ebcfb
> > --- /dev/null
> > +++ b/Documentation/loongarch/introduction.rst
> > @@ -0,0 +1,345 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +Introduction of LoongArch
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V. Loong=
Arch
> > +includes a reduced 32-bit version (LA32R), a standard 32-bit version (=
LA32S)
> > +and a 64-bit version (LA64). LoongArch has 4 privilege levels (PLV0~PL=
V3),
> > +PLV0 is the highest level which used by kernel, and PLV3 is the lowest=
 level
> > +which used by applications. This document introduces the registers, ba=
sic
>
> The sentence is a bit malformed; better reword into two sentences.
>
> "There are 4 privilege levels (PLVs) defined in LoongArch: PLV0~PLV3,
> from high to low. Kernel runs at the PLV0 while applications runs at PLV3=
.
>
> > +instruction set, virtual memory and some other topics of LoongArch.
> > +
> > +Registers
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +LoongArch registers include general purpose registers (GPRs), floating=
 point
> > +registers (FPRs), vector registers (VRs) and control status registers =
(CSRs)
> > +used in privileged mode (PLV0).
> Aren't privilege levels other than PLV0 also able to use CSRs?
> > +
> > +GPRs
> > +----
> > +
> > +LoongArch has 32 GPRs ($r0 - $r31), each one is 32bit wide in LA32 and=
 64bit
> > +wide in LA64. $r0 is always zero, and other registers has no special f=
eature,
>
> "while other registers are not special"
>
> But again, this is not technically true; $r1 ($ra) *is* architecturally
> special, in that the BL instruction has it hard-wired as the link
> register. This sentence may need a little tweak but I currently don't
> have a concrete suggestion.
>
> > +but we actually have an ABI register convention as below.
>
> We may link to the official psABI specification now. When this port is
> first announced the documentation is not yet ready, but we now have it
> at [1], so by referring to the official bits we can avoid stale
> description like...
>
> [1]:
> https://loongson.github.io/LoongArch-Documentation/LoongArch-ELF-ABI-EN.h=
tml
>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Name              Alias           Usage               Preserved
> > +                                                      across calls
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +``$r0``           ``$zero``       Constant zero       Unused
> > +``$r1``           ``$ra``         Return address      No
> > +``$r2``           ``$tp``         TLS                 Unused
> > +``$r3``           ``$sp``         Stack pointer       Yes
> > +``$r4``-``$r11``  ``$a0``-``$a7`` Argument registers  No
> > +``$r4``-``$r5``   ``$v0``-``$v1`` Return value        No
> ... this (the ABI alias is deprecated in the latest spec), and...
> > +``$r12``-``$r20`` ``$t0``-``$t8`` Temp registers      No
> > +``$r21``          ``$x``          Reserved            Unused
> ... this (for one thing, the alias is entirely removed in the latest
> spec; for other thing, kernel does make use of this register), and...
> > +``$r22``          ``$fp``         Frame pointer       Yes
> ... this (this can also be called $s9 when we don't care about or make
> use of its frame-pointer nature).
> > +``$r23``-``$r31`` ``$s0``-``$s8`` Static registers    Yes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> And as described above, while the $r21 is reserved in the userspace ABI,
> this port does make use of it (as the percpu base register); so we'd
> better mention this too.
> > +
> > +FPRs
> > +----
> > +
> > +LoongArch has 32 FPRs ($f0 - $f31), each one is 64bit wide. We also ha=
ve an
> "each one is 64bit wide" -- what about the possible LA32 and LA64
> distinction, as similarly shown in the GPR section?
> > +ABI register conversion as below.
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Name              Alias              Usage               Preserved
> > +                                                         across calls
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +``$f0``-``$f7``   ``$fa0``-``$fa7``  Argument registers  No
> > +``$f0``-``$f1``   ``$fv0``-``$fv1``  Return value        No
> Same here -- the $vX and $fvX aliases are deprecated.
> > +``$f8``-``$f23``  ``$ft0``-``$ft15`` Temp registers      No
> > +``$f24``-``$f31`` ``$fs0``-``$fs7``  Static registers    Yes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +VRs
> > +----
> > +
> > +LoongArch has 128bit vector extension (LSX, short for Loongson SIMD eX=
tention)
> > +and 256bit vector extension (LASX, short for Loongson Advanced SIMD eX=
tension).
> > +There are also 32 vector registers, for LSX is $v0 - $v31, and for LAS=
X is $x0
> > +- $x31. FPRs and VRs are reused, e.g. the lower 128bits of $x0 is $v0,=
 and the
>
> "for LSX is ..." -- Chinglish; "$v0 ~ $v31 for LSX and $x0 ~ $x31 for
> LASX" would be better.
>
> Also, see what you did here with "$vX"? I know the older names are
> "$vrX" and "$xrX", but the latest reference manual already switched to
> the current naming, so you really can't just continue using "$v[01]" for
> "$a[01]" any more. ;-)
>
> "FPRs and VRs are reused" -- the word "overlap" is better, "FPRs and VRs
> overlap; the FPRs share the same storage as VR's lower bits" might be a
> better expression.
>
> > +lower 64bits of $v0 is $f0, etc.
> > +
> > +CSRs
> > +----
> > +
> > +CSRs can only be used in privileged mode (PLV0):
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Address           Full Name                             Abbrev Name
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +0x0               Current Mode information              CRMD
> > +0x1               Pre-exception Mode information        PRMD
> is the word "information" needed?
> > +0x2               Extended Unit Enable                  EUEN
> > +0x3               Miscellaneous controller              MISC
> "controller"? just remove the word or "control" would be better.
> > +0x4               Exception Configuration               ECFG
> > +0x5               Exception Status                      ESTAT
> > +0x6               Exception Return Address              ERA
> > +0x7               Bad Virtual Address                   BADV
> > +0x8               Bad Instruction                       BADI
> > +0xC               Exception Entry Base address          EENTRY
> > +0x10              TLB Index                             TLBIDX
> > +0x11              TLB Entry High-order bits             TLBEHI
> > +0x12              TLB Entry Low-order bits 0            TLBELO0
> > +0x13              TLB Entry Low-order bits 1            TLBELO1
> > +0x18              Address Space Identifier              ASID
> > +0x19              Page Global Directory address for     PGDL
> > +                  Lower half address space
> > +0x1A              Page Global Directory address for     PGDH
> > +                  Higher half address space
> > +0x1B              Page Global Directory address         PGD
> > +0x1C              Page Walk Controller for Lower        PWCL
> > +                  half address space
> > +0x1D              Page Walk Controller for Higher       PWCH
> > +                  half address space
> > +0x1E              STLB Page Size                        STLBPS
> > +0x1F              Reduced Virtual Address Configuration RVACFG
> > +0x20              CPU Identifier                        CPUID
> > +0x21              Privileged Resource Configuration 1   PRCFG1
> > +0x22              Privileged Resource Configuration 2   PRCFG2
> > +0x23              Privileged Resource Configuration 3   PRCFG3
> > +0x30+n (0=E2=89=A4n=E2=89=A415)   Data Save register                  =
  SAVEn
> These are actually scratch registers, but I imagine you can't use that
> word as it's a bit MIPS-y... The name is less comprehensible but we
> might have no choice.
> > +0x40              Timer Identifier                      TID
> > +0x41              Timer Configuration                   TCFG
> > +0x42              Timer Value                           TVAL
> > +0x43              Compensation of Timer Count           CNTC
> > +0x44              Timer Interrupt Clearing              TICLR
> > +0x60              LLBit Controller                      LLBCTL
> "Control" is probably sufficient -- same for other places.
> > +0x80              Implementation-specific Controller 1  IMPCTL1
> > +0x81              Implementation-specific Controller 2  IMPCTL2
> > +0x88              TLB Refill Exception Entry Base       TLBRENTRY
> > +                  address
> > +0x89              TLB Refill Exception BAD Virtual      TLBRBADV
> > +                  address
> > +0x8A              TLB Refill Exception Return Address   TLBRERA
> > +0x8B              TLB Refill Exception data SAVE        TLBRSAVE
> > +                  register
> > +0x8C              TLB Refill Exception Entry Low-order  TLBRELO0
> > +                  bits 0
> > +0x8D              TLB Refill Exception Entry Low-order  TLBRELO1
> > +                  bits 1
> > +0x8E              TLB Refill Exception Entry High-order TLBEHI
> > +                  bits
> > +0x8F              TLB Refill Exception Pre-exception    TLBRPRMD
> > +                  Mode information
> > +0x90              Machine Error Controller              MERRCTL
> > +0x91              Machine Error Information 1           MERRINFO1
> > +0x92              Machine Error Information 2           MERRINFO2
> > +0x93              Machine Error Exception Entry Base    MERRENTRY
> > +                  address
> > +0x94              Machine Error Exception Return        MERRERA
> > +                  address
> > +0x95              Machine Error Exception data SAVE     MERRSAVE
> > +                  register
> It seems you're trying to match capitalization here to the CSR acronym
> -- but the resulting names are inconsistent-looking, such as the "data
> SAVE" here, and...
> > +0x98              Cache TAGs                            CTAG
> > +0x180+n (0=E2=89=A4n=E2=89=A43)   Direct Mapping configuration Window =
n DMWn
> ...here, and...
> > +0x200+2n (0=E2=89=A4n=E2=89=A431) Performance Monitor Configuration n =
  PMCFGn
> > +0x201+2n (0=E2=89=A4n=E2=89=A431) Performance Monitor overall Counter =
n PMCNTn
> > +0x300             Memory load/store WatchPoint          MWPC
> > +                  overall Controller
>
> here.
>
> It's inconsistent, because otherwise you'd have "CuRrent MoDe" at the
> top of the table, similarly for other entries. As the reference manual
> (Chinese version; this is the authoritative version) actually does NOT
> give full English names for the CSRs (only Chinese full-name and the
> abbreviation), I think we can be a bit lax here and use normal
> capitalization for reading comfort.
>
> > +0x301             Memory load/store WatchPoint          MWPS
> > +                  overall Status
> > +0x310+8n (0=E2=89=A4n=E2=89=A47)  Memory load/store WatchPoint n      =
  MWPnCFG1
> > +                  Configuration 1
> > +0x311+8n (0=E2=89=A4n=E2=89=A47)  Memory load/store WatchPoint n      =
  MWPnCFG2
> > +                  Configuration 2
> > +0x312+8n (0=E2=89=A4n=E2=89=A47)  Memory load/store WatchPoint n      =
  MWPnCFG3
> > +                  Configuration 3
> > +0x313+8n (0=E2=89=A4n=E2=89=A47)  Memory load/store WatchPoint n      =
  MWPnCFG4
> > +                  Configuration 4
> > +0x380             Fetch WatchPoint overall Controller   FWPC
> > +0x381             Fetch WatchPoint overall Status       FWPS
> > +0x390+8n (0=E2=89=A4n=E2=89=A47)  Fetch WatchPoint n Configuration 1  =
  FWPnCFG1
> > +0x391+8n (0=E2=89=A4n=E2=89=A47)  Fetch WatchPoint n Configuration 2  =
  FWPnCFG2
> > +0x392+8n (0=E2=89=A4n=E2=89=A47)  Fetch WatchPoint n Configuration 3  =
  FWPnCFG3
> > +0x393+8n (0=E2=89=A4n=E2=89=A47)  Fetch WatchPoint n Configuration 4  =
  FWPnCFG4
> > +0x500             Debug register                        DBG
> > +0x501             Debug Exception Return address        DERA
> > +0x502             Debug data SAVE register              DSAVE
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +ERA=EF=BC=8CTLBRERA=EF=BC=8CMERREEA and ERA sometimes are also called =
EPC=EF=BC=8CTLBREPC
> > +MERREPC and DEPC.
> > +
> > +Basic Instruction Set
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Instruction formats
> > +-------------------
> > +
> > +LoongArch has 32-bit wide instructions, and there are 9 instruction fo=
rmats::
> > +
> > +  2R-type:    Opcode + Rj + Rd
> > +  3R-type:    Opcode + Rk + Rj + Rd
> > +  4R-type:    Opcode + Ra + Rk + Rj + Rd
> > +  2RI8-type:  Opcode + I8 + Rj + Rd
> > +  2RI12-type: Opcode + I12 + Rj + Rd
> > +  2RI14-type: Opcode + I14 + Rj + Rd
> > +  2RI16-type: Opcode + I16 + Rj + Rd
> > +  1RI21-type: Opcode + I21L + Rj + I21H
> > +  I26-type:   Opcode + I26L + I26H
> > +
> > +Rj and Rk are source operands (register), Rd is destination operand (r=
egister),
> > +and Ra is the additional operand (register) in 4R-type. I8/I12/I16/I21=
/I26 are
> > +8-bits/12-bits/16-bits/21-bits/26bits immediate data. 21bits/26bits im=
mediate
> > +data are split into higher bits and lower bits in an instruction word,=
 so you
> > +can see I21L/I21H and I26L/I26H here.
> > +
> > +Instruction names (Mnemonics)
> > +-----------------------------
> > +
> > +We only list the instruction names here, for details please read the r=
eferences.
> > +
> > +Arithmetic Operation Instructions::
> > +
> > +  ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> > +  SLT SLTU SLTI SLTUI
> > +  AND OR NOR XOR ANDN ORN ANDI ORI XORI
> > +  MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> > +  MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> > +  PCADDI PCADDU12I PCADDU18I
> > +  LU12I.W LU32I.D LU52I.D ADDU16I.D
> > +
> > +Bit-shift Instructions::
> > +
> > +  SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> > +  SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> > +
> > +Bit-manipulation Instructions::
> > +
> > +  EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> > +  BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> > +  REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B BI=
TREV.W BITREV.D
> > +  MASKEQZ MASKNEZ
> > +
> > +Branch Instructions::
> > +
> > +  BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> > +
> > +Load/Store Instructions::
> > +
> > +  LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> > +  LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W STX.D
> > +  LDPTR.W LDPTR.D STPTR.W STPTR.D
> > +  PRELD PRELDX
> > +
> > +Atomic Operation Instructions::
> > +
> > +  LL.W SC.W LL.D SC.D
> > +  AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D AMXO=
R.W AMXOR.D
> > +  AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> > +
> > +Barrier Instructions::
> > +
> > +  IBAR DBAR
> > +
> > +Special Instructions::
> > +
> > +  SYSCALL BREAK CPUCFG NOP IDLE ERTN DBCL RDTIMEL.W RDTIMEH.W RDTIME.D=
 ASRTLE.D ASRTGT.D
> > +
> > +Privileged Instructions::
> > +
> > +  CSRRD CSRWR CSRXCHG
> > +  IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H IOCSRWR.=
W IOCSRWR.D
> > +  CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB LDDIR=
 LDPTE
>
> For the whole section, replace with reference to the official
> (translated or not) documentation repo? I believe this is similar to the
> psABI situation explained above.
>
> > +
> > +Virtual Memory
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +LoongArch can use direct-mapped virtual memory and page-mapped virtual=
 memory.
> > +
> > +Direct-mapped virtual memory is configured by CSR.DMWn (n=3D0~3), it h=
as a simple
> > +relationship between virtual address (VA) and physical address (PA)::
> "... is configured via CSR.DMWn (n=3D0~3). It specifies a simple
> relationship ..."
> > +
> > + VA =3D PA + FixedOffset
> > +
> > +Page-mapped virtual memory has arbitrary relationship between VA and P=
A, which
> > +is recorded in TLB and page tables. LoongArch's TLB includes a fully-a=
ssociative
> The first sentence is Chinglish. As the basics of paged virtual memory
> should be common sense to kernel developers, could we simplify, or
> better, just somehow get rid of the sentence?
> > +MTLB (Multiple Page Size TLB) and set-associative STLB (Single Page Si=
ze TLB).
> > +
> > +By default, the whole virtual address space of LA32 is configured like=
 this:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Name         Address Range               Attributes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +``UVRANGE``  ``0x00000000 - 0x7FFFFFFF`` Page-mapped, Cached, PLV0~3
> > +``KPRANGE0`` ``0x80000000 - 0x9FFFFFFF`` Direct-mapped, Uncached, PLV0
> > +``KPRANGE1`` ``0xA0000000 - 0xBFFFFFFF`` Direct-mapped, Cached, PLV0
> > +``KVRANGE``  ``0xC0000000 - 0xFFFFFFFF`` Page-mapped, Cached, PLV0
> The names sound awfully MIPS-like... I can't find any reference to the
> names here in the reference manual, are these Linux-specific inventions
> only documented here?
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +User mode (PLV3) can only access UVRANGE. For direct-mapped KPRANGE0 a=
nd
> > +KPRANGE1, PA is equal to VA with bit30~31 cleared. For example, the un=
cached
> > +direct-mapped VA of 0x00001000 is 0x80001000, and the cached direct-ma=
pped
> > +VA of 0x00001000 is 0xA0001000.
> > +
> > +By default, the whole virtual address space of LA64 is configured like=
 this:
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Name         Address Range          Attributes
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +``XUVRANGE`` ``0x0000000000000000 - Page-mapped, Cached, PLV0~3
> > +             0x3FFFFFFFFFFFFFFF``
> > +``XSPRANGE`` ``0x4000000000000000 - Direct-mapped, Cached / Uncached, =
PLV0
> > +             0x7FFFFFFFFFFFFFFF``
> > +``XKPRANGE`` ``0x8000000000000000 - Direct-mapped, Cached / Uncached, =
PLV0
> > +             0xBFFFFFFFFFFFFFFF``
> > +``XKVRANGE`` ``0xC000000000000000 - Page-mapped, Cached, PLV0
> > +             0xFFFFFFFFFFFFFFFF``
> Similarly here.
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +User mode (PLV3) can only access XUVRANGE. For direct-mapped XSPRANGE =
and XKPRANGE,
> > +PA is equal to VA with bit60~63 cleared, and the cache attributes is c=
onfigured by
> > +bit60~61 (0 is strongly-ordered uncached, 1 is coherent cached, and 2 =
is weakly-
> > +ordered uncached) in VA. Currently we only use XKPRANGE for direct map=
ping and
> > +XSPRANGE is reserved. As an example, the strongly-ordered uncached dir=
ect-mapped VA
> > +(in XKPRANGE) of 0x00000000 00001000 is 0x80000000 00001000, the coher=
ent cached
> > +direct-mapped VA (in XKPRANGE) of 0x00000000 00001000 is 0x90000000 00=
001000, and
> > +the weakly-ordered uncached direct-mapped VA (in XKPRANGE) of 0x000000=
00 00001000
> > +is 0xA0000000 00001000.
> > +
> > +Relationship of Loongson and LoongArch
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +LoongArch is a RISC ISA which is different from any other existing one=
s, while
> > +Loongson is a family of processors. Loongson includes 3 series: Loongs=
on-1 is
> > +the 32-bit processor series, Loongson-2 is the low-end 64-bit processo=
r series,
> > +and Loongson-3 is the high-end 64-bit processor series. Old Loongson i=
s based on
> > +MIPS, while New Loongson is based on LoongArch. Take Loongson-3 as an =
example:
> > +Loongson-3A1000/3B1500/3A2000/3A3000/3A4000 are MIPS-compatible, while=
 Loongson-
> > +3A5000 (and future revisions) are all based on LoongArch.
> Is this section truly necessary? At least FWIW Loongson is first of all,
> a corporation, in addition to its series of CPU products, bridge chip
> products, browser offering and pretty much everything. We could use a
> fair bit of clarification for this paragraph, at least use phrases like
> "Loongson processors"...
> > +
> > +References
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Official web site of Loongson and LoongArch (Loongson Technology Corp.=
 Ltd.):
> > +
> > +  http://www.loongson.cn/index.html
> You may omit the "index.html" part...
> > +
> > +Developer web site of Loongson and LoongArch (Software and Documentati=
on):
> > +
> > +  http://www.loongnix.cn/index.php
> Do you really mean loongnix.cn and not
> https://loongson.github.io/LoongArch-Documentation/ ? Because
> loongnix.cn is more an information portal for users... at least in its
> current iteration there's no link to actual documentation, no link to
> development repos, nothing useful for prospective contributors.
> > +
> > +  https://github.com/loongson
> > +
> > +Documentation of LoongArch ISA:
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/LoongArch-Vol1-v1.00-CN.pdf (in Chinese)
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/LoongArch-Vol1-v1.00-EN.pdf (in English)
> > +
> > +Documentation of LoongArch ELF ABI:
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/LoongArch-ELF-ABI-v1.00-CN.pdf (in Chinese)
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/LoongArch-ELF-ABI-v1.00-EN.pdf (in English)
> > +
> > +Linux kernel repository of Loongson and LoongArch:
> > +
> > +  https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loo=
ngson.git
> > diff --git a/Documentation/loongarch/irq-chip-model.rst b/Documentation=
/loongarch/irq-chip-model.rst
> > new file mode 100644
> > index 000000000000..bde112b81ace
> > --- /dev/null
> > +++ b/Documentation/loongarch/irq-chip-model.rst
> > @@ -0,0 +1,168 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +IRQ chip model (hierarchy) of LoongArch
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Currently, LoongArch based processors (e.g. Loongson-3A5000) can only =
work together
> > +with LS7A chipsets. The irq chips in LoongArch computers include CPUIN=
TC (CPU Core
> > +Interrupt Controller), LIOINTC (Legacy I/O Interrupt Controller), EIOI=
NTC (Extended
> > +I/O Interrupt Controller), HTVECINTC (Hyper-Transport Vector Interrupt=
 Controller),
> > +PCH-PIC (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC Inte=
rrupt Controller
> > +in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> > +
> > +CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC a=
re per-package
> > +controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are controllers ou=
t of CPU (i.e.,
> > +in chipsets). These controllers (in other words, irqchips) are linked =
in a hierarchy,
> > +and there are two models of hierarchy (legacy model and extended model=
).
> > +
> > +Legacy IRQ model
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer int=
errupt go
> > +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all oth=
er devices
> > +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC, an=
d then go
> > +to LIOINTC, and then CPUINTC.
> > +
> > + +---------------------------------------------+
> > + |::                                           |
> > + |                                             |
> > + |    +-----+     +---------+     +-------+    |
> > + |    | IPI | --> | CPUINTC | <-- | Timer |    |
> > + |    +-----+     +---------+     +-------+    |
> > + |                     ^                       |
> > + |                     |                       |
> > + |                +---------+     +-------+    |
> > + |                | LIOINTC | <-- | UARTs |    |
> > + |                +---------+     +-------+    |
> > + |                     ^                       |
> > + |                     |                       |
> > + |               +-----------+                 |
> > + |               | HTVECINTC |                 |
> > + |               +-----------+                 |
> > + |                ^         ^                  |
> > + |                |         |                  |
> > + |          +---------+ +---------+            |
> > + |          | PCH-PIC | | PCH-MSI |            |
> > + |          +---------+ +---------+            |
> > + |            ^     ^           ^              |
> > + |            |     |           |              |
> > + |    +---------+ +---------+ +---------+      |
> > + |    | PCH-LPC | | Devices | | Devices |      |
> > + |    +---------+ +---------+ +---------+      |
> > + |         ^                                   |
> > + |         |                                   |
> > + |    +---------+                              |
> > + |    | Devices |                              |
> > + |    +---------+                              |
> > + |                                             |
> > + |                                             |
> > + +---------------------------------------------+
> > +
> > +Extended IRQ model
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer int=
errupt go
> > +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all oth=
er devices
> > +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and =
then go to
> > +to CPUINTC directly.
> > +
> > + +--------------------------------------------------------+
> > + |::                                                      |
> > + |                                                        |
> > + |         +-----+     +---------+     +-------+          |
> > + |         | IPI | --> | CPUINTC | <-- | Timer |          |
> > + |         +-----+     +---------+     +-------+          |
> > + |                      ^       ^                         |
> > + |                      |       |                         |
> > + |               +---------+ +---------+     +-------+    |
> > + |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> > + |               +---------+ +---------+     +-------+    |
> > + |                ^       ^                               |
> > + |                |       |                               |
> > + |         +---------+ +---------+                        |
> > + |         | PCH-PIC | | PCH-MSI |                        |
> > + |         +---------+ +---------+                        |
> > + |           ^     ^           ^                          |
> > + |           |     |           |                          |
> > + |   +---------+ +---------+ +---------+                  |
> > + |   | PCH-LPC | | Devices | | Devices |                  |
> > + |   +---------+ +---------+ +---------+                  |
> > + |        ^                                               |
> > + |        |                                               |
> > + |   +---------+                                          |
> > + |   | Devices |                                          |
> > + |   +---------+                                          |
> > + |                                                        |
> > + |                                                        |
> > + +--------------------------------------------------------+
> > +
> > +ACPI-related definitions
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +CPUINTC::
> > +
> > +  ACPI_MADT_TYPE_CORE_PIC;
> > +  struct acpi_madt_core_pic;
> > +  enum acpi_madt_core_pic_version;
> > +
> > +LIOINTC::
> > +
> > +  ACPI_MADT_TYPE_LIO_PIC;
> > +  struct acpi_madt_lio_pic;
> > +  enum acpi_madt_lio_pic_version;
> > +
> > +EIOINTC::
> > +
> > +  ACPI_MADT_TYPE_EIO_PIC;
> > +  struct acpi_madt_eio_pic;
> > +  enum acpi_madt_eio_pic_version;
> > +
> > +HTVECINTC::
> > +
> > +  ACPI_MADT_TYPE_HT_PIC;
> > +  struct acpi_madt_ht_pic;
> > +  enum acpi_madt_ht_pic_version;
> > +
> > +PCH-PIC::
> > +
> > +  ACPI_MADT_TYPE_BIO_PIC;
> > +  struct acpi_madt_bio_pic;
> > +  enum acpi_madt_bio_pic_version;
> > +
> > +PCH-MSI::
> > +
> > +  ACPI_MADT_TYPE_MSI_PIC;
> > +  struct acpi_madt_msi_pic;
> > +  enum acpi_madt_msi_pic_version;
> > +
> > +PCH-LPC::
> > +
> > +  ACPI_MADT_TYPE_LPC_PIC;
> > +  struct acpi_madt_lpc_pic;
> > +  enum acpi_madt_lpc_pic_version;
> > +
> > +References
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Documentation of Loongson-3A5000:
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/Loongson-3A5000-usermanual-1.02-CN.pdf (in Chinese)
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/Loongson-3A5000-usermanual-1.02-EN.pdf (in English)
> > +
> > +Documentation of Loongson's LS7A chipset:
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/Loongson-7A1000-usermanual-2.00-CN.pdf (in Chinese)
> > +
> > +  https://github.com/loongson/LoongArch-Documentation/releases/latest/=
download/Loongson-7A1000-usermanual-2.00-EN.pdf (in English)
> > +
> > +Attention: CPUINTC is CSR.ECFG/CSR.ESTAT and its interrupt controller =
described
> "Note" may be enough. :-)
Thank you for all your suggestions, I will modify.

Huacai
> > +in Section 7.4 of "LoongArch Reference Manual, Vol 1"; LIOINTC is "Leg=
acy I/O
> > +Interrupts" described in Section 11.1 of "Loongson 3A5000 Processor Re=
ference
> > +Manual"; EIOINTC is "Extended I/O Interrupts" described in Section 11.=
2 of
> > +"Loongson 3A5000 Processor Reference Manual"; HTVECINTC is "HyperTrans=
port
> > +Interrupts" described in Section 14.3 of "Loongson 3A5000 Processor Re=
ference
> > +Manual"; PCH-PIC/PCH-MSI is "Interrupt Controller" described in Sectio=
n 5 of
> > +"Loongson 7A1000 Bridge User Manual"; PCH-LPC is "LPC Interrupts" desc=
ribed in
> > +Section 24.3 of "Loongson 7A1000 Bridge User Manual".
