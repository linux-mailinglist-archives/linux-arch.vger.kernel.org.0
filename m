Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC45164B8
	for <lists+linux-arch@lfdr.de>; Sun,  1 May 2022 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbiEAObZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 1 May 2022 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiEAObZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 1 May 2022 10:31:25 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE69201B9;
        Sun,  1 May 2022 07:28:00 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id m62so11042508vsc.2;
        Sun, 01 May 2022 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fdGSt2PTTDFmjsmUHG3G9N45wOriTOc1tMkOM1Lc4o=;
        b=TbcF9mVKX6dbPHzxZpQz8vLH6rQx1UanbXs6NAG3NhDsIV+HjOgR/4qc8hN9qjKWvT
         ioxNNzOOXcIX9xeb0J67xnOK9PceycGdjXUArsGFS4Cw+jmggIbCxAvuSdMCPYRpJDlX
         nEzuZdQrQKa/I/rhpp1ASENNVdZixGpCk4yVklY7esMgd0hK6Pr7Ws8yFnqeL7Ginrq3
         +YKn3YBtHq5VX8RUZZZQYlLE7goXTHM6PcA+QoSkcoZK76idRnqG0SGut1asygvBj1IE
         2uaJQ7RBaEPS644Gzn4HipjYVaA3yBCWwACvaXApPFa9JBu5PDgkMngPgqL8Oe7KM4aZ
         qLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fdGSt2PTTDFmjsmUHG3G9N45wOriTOc1tMkOM1Lc4o=;
        b=stAYBA6HLLlkjLa/Anrs9PPQ3N7N/tBzjmWZrGudpch4eI8QasFz2iutBO78S+5P6+
         cg+fFHL9XxGwMgrB+Z160SAm3jmwr32M4UPDR0Zc5ajGHzN7Z5iWQeSaZ3+QbffVcHe4
         uKr0vtQJnZQY8OfP39aOt0UDFz5CxF5h35Fwl8anoEzedBLl6MeUQAjuO2D8z3wPmtRt
         PQWa/TJHgSOfyOPPB+Mpv1PLyAPAbDcPSghkmN0zOW5yhTkbAIHEh2ZNZdpZD6BryaOv
         K82zxUp8JmS+o2S5m3lbWCPJml6gGPAOo/fxdY9zadg4whq5ON4eLnUqMfEEHuFE1+g8
         h3yQ==
X-Gm-Message-State: AOAM5327Fcv34QpMbEf8Ms62WE+nWf9BgJn0BHZztsf6gMUKWn19hAGc
        sE+YTsEskY0cvmFEAzinEaau0UCEmPXq7Gew00s=
X-Google-Smtp-Source: ABdhPJzaNo9WTKgCfNirmD85OSBip65iUqG7DWRG2pWJHLsOSF/jj4wnbe/WX0oYlE4YyzXHH4TVUkf5LBnfQkDfWbE=
X-Received: by 2002:a67:b142:0:b0:32c:e806:a0b0 with SMTP id
 z2-20020a67b142000000b0032ce806a0b0mr1996964vsl.71.1651415279145; Sun, 01 May
 2022 07:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-4-chenhuacai@loongson.cn> <1cd3fc0d-b17c-30c9-445b-612761b96cd1@xen0n.name>
In-Reply-To: <1cd3fc0d-b17c-30c9-445b-612761b96cd1@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 1 May 2022 22:27:47 +0800
Message-ID: <CAAhV-H5ZwJwUd4DYKTL3yxoQAC3fD=KqLacP_P-BHQhefZhgqw@mail.gmail.com>
Subject: Re: [PATCH V9 03/24] LoongArch: Add elf-related definitions
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

On Sun, May 1, 2022 at 5:41 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> Commit message title could be "ELF" -- proper capitalization.
OK, thanks.

Huacai
>
> On 4/30/22 17:04, Huacai Chen wrote:
> > Add elf-related definitions for LoongArch, including: EM_LOONGARCH,
> > KEXEC_ARCH_LOONGARCH, AUDIT_ARCH_LOONGARCH32, AUDIT_ARCH_LOONGARCH64
> > and NT_LOONGARCH_*.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   include/uapi/linux/audit.h  | 2 ++
> >   include/uapi/linux/elf-em.h | 1 +
> >   include/uapi/linux/elf.h    | 5 +++++
> >   include/uapi/linux/kexec.h  | 1 +
> >   scripts/sorttable.c         | 5 +++++
> >   5 files changed, 14 insertions(+)
> >
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 8eda133ca4c1..7c1dc818b1d5 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -439,6 +439,8 @@ enum {
> >   #define AUDIT_ARCH_UNICORE  (EM_UNICORE|__AUDIT_ARCH_LE)
> >   #define AUDIT_ARCH_X86_64   (EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> >   #define AUDIT_ARCH_XTENSA   (EM_XTENSA)
> > +#define AUDIT_ARCH_LOONGARCH32       (EM_LOONGARCH|__AUDIT_ARCH_LE)
> > +#define AUDIT_ARCH_LOONGARCH64       (EM_LOONGARCH|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
> >
> >   #define AUDIT_PERM_EXEC             1
> >   #define AUDIT_PERM_WRITE    2
> > diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
> > index f47e853546fa..ef38c2bc5ab7 100644
> > --- a/include/uapi/linux/elf-em.h
> > +++ b/include/uapi/linux/elf-em.h
> > @@ -51,6 +51,7 @@
> >   #define EM_RISCV    243     /* RISC-V */
> >   #define EM_BPF              247     /* Linux BPF - in-kernel virtual machine */
> >   #define EM_CSKY             252     /* C-SKY */
> > +#define EM_LOONGARCH 258     /* LoongArch */
> >   #define EM_FRV              0x5441  /* Fujitsu FR-V */
> >
> >   /*
> > diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> > index 7ce993e6786c..1e0ae3f554f6 100644
> > --- a/include/uapi/linux/elf.h
> > +++ b/include/uapi/linux/elf.h
> > @@ -436,6 +436,11 @@ typedef struct elf64_shdr {
> >   #define NT_MIPS_DSP 0x800           /* MIPS DSP ASE registers */
> >   #define NT_MIPS_FP_MODE     0x801           /* MIPS floating-point mode */
> >   #define NT_MIPS_MSA 0x802           /* MIPS SIMD registers */
> > +#define NT_LOONGARCH_CPUCFG  0xa00   /* LoongArch CPU config registers */
> > +#define NT_LOONGARCH_CSR     0xa01   /* LoongArch control and status registers */
> > +#define NT_LOONGARCH_LSX     0xa02   /* LoongArch Loongson SIMD Extension registers */
> > +#define NT_LOONGARCH_LASX    0xa03   /* LoongArch Loongson Advanced SIMD Extension registers */
> > +#define NT_LOONGARCH_LBT     0xa04   /* LoongArch Loongson Binary Translation registers */
> These are named NT_LARCH_* in binutils source, better keep consistent?
> >
> >   /* Note types with note name "GNU" */
> >   #define NT_GNU_PROPERTY_TYPE_0      5
> > diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> > index fb7e2ef60825..981016e05cfa 100644
> > --- a/include/uapi/linux/kexec.h
> > +++ b/include/uapi/linux/kexec.h
> > @@ -43,6 +43,7 @@
> >   #define KEXEC_ARCH_MIPS    ( 8 << 16)
> >   #define KEXEC_ARCH_AARCH64 (183 << 16)
> >   #define KEXEC_ARCH_RISCV   (243 << 16)
> > +#define KEXEC_ARCH_LOONGARCH (258 << 16)
> >
> >   /* The artificial cap on the number of segments passed to kexec_load. */
> >   #define KEXEC_SEGMENT_MAX 16
> > diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> > index d00504c5f530..fba40e99f354 100644
> > --- a/scripts/sorttable.c
> > +++ b/scripts/sorttable.c
> > @@ -60,6 +60,10 @@
> >   #define EM_RISCV    243
> >   #endif
> >
> > +#ifndef EM_LOONGARCH
> > +#define EM_LOONGARCH 258
> > +#endif
> > +
> >   static uint32_t (*r)(const uint32_t *);
> >   static uint16_t (*r2)(const uint16_t *);
> >   static uint64_t (*r8)(const uint64_t *);
> > @@ -313,6 +317,7 @@ static int do_file(char const *const fname, void *addr)
> >       case EM_ARCOMPACT:
> >       case EM_ARCV2:
> >       case EM_ARM:
> > +     case EM_LOONGARCH:
> >       case EM_MICROBLAZE:
> >       case EM_MIPS:
> >       case EM_XTENSA:
