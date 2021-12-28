Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60056480ACB
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhL1PUQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 10:20:16 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:46652 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhL1PUO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 10:20:14 -0500
Received: by mail-qv1-f42.google.com with SMTP id r6so16635990qvr.13;
        Tue, 28 Dec 2021 07:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fY3FmhAa22/bq1K7vSBws2+S2Pg0+cIwqXDwc5lfsw=;
        b=UCQFUY3wLUUmtLC9Ea6wcxv7CqvKjD3sGXV2mGca039w/lW5A2Czh2DzVDhXXJzQRi
         CyVZ4QOtvVJSs2PxIOce5dpe0HQcOQ+NV9X+Yw2BN0OR8J35wsZPyFDcD+uwxL22o0Cg
         Dm4JNU+lYrGqpoSnT4antbJkVfD9NmSH78hT4wlSrZCdUjAwgPeJJ+rZU0R3l8+oDCZl
         mMlTeHbaeUwtZC6dmun78W3kyPkBH31r8j21ykWWT+mOCFp9qssNjZeaqT4UPUbNS8uU
         J3+FXG0rKS1S0k7rXWDarDu+Iy6y14GeUJP1D3VkoqB9KAfILKjSiXMjGioOq9XraYB4
         zPXA==
X-Gm-Message-State: AOAM532qs0614pgFmCVeevk+e7Vkx1P9Z38YiCPtiI0PfiLPNSvxjYn+
        ZgJqtlpqXVvXqS1Ismu8goorcrS8T7FXQPrIjwA=
X-Google-Smtp-Source: ABdhPJwvMDI1hVWuwpeJm0z85bOJLHXSFIeaxxqnKp8rrJOftEJ2aVNhZWqV1CODEWkrk/+iaCoh31AJInvbc7cE4Gs=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr19277943qvd.52.1640704813291;
 Tue, 28 Dec 2021 07:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-4-schnelle@linux.ibm.com> <CAJZ5v0iBJ8NtQautnWnp_pXMfLy_rxys8j4+ugSTbNBb=wzy6A@mail.gmail.com>
 <f9f698b44173c6906e49e17aa33a98e12da7f60b.camel@linux.ibm.com>
 <CAJZ5v0iG=wqVtJULiTFsffMWqihA0Rk+abMzmfTcH+J9d5G+YA@mail.gmail.com>
 <CAJZ5v0htSMwM5SgSAaS-UB3G=99DC8ytQ5P4BfjDhdAoQ7pFdg@mail.gmail.com> <d1daba9437783ffca746ab7329fe4fbdd04d247f.camel@linux.ibm.com>
In-Reply-To: <d1daba9437783ffca746ab7329fe4fbdd04d247f.camel@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Dec 2021 16:20:02 +0100
Message-ID: <CAJZ5v0idJXf0dBctmCVxyp4rWsMp_MvnryibZa8hqvmjtKV5TQ@mail.gmail.com>
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

On Mon, Dec 27, 2021 at 6:43 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> On Mon, 2021-12-27 at 18:15 +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 27, 2021 at 6:12 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Mon, Dec 27, 2021 at 6:02 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > On Mon, 2021-12-27 at 17:47 +0100, Rafael J. Wysocki wrote:
> > > > > On Mon, Dec 27, 2021 at 5:44 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > > > > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > > > > not being declared. As ACPI always uses I/O port access
> > > > >
> > > > > The ARM64 people may not agree with this.
> > > >
> > > > Maybe my wording is bad. This is my rewording of what Arnd had in his
> > > > original mail: "The ACPI subsystem needs access to I/O ports, so that
> > > > also gets a dependency."(
> > > > https://lore.kernel.org/lkml/CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com/
> > > > ).
> > >
> > > And my point is that on ARM64 the ACPI subsystem does not need to
> > > access IO ports.
> > >
> > > It may not even need to access them on x86, but that depends on the
> > > platform firmware in use.
>
> Well at least it does compile code calling outb() in
> drivers/acpi/ec.c:acpi_ec_write_cmd().

That's the EC driver which is not used on arm64 AFAICS and that driver
itself can be made depend on HAS_IOPORT.

> Not sure if there is an
> alternative path at runtime if there is then we might want to instead
> use ifdefs to always use the non I/O port path if HAS_IOPORT is
> undefined.
>
> > >
> > > If arm64 is going to set HAS_IOPORT, then fine, but is it (and this
> > > applies to ia64 too)?
>
> Yes x86, arm64 and ia64 that is all arches that set ACH_SUPPORTS_ACPI
> all select HAS_IOPORT too. See patch 02 or the summary in the cover
> letter which notes that only s390, nds32, um, h8300, nios2, openrisc,
> hexagon, csky, and xtensa do not select it.

If that is the case, there should be no need to add the extra
dependency to CONFIG_ACPI.

> > >
> > > > > > we depend on HAS_IOPORT unconditionally.
> > > > > >
> > > > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > > > ---
> > > > > >  drivers/acpi/Kconfig | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > > > > > index cdbdf68bd98f..b57f15817ede 100644
> > > > > > --- a/drivers/acpi/Kconfig
> > > > > > +++ b/drivers/acpi/Kconfig
> > > > > > @@ -9,6 +9,7 @@ config ARCH_SUPPORTS_ACPI
> > > > > >  menuconfig ACPI
> > > > > >         bool "ACPI (Advanced Configuration and Power Interface) Support"
> > > > > >         depends on ARCH_SUPPORTS_ACPI
> >
> > Besides, I'm not sure why ARCH_SUPPORTS_ACPI cannot cover this new dependency.
>
> If you prefer to have the dependency there that should work too yes.

I would prefer that.

IMO, if ARCH_SUPPORTS_ACPI is set, all of the requisite dependencies
should be met.
