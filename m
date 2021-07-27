Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9AD3D7AD9
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 18:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhG0QWt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 12:22:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QWs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Jul 2021 12:22:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD6B061BA7
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627402968;
        bh=tRCIQ+06KgU4lNi+Fb90+jG21dR89j+8DXYirnR5tDs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oggmkEOzZHTmTr+dyl9lyB6x3Muw4sl/cooJ6rHg9wP6+OvHykFanpCYP1IHuwQLq
         XCQkrVdfQ3hSKluxGMdpc0AhJPqYMrDE135wtwjLr8Fd3o4guduHtmXTYpCxQrYNTm
         8AVg/JWMR1evNTSl11XKRtRCrPaFNNz4SXYm9T1gfH8l/oF9Qr8Q9GIA32EOwWeQhO
         euDaPKRXHaQypj2Ny/TDqJMvB8Z5Esm2QdDGfm0gKjvPC4CQkbwYJFz+1LFLRML5Pa
         foWJw0JQPZDc5CWp90tSdWzQZpiKEHdMsj3qtI0PKXUFJUHV4nDZubOLt6xQxOK60a
         DvTJ8j7S5pc4Q==
Received: by mail-oi1-f182.google.com with SMTP id w6so15711245oiv.11
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 09:22:48 -0700 (PDT)
X-Gm-Message-State: AOAM530TcceFN2wcVnm/YAcsjM1uxYv5ILDnoZq4ashu5mxu/byKZWa/
        SXKpUcQmJLJJwia7I2HP2picS0zZGpBX6SujEZs=
X-Google-Smtp-Source: ABdhPJyBuKnxY8Pbw5e/jntqYaOpgtL96+p+2fcX2a2430vwN+U0SOntBRgNNI90We0qeJ54Broyo31A/ZbYaskdyX4=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr15355137oib.33.1627402968174;
 Tue, 27 Jul 2021 09:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-6-chenhuacai@loongson.cn> <CAK8P3a1w2Dz_7J1qrGmTYwUqpu=Mc4ew2TMmLynjvyvoEXMd7Q@mail.gmail.com>
 <CAAhV-H4HrcfmLmgxB765CyU72FGsAx1kEzV+yjfgKUO+9KiCNw@mail.gmail.com>
 <CAK8P3a3WdXOrsg6wYShr9KU7PFn2mUHz4dwOTNhYtw53WiwT1A@mail.gmail.com>
 <CAMj1kXGCMcy5qTmjg_Ejg2eXBo2zhDrK+d-yrsQXmF_A4CVcDg@mail.gmail.com> <CAK8P3a3kRum-qZBdwJ0bAKbxL2iDfmCgzNeoJk8zEr_Zc_J1Fg@mail.gmail.com>
In-Reply-To: <CAK8P3a3kRum-qZBdwJ0bAKbxL2iDfmCgzNeoJk8zEr_Zc_J1Fg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 27 Jul 2021 18:22:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGUfAZ79N7Xtsyh3P+HubVhgLgnrBuJT1U3z80z569uag@mail.gmail.com>
Message-ID: <CAMj1kXGUfAZ79N7Xtsyh3P+HubVhgLgnrBuJT1U3z80z569uag@mail.gmail.com>
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

On Tue, 27 Jul 2021 at 15:14, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 27, 2021 at 2:51 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Tue, 27 Jul 2021 at 14:41, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Jul 27, 2021 at 1:53 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > >
> > > As far as I understand it, this should be using the kernel's UEFI stub
> > > as documented in Documentation/admin-guide/efi-stub.rst
> > >
> >
> > That document describes how the EFI stub can load an initrd from the
> > partition that the kernel image itself was loaded from.
> >
> > After loading it, the EFI stub still needs to tell the kernel proper
> > where the initrd lives in memory, and it uses either struct bootparam
> > (x86) or DT's /chosen node (other arches) for this.
> >
> > I think we should avoid inventing yet another way of passing this
> > information, but if the architecture in question does not use DT (and
> > is != x86), I don't think we have a choice.
>
> Ok, I see.
>
> Would the existing early_param("initrd", early_initrd); in
> init/do_mounts_initrd.c work for this then? This would be
> similar to the proposed rd_start()/rd_size() early_parem
> additions, but use architecture-independent code.
>

Yes, I think that should be fine. The reason we use the /chosen node
for DT architectures is simply because that is how the command line
itself gets passed as well, and DT nodes are more structured than the
command line. Otherwise, initrd= should be perfectly suitable for DT
platforms as well, modulo the syntax clash between the stub's initrd=
and the kernel's initrd=


> How is other information passed from grub to the efi stub
> and from there to the kernel on loongarch?

I don't think this architecture boots via EFI at all - it looks like a
data structure is created in memory that looks like an EFI system
table, and provided to the kernel proper without going through the
stub. This is not surprising, given that the stub turns the kernel
into a PE/COFF executable, and the PE/COFF spec nor the EFI spec
support the LoongSon architecture.

This is problematic from a maintenance point of view, given that the
interface between the kernel proper and the EFI stub is being promoted
from an internal interface that we can freely modify to one that needs
to remain stable for compatibility of new kernels with older firmware.
I don't think we should be going down this path tbh.


> I suppose at the minimum we need memory regions, ACPI
> tables, and command line, in addition to the initrd.
>
>        Arnd
