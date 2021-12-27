Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB194802A1
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhL0RMv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:12:51 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:41898 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhL0RMv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 12:12:51 -0500
Received: by mail-qv1-f43.google.com with SMTP id h5so14246801qvh.8;
        Mon, 27 Dec 2021 09:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=af02MDoLDv5kbBqJbyiSBVRg3nPQiESX18I2wb5cRsA=;
        b=CHgTknhZfS33OCTpZlns9j6oV14wr4xLFPhW4lPxkWyYlDYWhmNO0ZNrvWNDkh4lXi
         9RfJ5BrD2AJnWz2OMj/n4j1bhp7kwnIN9qhTZe1s1fZyF4kJs7uTgW2VCrnMXW2kU7kb
         1b5DZz0/VttQwdxQZtefviUk0EL3cVZ1oiNxUmSax2ylOfbNf4XpFiE1k6g+WvdjXmfb
         WQpNynjPET9Wlu/RHJXj1HWPsHvI6ZDLX2uqq8kY3kY6CHP/FwipzmgSxcM11X2mB4lP
         W5kLnlAOQ2BZMo3jrX6BOG7idqqfxnGvuXXuNf1NDcHu2oF2LBdnhfTJMEHgwbf0dCpJ
         nD1g==
X-Gm-Message-State: AOAM53066xg/VgKLeuIfxv9oKPTXxRZ2iNo97PkGhY9rpgiEMYQ8FHss
        YQyf5lvm7zzbbnzEQeEVPJFRl0fpNsW/sGzkjDs=
X-Google-Smtp-Source: ABdhPJxNmaSn541hp00AtbTQkpIwBC7T6N1h7BjA/mD+syu3XRg/0WG6Xin/cclUcv9Fozfek23tdPR8FsdpVccd1ZY=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr15740245qvd.52.1640625170529;
 Mon, 27 Dec 2021 09:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-4-schnelle@linux.ibm.com> <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
 <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com>
In-Reply-To: <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 18:12:39 +0100
Message-ID: <CAJZ5v0iG=wqVtJULiTFsffMWqihA0Rk+abMzmfTcH+J9d5G+YA@mail.gmail.com>
Subject: Re: [RFC 03/32] ACPI: Kconfig: add HAS_IOPORT dependencies
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
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

On Mon, Dec 27, 2021 at 6:02 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> On Mon, 2021-12-27 at 17:47 +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. As ACPI always uses I/O port access
> >
> > The ARM64 people may not agree with this.
>
> Maybe my wording is bad. This is my rewording of what Arnd had in his
> original mail: "The ACPI subsystem needs access to I/O ports, so that
> also gets a dependency."(
> https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
> ).

And my point is that on ARM64 the ACPI subsystem does not need to
access IO ports.

It may not even need to access them on x86, but that depends on the
platform firmware in use.

If arm64 is going to set HAS_IOPORT, then fine, but is it (and this
applies to ia64 too)?

> >
> > > we depend on HAS_IOPORT unconditionally.
> > >
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > >  drivers/acpi/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > index cdbdf68bd98f..b57f15817ede 100644
> > > --- a/drivers/acpi/Kconfig
> > > +++ b/drivers/acpi/Kconfig
> > > @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
> > >  menuconfig ACPI
> > >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > >         depends on ARCH_SUPPORTS_ACPI
> > > +       depends on HAS_IOPORT
> > >         select PNP
> > >         select NLS
> > >         default y if X86
> > > --
> > > 2.32.0
> > >
>
