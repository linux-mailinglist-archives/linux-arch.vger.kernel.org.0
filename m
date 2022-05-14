Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3FB5271A8
	for <lists+linux-arch@lfdr.de>; Sat, 14 May 2022 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiENOLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 May 2022 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiENOLN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 14 May 2022 10:11:13 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BB140C1;
        Sat, 14 May 2022 07:11:12 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id a127so11182331vsa.3;
        Sat, 14 May 2022 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hu9lcC4VWnmKtfo/8BJeK5iYaxKMLlV7G2yQ6uCfIbE=;
        b=EiKl6gufYXvNhX7bWY6qm5SjpcB52oXBz6oRHZo03KTV8ISjv1Uly20EwrMgBdAU6R
         JGOIl+NFGIde9B9+wYU/q+Z88GldTTTNtRjSaH5ec7n/DBVDslnz9fpvcXoEILva8C7G
         tsGtAsTCxzRIQz+/zJrbGjrTh6Q/kjAV8ow0RfPZe2SOM+xSOUfr01svfgRgsiHIoCnH
         GJIKQrQfray0oYh8rmZIfV9SC/xjVVMuHGHAOPQikDWzvWYWh3JwC0SWQpOoU/IOnjyB
         HibG1Ydv24vsAlqmchaTWN94S3mbOy9g7NXVza4P5E5g/PwkZ1kRiyObOfHctuIWmF6d
         7oJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu9lcC4VWnmKtfo/8BJeK5iYaxKMLlV7G2yQ6uCfIbE=;
        b=PT8JEhMJYYN1QELk5zSAnS7Eu5/O3eibvIVWUSn8wgXrrzcyg2J/MOGIafhQZjXN+K
         lFpn7dKnNUHeibzcyLinIicar9aXotrdRMzAeEgjqzYOiBkWzTHhnhZzeGGD0Ms3aevW
         nKUA2lmZ0BpyeCYg5nFrDRuJ4013XE1XbV1DvvdEaP5pJQrh0h9BO0wlGhOLyJG45gZi
         uMSgs0ZEol8DuyMqCtmijoPAWYUJ6K3aXE5pyYAwsRcgKzyIL8UDj+3Ib0b73iifvTXg
         lOBHqylgkWiZ58wq/vbT8vY8xbDjHLAgfnRuEJskLhtgjDp76qDry4jcNHKuYIz/oy9F
         w+rA==
X-Gm-Message-State: AOAM533g8z70ozLoTi43+etKVaFQfWQk2hCuF/JIXIfkh7qLOAxuwpB/
        nO52ZH5rQrxcJbKV1ft3LlD3J0oRDB1nPLt0BeTKcNHQudxtZg==
X-Google-Smtp-Source: ABdhPJxLFBONgCNpcyCncuhUjtMLS3C9LnuqiiTH5fG+Yf8TCRdXF9zfnk4DzS+KOxkQTh81E3aMyvZiU/N0ieX4lbM=
X-Received: by 2002:a67:ea4f:0:b0:328:1db4:d85c with SMTP id
 r15-20020a67ea4f000000b003281db4d85cmr3656308vso.20.1652537471149; Sat, 14
 May 2022 07:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-4-chenhuacai@loongson.cn> <25efb0c1-f2e7-0052-c925-08dd778d7ad7@xen0n.name>
In-Reply-To: <25efb0c1-f2e7-0052-c925-08dd778d7ad7@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 14 May 2022 22:11:00 +0800
Message-ID: <CAAhV-H6rBtmTQTpxdZtk26sP9SJui5dpv2e-2ZUyWTtpxpf9FQ@mail.gmail.com>
Subject: Re: [PATCH V3 03/22] LoongArch: Add elf-related definitions
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
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Sat, May 14, 2022 at 9:29 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> Why this patch is from V3? I guess it's by mistake so would you re-send
> a proper v10?
This is just a typo, it is really V10.

Huacai
>
> On 5/14/22 16:03, Huacai Chen wrote:
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
