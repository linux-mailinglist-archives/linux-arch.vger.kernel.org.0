Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954EA3D7555
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 14:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhG0Mv5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 08:51:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236509AbhG0Mv4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 08:51:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D3EA61A83
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627390316;
        bh=O2H66cyN4UbGLGQMfum+rB8Wn4aDCdpCaUOASgB3rSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YcMBPRtH2za/WwY4RYpyuOsf2Xo3Amre4TnZPvcqOrUkza2+Ipuko4vjambFLUoF2
         iG+SJZGKYHr8LyC/OVLg9wYP10QUBa9Y+9/As00ETU1F7wsuqwLTO80ZETjoa4r8ZX
         BNu88gZL9ZoH6C2nZlHNocAs5BxAyhEzgalmf0hh9hQ4OsGD46euMr013RWgnJEbLb
         spBY6RlAUmg+0Os/lTgb2g/fQm2n2gVNfLFfTWQo3+CKB5XmXMvigGLltMdiNciyrJ
         y03eg6ZjRT40drsndHYCWNBRzYYV48dO1TjmBXYSFdEUbQLMbre5Ot1P7096Ttf9RU
         Nm8X3Vs7MNivg==
Received: by mail-ot1-f53.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so13251386oto.12
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 05:51:56 -0700 (PDT)
X-Gm-Message-State: AOAM5325sAEeazNALAFDT/xeYwKklsxJdh1LsmJar+nGqB7PBSNc9Crs
        WvST/C4xd13uTzYgE39O7r/0dIummHL6uSUJPsg=
X-Google-Smtp-Source: ABdhPJxpsJdJ5xo/l7SsoLGHt4ksrG6IDlRbtCR59upL4fOXNftyHX7SWocMN1I3LROow9ofxu30jEV7yqW3D1Y42zk=
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr15321882ote.90.1627390315294;
 Tue, 27 Jul 2021 05:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
 <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com> <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
In-Reply-To: <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jul 2021 14:51:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com>
Message-ID: <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com>
Subject: Re: [PATCH 05/19] LoongArch: Add boot and setup routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 27 Jul 2021 at 14:41, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 27, 2021 at 1:53 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Jul 6, 2021 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > > +
> > > > +#ifdef CONFIG_64BIT
> > > > +       /* Guess if the sign extension was forgotten by bootloader */
> > > > +       if (start < CAC_BASE)
> > > > +               start = (int)start;
> > > > +#endif
> > > > +       initrd_start = start;
> > > > +       initrd_end += start;
> > > > +       return 0;
> > > > +}
> > > > +early_param("rd_start", rd_start_early);
> > > > +
> > > > +static int __init rd_size_early(char *p)
> > > > +{
> > > > +       initrd_end += memparse(p, &p);
> > > > +       return 0;
> > > > +}
> > > > +early_param("rd_size", rd_size_early);
> > >
> > > The early parameters should not be used for this, I'm fairly sure the UEFI
> > > boot protocol already has ways to communicate all necessary information.
> > We use grub to boot the Linux kernel. We found X86 uses private data
> > structures (seems not UEFI-specific) to pass initrd information from
> > grub to kernel. Some archs use fdt, and other archs use cmdline with
> > "initrd=start,size" (init/do_mounts_initrd.c). So, I think use cmdline
> > is not unacceptable, but we do can remove the the rd_start/rd_size
> > parsing code here
>
> (adding Ard Biesheuvel to Cc for clarification)
>
> As far as I understand it, this should be using the kernel's UEFI stub
> as documented in Documentation/admin-guide/efi-stub.rst
>

That document describes how the EFI stub can load an initrd from the
partition that the kernel image itself was loaded from.

After loading it, the EFI stub still needs to tell the kernel proper
where the initrd lives in memory, and it uses either struct bootparam
(x86) or DT's /chosen node (other arches) for this.

I think we should avoid inventing yet another way of passing this
information, but if the architecture in question does not use DT (and
is != x86), I don't think we have a choice. Does this system boot via
EFI to begin with?


> This lets you load the initrd from within the kernel and pass the
> address using the architecture specific boot information.
>
> Maybe I misunderstood and you already do it like this?
>
>        Arnd
