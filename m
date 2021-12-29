Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599B2480F1D
	for <lists+linux-arch@lfdr.de>; Wed, 29 Dec 2021 03:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhL2C7H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 21:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhL2C7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 21:59:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86C3C061574;
        Tue, 28 Dec 2021 18:59:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4F94B817DC;
        Wed, 29 Dec 2021 02:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5F1C36AF1;
        Wed, 29 Dec 2021 02:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640746742;
        bh=WWehljrE+d9Z+3M+T9SrX10/EYU7Gcap3svFN0FpHdY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=doH0dqKHCCTGOPu7FBhWS2NixYdNIAZs3lvbFohR9oR9TumeD881kf9+IoQao0Fnn
         D2nm6NiAyKk+tf4J71AFRLYpRNAqCU9tOabxkqydkOGq0cyZbBEWV/CyJw1Ro+l24Z
         zrX7Qo+Xtx4pDEZzhBUX6fdPKU/THYX+AUPG/HXQt7fC2J6CET/D6gW7X9kgSCV1zI
         yyXR9O9uizkViq/MpkH2MiXqAWEtjTgI35mbL0pLm+RwbwBXu6rHSMSebd0G3g2ObM
         5ro9OAUNI/kzdBc373QdKLKbYDKg5NLrw91WExPg9pC1lzu2PRgPs73T+8XHdadHTC
         g1lCqK3LJsZxw==
Received: by mail-wr1-f43.google.com with SMTP id v11so41687188wrw.10;
        Tue, 28 Dec 2021 18:59:02 -0800 (PST)
X-Gm-Message-State: AOAM5327qx2ZlNTPzLSKz6sJ2kHKUbOQu39xv32hto3WL1Da4tKRDb5x
        ljoGAMDVgxu/qJ1m4YwoyPTEpS41645XNqpzt+4=
X-Google-Smtp-Source: ABdhPJxrps/NwZGe5JTUmDrzyXLa9rjvKVDghRb3MXHYJ0NDa0CGgiMBThXsngnn+H2n+tqEv9R0l1/E9RkqUJy1fEI=
X-Received: by 2002:adf:f051:: with SMTP id t17mr18729122wro.192.1640746740813;
 Tue, 28 Dec 2021 18:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
 <20211227164317.4146918-5-schnelle@linux.ibm.com> <CAMuHMdVBXBXSE8bQFNqxkbCASZKq25evHGXHjC6u7f3ktW4dpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVBXBXSE8bQFNqxkbCASZKq25evHGXHjC6u7f3ktW4dpQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Dec 2021 21:58:51 -0500
X-Gmail-Original-Message-ID: <CAK8P3a2uw2PMjAEeEA36hssL9aoNv4BCNpubon+0UK=ubCbLXQ@mail.gmail.com>
Message-ID: <CAK8P3a2uw2PMjAEeEA36hssL9aoNv4BCNpubon+0UK=ubCbLXQ@mail.gmail.com>
Subject: Re: [RFC 04/32] parport: PC style parport depends on HAS_IOPORT
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 28, 2021 at 5:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Niklas,
>
> On Mon, Dec 27, 2021 at 5:48 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > not being declared. As PC style parport uses these functions we need to
> > handle this dependency for HAS_IOPORT.
> >
> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks for your patch!
>
> > --- a/drivers/parport/Kconfig
> > +++ b/drivers/parport/Kconfig
> > @@ -14,7 +14,6 @@ config ARCH_MIGHT_HAVE_PC_PARPORT
> >
> >  menuconfig PARPORT
> >         tristate "Parallel port support"
> > -       depends on HAS_IOMEM
>
> Why drop this?
> Don't all other parport drivers depend on it?

The other drivers all have dependencies on specific platforms, so I
probably dropped it in the original draft because the remaining dependencies
are sufficient.

Technically, the partport_pc driver only needs HAS_IOPORT, not HAS_IOMEM,
but in the end this makes very little difference.

        Arnd
