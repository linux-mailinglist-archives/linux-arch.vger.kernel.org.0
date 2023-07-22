Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6735A75D805
	for <lists+linux-arch@lfdr.de>; Sat, 22 Jul 2023 02:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjGVAHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 20:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGVAHI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 20:07:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CB912F;
        Fri, 21 Jul 2023 17:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276B561DB5;
        Sat, 22 Jul 2023 00:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C929C433CB;
        Sat, 22 Jul 2023 00:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689984426;
        bh=2aLCwDO4RNMyvWiQ7Gf0WYxWlcoqijS/87EfNa8tSV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sytF87HZUS79ob+llm+N9vmsbE1uo+OoabhgXAc0wMfW5sroqffqiKJp998P7YirM
         MqP3GpyU5oVw+zkx+T9Z8QOuv0jJVDvevFs/7CfA9DMWB5EEbL13xWYr92SQjnfOI7
         MELetoicsrlAXGm3PpNoIq0XMFdRXlmMJCooOywt+q9SqEkBB8a7NdeOwEJ37tcudV
         Eiq5EwU4VMvnNoQXaUJa2wuMgerZ6u3uZe531Wzd3MWD6xLKK5zDmSTGsOepyDT855
         rx5B+YNdmMpztelTiV9I7NLP5KR13vNoHoRwoWKOzIy3cOnSJ0N1nvHrNT8WXvCR+Z
         FCdxC9/1rhgxA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-521dc8ae899so2927436a12.3;
        Fri, 21 Jul 2023 17:07:06 -0700 (PDT)
X-Gm-Message-State: ABy/qLYI2cGd5e+qv/5v//giIaVKO9uq7Gk6wixK0FM0psMM4VxwAE+N
        XDNpAfBylp93GRI228FmniTRNZWLHFmeLMirspQ=
X-Google-Smtp-Source: APBJJlGcl9QezTiSJ9T9tJT9wWdf04lQ1BB1CWTh4SzgFKovP1Pgqgko53wXBujeXOHWsKdTLL5xW76oF812EC/743c=
X-Received: by 2002:aa7:d991:0:b0:521:d83e:8db2 with SMTP id
 u17-20020aa7d991000000b00521d83e8db2mr2589897eds.39.1689984424762; Fri, 21
 Jul 2023 17:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230716152033.3713581-1-guoren@kernel.org> <bb296a8e-4f84-f45d-8f46-5acfa73022d9@ghiti.fr>
In-Reply-To: <bb296a8e-4f84-f45d-8f46-5acfa73022d9@ghiti.fr>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jul 2023 20:06:53 -0400
X-Gmail-Original-Message-ID: <CAJF2gTTBbHDr4yD=aeof_h1WM6b_CD-yJcs6R5g=jt4-NdAR8w@mail.gmail.com>
Message-ID: <CAJF2gTTBbHDr4yD=aeof_h1WM6b_CD-yJcs6R5g=jt4-NdAR8w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add HAVE_IOREMAP_PROT support
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     palmer@rivosinc.com, paul.walmsley@sifive.com, falcon@tinylab.org,
        bjorn@kernel.org, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 17, 2023 at 5:07=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Guo,
>
> On 16/07/2023 17:20, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add pte_pgprot macro, then riscv could have HAVE_IOREMAP_PROT,
> > which will enable generic_access_phys() code, it is useful for
> > debug, eg, gdb.
>
>
> I don't understand, we already have the generic ioremap_prot()
> implementation since we select GENERIC_IOREMAP: shouldn't
> HAVE_IOREMAP_PROT imply that we have our own implementation?
They are different! See arch/arm64/Kconfig, which selects all of them.

HAVE_IOREMAP_PROT would enable your drivers/char/mem.c
generic_access_phys of mmap_mem_ops.

It's a small function enabling.

>
> Thanks,
>
> Alex
>
>
> > Because generic_access_phys() would call ioremap_prot()->
> > pgprot_nx() to disable excutable attribute, add definition
> > of pgprot_nx() for riscv.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >   .../features/vm/ioremap_prot/arch-support.txt     |  2 +-
> >   arch/riscv/Kconfig                                |  1 +
> >   arch/riscv/include/asm/pgtable.h                  | 15 ++++++++++++++=
+
> >   3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/=
Documentation/features/vm/ioremap_prot/arch-support.txt
> > index a24149e59d73..ea8c8a361455 100644
> > --- a/Documentation/features/vm/ioremap_prot/arch-support.txt
> > +++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
> > @@ -21,7 +21,7 @@
> >       |    openrisc: | TODO |
> >       |      parisc: | TODO |
> >       |     powerpc: |  ok  |
> > -    |       riscv: | TODO |
> > +    |       riscv: |  ok  |
> >       |        s390: |  ok  |
> >       |          sh: |  ok  |
> >       |       sparc: | TODO |
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 4c07b9189c86..15900fa20797 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -117,6 +117,7 @@ config RISCV
> >       select HAVE_FUNCTION_ERROR_INJECTION
> >       select HAVE_GCC_PLUGINS
> >       select HAVE_GENERIC_VDSO if MMU && 64BIT
> > +     select HAVE_IOREMAP_PROT
> >       select HAVE_IRQ_TIME_ACCOUNTING
> >       select HAVE_KPROBES if !XIP_KERNEL
> >       select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index 75970ee2bda2..c9552a161f90 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -415,6 +415,11 @@ static inline pte_t pte_mkhuge(pte_t pte)
> >       return pte;
> >   }
> >
> > +static inline pgprot_t pte_pgprot(pte_t pte)
> > +{
> > +     return __pgprot(pte_val(pte) & ~_PAGE_PFN_MASK);
> > +}
> > +
> >   #ifdef CONFIG_NUMA_BALANCING
> >   /*
> >    * See the comment in include/asm-generic/pgtable.h
> > @@ -573,6 +578,16 @@ static inline int ptep_clear_flush_young(struct vm=
_area_struct *vma,
> >       return ptep_test_and_clear_young(vma, address, ptep);
> >   }
> >
> > +#define pgprot_nx pgprot_nx
> > +static inline pgprot_t pgprot_nx(pgprot_t _prot)
> > +{
> > +     unsigned long prot =3D pgprot_val(_prot);
> > +
> > +     prot &=3D ~_PAGE_EXEC;
> > +
> > +     return __pgprot(prot);
> > +}
> > +
> >   #define pgprot_noncached pgprot_noncached
> >   static inline pgprot_t pgprot_noncached(pgprot_t _prot)
> >   {



--=20
Best Regards
 Guo Ren
