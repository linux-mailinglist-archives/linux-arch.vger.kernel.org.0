Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9307B3D8BA8
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhG1KZD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1KZD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 06:25:03 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487AC061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 03:25:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id j21so2369522ioo.6
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lR86CumlSscoNTZZ/SBgia1YwuLd5hb6wb2zb/k7e2Y=;
        b=PC8BfjLbUXEQqDTrnOQKAcqt73VmKW2leci5nCdRGkaORkVOdWfFCHEiI+HCJ3Jxax
         ixgCVnJH6IItli9qv7XEXUwkIZVb8gyl0KVFuzlbtUpo3bYg+OhAmt1SYKQrXgmzJntK
         XWam5EDEHuRKHZY/skqP6MpVzF/WUbg0tmhJocWiHgt6q5bQPvAUxzcnfsLT74UJ4IJ9
         iC/WGflNibQQVBBSXnknPMxXBayuooxSfzPw8QP4DKhUaNhB9d537G5T+TiO3xJ+kqB9
         Rrf/pGTjzpaF0YpZcE45DEQz0VmbtiKn/4W0l5DtTMsuzE3yliCeAapwLF59oyLluNOs
         huxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lR86CumlSscoNTZZ/SBgia1YwuLd5hb6wb2zb/k7e2Y=;
        b=r5oXu9fYxSWyj9/wdhhMYE01Rs++HgUsjHQGLJhZtQRzWMM98HVA0IXyFeWL7xgiDa
         +A8jW+PtcwNK5tFbha0b0x62XNJNjLQhuab1RXVX579fURtM+kLKZ7EKywkZmfPPMCY2
         HzKQv/IHpOZGyKxPC/n3hdZBnBkGm40XjVqfclwxwH2imbW3d4K8jB9s8/YDVNtDqwbD
         pSDMv5xKh5FdcOHwolkYYffbCF0q+1tb3h8tzCiW07HuTGpBjLoe8Als2KHd3nX0mQB3
         1l8Wym6sLJ4QonvHxqdwqPZopexUo4BeSok3wXj5PXjPivHx6EDcyyAYSdxdMVG9HGab
         GJKg==
X-Gm-Message-State: AOAM533FZSLqTvwZp02PaTpSh6AaGGSrQ4OCoBXcwkujAeIj0BZVW+x5
        yk7HjW9yC3IRoVSpKZ28Xj4JJTTeoKOaYlfB16Y=
X-Google-Smtp-Source: ABdhPJypTkTZ0FLNf1C590pa980w0mrv5KuxsvaDFAQBeehOZ2gTU0k069UnD+6aYeyZe3IHyoTgN08m8sn9ooEnZAg=
X-Received: by 2002:a05:6638:338f:: with SMTP id h15mr25684809jav.135.1627467900441;
 Wed, 28 Jul 2021 03:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
 <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
 <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
 <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com>
 <CAK8P3a3kRum-qZBdwJ0bAKbxL2iDfmCgzNeoJk8zEr_Zc_J1Fg@mail.gmail.com>
 <CAMj1kXGUfAZ79N7Xtsyh3P+HubVhgLgnrBuJT1U3z80z569uag@mail.gmail.com> <CAK8P3a0zYMrZ7muts2sR==_Ca=Vx-MjOQXmzteAcj6Oqmtiufw@mail.gmail.com>
In-Reply-To: <CAK8P3a0zYMrZ7muts2sR==_Ca=Vx-MjOQXmzteAcj6Oqmtiufw@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 28 Jul 2021 18:24:49 +0800
Message-ID: <CAAhV-H4Y46_a-Bx2aL=f3ZrrEWgXw_26D_6LnFq-F3u4fUdPtg@mail.gmail.com>
Subject: Re: [PATCH 05/19] LoongArch: Add boot and setup routines
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

Hi, Arnd and Ard,

On Wed, Jul 28, 2021 at 1:54 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 27, 2021 at 6:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Tue, 27 Jul 2021 at 15:14, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 27, 2021 at 2:51 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > On Tue, 27 Jul 2021 at 14:41, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > On Tue, Jul 27, 2021 at 1:53 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > >
> > > How is other information passed from grub to the efi stub
> > > and from there to the kernel on loongarch?
> >
> > I don't think this architecture boots via EFI at all - it looks like a
> > data structure is created in memory that looks like an EFI system
> > table, and provided to the kernel proper without going through the
> > stub. This is not surprising, given that the stub turns the kernel
> > into a PE/COFF executable, and the PE/COFF spec nor the EFI spec
> > support the LoongSon architecture.
>
> A lot of upstream projects are still missing loongarch support completely.
> I already pointed out the lack of kernel support when the musl and
> qemu patches got posted first, and the lack of toolchain support for the
> kernel, so it's possible this one is just another missing dependency that
> they plan to post later but really should have sooner.
>
> > This is problematic from a maintenance point of view, given that the
> > interface between the kernel proper and the EFI stub is being promoted
> > from an internal interface that we can freely modify to one that needs
> > to remain stable for compatibility of new kernels with older firmware.
> > I don't think we should be going down this path tbh.
>
> Agreed. Having a reliable boot interface is definitely important here,
> and copying from arch/mips was probably not the best choice in this
> regard. They can probably look at what was needed for RISC-V to
> add this properly, as that was done fairly recently.
Now the boot information passed to kernel is like this:
1, kernel get a0, a1 and a2 from bootloader.
2, a0 is "argc", a1 is "argc", so "cmdline" comes from a0/a1
3, a2 is "envrion", which is a pointer to a "struct bootparamsinterface"
4, "struct bootparamsinterface" include "systemtable" pointer, whose
type is "efi_system_table_t". Most information, include ACPI tables,
come from here.
5, initrd path is specified in grub.cfg, but its load address and size
is calculated dynamically by grub, so grub appends parameters to
cmdline.

Huacai
>
>         Arnd
