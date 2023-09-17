Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACFE7A3619
	for <lists+linux-arch@lfdr.de>; Sun, 17 Sep 2023 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbjIQPQO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 17 Sep 2023 11:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjIQPQN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 17 Sep 2023 11:16:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91D410A;
        Sun, 17 Sep 2023 08:16:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886B4C433B8;
        Sun, 17 Sep 2023 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694963766;
        bh=yqYuHFM11dDEbGgRFjwdL8i1SBb1Q4DRgrg2H5O/8PY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rm9m2+/44Vx0vcZ9qcdRo/1Kj/rvV34heBsSXx1Ju9/jDyviEX/pibI8QR4QO6Gpw
         JO6Eu5biN/lxsBND+vk/geqwgY4jvR6DzVRXnM0GkPat7/qT+0+RRc9NVsbg16ohaP
         ZV2Ki9DkhViMipBg3Ml8n0+7f0ZvWsEFjipDBas5btPEtTb98VOTUd6IJ5Aiph3bzA
         Y28aHbuCl2GbZzXBh3mYsN2MCVg5Mw0388011cslfotceGs6Uv78RIQ20yXt1KcNwJ
         kj5fS2JNY8cZVVtd+mQkPvsENkNv2jesSBUTdVVSS8wkIqbj4s1TDQGVbi2nVkajrX
         tvO78ralItReA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so4562592a12.2;
        Sun, 17 Sep 2023 08:16:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YxuQpj65aGtNAgPuFFPiFd54WgscF8D4yltxOezJyDbqaBq2ZBM
        U3ULB1u0qL/iz+jUmjbg5hrP5jkYxo76gApv9DQ=
X-Google-Smtp-Source: AGHT+IEgnMuDRnHrW6EXLkgG92zGhZaIvPN8yV6y13aOl+aCOPE4bIvwAGhJIxCEg7pA9tUbuXjESfqKfx1QA0+Qw7o=
X-Received: by 2002:a05:6402:b16:b0:52f:8ca7:f255 with SMTP id
 bm22-20020a0564020b1600b0052f8ca7f255mr5650921edb.37.1694963764811; Sun, 17
 Sep 2023 08:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-10-guoren@kernel.org>
 <ZQLFJ1cmQ8PAoMHm@redhat.com>
In-Reply-To: <ZQLFJ1cmQ8PAoMHm@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 17 Sep 2023 23:15:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQNduoHJgf3iJP5ada4WTwrzD9UtkyRj0X=0JFyRPM=w@mail.gmail.com>
Message-ID: <CAJF2gTRQNduoHJgf3iJP5ada4WTwrzD9UtkyRj0X=0JFyRPM=w@mail.gmail.com>
Subject: Re: [PATCH V11 09/17] riscv: qspinlock: errata: Add
 ERRATA_THEAD_WRITE_ONCE fixup
To:     Leonardo Bras <leobras@redhat.com>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 4:32=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Sun, Sep 10, 2023 at 04:29:03AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The early version of T-Head C9xx cores has a store merge buffer
> > delay problem. The store merge buffer could improve the store queue
> > performance by merging multi-store requests, but when there are not
> > continued store requests, the prior single store request would be
> > waiting in the store queue for a long time. That would cause
> > significant problems for communication between multi-cores. This
> > problem was found on sg2042 & th1520 platforms with the qspinlock
> > lock torture test.
> >
> > So appending a fence w.o could immediately flush the store merge
> > buffer and let other cores see the write result.
> >
> > This will apply the WRITE_ONCE errata to handle the non-standard
> > behavior via appending a fence w.o instruction for WRITE_ONCE().
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig.errata              | 19 +++++++++++++++++++
> >  arch/riscv/errata/thead/errata.c       | 20 ++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h   | 13 -------------
> >  arch/riscv/include/asm/rwonce.h        | 24 ++++++++++++++++++++++++
> >  arch/riscv/include/asm/vendorid_list.h | 14 ++++++++++++++
> >  include/asm-generic/rwonce.h           |  2 ++
> >  6 files changed, 79 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/rwonce.h
> >
> > diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> > index 1aa85a427ff3..c919cc3f1a3a 100644
> > --- a/arch/riscv/Kconfig.errata
> > +++ b/arch/riscv/Kconfig.errata
> > @@ -77,4 +77,23 @@ config ERRATA_THEAD_PMU
> >
> >         If you don't know what to do here, say "Y".
> >
> > +config ERRATA_THEAD_WRITE_ONCE
> > +     bool "Apply T-Head WRITE_ONCE errata"
> > +     depends on ERRATA_THEAD
> > +     default y
> > +     help
> > +       The early version of T-Head C9xx cores has a store merge buffer
> > +       delay problem. The store merge buffer could improve the store q=
ueue
> > +       performance by merging multi-store requests, but when there are=
 no
> > +       continued store requests, the prior single store request would =
be
> > +       waiting in the store queue for a long time. That would cause
> > +       significant problems for communication between multi-cores. App=
ending
> > +       a fence w.o could immediately flush the store merge buffer and =
let
> > +       other cores see the write result.
> > +
> > +       This will apply the WRITE_ONCE errata to handle the non-standar=
d
> > +       behavior via appending a fence w.o instruction for WRITE_ONCE()=
.
> > +
> > +       If you don't know what to do here, say "Y".
> > +
> >  endmenu # "CPU errata selection"
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index be84b14f0118..751eb5a7f614 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -69,6 +69,23 @@ static bool errata_probe_pmu(unsigned int stage,
> >       return true;
> >  }
> >
> > +static bool errata_probe_write_once(unsigned int stage,
> > +                                 unsigned long arch_id, unsigned long =
impid)
> > +{
> > +     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> > +             return false;
> > +
> > +     /* target-c9xx cores report arch_id and impid as 0 */
> > +     if (arch_id !=3D 0 || impid !=3D 0)
> > +             return false;
> > +
> > +     if (stage =3D=3D RISCV_ALTERNATIVES_BOOT ||
> > +         stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  static u32 thead_errata_probe(unsigned int stage,
> >                             unsigned long archid, unsigned long impid)
> >  {
> > @@ -83,6 +100,9 @@ static u32 thead_errata_probe(unsigned int stage,
> >       if (errata_probe_pmu(stage, archid, impid))
> >               cpu_req_errata |=3D BIT(ERRATA_THEAD_PMU);
> >
> > +     if (errata_probe_write_once(stage, archid, impid))
> > +             cpu_req_errata |=3D BIT(ERRATA_THEAD_WRITE_ONCE);
> > +
> >       return cpu_req_errata;
> >  }
> >
> > diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/=
asm/errata_list.h
> > index 712cab7adffe..fbb2b8d39321 100644
> > --- a/arch/riscv/include/asm/errata_list.h
> > +++ b/arch/riscv/include/asm/errata_list.h
> > @@ -11,19 +11,6 @@
> >  #include <asm/hwcap.h>
> >  #include <asm/vendorid_list.h>
> >
> > -#ifdef CONFIG_ERRATA_SIFIVE
> > -#define      ERRATA_SIFIVE_CIP_453 0
> > -#define      ERRATA_SIFIVE_CIP_1200 1
> > -#define      ERRATA_SIFIVE_NUMBER 2
> > -#endif
> > -
> > -#ifdef CONFIG_ERRATA_THEAD
> > -#define      ERRATA_THEAD_PBMT 0
> > -#define      ERRATA_THEAD_CMO 1
> > -#define      ERRATA_THEAD_PMU 2
> > -#define      ERRATA_THEAD_NUMBER 3
> > -#endif
> > -
>
> Here I understand you are moving stuff from errata_list.h to
> vendorid_list.h. Wouldn't it be better to do this on a separated patch
> before this one?
Okay.

>
> I understand this is used here, but it looks like it's unrelated.
>
> >  #ifdef __ASSEMBLY__
> >
> >  #define ALT_INSN_FAULT(x)                                            \
> > diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/r=
wonce.h
> > new file mode 100644
> > index 000000000000..be0b8864969d
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/rwonce.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __ASM_RWONCE_H
> > +#define __ASM_RWONCE_H
> > +
> > +#include <linux/compiler_types.h>
> > +#include <asm/alternative-macros.h>
> > +#include <asm/vendorid_list.h>
> > +
> > +#define __WRITE_ONCE(x, val)                         \
> > +do {                                                 \
> > +     *(volatile typeof(x) *)&(x) =3D (val);            \
> > +     asm volatile(ALTERNATIVE(                       \
> > +             __nops(1),                              \
> > +             "fence w, o\n\t",                       \
> > +             THEAD_VENDOR_ID,                        \
> > +             ERRATA_THEAD_WRITE_ONCE,                \
> > +             CONFIG_ERRATA_THEAD_WRITE_ONCE)         \
> > +             : : : "memory");                        \
> > +} while (0)
> > +
> > +#include <asm-generic/rwonce.h>
> > +
> > +#endif       /* __ASM_RWONCE_H */
>
> IIUC the idea here is to have an alternative __WRITE_ONCE that replaces t=
he
> asm-generic one.
>
> Honestly, this asm alternative here seems too much information, and too
> cryptic. I mean, yeah in the patch it all makes sense, but I imagine myse=
lf
> in the future looking at all this and trying to understand what is going
> on.
>
> Wouldn't it look better to have something like:
>
> #####
>
> /* Some explanation like the one on Kconfig */
>
> #define write_once_flush()                      \
> do {                                            \
>         asm volatile(ALTERNATIVE(                       \
>                 __nops(1),                      \
>                 "fence w, o\n\t",               \
>                 THEAD_VENDOR_ID,                \
>                 ERRATA_THEAD_WRITE_ONCE,        \
>                 CONFIG_ERRATA_THEAD_WRITE_ONCE) \
>                 : : : "memory");                \
> } while(0)
>
>
> #define __WRITE_ONCE(x, val)                    \
> do {                                            \
>         *(volatile typeof(x) *)&(x) =3D (val);    \
>         write_once_flush();                     \
> } while(0)
>
> #####
>
>
> This way I could quickly see there is a flush after the writting of
> WRITE_ONCE(), and this flush is the above "complicated" asm.
>
> What do you think?
Okay, good point, and I would take it.

>
> > diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/includ=
e/asm/vendorid_list.h
> > index cb89af3f0704..73078cfe4029 100644
> > --- a/arch/riscv/include/asm/vendorid_list.h
> > +++ b/arch/riscv/include/asm/vendorid_list.h
> > @@ -8,4 +8,18 @@
> >  #define SIFIVE_VENDOR_ID     0x489
> >  #define THEAD_VENDOR_ID              0x5b7
> >
> > +#ifdef CONFIG_ERRATA_SIFIVE
> > +#define      ERRATA_SIFIVE_CIP_453 0
> > +#define      ERRATA_SIFIVE_CIP_1200 1
> > +#define      ERRATA_SIFIVE_NUMBER 2
> > +#endif
> > +
> > +#ifdef CONFIG_ERRATA_THEAD
> > +#define      ERRATA_THEAD_PBMT 0
> > +#define      ERRATA_THEAD_CMO 1
> > +#define      ERRATA_THEAD_PMU 2
> > +#define      ERRATA_THEAD_WRITE_ONCE 3
> > +#define      ERRATA_THEAD_NUMBER 4
> > +#endif
> > +
> >  #endif
> > diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.=
h
> > index 8d0a6280e982..fb07fe8c6e45 100644
> > --- a/include/asm-generic/rwonce.h
> > +++ b/include/asm-generic/rwonce.h
> > @@ -50,10 +50,12 @@
> >       __READ_ONCE(x);                                                 \
> >  })
> >
> > +#ifndef __WRITE_ONCE
> >  #define __WRITE_ONCE(x, val)                                         \
> >  do {                                                                 \
> >       *(volatile typeof(x) *)&(x) =3D (val);                           =
 \
> >  } while (0)
> > +#endif
> >
> >  #define WRITE_ONCE(x, val)                                           \
> >  do {                                                                 \
> > --
> > 2.36.1
> >
>


--=20
Best Regards
 Guo Ren
