Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F904802A7
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhL0RPa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:15:30 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:44964 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhL0RPa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 12:15:30 -0500
Received: by mail-qt1-f180.google.com with SMTP id a1so13981276qtx.11;
        Mon, 27 Dec 2021 09:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtgQp7E+XHWylh821kSXZHujAj5pCd79Pzv+DDY2bEU=;
        b=cTY0I7ab+1YISy9GG7AM0ilwNNMJBKFARIkEJMRtYhsDFgFnL/tcKssbx1+ecnu5SD
         rh631Zo4pOHjxCpN1zzW58PlNyOkLlooE2Lr0XV1muAXrkesa+FsXmGOaJw4Mjst3n/Y
         DzcUcyfm0EMJKN7C+yTq7P0uu4Z6NEAyYYvDz7g2baIgN0CnsTGeYYuzJjh11Aik1AGm
         tvsm421MD6PLXW0vIA6M/cVd8/0L6KAi5YcE9hBYbIo2jxmUbvUDEmaJzkk3xHVN79Eu
         e/251c0VmRV9ldJ+mWkutdk3xaDcZeUrsTxc9n+t/zvjs068QNJ7cCDl3UAsQhd61Qln
         KQDg==
X-Gm-Message-State: AOAM533bPlXENnL5u0QrxTyisqS66b+/NrUVy2Ntd36Gga6DSc7mJRES
        QP/o95xMdjI0tqoi90wyy07JHgCZnmipUDW7ULI=
X-Google-Smtp-Source: ABdhPJzA0UGsW2BMjYh4XhxHxtQu5xuUJBsEKsGOHY8rU94CjJKL3IsMfTI+JhA0Q5Zt69+rfrdTsyx47n0p+gK10nc=
X-Received: by 2002:ac8:46cc:: with SMTP id h12mr15513581qto.417.1640625329642;
 Mon, 27 Dec 2021 09:15:29 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-4-schnelle@linux.ibm.com> <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
 <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com> <CAJZ5v0iG=wqVtJULiTFsffMWqihA0Rk+abMzmfTcH+J9d5G+YA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iG=wqVtJULiTFsffMWqihA0Rk+abMzmfTcH+J9d5G+YA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 18:15:18 +0100
Message-ID: <CAJZ5v0htSMwM5SgSAaS-UB3G=99DC8ytQ5P4BfjDhdAoQ7pFdg@mail.gmail.com>
Subject: Re: [RFC 03/32] ACPI: Kconfig: add HAS_IOPORT dependencies
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Dec 27, 2021 at 6:02 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> >
> > On Mon, 2021-12-27 at 17:47 +0100, Rafael J. Wysocki wrote:
> > > On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > not being declared. As ACPI always uses I/O port access
> > >
> > > The ARM64 people may not agree with this.
> >
> > Maybe my wording is bad. This is my rewording of what Arnd had in his
> > original mail: "The ACPI subsystem needs access to I/O ports, so that
> > also gets a dependency."(
> > https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
> > ).
>
> And my point is that on ARM64 the ACPI subsystem does not need to
> access IO ports.
>
> It may not even need to access them on x86, but that depends on the
> platform firmware in use.
>
> If arm64 is going to set HAS_IOPORT, then fine, but is it (and this
> applies to ia64 too)?
>
> > >
> > > > we depend on HAS_IOPORT unconditionally.
> > > >
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >  drivers/acpi/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > > index cdbdf68bd98f..b57f15817ede 100644
> > > > --- a/drivers/acpi/Kconfig
> > > > +++ b/drivers/acpi/Kconfig
> > > > @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
> > > >  menuconfig ACPI
> > > >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > > >         depends on ARCH_SUPPORTS_ACPI

Besides, I'm not sure why ARCH_SUPPORTS_ACPI cannot cover this new dependency.

> > > > +       depends on HAS_IOPORT
> > > >         select PNP
> > > >         select NLS
> > > >         default y if X86
> > > > --
> > > > 2.32.0
> > > >
> >
